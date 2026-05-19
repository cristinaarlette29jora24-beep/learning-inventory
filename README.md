Markdown
# 📦 Inventario de Aprendizaje - Fase 6

Proyecto full-stack desarrollado con **Next.js** y **React**, integrado con una base de datos relacional **PostgreSQL** serverless alojada en **Neon DB** y desplegado en **Vercel**. El objetivo principal de esta fase es el modelado robusto de datos, la persistencia segura y la mitigación de vulnerabilidades críticas como la inyección SQL.

---

## 🚀 Características del Proyecto

- **Framework:** Next.js con App Router y soporte nativo para TypeScript.
- **Base de Datos:** PostgreSQL en la nube (Neon DB) con arquitectura serverless y branching de datos.
- **Seguridad Avanzada:** Capa de persistencia blindada mediante el uso exclusivo de **consultas parametrizadas** (parámetros preparados).
- **Integridad Referencial:** Relaciones estrictas entre entidades utilizando claves primarias UUID y restricciones operativas seguras (`ON DELETE RESTRICT`).

---

## 📂 Estructura de la Fase 6

El proyecto incluye dos carpetas fundamentales requeridas para la auditoría técnica de esta fase:

### 1. Carpeta `sql/` (Scripts de Base de Datos)
Contiene las instrucciones estructuradas para el motor PostgreSQL:
- `schema.sql`: Definición del Modelo Entidad-Relación (tablas `categories` y `products`) utilizando restricciones `UNIQUE`, `CHECK` y tipos de datos de alta precisión como `NUMERIC` y `UUID`.
- `seed.sql`: Script de población inicial con datos de prueba reales, simulaciones de transacciones de inventario (actualización de stock) y pruebas de borrado controlado.

### 2. Carpeta `docs/` (Documentación Técnica Avanzada)
Auditoría y análisis detallado sobre el comportamiento del sistema:
- `arquitectura-datos.md`: Justificación del modelo relacional y análisis de seguridad entre la eliminación en cascada (`CASCADE`) frente a la restricción selectiva (`RESTRICT`).
- `analisis-sql.md`: Demostración práctica de consultas complejas utilizando `INNER JOIN` frente a `LEFT JOIN`, y analíticas grupales con `GROUP BY` y funciones agregadas (`COUNT`).
- `seguridad-db.md`: Estudio e ingeniería inversa sobre cómo se produce una vulnerabilidad de Inyección SQL y cómo la neutralizamos usando parámetros preparados en Node/Next.js.

---

## 🛠️ Tecnologías Utilizadas

- **Frontend & Backend:** Next.js, React, Tailwind CSS, TypeScript.
- **Base de Datos & Driver:** PostgreSQL, Neon DB, `@neondatabase/serverless`.
- **Despliegue:** Vercel (Integración continua conectada al repositorio de GitHub).

---

## 🔒 Variables de Entorno

Para que el proyecto funcione localmente, es indispensable configurar las credenciales maestras en un archivo `.env.local` (el cual se encuentra protegido e ignorado en el `.gitignore` por motivos de seguridad):

```env
DATABASE_URL=postgres://tu_usuario:tu_contraseña@tu_host.neon.tech/learning-inventory?sslmode=require
💡 Ventajas de la Abstracción con ORMs (Drizzle / Prisma)
Nota de investigación integrada: Aunque escribir SQL puro (sql/) es vital para entender los cimientos de los motores relacionales y optimizar el rendimiento de las consultas, en entornos de producción a gran escala se suele incorporar un ORM (como Drizzle ORM o Prisma).

Las principales ventajas que aportan al flujo de desarrollo son:

Tipado de Extremo a Extremo (Type-Safety): Permiten definir el esquema de la base de datos directamente en TypeScript. Si cambias el nombre de una columna, el editor te marcará errores en todo el código antes de compilar, evitando fallos en producción.

Migraciones Automatizadas: El ORM detecta los cambios del código y genera los scripts SQL necesarios para actualizar la base de datos automáticamente, manteniendo la coherencia del equipo de desarrollo.

Productividad: Abstrae la sintaxis compleja de SQL en funciones nativas del lenguaje (por ejemplo, .findMany()), manteniendo el código limpio, legible y protegido por defecto contra inyecciones de código.