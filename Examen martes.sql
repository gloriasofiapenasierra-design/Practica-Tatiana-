CREATE DATABASE IF NOT EXISTS Libreria
CHARACTER SET utf8mb4 COLLATE utf8mb4_spanish_ci; 

USE Libreria;


CREATE TABLE Cliente (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    email VARCHAR(100),
    telefono VARCHAR(30)
);


CREATE TABLE autores (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(55),
    pais VARCHAR(20)
);


CREATE TABLE categorias (
    categorias_id INT PRIMARY KEY,
    nombre VARCHAR(56)
);


CREATE TABLE editoriales (
    editorial_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30),
    pais VARCHAR(30)
);


CREATE TABLE libros (
    libro_id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),  
    categoria_id INT,
    editorial_id INT,
    autor_id INT,
    año_publicacion DATE,
    precio DECIMAL(10, 2),
    FOREIGN KEY (categoria_id) REFERENCES categorias(categorias_id),
    FOREIGN KEY (editorial_id) REFERENCES editoriales(editorial_id),
    FOREIGN KEY (autor_id) REFERENCES autores(autor_id)    
);


CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATE,  
    cantidad INT,
    cliente_id INT,
    libro_id INT,
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (libro_id) REFERENCES libros(libro_id)
); 


INSERT INTO Cliente (nombre, email, telefono) VALUES
('Carlos Mendoza', 'carlosmendo@correo.com', '3101234567'),
('María Rodríguez', 'mariarodrigue@correo.com', '3209876543'),
('Marce Rodríguez', 'marcerodrigu@correo.com', '3209877753'),
('Karen Romero', 'karenromero@correo.com', '3009576750'),
('Daniel Romero', 'danielromero@correo.com', '3009576750'),
('Esteban Romero', 'estebanromero@correo.com', '3009576750'),
('Deisi Romero', 'deisiromero@correo.com', '3004076750'),
('lorena Romero', 'lorenaromero@correo.com', '3009666750'),
('Jaime Romero', 'jaimeromero@correo.com', '3009576750'),
('Lorenzo Romero', 'lorenzoromero@correo.com', '3013576750'),
('Andrés Gómez', 'andresgome@correo.com', '3555551234');

INSERT INTO editoriales (nombre, pais) VALUES 
('minerva', 'colombia'),
('Lobo', 'colombia'),
('cocina', 'Brazil'),
('se feliz', 'Mexico'),
('planeta', 'Italia'),
('agua', 'Estados Unidos'),
('arboles', 'India'),
('animales', 'China'),
('vida', 'Japon'),
('futbol', 'Argentina'),
('casco', 'Nigueria'),
('vidas felices', 'Filipinas');

INSERT INTO autores (Nombre, pais) VALUES
('Dana', 'Colombia'),
('Willson', 'Colombia'),
('Tatiana', 'Brazil'),
('Francis', 'Mexico'),
('Uta', 'Canada'),
('Carlos', 'Italia'),
('Karen', 'Puerto rico'),
('Yulia', 'Mexico'),
('Emiliano', 'Francia'),
('Santiago', 'Peru'),
('Kevin', 'Canda'),
('Raul', 'Italia');

INSERT INTO categorias (categorias_id, nombre) VALUES 
(1, 'terror'),
(2, 'misterio'),
(3, 'romance'),
(4, 'suspenso'),
(5, 'anime'),
(6, 'manga'),
(7, 'historia'),
(8, 'ciencia'),
(9, 'economia'),
(10, 'fantasia'),
(11, 'arte'),
(12, 'religion');


INSERT INTO libros (titulo, categoria_id, editorial_id, autor_id, año_publicacion, precio) VALUES
('Madres', 1, 1, 1, '2026-01-02', 56000.00),
('Leana', 2, 2, 2, '2022-03-04', 10000.00),
('Jhonaxis', 3, 3, 3, '2026-09-10', 20000.00),
('Rona', 4, 4, 4, '2000-06-06', 17000.00),
('Jamesval', 5, 5, 5, '2003-09-07', 7000.00),
('Yupites', 6, 6, 6, '2006-12-06', 6000.00),
('Padrino', 7, 7, 7, '2009-07-07', 9000.00),
('Patos', 8, 8, 8, '2009-06-09', 100.00),
('Mala', 9, 9, 9, '2012-08-02', 7000.00),
('Onda', 10, 10, 10, '2003-07-01', 2000.00),
('Silvando', 11, 11, 11, '2005-12-06', 107000.00),
('En silencio', 12, 12, 12, '2018-11-09', 1000000.00);


INSERT INTO ventas (fecha_venta, cantidad, cliente_id, libro_id) VALUES
('2026-04-28', 2, 1, 1),
('2026-07-29', 4, 2, 2),
('2026-02-10', 3, 3, 3),
('2026-02-06', 5, 4, 4),
('2026-06-06', 3, 5, 5),  
('2026-03-23', 7, 6, 6),  
('2026-07-22', 8, 7, 7),
('2026-04-21', 4, 8, 8),  
('2026-06-27', 9, 9, 9),
('2026-05-26', 12, 10, 10),
('2026-09-16', 34, 11, 11),
('2026-11-21', 22, 1, 12);



-- consulta entre dos tablas  :)
SELECT 
    l.titulo, 
    a.Nombre AS autor
FROM libros l
INNER JOIN autores a ON l.autor_id = a.autor_id;


-- Consultar todos los libros con su autor, categoría y editorial :)

SELECT 
    l.libro_id,
    l.titulo,
    a.Nombre AS autor,
    c.nombre AS categoria,
    e.nombre AS editorial,
    l.precio
FROM libros l
INNER JOIN autores a ON l.autor_id = a.autor_id
INNER JOIN categorias c ON l.categoria_id = c.categorias_id
INNER JOIN editoriales e ON l.editorial_id = e.editorial_id;

-- Obtener las ventas con los nombres de los clientes y títulos de los libros  ( no  se si funcione simepre )

SELECT 
    v.id_venta,
    v.fecha_venta,
    c.nombre AS cliente,
    l.titulo AS libro,
    v.cantidad,
    l.precio AS precio_unitario,
    (v.cantidad * l.precio) AS total_venta
FROM ventas v
INNER JOIN Cliente c ON v.cliente_id = c.cliente_id
INNER JOIN libros l ON v.libro_id = l.libro_id;


-- Consultar los libros por la categoría 'terror' :)

SELECT 
    l.titulo,
    c.nombre AS categoria,
    l.precio
FROM libros l
INNER JOIN categorias c ON l.categoria_id = c.categorias_id
WHERE c.nombre LIKE 'terror';



--  Actualizar  (en el precio cambienlo por si en la tabla ya tiene ese precio )  :)


UPDATE libros
SET precio = 65000.00
WHERE libro_id = 1;


-- Eliminar un cliente que ya no exista  (sin ejecutar aun ) :)


DELETE FROM Cliente
WHERE cliente_id = 11;



