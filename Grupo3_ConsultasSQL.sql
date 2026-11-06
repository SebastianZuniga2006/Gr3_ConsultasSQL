-- TAREA CONSULTAS SQL -- 
-- Grupo No.: 3
-- Integrantes: Echeverría Steven, Palomeque Matías, Quillupangui Ana María y Zúñiga Sebastián 

use master
go

use PEDIDOS
go

set dateformat dmy

--1. Ingrese un nuevo empleado
select * from EMPLEADOS
INSERT INTO EMPLEADOS VALUES (8, 3, 'MARTIN','BURGOS','13/12/89',270)
select * from EMPLEADOS

--2. Ingresar una nueva categoría 
select * from CATEGORIAS
INSERT INTO CATEGORIAS VALUES (800, 'CONDIMENTOS')
select * from CATEGORIAS

--3. Ingresar 4 productos asociados a la categoría creada en el numeral 2.
select * from PRODUCTOS
select * from PROVEEDORES
INSERT INTO PRODUCTOS VALUES (12,800,20,'SALSA DE TOMATE',2.50,200)
INSERT INTO PRODUCTOS VALUES (14, 800,20,'MOSTAZA',3.00,15)
INSERT INTO PRODUCTOS VALUES (15,800,20,'ACEITE DE OLIVA',14.30,50)
INSERT INTO PRODUCTOS VALUES (16,800,120,'CHIMICHURRI',6.30,300)
select * from PRODUCTOS

--4. Ingresar una nueva orden para el SUPERMERCADO DESCUENTO.
select * from ORDENES
INSERT INTO ORDENES VALUES (11,7,8,'14/02/12',3)
select * from ORDENES

/* 5. Ingresar dos registros de detalle_ordenes, relacionados con la orden ingresada en el numeral 4, 
en la que se incluya 3 de los productos que ingresó en el numeral 3 */
select * from DETALLE_ORDENES
INSERT INTO DETALLE_ORDENES VALUES (11,1,12,50)
INSERT INTO DETALLE_ORDENES VALUES (11,2,14,10)
INSERT INTO DETALLE_ORDENES VALUES (11,3,15,30)
select * from DETALLE_ORDENES

-- 6. Actualice el precio de los productos que ingresó en el numeral 3 (de la nueva categoría), subiendo el 5% */
UPDATE PRODUCTOS

	-- se empleó la función "round" para calcular el precio con dos decimales de precisión
SET PRECIOUNIT = ROUND(PRECIOUNIT * 1.05, 2)
WHERE CATEGORIAID = '800'
SELECT * FROM PRODUCTOS

-- 7. Borre el registro del producto que no se ha incluido en la orden. 
DELETE FROM PRODUCTOS
WHERE PRODUCTOID = '16'
SELECT * FROM PRODUCTOS

/*8. Mostrar todos los PRODUCTOS con su nombre y el total de unidades (suma de CANTIDAD) 
incluidas en las ORDENES. Debe mostrar todos los productos, aún si no han sido incluidos 
en ninguna orden. Para probar el SELECT, previamente inserte estos registros: */
INSERT INTO PRODUCTOS VALUES (16, 200, 30, 'QUESO FRESCO', 3.5, 10), 
                             (17, 200, 40, 'QUESO MADURO', 4.5, 10);
SELECT * FROM PRODUCTOS
SELECT * FROM DETALLE_ORDENES

SELECT P.PRODUCTOID, DESCRIPCION, ISNULL(SUM(CANTIDAD), 0) AS 'Total unidades ORDENES' 
FROM PRODUCTOS P
LEFT JOIN DETALLE_ORDENES DO ON P.PRODUCTOID = DO.PRODUCTOID
GROUP BY P.PRODUCTOID, DESCRIPCION

/*9. Muestre el número de órdenes que tiene cada cliente, indicando el nombre de la compañía cliente 
y el número de órdenes, solo de las compañías que tengan más de 3 órdenes. */

SELECT * FROM ORDENES
SELECT * FROM CLIENTES

SELECT C.NOMBRECIA, count(O.CLIENTEID) AS 'Numero de ordenes'
FROM ORDENES O JOIN CLIENTES C 
ON O.CLIENTEID = C.CLIENTEID
GROUP BY C.NOMBRECIA, O.CLIENTEID
HAVING count(O.CLIENTEID) > 3

