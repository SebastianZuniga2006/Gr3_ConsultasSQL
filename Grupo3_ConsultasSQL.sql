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

/*10. Muestre los PRODUCTOS, con su nombre y precio unitario y el nombre del proveedor.*/

SELECT * FROM PRODUCTOS
SELECT * FROM PROVEEDORES

SELECT P.DESCRIPCION AS 'NOMBRE PRODUCTO', P.PRECIOUNIT, PV.NOMBREPROV 
FROM PRODUCTOS P JOIN PROVEEDORES PV 
ON P.PROVEEDORID = PV.PROVEEDORID
GROUP BY P.DESCRIPCION, P.PRECIOUNIT, PV.NOMBREPROV

/*11. Muestre el nombre del cliente, el número de orden y la suma de unidades de productos incluidos en cada orden.*/

SELECT * FROM CLIENTES
SELECT * FROM DETALLE_ORDENES
SELECT * FROM ORDENES

SELECT C.NOMBRECIA, DO.ORDENID AS 'NÚMERO DE ORDEN', sum(DO.CANTIDAD) AS 'SUMA DE UNIDADES EN CADA ORDEN'
FROM CLIENTES C JOIN ORDENES O 
ON C.CLIENTEID = O.CLIENTEID 
JOIN DETALLE_ORDENES DO
ON DO.ORDENID = O.ORDENID
GROUP BY C.NOMBRECIA, DO.ORDENID 

/*12. Presente el nombre de la categoría, el número de productos en esa categoría, 
el precio promedio de los productos. Solo muestre los grupos en los que el precio promedio de productos sea > 10.*/
	
SELECT * FROM CATEGORIAS
SELECT * FROM PRODUCTOS

SELECT C.NOMBRECAT, count(P.CATEGORIAID) AS 'Productos x categoría', round(avg(P.PRECIOUNIT), 2) AS 'Precio promedio'
FROM CATEGORIAS C JOIN PRODUCTOS P 
ON C.CATEGORIAID = P.CATEGORIAID
GROUP BY C.NOMBRECAT
HAVING avg(P.PRECIOUNIT) > 10 


/*13. Muestre el número de orden, fecha de la orden, nombre de la compañía cliente,  
apellido y nombre del empleado que atendió la orden. */
	
SELECT * FROM ORDENES
SELECT * FROM CLIENTES
SELECT * FROM EMPLEADOS

SELECT O.ORDENID AS 'NÚMERO DE ORDEN', FECHAORDEN, NOMBRECIA, APELLIDO, NOMBRE
FROM ORDENES O JOIN CLIENTES C
ON O.CLIENTEID = C.CLIENTEID
JOIN EMPLEADOS E
ON O.EMPLEADOID = E.EMPLEADOID
ORDER BY O.ORDENID

/*14. Muestre el nombre de la categoría y el precio promedio de los productos en esa categoría.*/
	
SELECT * FROM CATEGORIAS
SELECT * FROM PRODUCTOS

SELECT NOMBRECAT, ROUND(AVG(P.PRECIOUNIT),2) AS 'PRECIO PROMEDIO'
FROM CATEGORIAS C JOIN PRODUCTOS P
ON C.CATEGORIAID = P.CATEGORIAID
GROUP BY NOMBRECAT


/*15. Muestre el nombre de las compañías cliente con el número de órdenes que tiene 
(cuántas órdenes tiene) */
	
SELECT * FROM CLIENTES
SELECT * FROM ORDENES

SELECT NOMBRECIA, COUNT(O.ORDENID) AS 'NÚMERO ORDENES'
FROM CLIENTES C JOIN ORDENES O
ON C.CLIENTEID = O.CLIENTEID
GROUP BY NOMBRECIA

