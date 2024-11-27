const express = require("express");
const fs = require("fs").promises; //SE USA PROMISES PARA MANEJAR DE MANERA ASINCRONICA LA LECTURA DE LOS DATOS
const path = require("path");
const cors = require("cors"); // INSTALADO PARA AUTORIZACION EN LOS PUERTOS Y LECTURA DEL LOCALHOST
const jwt = require("jsonwebtoken"); // PARA GENERAR Y VALIDAR TOKENS

const app = express();
const port = 3000;
//LLAMADO A TRAER EL UNICO ARCHIVO JSON QUE CONTIENE TODAS LAS CATEGORIAS
const categories = require("./cats/cat.json");

// Clave para firmar los tokens
const SECRET_KEY = "CLAVESUPERSECRETA";

// Usuario y contraseña válidos para autenticación
const VALID_USER = "proyectofinal@jap.com";
const VALID_PASSWORD = "1234";

//IMPLEMENTACION DE MARIADB
// const mariadb = require("mariadb");
//IMPLEMENTACION DE MYSQL
const mysql = require('mysql2/promise')

// Crear pool de conexiones a la base de datos
const db = mysql.createPool({
  connectionLimit: 10,
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'ecommercejap'
});

// Inicializar la conexión a la base de datos
async function iniciarConexionDB() {
  try {
    // Obtener una conexión del pool
    const connection = await db.getConnection();
    console.log("DB connected");
    connection.release();
  } catch (err) {
    // Si hay errores, mostrarlos en consola
    console.log("DB connection error: " + err);
  }
}

// Inicializar la conexión a la base de datos
iniciarConexionDB();


//LLAMADO A LA LECTURA DE ARCHIVOS DE CATEGORIAS DE PRODUCTOS SEGUND CATID
async function mostrarPorID(catID) {
  const filePath = path.join(__dirname, "cats_products", `${catID}.json`);
  try {
    const data = await fs.readFile(filePath, "utf-8");
    return JSON.parse(data);
  } catch (error) {
    return console.log("Archivo no encontrado");
  }
}
// FUNCION PARA LA LECTURA DE ARCHIVOS DE PRODUCTS SEGUN SU ID
async function productsPorId(id) {
  const filePath = path.join(__dirname, "products", `${id}.json`);
  try {
    const lecturaInfo = await fs.readFile(filePath, "utf-8");
    return JSON.parse(lecturaInfo);
  } catch (error) {
    return console.log("Archivo no encontrado");
  }
}
//FUNCION PARA LA LECTURA DE ARCHIVO PRODUCTS_COMMENTS SEGUN  PRODUCTO
async function comentsPorId(product) {
  const filePath = path.join(__dirname, "products_comments", `${product}.json`);
  try {
    const lecturaComm = await fs.readFile(filePath, "utf-8");
    return JSON.parse(lecturaComm);
  } catch (error) {
    return console.log("Archivo no encontrado");
  }
}

//INICIO DE CREACION DE RUTAS PARA DEVOLUCION AL FRONTEND
app.use(cors());
app.use(express.json());
app.get("/", (req, res) => {
  res.send("BIENVENIDO A MI API: INGRESA UNA RUTA");
});
//DEVOLUCION DE JSON DE CATEGORIAS
app.get("/categorias.json", (req, res) => {
  res.json(categories);
});
//DEVOLUCION DE JSON DE CATEGORIA DE PRODUCTOS SEGUN EL CAT ID
app.get("/cat_prod/:catID.json", async (req, res) => {
  const catID = req.params.catID;
  const information = await mostrarPorID(catID);
  if (information) {
    res.json(information);
  } else {
    res.status(404).send("Producto  no encontrado");
  }
});
//DEVOLUCION DE JSON DE PRODUCTOS SEGUN EL ID
app.get("/productos/:id.json", async (req, res) => {
  const id = req.params.id;
  const datosFinal = await productsPorId(id);
  if (datosFinal) {
    res.json(datosFinal);
  } else {
    res.status(404).send("Producto  no encontrado");
  }
});
//DEVOLUCION DE JSON DE COMENTARIOS DE CLIENTES
app.get("/comentario_prod/:product.json", async (req, res) => {
  const product = req.params.product;
  const datosComm = await comentsPorId(product);
  if (datosComm) {
    res.json(datosComm);
  } else {
    res.status(404).send("Producto  no encontrado");
  }
});

// Endpoint POST /login para autenticación
app.post("/login", (req, res) => {
  const { email, password } = req.body;

  // Verificar credenciales
  if (email === VALID_USER && password === VALID_PASSWORD) {
    // Generar token con información del usuario
    const token = jwt.sign(
      { email: email }, // Información que incluirá el token
      SECRET_KEY // Clave secreta
    );
    console.log(token);
    // Responder con el token
    return res.json({ token });
  } else {
    // Responder con un error si los datos son incorrect0s
    return res.status(401).json({ message: "Usuario no autorizado" });
  }
});

//LLAMADO A LA ESCUCHAR EN EL PUERTO INDICADO
app.listen(port, () => {
  console.log(`Servidor corriendo en localhost: ${port}`);
});

//MIDDLEWARE
const autorizacionMiddleware = (req, res, next) => {
const token = req.headers.authorization;
if (!token) {
return res.status(401).json({ message: "Token de autorización no proporcionado" });
}
jwt.verify(token, SECRET_KEY, (err, decoded) => {
if (err) {
return res.status(401).json({ message: "Token de autorización inválido" });
}
req.user = decoded;
next();
});
};
// Endpoint protegido que requiere autorización
app.get("/ruta-protegida", autorizacionMiddleware, (req, res) => {
// Lógica de la ruta protegida aquí
  res.json({ message: "Acceso autorizado a la ruta protegida" });
});


//CREACIÓN DEL ENDPOINT CART PARA LAS COMPRAS DEL USUARIO

// Endpoint POST /cart para procesar una orden de compra
app.post("/cart", (req, res) => {
  // Obtener la orden del cuerpo de la solicitud
  let order = req.body;
  // Mostramos lo recibido en la petición entrante
  console.table(order);

  // Obtener una conexión del pool
  db.getConnection().then(async (connection) => {
    // Iniciar una transacción
    await connection.beginTransaction();
    try {
      // Insertar la orden en la base de datos
      const [result] = await connection.query(
        `INSERT INTO ordenes 
        (tipo_envio,
        departamento,
        localidad,
        calle,
        nro,
        apto,
        esquina,
        forma_pago,
        sub_total,
        costo_envio,
        total,
        usuario_id)
        VALUES (?,?,?,?,?,?,?,?,?,?,?,?)`,
        [
          order.tipo_envio,
          order.departamento,
          order.localidad,
          order.calle,
          order.nro,
          order.apto,
          order.esquina,
          order.payment,
          order.sub_total,
          order.costo_envio,
          order.total,
          order.user_id,
        ]
      );
      // Obtener el ID de la orden insertada para luego ser usada al guardar datos en la tabla de ordenes_producto y saber que el producto
      // pertenence a cierta orden en concreto
      const orderId = result.insertId;

      // Insertar cada producto de la orden en la base de datos
      for (const product of order.products) {
        let prod = {
          id: product.id,
          producto_id: product.id,
          cantidad: product.quantity,
          precio: product.cost,
          sub_total: product.cost * product.quantity,
          orden_id: orderId,
        };

        await connection.query(
          `INSERT INTO ordenes_producto (producto_id, cantidad, precio, sub_total, orden_id) VALUES (?,?,?,?,?)`,
          [
            prod.producto_id,
            prod.cantidad,
            prod.precio,
            prod.sub_total,
            prod.orden_id,
          ]
        );
      }

      // Confirmar la transacción
      await connection.commit();
      return res.status(201).json("Orden insertada correctamente");
    } catch (err) {
      // Revertir la transacción en caso de error
      // Si la transacción no se pudo revertir, se pierden los cambios
      await connection.rollback();
      console.log(err);
      return res.status(500).json("Error al insertar la orden" + err);
    } finally {
      // Liberar la conexión
      connection.release();
    }
  });
});