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
