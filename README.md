# 📦 Inventario de Aprendizaje — Fase 6

> Proyecto full-stack desarrollado como parte del ciclo formativo **ASIR** en CEAC Valencia.  
> Stack: **Next.js · PostgreSQL · Neon DB · Vercel**

---

## 📌 Descripción

Aplicación de inventario de productos construida desde cero con una base de datos relacional **PostgreSQL serverless** alojada en **Neon DB**. El proyecto cubre el ciclo completo: modelado de datos, consultas SQL avanzadas, integración segura en backend y despliegue en producción.

---

## 🚀 Demo en producción

🔗 [Ver aplicación en Vercel](https://learning-inventory-wzdq.vercel.app)

---

## 🛠️ Tecnologías

| Capa | Tecnología |
|---|---|
| Frontend | Next.js 16, React, TypeScript |
| Backend | Next.js API Routes |
| Base de datos | PostgreSQL 17 (Neon DB serverless) |
| Driver | `@neondatabase/serverless` |
| Despliegue | Vercel |
| Control de versiones | Git + GitHub |

---

## 📂 Estructura del proyecto
learning-inventory/
├── app/
│   ├── api/
│   │   └── products/
│   │       └── route.ts      # Endpoints GET y POST
│   ├── lib/
│   │   └── db.ts             # Conexión a Neon DB
│   └── page.tsx              # Interfaz de usuario
├── sql/
│   ├── schema.sql            # Definición de tablas
│   └── seed.sql              # Datos de prueba
├── docs/
│   ├── arquitectura-datos.md # Foreign keys y ON DELETE
│   ├── analisis-sql.md       # INNER JOIN vs LEFT JOIN
│   └── seguridad-db.md       # SQL Injection y parámetros preparados
└── .env.local                # Variables de entorno (ignorado en git)

---

## ⚙️ Instalación local

```bash
# 1. Clonar el repositorio
git clone https://github.com/cristinaarlette29jora24-beep/learning-inventory.git
cd learning-inventory

# 2. Instalar dependencias
npm install

# 3. Configurar variables de entorno
# Crea un archivo .env.local con:
DATABASE_URL=postgresql://usuario:contraseña@host.neon.tech/neondb?sslmode=require

# 4. Arrancar en local
npm run dev
```

---

## 🗄️ Base de datos

El esquema incluye dos tablas relacionadas mediante **Foreign Key**:

- **`categories`** — id (UUID), name (UNIQUE), description
- **`products`** — id (UUID), name, price (CHECK > 0), stock, category_id (FK)

La relación usa `ON DELETE RESTRICT` para proteger la integridad referencial: no se puede eliminar una categoría si tiene productos asociados.

---

## 🔒 Seguridad

Todas las queries del backend usan **consultas parametrizadas** con el driver de Neon, separando los datos del usuario de la instrucción SQL y neutralizando cualquier intento de inyección SQL.

```typescript
// ✅ Seguro — parámetros separados
const result = await sql`
  INSERT INTO products (name, price, stock, category_id)
  VALUES (${name}, ${price}, ${stock}, ${category_id})
`;
```

---

## 💡 Ventajas de usar un ORM tipado (Drizzle / Prisma)

Aunque escribir SQL puro es fundamental para entender los cimientos de los motores relacionales, en proyectos grandes se suele incorporar un ORM como **Drizzle ORM** o **Prisma**.

Sus principales ventajas son:

- **Tipado de extremo a extremo:** El esquema se define en TypeScript. Si cambias una columna, el editor detecta errores antes de compilar.
- **Migraciones automáticas:** El ORM genera los scripts SQL necesarios al detectar cambios en el código.
- **Productividad:** Abstrae la sintaxis SQL en funciones nativas como `.findMany()`, manteniendo el código limpio y seguro por defecto.

---

## 📚 Documentación técnica

| Archivo | Contenido |
|---|---|
| `docs/arquitectura-datos.md` | Explicación de Foreign Keys y ON DELETE CASCADE vs RESTRICT |
| `docs/analisis-sql.md` | Diferencia entre INNER JOIN y LEFT JOIN con ejemplos reales |
| `docs/seguridad-db.md` | SQL Injection: demostración y prevención con parámetros preparados |