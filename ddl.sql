USE tienda_de_maquillaje;

INSERT INTO clientes (id_cliente, nombre, email, direccion, telefono) VALUES
(1,  'Maria Gonzalez Perez',   'maria.gonzalez@email.com',  'Calle 12 #34-56, Bogota',       '3001234567'),
(2,  'Camila Rodriguez Diaz',  'camila.rodriguez@email.com','Cra 45 #67-89, Medellin',       '3012345678'),
(3,  'Valentina Lopez Ruiz',   'valentina.lopez@email.com', 'Av 30 #10-15, Cali',            '3023456789'),
(4,  'Sofia Martinez Gil',     'sofia.martinez@email.com',  'Calle 8 #22-40, Barranquilla',  '3034567890'),
(5,  'Isabella Torres Mora',   'isabella.torres@email.com', 'Cra 15 #100-25, Bogota',        '3045678901'),
(6,  'Daniela Ramirez Sanz',   'daniela.ramirez@email.com', 'Calle 50 #12-08, Bucaramanga',  '3056789012'),
(7,  'Andrea Castro Vela',     'andrea.castro@email.com',   'Av 68 #40-30, Bogota',          '3067890123'),
(8,  'Laura Jimenez Rios',     'laura.jimenez@email.com',   'Cra 7 #85-14, Bogota',          '3078901234'),
(9,  'Paula Vargas Nino',      'paula.vargas@email.com',    'Calle 33 #24-60, Pereira',      '3089012345'),
(10, 'Manuela Ortega Paz',     'manuela.ortega@email.com',  'Cra 52 #9-77, Medellin',        '3090123456');

INSERT INTO empleados (id_empleado, nombre, puesto, fecha_contratacion, area) VALUES
(1, 'Laura Ramirez Soto',   'Vendedora',          '2022-03-15 08:00:00', 'venta'),
(2, 'Carlos Mendoza Leal',  'Cajero',             '2024-11-01 08:00:00', 'venta'),
(3, 'Ana Torres Quintero',  'Jefe de Bodega',     '2021-06-10 08:00:00', 'bodega'),
(4, 'Jorge Castro Pena',    'Auxiliar de Bodega', '2025-12-20 08:00:00', 'bodega'),
(5, 'Diana Suarez Melo',    'Administradora',     '2020-01-05 08:00:00', 'administración'),
(6, 'Felipe Leon Cardona',  'Vendedor',           '2026-05-01 08:00:00', 'venta');

INSERT INTO proveedores (id_proveedor, nombre_empresa, nombre_contacto, direccion, telefono) VALUES
(1, 'Cosmeticos del Valle SAS',   'Pedro Nel Ochoa',      'Cra 50 #10-20, Medellin',        '6041234567'),
(2, 'BeautyImport Ltda',          'Sandra Milena Ruiz',   'Calle 80 #15-30, Bogota',        '6017654321'),
(3, 'Fragancias Premium SA',      'Ricardo Gomez Arias',  'Autopista Sur #45-12, Itagui',   '6042345678'),
(4, 'Accesorios y Brochas Pro',   'Natalia Velez Rua',    'Calle 5 #23-45, Cali',           '6053456789'),
(5, 'SkinCare Distribuciones',    'Andres Felipe Mora',   'Cra 7 #100-50, Bogota',          '6018901234');

-- ---------------------------------------------------------------------
INSERT INTO productos (id_producto, nombre, descripcion, categoria, precio, stock) VALUES
(1,  'Labial Rojo Mate',              'Labial de larga duracion acabado mate',        'cosmeticos',          25000.00, 40),
(2,  'Labial Nude Satinado',          'Labial tono nude acabado satinado',            'cosmeticos',          27000.00, 8),
(3,  'Labial Vino Liquido',           'Labial liquido tono vino alta pigmentacion',   'cosmeticos',          30000.00, 55),
(4,  'Base Liquida Cobertura Total',  'Base liquida cobertura alta 30ml',             'cosmeticos',          65000.00, 20),
(5,  'Base en Polvo Compacta',        'Base compacta en polvo con espejo',            'cosmeticos',          58000.00, 5),
(6,  'Paleta de Sombras Nude',        'Paleta 12 sombras tonos neutros',              'cosmeticos',          89000.00, 15),
(7,  'Sombra Individual Shimmer',     'Sombra individual acabado shimmer',            'cosmeticos',          18000.00, 60),
(8,  'Mascara de Pestanas Volumen',   'Mascara efecto volumen a prueba de agua',      'cosmeticos',          32000.00, 3),
(9,  'Crema Hidratante Piel Seca',    'Crema facial hidratacion profunda 50ml',       'cuidado de la piel',  45000.00, 25),
(10, 'Gel Limpiador Piel Grasa',      'Gel limpiador control de grasa 150ml',         'cuidado de la piel',  38000.00, 30),
(11, 'Serum Acido Hialuronico',       'Serum facial hidratante 30ml',                 'cuidado de la piel',  72000.00, 12),
(12, 'Contorno de Ojos',              'Crema contorno de ojos antiedad 15ml',         'cuidado de la piel',  55000.00, 4),
(13, 'Protector Solar FPS 50',        'Protector solar facial FPS 50 60ml',           'cuidado de la piel',  48000.00, 40),
(14, 'Perfume Floral Elegance 50ml',  'Eau de parfum floral femenino',                'perfumes',           180000.00, 10),
(15, 'Perfume Amaderado Intenso 100ml','Eau de parfum amaderado unisex',              'perfumes',           250000.00, 6),
(16, 'Perfume Citrico Fresh 30ml',    'Eau de toilette citrico fresco',               'perfumes',           120000.00, 18),
(17, 'Body Mist Vainilla 200ml',      'Bruma corporal aroma vainilla',                'perfumes',            60000.00, 22),
(18, 'Brocha Kabuki',                 'Brocha densa para polvos y base',              'accesorios',          35000.00, 45),
(19, 'Set de Brochas x12',            'Estuche con 12 brochas de maquillaje',         'accesorios',          95000.00, 7),
(20, 'Esponja de Maquillaje',         'Esponja tipo huevo para difuminar base',       'accesorios',          12000.00, 2);

INSERT INTO detalles_cosmeticos (id_producto, tipo, tono_color, fecha_expiracion) VALUES
(1, 'labial',  'Rojo Mate',    '2027-06-30'),
(2, 'labial',  'Nude',         '2027-08-15'),
(3, 'labial',  'Vino',         '2026-12-01'),
(4, 'base',    'Beige Medio',  '2027-01-20'),
(5, 'base',    'Arena',        '2026-11-10'),
(6, 'sombra',  'Tonos Nude',   '2028-03-01'),
(7, 'sombra',  'Dorado',       '2028-05-01'),
(8, 'mascara', 'Negro',        '2026-10-05');

INSERT INTO cuidado_de_piel (id_producto, tipo_de_piel, componentes_principales, fecha_expiracion) VALUES
(9,  'seca',  'Manteca de karite, glicerina, acido hialuronico', '2027-04-01'),
(10, 'grasa', 'Acido salicilico, extracto de te verde',          '2027-02-01'),
(11, 'mixta', 'Acido hialuronico, vitamina B5, panthenol',       '2026-09-30'),
(12, 'seca',  'Cafeina, peptidos, retinol encapsulado',          '2026-12-15'),
(13, 'mixta', 'Oxido de zinc, vitamina E, filtros UV',           '2027-07-01');

INSERT INTO perfumes_accesorios (id_producto, tipo_aroma, tamaño, material) VALUES
(14, 'Floral',          '50ml',     NULL),
(15, 'Amaderado',       '100ml',    NULL),
(16, 'Citrico',         '30ml',     NULL),
(17, 'Dulce - Vainilla','200ml',    NULL),
(18, NULL,              'Mediana',  'Fibra sintetica / aluminio'),
(19, NULL,              'Estandar', 'Madera y fibra sintetica'),
(20, NULL,              'Pequena',  'Poliuretano');

INSERT INTO ventas (id_venta, fecha_venta, id_cliente, id_empleado) VALUES
(1,  '2025-02-10 09:30:00', 3,  1),
(2,  '2025-04-22 14:15:00', 1,  2),
(3,  '2025-06-05 11:00:00', 5,  1),
(4,  '2025-08-30 16:45:00', 2,  1),
(5,  '2025-09-15 10:20:00', 3,  2),
(6,  '2025-10-01 12:00:00', 4,  1),
(7,  '2025-11-11 17:30:00', 1,  2),
(8,  '2025-12-24 13:10:00', 6,  1),
(9,  '2026-01-08 09:00:00', 3,  2),
(10, '2026-01-20 15:40:00', 7,  1),
(11, '2026-02-14 18:00:00', 8,  6),
(12, '2026-03-03 10:05:00', 1,  2),
(13, '2026-05-19 11:25:00', 3,  1),
(14, '2026-06-28 16:00:00', 9,  6),
(15, '2026-08-07 14:50:00', 10, 1),
(16, '2026-09-02 12:30:00', 3,  2);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1,  1,  2, 25000.00), (1,  6,  1, 89000.00),
(2,  4,  1, 65000.00), (2,  9,  2, 45000.00),
(3,  1,  3, 25000.00), (3,  3,  2, 30000.00), (3, 20, 1, 12000.00),
(4,  14, 1, 180000.00),
(5,  1,  1, 25000.00), (5,  7,  4, 18000.00),
(6,  10, 1, 38000.00), (6,  13, 2, 48000.00),
(7,  6,  1, 89000.00), (7,  8,  2, 32000.00),
(8,  15, 1, 250000.00),(8,  19, 1, 95000.00),
(9,  1,  2, 25000.00), (9,  2,  1, 27000.00),
(10, 11, 1, 72000.00), (10, 12, 1, 55000.00),
(11, 16, 1, 120000.00),(11, 17, 2, 60000.00),
(12, 1,  1, 25000.00), (12, 18, 2, 35000.00),
(13, 3,  3, 30000.00), (13, 7,  2, 18000.00),
(14, 4,  1, 65000.00), (14, 5,  1, 58000.00),
(15, 1,  2, 25000.00), (15, 6,  1, 89000.00), (15, 9, 1, 45000.00),
(16, 1,  1, 25000.00), (16, 20, 3, 12000.00);

INSERT INTO ordenes_compra (id_orden, id_proveedor, fecha_orden) VALUES
(1, 1, '2024-05-10'),
(2, 3, '2025-01-15'),
(3, 1, '2025-07-20'),
(4, 5, '2025-10-05'),
(5, 2, '2026-02-11'),
(6, 4, '2026-04-30'),
(7, 1, '2026-07-15'),
(8, 3, '2026-08-25');

INSERT INTO detalle_ordenes_compra (id_orden, id_producto, cantidad_solicitada, cantidad_recibida) VALUES
(1, 1,  50, 50), (1, 2,  30, 28), (1, 6,  20, 20),
(2, 14, 15, 15), (2, 15, 10, 10),
(3, 3,  60, 55), (3, 7,  80, 80),
(4, 9,  25, 25), (4, 11, 15, 12), (4, 13, 40, 40),
(5, 4,  20, 20), (5, 5,  10, 10),
(6, 18, 50, 45), (6, 19, 10, 7),  (6, 20, 30, 30),
(7, 1,  40, 40), (7, 8,  20, 15),
(8, 16, 20, 20), (8, 17, 25, 25);
