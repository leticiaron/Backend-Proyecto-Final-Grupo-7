CREATE TABLE `usuarios` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`primer_nombre` VARCHAR(255) NOT NULL,
	`segundo_nombre` VARCHAR(255),
	`apellido_paterno` VARCHAR(255) NOT NULL,
	`apellido_materno` VARCHAR(255) NOT NULL,
	`password` VARCHAR(255) NOT NULL,
	`email` VARCHAR(255) NOT NULL,
	`darkmode` BOOLEAN NOT NULL DEFAULT 0,
	`imagen_perfil` VARCHAR(255),
	`telefono` VARCHAR(255),
	PRIMARY KEY(`id`)
);

CREATE TABLE `categorias` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre` VARCHAR(255) NOT NULL,
	`descripcion` VARCHAR(255),
	`imagen_categoria` VARCHAR(255),
	`cantidad` INTEGER UNSIGNED,
	PRIMARY KEY(`id`)
);

CREATE TABLE `productos` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre` VARCHAR(255) NOT NULL,
	`descripcion` VARCHAR(255) NOT NULL,
	`precio` INTEGER UNSIGNED NOT NULL,
	`moneda` VARCHAR(255) NOT NULL,
	`vendidos` INTEGER UNSIGNED NOT NULL,
	`imagenes` VARCHAR(255),
	`categoria_id` INTEGER,
	PRIMARY KEY(`id`)
);

CREATE TABLE `opiniones` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_usuario` VARCHAR(255) NOT NULL,
	`puntuacion` TINYINT NOT NULL,
	`descripcion` VARCHAR(255),
	`fecha` DATE,
	`hora` TIMESTAMP,
	`producto_id` INTEGER,
	PRIMARY KEY(`id`)
);

CREATE TABLE `carrito` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`usuario_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `ordenes` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`tipo_envio` ENUM('premium', 'express', 'standard') NOT NULL,
	`departamento` VARCHAR(255) NOT NULL,
	`localidad` VARCHAR(255) NOT NULL,
	`calle` VARCHAR(255) NOT NULL,
	`nro` VARCHAR(255) NOT NULL,
	`apto` VARCHAR(255) NOT NULL,
	`esquina` VARCHAR(255) NOT NULL,
	`forma_pago` ENUM('tarjeta', 'contraentrega') NOT NULL,
	`sub_total` INTEGER UNSIGNED NOT NULL,
	`costo_envio` INTEGER UNSIGNED NOT NULL,
	`total` INTEGER UNSIGNED NOT NULL,
	`usuario_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `ordenes_producto` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`producto_id` INTEGER NOT NULL,
	`cantidad` INTEGER UNSIGNED NOT NULL,
	`precio` INTEGER UNSIGNED NOT NULL,
	`sub_total` INTEGER UNSIGNED NOT NULL,
	`orden_id` INTEGER NOT NULL,
	PRIMARY KEY(`id`)
);

CREATE TABLE `carrito_producto` (
	`id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`producto_id` INTEGER,
	`cantidad` INTEGER,
	`precio` INTEGER,
	`sub_total` INTEGER,
	`carrito_id` INTEGER,
	`moneda` ENUM('UYU', 'USD'),
	PRIMARY KEY(`id`)
);

ALTER TABLE `productos`
ADD FOREIGN KEY(`categoria_id`) REFERENCES `categorias`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `opiniones`
ADD FOREIGN KEY(`producto_id`) REFERENCES `productos`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `carrito`
ADD FOREIGN KEY(`usuario_id`) REFERENCES `usuarios`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `ordenes`
ADD FOREIGN KEY(`usuario_id`) REFERENCES `usuarios`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `ordenes_producto`
ADD FOREIGN KEY(`producto_id`) REFERENCES `productos`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `ordenes_producto`
ADD FOREIGN KEY(`orden_id`) REFERENCES `ordenes`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `carrito_producto`
ADD FOREIGN KEY(`carrito_id`) REFERENCES `carrito`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;
ALTER TABLE `carrito_producto`
ADD FOREIGN KEY(`producto_id`) REFERENCES `productos`(`id`)
ON UPDATE NO ACTION ON DELETE NO ACTION;