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

//LLAMADO A LA LECTURA DE ARCHIVOS DE CATEGORIAS DE PRODUCTOS SEGUND CATID
async function mostrarPorID(catID) {
  const filePath = path.join(__dirname, "cats_products", `${catID}.json`);
  try {
    const data = await fs.readFile(filePath, "utf-8");
    const categoria = JSON.parse(data);
    if (Array.isArray(categoria.products)) {
      return categoria.products; //devuelve el array de productos
    } else {
      return []; //si no hay productos devuelve un array vacío
    }
  } catch (error) {
    console.error(`Error al leer productos para categoría ${catID}:`, error);
    return [];
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
app.use(cors()); //para permitir solicitudes desde cualquier origen
app.use(express.json());
app.get("/", (req, res) => {
  res.send("BIENVENIDO A MI API: INGRESA UNA RUTA");
});

//DEVOLUCION DE JSON DE CATEGORIAS
app.get("/categorias.json", (req, res) => {
  res.json(categories);
});

//DEVOLUCION DE JSON DE CATEGORIA DE PRODUCTOS SEGUN EL CAT ID
app.get("/products/:catID.json", authorize, async (req, res) => {
  const catID = req.params.catID;
  const productos = await mostrarPorID(catID);
  if (Array.isArray(productos) && productos.length > 0) {
    res.json(productos); //devuelve los productos si esta todo ok
  } else {
    res.status(404).send("Productos no encontrados");
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

//MIDDLEWARE DE AUTORIZACION
function authorize(req, res, next) {
  const token = req.headers["access-token"]; //obtiene el token del encabezado
  console.log("Token recibido: ", token);

  if (!token) {
    //si no hya token responder con error 401 - no autorizado
    return res
      .status(401)
      .json({ message: "Acceso denegado. Por favor, inicia sesion." });
  }

  try {
    const decoded = jwt.verify(token, SECRET_KEY); // verifica el token
    console.log("Token decodificado: ", decoded);
    req.user = decoded; // guarda los datos del token verificado en el req para usar despues
    next(); // pasa al siguiente middleware
  } catch (error) {
    console.log("Error de verificación de token:", error.message);
    return res.status(403).json({ message: "Token invalido" });
  }
}

//RUTA PARA VALIDAR TOKEN
app.post("/validate-token", (req, res) => {
  const token = req.headers["access-token"]; //obtiene el token del encabezado
  if (!token) {
    return res.status(401).json({ message: "Falta token" });
  }

  try {
    jwt.verify(token, SECRET_KEY); // verifica el token
    res.status(200).json({ message: "Token valido" });
  } catch (error) {
    res.status(401).json({ message: "Token invalido" });
  }
});

//Endpoint para depuracion
app.get("/debug-products", authorize, async (req, res) => {
  try {
    const categorias = await fs.readdir(path.join(__dirname, "cats_products"));
    const productos = {};

    for (let archivo of categorias) {
      const catID = archivo.replace(".json", "");
      const data = await mostrarPorID(catID);
      productos[catID] = data;
    }

    res.json({
      categorias,
      productos,
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//LLAMADO A LA ESCUCHAR EN EL PUERTO INDICADO
app.listen(port, () => {
  console.log(`Servidor corriendo en localhost: ${port}`);
});
