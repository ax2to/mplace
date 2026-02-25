-- MPLACE setup script (entorno local educativo)
-- Ejecutar con: mysql -u root -p < sql/setup.sql
-- Inserta datos demo idempotentes: 3 productos + 1 usuario

CREATE DATABASE IF NOT EXISTS mplace_app;
USE mplace_app;

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  price DECIMAL(10,2) NOT NULL,
  image VARCHAR(500) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO products (title, description, price, image)
SELECT 'PlayStation 5', 'Consola de videojuegos de ultima generacion.', 500.00, 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=1200'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE title = 'PlayStation 5');

INSERT INTO products (title, description, price, image)
SELECT 'Nintendo Switch', 'Consola hibrida para jugar en casa o portatil.', 300.00, 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=1200'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE title = 'Nintendo Switch');

INSERT INTO products (title, description, price, image)
SELECT 'Meta Quest 2', 'Visor de realidad virtual para juegos y experiencias inmersivas.', 200.00, 'https://images.unsplash.com/photo-1622979135225-d2ba269cf1ac?w=1200'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE title = 'Meta Quest 2');

INSERT INTO users (email, password)
SELECT 'demo@mplace.local', '$2b$10$ckCFRbYYqI7X30WxMh7by.zpasuOOWOQ.rNCqkX0JeoSTbvmt1Vuq'
WHERE NOT EXISTS (SELECT 1 FROM users WHERE email = 'demo@mplace.local');
