CREATE DATABASE IF NOT EXISTS tienda_de_maquillaje;
USE tienda_de_maquillaje;

DROP TABLE IF EXISTS detalle_ordenes_compra;
DROP TABLE IF EXISTS ordenes_compra;
DROP TABLE IF EXISTS detalle_ventas;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS perfumes_accesorios;
DROP TABLE IF EXISTS cuidado_de_piel;
DROP TABLE IF EXISTS detalles_cosmeticos;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS empleados;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(100) NOT NULL,
    fecha_contratacion DATETIME NOT NULL,
    area ENUM('venta','bodega','administración') NOT NULL
);

CREATE TABLE proveedores (
    id_proveedor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(50) NOT NULL,
    nombre_contacto VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    categoria ENUM('cosmeticos', 'cuidado de la piel', 'perfumes', 'accesorios') NOT NULL,
    precio DECIMAL(10,2),
    stock INT NOT NULL DEFAULT 0
);

CREATE TABLE detalles_cosmeticos (
    id_detalle_cosmetico INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo VARCHAR(100) NOT NULL,
    tono_color VARCHAR(50),
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

CREATE TABLE cuidado_de_piel (
    id_cuidado_de_piel INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo_de_piel ENUM('seca', 'grasa', 'mixta') NOT NULL,
    componentes_principales TEXT,
    fecha_expiracion DATE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

CREATE TABLE perfumes_accesorios (
    id_perfume_accesorio INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT NOT NULL,
    tipo_aroma VARCHAR(50),
    tamaño VARCHAR(50) NOT NULL,
    material VARCHAR(50),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto) ON DELETE CASCADE
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE detalle_ventas (
    id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

CREATE TABLE ordenes_compra (
    id_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_proveedor INT NOT NULL,
    fecha_orden DATE NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
);

CREATE TABLE detalle_ordenes_compra (
    id_detalle_orden INT AUTO_INCREMENT PRIMARY KEY,
    id_orden INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad_solicitada INT NOT NULL,
    cantidad_recibida INT NOT NULL DEFAULT 0,
    FOREIGN KEY (id_orden) REFERENCES ordenes_compra(id_orden) ON DELETE CASCADE,
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);