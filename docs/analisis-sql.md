# Análisis SQL y Consultas Avanzadas - Fase 6

## 1. Consultas Solicitadas para el Proyecto

### Consulta A: INNER JOIN para obtener Producto, Precio y Categoría
Esta consulta combina ambas tablas mostrando únicamente los productos que tienen una categoría válida asignada.

```sql
SELECT 
    p.name AS producto, 
    p.price AS precio, 
    c.name AS categoria
FROM products p
INNER JOIN categories c ON p.category_id = c.id;

Consulta B: GROUP BY y COUNT() para conteo por categoría
Esta consulta agrupa los productos por el nombre de su categoría y cuenta cuántos artículos pertenecen a cada una.

SQL
SELECT 
    c.name AS categoria, 
    COUNT(p.id) AS total_productos
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
GROUP BY c.name;
(Nota: Se utiliza LEFT JOIN en el conteo para que, si en el futuro existe una categoría vacía sin productos, aparezca en el listado con un total de 0 en lugar de desaparecer del reporte).

## 2. Diferencia Funcional: INNER JOIN vs. LEFT JOIN
En el diseño de bases de datos relacionales, la elección del tipo de acoplamiento (JOIN) altera por completo el resultado de los datos obtenidos y la lógica del negocio.

INNER JOIN (Intersección Estricta)
Cómo funciona: Devuelve registros únicamente cuando existe una coincidencia exacta en ambas tablas involucradas. Si una fila de la tabla A no encuentra su pareja correspondiente en la tabla B, ese registro queda completamente excluido del resultado final.

Escenario del mundo real: Un reporte de facturación escolar o de pasarelas de pago. Si necesitas listar "Facturas cobradas con sus respectivos métodos de pago", usarías un INNER JOIN. Si una factura está en borrador o no tiene un método de pago registrado todavía, no debe aparecer en este listado analítico porque rompería la métrica de transacciones completadas.

LEFT JOIN (Inclusión de la Tabla Izquierda)
Cómo funciona: Devuelve todos los registros de la tabla de la izquierda (la primera que se menciona), junto con los datos coincidentes de la tabla de la derecha. Si un registro de la izquierda no tiene correspondencia en la derecha, la consulta lo muestra de todos modos, rellenando los campos de la tabla derecha con valores NULL.

Escenario del mundo real: Un panel de control de inventario o catálogo. Si deseas mostrar un listado de "Todas las categorías registradas en la plataforma y sus productos", utilizas un LEFT JOIN. Queremos que las categorías nuevas (por ejemplo, una categoría llamada 'Deportes' que acabamos de crear y aún no tiene stock) aparezcan en la pantalla del usuario, aunque sus columnas de producto salgan completamente vacías (NULL). Si usáramos un INNER JOIN, esa categoría nueva sería invisible para el sistema.