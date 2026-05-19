-- Insertar categorías
INSERT INTO categories (name, description) VALUES 
('Electrónica', 'Dispositivos tecnológicos y gadgets'),
('Hogar', 'Muebles y decoración para el hogar'),
('Ropa', 'Prendas y accesorios de moda');

-- Insertar productos
INSERT INTO products (name, price, stock, category_id) VALUES
('Auriculares Bluetooth', 49.99, 20, (SELECT id FROM categories WHERE name = 'Electrónica')),
('Smartwatch', 129.99, 10, (SELECT id FROM categories WHERE name = 'Electrónica')),
('Lámpara de escritorio', 34.99, 15, (SELECT id FROM categories WHERE name = 'Hogar')),
('Cojín decorativo', 12.99, 50, (SELECT id FROM categories WHERE name = 'Hogar')),
('Camiseta básica', 9.99, 100, (SELECT id FROM categories WHERE name = 'Ropa')),
('Chaqueta de invierno', 79.99, 25, (SELECT id FROM categories WHERE name = 'Ropa'));

-- Simular una venta (restar stock)
UPDATE products 
SET stock = stock - 1 
WHERE name = 'Smartwatch';

-- Eliminar un producto
DELETE FROM products 
WHERE name = 'Cojín decorativo';