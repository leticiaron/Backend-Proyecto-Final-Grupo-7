/*
 Navicat Premium Dump SQL

 Source Server         : MYSQL LOCALHOST
 Source Server Type    : MySQL
 Source Server Version : 80040 (8.0.40)
 Source Host           : localhost:3306
 Source Schema         : ecommercejap

 Target Server Type    : MySQL
 Target Server Version : 80040 (8.0.40)
 File Encoding         : 65001

 Date: 30/11/2024 18:45:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for categorias
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias`  (
  `id` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL DEFAULT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL DEFAULT NULL,
  `imagen_categoria` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL,
  `cantidad` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categorias
-- ----------------------------
INSERT INTO `categorias` VALUES (101, 'Autos', 'Autos XD', NULL, NULL);
INSERT INTO `categorias` VALUES (102, 'Juguetes', 'Juguetes', NULL, NULL);
INSERT INTO `categorias` VALUES (103, 'Muebles', 'Muebles', NULL, NULL);
INSERT INTO `categorias` VALUES (104, 'Herramientas', 'Herramientas', NULL, NULL);
INSERT INTO `categorias` VALUES (105, 'Computadoras', 'Computadoras', NULL, NULL);
INSERT INTO `categorias` VALUES (106, 'Vestimenta', 'Vestimenta', NULL, NULL);
INSERT INTO `categorias` VALUES (107, 'Electrodomesticos', 'Electrodomesticos', NULL, NULL);
INSERT INTO `categorias` VALUES (108, 'Deporte', 'Deporte', NULL, NULL);
INSERT INTO `categorias` VALUES (109, 'Celulares', 'Celulares', NULL, NULL);

-- ----------------------------
-- Table structure for opiniones
-- ----------------------------
DROP TABLE IF EXISTS `opiniones`;
CREATE TABLE `opiniones`  (
  `id` int NOT NULL,
  `nombre_usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `puntuacion` tinyint NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL DEFAULT NULL,
  `fecha` date NULL DEFAULT NULL,
  `hora` timestamp NULL DEFAULT NULL,
  `producto_id` int NULL DEFAULT NULL,
  `usuario_id` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of opiniones
-- ----------------------------

-- ----------------------------
-- Table structure for ordenes
-- ----------------------------
DROP TABLE IF EXISTS `ordenes`;
CREATE TABLE `ordenes`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `tipo_envio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `departamento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `localidad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `calle` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `nro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `apto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `esquina` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `forma_pago` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `sub_total` int UNSIGNED NOT NULL,
  `costo_envio` int UNSIGNED NOT NULL,
  `total` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ordenes
-- ----------------------------

-- ----------------------------
-- Table structure for ordenes_producto
-- ----------------------------
DROP TABLE IF EXISTS `ordenes_producto`;
CREATE TABLE `ordenes_producto`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `cantidad` int UNSIGNED NOT NULL,
  `precio` int UNSIGNED NOT NULL,
  `sub_total` int UNSIGNED NOT NULL,
  `orden_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id` ASC) USING BTREE,
  INDEX `orden_id`(`orden_id` ASC) USING BTREE,
  CONSTRAINT `ordenes_producto_ibfk_1` FOREIGN KEY (`orden_id`) REFERENCES `ordenes` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ordenes_producto
-- ----------------------------

-- ----------------------------
-- Table structure for productos
-- ----------------------------
DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos`  (
  `id` int NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `descripcion` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `precio` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `moneda` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `vendidos` int NOT NULL,
  `imagenes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL,
  `categoria_id` int NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of productos
-- ----------------------------
INSERT INTO `productos` VALUES (40281, 'Computadora de escritorio', 'Computadora de escritorio. Potencia y rendimiento, para juegos o trabajo', '2599', 'USD', 11, 'img/prod40281_1.jpg', 105);
INSERT INTO `productos` VALUES (50741, 'Oso de peluche', 'Oso de peluche gigante, con el bebé. Resistente y lavable. Tus hijos los amarán', '2400', 'UYU', 97, 'img/prod50741_1.jpg', 102);
INSERT INTO `productos` VALUES (50742, 'Pelota de básquetbol', 'Balón de baloncesto profesional, para interiores, tamaño 5, 27.5 pulgadas. Oficial de la NBA', '2999', 'UYU', 11, 'img/prod50742_1.jpg', 102);
INSERT INTO `productos` VALUES (50743, 'PlayStation 5', 'Maravíllate con increíbles gráficos y disfruta de nuevas funciones de PS5. Con E/S integrada.', '59999', 'UYU', 16, 'img/prod50743_1.jpg', 102);
INSERT INTO `productos` VALUES (50744, 'Bicicleta', '¡La mejor BMX pequeña del mercado! Frenos traseros y cuadro duradero de acero Hi-Ten.', '10999', 'UYU', 8, 'img/prod50744_1.jpg', 102);
INSERT INTO `productos` VALUES (50921, 'Chevrolet Onix Joy', 'Generación 2019, variedad de colores. Motor 1.0, ideal para ciudad.', '13500', 'USD', 14, 'img/prod50921_1.jpg', 101);
INSERT INTO `productos` VALUES (50922, 'Fiat Way', 'La versión de Fiat que brinda confort y a un precio accesible.', '14500', 'USD', 52, 'img/prod50922_1.jpg', 101);
INSERT INTO `productos` VALUES (50923, 'Suzuki Celerio', 'Un auto que se ha ganado la buena fama por su economía con el combustible.', '12500', 'USD', 25, 'img/prod50923_1.jpg', 101);
INSERT INTO `productos` VALUES (50924, 'Peugeot 208', 'El modelo de auto que se sigue renovando y manteniendo su prestigio en comodidad.', '15200', 'USD', 17, 'img/prod50924_1.jpg', 101);
INSERT INTO `productos` VALUES (50925, 'Bugatti Chiron', 'El mejor hiperdeportivo de mundo. Producción limitada a 500 unidades.', '3500000', 'USD', 0, 'img/prod50925_1.jpg', 101);
INSERT INTO `productos` VALUES (60801, 'Juego de comedor', 'Un conjunto sencillo y sólido, ideal para zonas de comedor pequeñas, hecho en madera maciza de pino', '4000', 'UYU', 88, 'img/prod60801_1.jpg', 103);
INSERT INTO `productos` VALUES (60802, 'Sofá', 'Cómodo sofá de tres cuerpos, con chaiselongue intercambiable. Ideal para las siestas', '24000', 'UYU', 12, 'img/prod60802_1.jpg', 103);
INSERT INTO `productos` VALUES (60803, 'Armario', 'Diseño clásico con puertas con forma de panel. Espejo de cuerpo entero para ver cómo te queda la ropa', '8000', 'UYU', 24, 'img/prod60803_1.jpg', 103);
INSERT INTO `productos` VALUES (60804, 'Mesa de centro', 'Añade más funciones a tu sala de estar, ya que te permite cambiar fácilmente de actividad.', '10000', 'UYU', 37, 'img/prod60804_1.jpg', 103);

-- ----------------------------
-- Table structure for usuarios
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios`  (
  `id` int NOT NULL,
  `primer_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `segundo_nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL DEFAULT NULL,
  `apellido_paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `apellido_materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `darkmode` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NOT NULL,
  `imagen_perfil` text CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL,
  `telefono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usuarios
-- ----------------------------
INSERT INTO `usuarios` VALUES (1, 'Mrs.', 'Kong Jiehong', 'Married', 'Operations manager', 'W5xtWFTp6Q', 'konjiehong3@hotmail.com', '113', 'rPNce3VmUn', '212-261-2405');
INSERT INTO `usuarios` VALUES (2, 'Ms.', 'Liao Wai Man', 'Single', 'Office manager', 'ZujeSYdnbw', 'wmliao7@yahoo.com', '49', 'eQdrJx6eVJ', '838-698-1136');
INSERT INTO `usuarios` VALUES (3, 'Mrs.', 'Xiong Jialun', 'Married', 'Business reporter', 'hrs2muEv6N', 'xjialun6@outlook.com', '103', 'KAcreuol66', '614-914-6902');
INSERT INTO `usuarios` VALUES (4, 'Miss.', 'Ando Ikki', 'Single', 'Financial planner', 'dCiWRs2RZs', 'ando50@yahoo.com', '58', 'x6Ax452u5W', '330-177-8252');
INSERT INTO `usuarios` VALUES (5, 'Miss.', 'Frances Fisher', 'Married', 'Architect', 'i7E5HLcKtf', 'fifr@icloud.com', '9', 'yWEU2GXzPF', '614-469-4148');
INSERT INTO `usuarios` VALUES (6, 'Mrs.', 'Sano Rin', 'Married', 'Fashion designer', 'iSbQZRVA5U', 'rin16@hotmail.com', '12', 'YDKe4fx8un', '212-757-7201');
INSERT INTO `usuarios` VALUES (7, 'Prof.', 'Okada Mai', 'Married', 'Mobile application developer', 'OwHmaiClLU', 'okadamai7@outlook.com', '46', 'APQRbw8YaK', '212-185-8244');
INSERT INTO `usuarios` VALUES (8, 'Mr.', 'Xia Zitao', 'Married', 'Web developer', 'Pfpp7OuTvF', 'xiazita@outlook.com', '16', 'PhsQ9fnW3c', '614-062-2334');
INSERT INTO `usuarios` VALUES (9, 'Ms.', 'David Gardner', 'Married', 'Graphic designer', '85uEZG9So7', 'gardner1012@yahoo.com', '25', 'L4A0U4qQwe', '838-813-8560');
INSERT INTO `usuarios` VALUES (10, 'Prof.', 'Liang Lu', 'Single', 'UX/UI designer', 'BED68sSOgh', 'lulia@yahoo.com', '104', '656XufDLFi', '212-588-9205');
INSERT INTO `usuarios` VALUES (11, 'Mrs.', 'Nakamura Ayato', 'Single', 'Librarian', '5rvpO9iHTk', 'anakamura@outlook.com', '1', 'jA64xWKCS2', '312-625-6044');
INSERT INTO `usuarios` VALUES (12, 'Mr.', 'Yuen Kar Yan', 'Single', 'Multimedia animator', 'mqzMSb5POy', 'kyyue@outlook.com', '62', 'TOjTIFIFol', '838-734-6659');
INSERT INTO `usuarios` VALUES (13, 'Mrs.', 'Lai Siu Wai', 'Single', 'Sales manager', 'ZNbOkgNoj9', 'lsw@icloud.com', '65', 'eFwA5Eky6Y', '838-691-4309');
INSERT INTO `usuarios` VALUES (14, 'Mrs.', 'Sakurai Hikari', 'Single', 'Team leader', '1ttB4CVYl3', 'hikari10@outlook.com', '91', 'K2Q1WHI8tF', '718-852-6353');
INSERT INTO `usuarios` VALUES (15, 'Mr.', 'Tang Ka Man', 'Married', 'Fashion designer', 'JXmqmlNS5w', 'tkaman55@gmail.com', '127', 'osJ1eaEoFU', '212-133-4709');
INSERT INTO `usuarios` VALUES (16, 'Mr.', 'Travis Phillips', 'Married', 'Chief operations officer', '6VnefPhT7L', 'phillipstravi@outlook.com', '64', 'fNG3HTER55', '330-638-7022');
INSERT INTO `usuarios` VALUES (17, 'Miss.', 'Kong Wai Man', 'Married', 'Project manager', 'CjQxMb0vPU', 'waiman2@gmail.com', '97', 'sBoMf7F2Bm', '212-480-3986');
INSERT INTO `usuarios` VALUES (18, 'Prof.', 'Kyle Hughes', 'Married', 'Farmer', '7RCqB7n7LZ', 'hugheskyle3@outlook.com', '119', 'UuA7c61u1X', '838-934-7306');
INSERT INTO `usuarios` VALUES (19, 'Miss.', 'Cho Ling Ling', 'Married', 'Logistics coordinator', 'goxP6fmmpw', 'llcho@hotmail.com', '48', 'kF5NKP5peK', '330-277-2602');
INSERT INTO `usuarios` VALUES (20, 'Mr.', 'Lee Wing Sze', 'Married', 'Social media coordinator', 'dMhLbmYWyQ', 'leewingsze109@icloud.com', '107', 'XFHqOoQ3wU', '212-271-9020');

SET FOREIGN_KEY_CHECKS = 1;
