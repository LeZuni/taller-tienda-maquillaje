USE tienda_de_maquillaje;

DROP PROCEDURE IF EXISTS sp_cosmeticos_por_tipo;
DROP PROCEDURE IF EXISTS sp_productos_categoria_stock_bajo;
DROP PROCEDURE IF EXISTS sp_ventas_cliente_rango;
DROP FUNCTION  IF EXISTS fn_total_ventas_empleado_mes;
DROP PROCEDURE IF EXISTS sp_productos_mas_vendidos;
DROP PROCEDURE IF EXISTS sp_consultar_stock;
DROP PROCEDURE IF EXISTS sp_ordenes_proveedor_ultimo_anio;
DROP PROCEDURE IF EXISTS sp_empleados_antiguedad_mayor_anio;
DROP FUNCTION  IF EXISTS fn_total_productos_vendidos_dia;
DROP PROCEDURE IF EXISTS sp_ventas_por_producto;

DELIMITER $$

-- 1. Listar todos los productos de cosmeticos de un tipo especifico
CREATE PROCEDURE sp_cosmeticos_por_tipo(IN p_tipo VARCHAR(100))
BEGIN
    SELECT p.id_producto,
           p.nombre,
           p.descripcion,
           p.precio,
           p.stock,
           dc.tipo,
           dc.tono_color,
           dc.fecha_expiracion
    FROM productos p
    INNER JOIN detalles_cosmeticos dc ON dc.id_producto = p.id_producto
    WHERE p.categoria = 'cosmeticos'
      AND dc.tipo = p_tipo
    ORDER BY p.nombre;
END$$

-- 2. Obtener todos los productos de una categoria cuyo stock sea inferior a un valor dado.
CREATE PROCEDURE sp_productos_categoria_stock_bajo(
    IN p_categoria VARCHAR(30),
    IN p_stock_minimo INT)
BEGIN
    SELECT id_producto,
           nombre,
           categoria,
           precio,
           stock
    FROM productos
    WHERE categoria = p_categoria
      AND stock < p_stock_minimo
    ORDER BY stock ASC;
END$$

-- 3. Mostrar todas las ventas realizadas por un cliente especifico en un rango de fechas.
CREATE PROCEDURE sp_ventas_cliente_rango(
    IN p_id_cliente INT,
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE)
BEGIN
    SELECT v.id_venta,
           v.fecha_venta,
           c.nombre AS cliente,
           e.nombre AS empleado,
           SUM(dv.cantidad)                        AS unidades,
           SUM(dv.cantidad * dv.precio_unitario)   AS total_venta
    FROM ventas v
    INNER JOIN clientes  c  ON c.id_cliente  = v.id_cliente
    INNER JOIN empleados e  ON e.id_empleado = v.id_empleado
    INNER JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
    WHERE v.id_cliente = p_id_cliente
      AND v.fecha_venta >= p_fecha_inicio
      AND v.fecha_venta <  DATE_ADD(p_fecha_fin, INTERVAL 1 DAY)
    GROUP BY v.id_venta, v.fecha_venta, c.nombre, e.nombre
    ORDER BY v.fecha_venta;
END$$

-- 4. Calcular el total de ventas realizadas por un empleado en un mes dado (ano + mes).
CREATE FUNCTION fn_total_ventas_empleado_mes(
    p_id_empleado INT,
    p_anio INT,
    p_mes INT)
RETURNS DECIMAL(12,2)
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(12,2);

    SELECT IFNULL(SUM(dv.cantidad * dv.precio_unitario), 0)
    INTO v_total
    FROM ventas v
    INNER JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
    WHERE v.id_empleado = p_id_empleado
      AND YEAR(v.fecha_venta)  = p_anio
      AND MONTH(v.fecha_venta) = p_mes;

    RETURN v_total;
END$$

-- 5. Listar los productos mas vendidos en un periodo determinado.
CREATE PROCEDURE sp_productos_mas_vendidos(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE)
BEGIN
    SELECT p.id_producto,
           p.nombre,
           p.categoria,
           SUM(dv.cantidad)                       AS unidades_vendidas,
           SUM(dv.cantidad * dv.precio_unitario)  AS ingreso_total
    FROM detalle_ventas dv
    INNER JOIN ventas v    ON v.id_venta    = dv.id_venta
    INNER JOIN productos p ON p.id_producto = dv.id_producto
    WHERE v.fecha_venta >= p_fecha_inicio
      AND v.fecha_venta <  DATE_ADD(p_fecha_fin, INTERVAL 1 DAY)
    GROUP BY p.id_producto, p.nombre, p.categoria
    ORDER BY unidades_vendidas DESC;
END$$

-- 6. Consultar el stock disponible de un producto por su nombre o identificador.
CREATE PROCEDURE sp_consultar_stock(
    IN p_id_producto INT,
    IN p_nombre VARCHAR(50))
BEGIN
    SELECT id_producto,
           nombre,
           categoria,
           stock
    FROM productos
    WHERE (p_id_producto IS NOT NULL AND id_producto = p_id_producto)
       OR (p_nombre      IS NOT NULL AND nombre LIKE CONCAT('%', p_nombre, '%'));
END$$

-- 7. Mostrar las ordenes de compra realizadas a un proveedor especifico en el ultimo ano.
CREATE PROCEDURE sp_ordenes_proveedor_ultimo_anio(IN p_id_proveedor INT)
BEGIN
    SELECT oc.id_orden,
           oc.fecha_orden,
           pr.nombre_empresa,
           SUM(doc.cantidad_solicitada) AS total_solicitado,
           SUM(doc.cantidad_recibida)   AS total_recibido
    FROM ordenes_compra oc
    INNER JOIN proveedores pr ON pr.id_proveedor = oc.id_proveedor
    LEFT  JOIN detalle_ordenes_compra doc ON doc.id_orden = oc.id_orden
    WHERE oc.id_proveedor = p_id_proveedor
      AND oc.fecha_orden >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY oc.id_orden, oc.fecha_orden, pr.nombre_empresa
    ORDER BY oc.fecha_orden DESC;
END$$

-- 8. Listar los empleados que han trabajado mas de un ano en la tienda.
CREATE PROCEDURE sp_empleados_antiguedad_mayor_anio()
BEGIN
    SELECT id_empleado,
           nombre,
           puesto,
           area,
           fecha_contratacion,
           TIMESTAMPDIFF(YEAR, fecha_contratacion, CURDATE()) AS anios_antiguedad
    FROM empleados
    WHERE fecha_contratacion <= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    ORDER BY fecha_contratacion;
END$$

-- 9. Obtener la cantidad total de productos vendidos en un dia especifico.
CREATE FUNCTION fn_total_productos_vendidos_dia(p_fecha DATE)
RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
    DECLARE v_total INT;

    SELECT IFNULL(SUM(dv.cantidad), 0)
    INTO v_total
    FROM ventas v
    INNER JOIN detalle_ventas dv ON dv.id_venta = v.id_venta
    WHERE DATE(v.fecha_venta) = p_fecha;

    RETURN v_total;
END$$

-- 10. Consultar las ventas de un producto especifico y cuantas unidades se vendieron.
CREATE PROCEDURE sp_ventas_por_producto(
    IN p_id_producto INT,
    IN p_nombre VARCHAR(50))
BEGIN
    SELECT p.id_producto,
           p.nombre,
           COUNT(DISTINCT v.id_venta)             AS numero_ventas,
           SUM(dv.cantidad)                       AS unidades_vendidas,
           SUM(dv.cantidad * dv.precio_unitario)  AS ingreso_total
    FROM productos p
    INNER JOIN detalle_ventas dv ON dv.id_producto = p.id_producto
    INNER JOIN ventas v          ON v.id_venta     = dv.id_venta
    WHERE (p_id_producto IS NOT NULL AND p.id_producto = p_id_producto)
       OR (p_nombre      IS NOT NULL AND p.nombre LIKE CONCAT('%', p_nombre, '%'))
    GROUP BY p.id_producto, p.nombre;
END$$

DELIMITER ;

CALL sp_cosmeticos_por_tipo('labial');

CALL sp_productos_categoria_stock_bajo('cosmeticos', 10);

CALL sp_ventas_cliente_rango(3, '2026-01-01', '2026-12-31');
SELECT fn_total_ventas_empleado_mes(2, 2026, 1) AS total_empleado;

CALL sp_productos_mas_vendidos('2025-09-01', '2026-09-09');

CALL sp_consultar_stock(1, NULL);
CALL sp_consultar_stock(NULL, 'Labial');

CALL sp_ordenes_proveedor_ultimo_anio(1);

CALL sp_empleados_antiguedad_mayor_anio();

SELECT fn_total_productos_vendidos_dia('2025-06-05') AS unidades_dia;

CALL sp_ventas_por_producto(1, NULL);
CALL sp_ventas_por_producto(NULL, 'Perfume');
