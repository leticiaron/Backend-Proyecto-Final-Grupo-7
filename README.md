# Instructivo para ejecutar el Backend

Paso a paso con todo lo necesario para poder ejecutar el proyecto del backend

## Instalar dependencias del proyecto

**Instalar Node.js** | Luego inicializa el proyecto Node.js

**Instalar dependencias del proyecto con los siguientes comandos:** Node, Express

```bash
  I. npm init
 II. npm install express fs path cors jsonwebtoken mysql2 nodemon
```

I. Para inicializar un proyecto Node.js (si aún no lo has hecho)

II. Esto instalará los siguientes paquetes:

- express: Framework para crear el servidor
- fs: Módulo para manejar archivos
- path: Para manejar rutas de manera segura
- cors: Para habilitar el CORS
- jsonwebtoken: Para crear y verificar tokens JWT
- mysql: Cliente MySQL para interactuar con la base de datos
- nodemon: Herramienta para reiniciar el servidor automáticamente durante el desarrollo

## Ejecutar servidor

```bash
node app.js
```

## Configuración Base de Datos (MySQL)

**a. Creación base de datos:**

- Abre un cliente de MySQL como HeidiSQL o phpMyAdmin, y crea una nueva base de datos llamada “ecommerce”
- En phpMyAdmin: Ve a la base de datos ecommerce, selecciona la pestaña de "Importar", selecciona el archivo ecommerce.sql (que se encuentra en la carpeta del backend) y haz clic en "Continuar".
- En HeidiSQL: Conéctate a la base de datos ecommerce, selecciona "File" -> "Load SQL file" y elige el archivo ecommerce.sql.

**b. Conéctate a la base de datos**

**c. Actualiza las credenciales en el archivo app.js:**

Localiza la sección dónde se crea la conexión, luego asegúrate de que los valores de host, user, password y database coincidan con las credenciales de tu servidor MySQL

**d. Verifica la conexión a la base de datos**

## Login (credenciales para autenticación)

```bash
  email: "proyectofinal@jap.com",
  password: "1234"
```

## Proyecto Frontend

Este Backend fue realizado para el siguiente proyecto:

[Proyecto Final Jap - Subgrupo 7](https://github.com/VioletDarklight/Proyecto-Final-Grupo-7)

## Autoras

- [@florenciagarciacastelli](https://github.com/florenciagarciacastelli)
- [@karenfigueroa](https://github.com/karenseptember)
- [@VioletDarklight](https://github.com/VioletDarklight)
- [@leticiaron](https://github.com/leticiaron)
