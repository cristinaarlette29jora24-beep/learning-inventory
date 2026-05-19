Markdown
# Auditoría de Seguridad de la Base de Datos - Fase 6

## 1. ¿Qué es una Inyección SQL (SQL Injection)?

La **Inyección SQL** es una de las vulnerabilidades más críticas en el desarrollo web. Ocurre cuando una aplicación web permite que datos introducidos por un usuario (por ejemplo, en un formulario de búsqueda, un login o un input) se concatenen directamente dentro de una sentencia SQL sin ninguna validación previa.

Al hacer esto, el motor de la base de datos no puede distinguir dónde termina la estructura de la consulta programada y dónde empiezan los datos del usuario. Como resultado, un atacante puede "inyectar" comandos SQL maliciosos para saltarse la autenticación, ver datos confidenciales, modificar la base de datos o incluso borrar tablas enteras (`DROP TABLE`).

---

## 2. Demostración Técnica y Prevención

### El Código Vulnerable (Malas Prácticas)
Si quisiéramos buscar un producto por su nombre y concatenamos la variable directamente, el código se vería así:

```javascript
// El atacante escribe en el buscador: Camiseta' OR '1'='1
const busquedaUsuario = "Camiseta' OR '1'='1"; 

// Esto genera la consulta: SELECT * FROM products WHERE name = 'Camiseta' OR '1'='1';
const queryVulnerable = "SELECT * FROM products WHERE name = '" + busquedaUsuario + "'";
Consecuencia: Como '1'='1' siempre es verdadero (TRUE), la base de datos ignorará el filtro del nombre y devolverá absolutamente todos los productos del inventario, exponiendo información privada.

El Código Seguro (Consultas Parametrizadas)
Para evitar este peligro, en nuestra capa de persistencia se utilizan consultas parametrizadas (o marcadores de posición). Mediante esta técnica, el driver de la base de datos envía las instrucciones SQL por un lado y los datos del usuario por otro completamente separado.

Aquí tienes el ejemplo de cómo implementamos la inserción segura de productos en nuestro backend:

TypeScript
// Datos que vienen de la solicitud del usuario
const nuevoProducto = {
  name: "Teclado Mecánico",
  price: 89.99,
  stock: 15,
  category_id: "id-de-la-categoria-aqui"
};

// CONSULTA SEGURA: Usamos los marcadores $1, $2, $3 y $4
const querySegura = `
  INSERT INTO products (name, price, stock, category_id) 
  VALUES ($1, $2, $3, $4)
  RETURNING *;
`;

// Pasamos los valores en un array independiente
const valores = [
  nuevoProducto.name, 
  nuevoProducto.price, 
  nuevoProducto.stock, 
  nuevoProducto.category_id
];

// El driver envía la consulta y los valores por canales distintos
const resultado = await db.query(querySegura, valores);
¿Por qué es seguro este método?
Aunque el usuario intente escribir comandos SQL o comillas en el campo de texto, el motor de PostgreSQL tratará toda su entrada estrictamente como una simple cadena de texto plana (un string) dentro de $1, inutilizando por completo cualquier intento de ejecutar comandos arbitrarios.