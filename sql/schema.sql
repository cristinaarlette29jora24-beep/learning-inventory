-- Tabla de categorías
CREATE TABLE categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(100) UNIQUE NOT NULL,
  description TEXT
);

-- Tabla de productos con foreign key a categories
CREATE TABLE products (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(150) NOT NULL,
  price NUMERIC(10,2) CHECK (price > 0),
  stock INTEGER DEFAULT 0,
  category_id UUID NOT NULL,
  CONSTRAINT fk_category FOREIGN KEY (category_id) 
    REFERENCES categories(id) ON DELETE RESTRICT
);