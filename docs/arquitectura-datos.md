# Arquitectura de Datos - Fase 6

## 1. Significado de `category_id` como Foreign Key (Clave Foránea)
En nuestro modelo relacional, la columna `category_id` dentro de la tabla `products` actúa como una **Foreign Key (FK)** o clave foránea. Esto significa que establece un "enlace" o relación directa con la columna `id` (Primary Key) de la tabla `categories`. 

Técnicamente, su función es garantizar la **integridad referencial**. Esto asegura que:
- No se pueda introducir un producto con un código de categoría que no exista previamente en la tabla de categorías.
- El motor de la base de datos valide automáticamente esta relación en cada inserción o modificación.

---

## 2. Comportamiento ante borrados: ¿ON DELETE CASCADE o ON DELETE RESTRICT?

Al intentar ejecutar un comando `DELETE` sobre una categoría que todavía tiene productos asociados, el comportamiento configurado en nuestro esquema es **`ON DELETE RESTRICT`**.

### ¿Cuál es más seguro?
Para este escenario de negocio (tienda / inventario), **`ON DELETE RESTRICT` es el comportamiento más seguro**. 

### Justificación:
- **`ON DELETE RESTRICT` (Elegido):** Bloquea por completo la eliminación de la categoría si existen productos vinculados a ella. Esto evita catástrofes operativas, como borrar accidentalmente la categoría "Electrónica" y perder o dejar sin categoría todos los productos caros asociados a ella (como el Smartwatch o los Auriculares). Obliga al administrador a reubicar o eliminar primero los productos antes de poder deshacerse de la categoría.
- **`ON DELETE CASCADE`:** Si se eliminara una categoría, borraría de forma automática e irreversible **todos** los productos asociados en cascada. En un entorno de inventario real, esto podría causar pérdidas masivas de datos históricos y de stock por un simple error humano al gestionar las categorías.