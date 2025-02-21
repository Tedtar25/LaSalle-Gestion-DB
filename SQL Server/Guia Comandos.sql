-- Crear la base de datos
CREATE DATABASE Guia_Comandos;
GO

-- Usar la base de datos
USE Guia_Comandos;
GO

-- Crear tablas
-- Tabla Libro
CREATE TABLE Libro(
    IdLibro INT PRIMARY KEY IDENTITY(1,1), 
    Titulo VARCHAR(100) NOT NULL,
    Autor VARCHAR(100) NOT NULL,
    Genero VARCHAR(100),
    FechaPublicacion DATE
);

-- Tabla Usuario
CREATE TABLE Usuario(
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(100),
    Correo VARCHAR(100) UNIQUE
);

-- Tabla Prestamo
CREATE TABLE Prestamo(
    IdPrestamo INT PRIMARY KEY IDENTITY(1,1),
    FechaInicio DATE NOT NULL,
    FechaEntrega DATE,
    Estado BIT
);

-- Tabla DetallePrestamo
CREATE TABLE DetallePrestamo(
    IdDetallePrestamo INT PRIMARY KEY IDENTITY(1,1),
    IdLibro INT FOREIGN KEY REFERENCES Libro(IdLibro),
    IdUsuario INT FOREIGN KEY REFERENCES Usuario(IdUsuario),
    IdPrestamo INT FOREIGN KEY REFERENCES Prestamo(IdPrestamo)
);

-- Insertar datos en las tablas
-- Insertar datos en la tabla Libro
INSERT INTO Libro (Titulo, Autor, Genero, FechaPublicacion) VALUES
('El alquimista', 'Paulo Coelho', 'Novela', '1988-01-01'),
('Cien años de soledad', 'Gabriel García Márquez', 'Realismo mágico', '1967-01-01'),
('1984', 'George Orwell', 'Ciencia ficción', '1949-01-01'),
('Orgullo y prejuicio', 'Jane Austen', 'Novela romántica', '1813-01-01'),
('Harry Potter y la piedra filosofal', 'J.K. Rowling', 'Fantasía', '1997-01-01'),
('Crimen y castigo', 'Fyodor Dostoevsky', 'Novela', '1866-01-01'),
('El código Da Vinci', 'Dan Brown', 'Misterio', '2003-01-01'),
('Matar a un ruiseñor', 'Harper Lee', 'Novela', '1960-01-01'),
('Don Quijote de la Mancha', 'Miguel de Cervantes', 'Novela', '1605-01-01'),
('La Odisea', 'Homero', 'Épica', '0700-01-01');

-- Insertar datos en la tabla Usuario
INSERT INTO Usuario (Nombre, Direccion, Correo) VALUES
('Juan Perez', 'Calle 123, Ciudad ABC', 'juanperez@gmail.com'),
('María López', 'Avenida XYZ, Pueblo Z', 'marialopez@hotmail.com'),
('Pedro Martinez', 'Carrera 456, Villa W', 'pedromartinez@yahoo.com'),
('Ana Gómez', 'Plaza Principal, Ciudad XYZ', 'anagomez@gmail.com'),
('Luis Ramirez', 'Calle Mayor, Pueblo Y', 'luisramirez@hotmail.com'),
('Laura García', 'Avenida Norte, Villa X', 'lauragarcia@yahoo.com'),
('Carlos Rodríguez', 'Calle Sur, Ciudad Z', 'carlosrodriguez@gmail.com'),
('Sofía Fernández', 'Avenida Oeste, Pueblo W', 'sofiafernandez@hotmail.com'),
('Diego Sanchez', 'Carrera Este, Villa Y', 'diegosanchez@yahoo.com'),
('Valentina Torres', 'Calle Este, Ciudad X', 'valentinatorres@gmail.com');

-- Insertar datos en la tabla Prestamo
INSERT INTO Prestamo (FechaInicio, FechaEntrega, Estado) VALUES
('2024-04-01', '2024-04-15', 1),
('2024-04-02', '2024-04-16', 1),
('2024-04-03', '2024-04-17', 1),
('2024-04-04', '2024-04-18', 1),
('2024-04-05', '2024-04-19', 1),
('2024-04-06', '2024-04-20', 1),
('2024-04-07', '2024-04-21', 1),
('2024-04-08', '2024-04-22', 1),
('2024-04-09', '2024-04-23', 1),
('2024-04-10', '2024-04-24', 1);

-- Insertar datos en la tabla DetallePrestamo
INSERT INTO DetallePrestamo (IdLibro, IdUsuario, IdPrestamo) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5),
(6, 6, 6),
(7, 7, 7),
(8, 8, 8),
(9, 9, 9),
(10, 10, 10);

-- Crear vistas
-- Vista fácil: Lista de libros con su autor
CREATE VIEW VistaLibrosAutores AS
SELECT Titulo, Autor
FROM Libro;

-- Vista media: Lista de préstamos con información del libro y el usuario
CREATE VIEW VistaPrestamos AS
SELECT 
    P.IdPrestamo, 
    U.Nombre AS Usuario, 
    L.Titulo AS Libro, 
    P.FechaInicio, 
    P.FechaEntrega, 
    P.Estado
FROM Prestamo P
INNER JOIN DetallePrestamo DP ON P.IdPrestamo = DP.IdPrestamo
INNER JOIN Usuario U ON DP.IdUsuario = U.IdUsuario
INNER JOIN Libro L ON DP.IdLibro = L.IdLibro;

-- Vista compleja: Lista de usuarios con la cantidad de préstamos realizados
CREATE VIEW VistaUsuariosConCantidadPrestamos AS
SELECT 
    U.Nombre, 
    COUNT(DP.IdPrestamo) AS CantidadPrestamos
FROM Usuario U
INNER JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario
GROUP BY U.Nombre;

-- Consultas con INNER JOIN
-- Consulta fácil: Libros prestados con los nombres de los usuarios
SELECT L.Titulo, U.Nombre
FROM Libro L
INNER JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro
INNER JOIN Usuario U ON DP.IdUsuario = U.IdUsuario;

-- Consulta media: Información de préstamos incluyendo estado y fechas
SELECT P.IdPrestamo, L.Titulo, U.Nombre, P.FechaInicio, P.FechaEntrega, P.Estado
FROM Prestamo P
INNER JOIN DetallePrestamo DP ON P.IdPrestamo = DP.IdPrestamo
INNER JOIN Libro L ON DP.IdLibro = L.IdLibro
INNER JOIN Usuario U ON DP.IdUsuario = U.IdUsuario;

-- Consulta compleja: Lista de usuarios con libros prestados, incluyendo géneros
SELECT U.Nombre, L.Titulo, L.Genero, P.FechaInicio, P.FechaEntrega
FROM Usuario U
INNER JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario
INNER JOIN Libro L ON DP.IdLibro = L.IdLibro
INNER JOIN Prestamo P ON DP.IdPrestamo = P.IdPrestamo;

-- Consultas con RIGHT JOIN
-- Consulta fácil: Usuarios que han realizado préstamos y los libros prestados
SELECT U.Nombre, L.Titulo
FROM Usuario U
RIGHT JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario
RIGHT JOIN Libro L ON DP.IdLibro = L.IdLibro;

-- Consulta media: Información de préstamos con posibles usuarios y libros no prestados
SELECT P.IdPrestamo, L.Titulo, U.Nombre, P.FechaInicio, P.FechaEntrega, P.Estado
FROM Prestamo P
RIGHT JOIN DetallePrestamo DP ON P.IdPrestamo = DP.IdPrestamo
RIGHT JOIN Libro L ON DP.IdLibro = L.IdLibro
RIGHT JOIN Usuario U ON DP.IdUsuario = U.IdUsuario;

-- Consulta compleja: Lista de todos los libros, incluyendo los que no han sido prestados, con usuarios posibles
SELECT L.Titulo, U.Nombre, P.FechaInicio, P.FechaEntrega
FROM Libro L
RIGHT JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro
RIGHT JOIN Usuario U ON DP.IdUsuario = U.IdUsuario
RIGHT JOIN Prestamo P ON DP.IdPrestamo = P.IdPrestamo;

-- Consultas con LEFT JOIN
-- Consulta fácil: Usuarios y los libros que han prestado, incluyendo los usuarios sin préstamos
SELECT U.Nombre, L.Titulo
FROM Usuario U
LEFT JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario
LEFT JOIN Libro L ON DP.IdLibro = L.IdLibro;

-- Consulta media: Información de préstamos incluyendo usuarios y libros posibles, incluso si no han sido prestados
SELECT P.IdPrestamo, L.Titulo, U.Nombre, P.FechaInicio, P.FechaEntrega, P.Estado
FROM Prestamo P
LEFT JOIN DetallePrestamo DP ON P.IdPrestamo = DP.IdPrestamo
LEFT JOIN Libro L ON DP.IdLibro = L.IdLibro
LEFT JOIN Usuario U ON DP.IdUsuario = U.IdUsuario;

-- Consulta compleja: Lista de todos los libros con usuarios posibles, incluyendo libros no prestados
SELECT L.Titulo, U.Nombre, P.FechaInicio, P.FechaEntrega
FROM Libro L
LEFT JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro
LEFT JOIN Usuario U ON DP.IdUsuario = U.IdUsuario
LEFT JOIN Prestamo P ON DP.IdPrestamo = P.IdPrestamo;

-- Consultas con funciones de agregación y INNER JOIN
-- Suma del total de ventas
SELECT SUM(Precio * Cantidad) AS [Ventas Totales]
FROM Libro
INNER JOIN DetallePrestamo ON Libro.IdLibro = DetallePrestamo.IdLibro;

-- Promedio de precios de libros vendidos
SELECT AVG(Precio) AS [Promedio Precios Libros Vendidos]
FROM Libro
INNER JOIN DetallePrestamo ON Libro.IdLibro = DetallePrestamo.IdLibro;

-- Precio máximo de los libros vendidos
SELECT MAX(Precio) AS [Precio máximo de los libros vendidos]
FROM Libro
INNER JOIN DetallePrestamo ON Libro.IdLibro = DetallePrestamo.IdLibro;

-- Precio mínimo de los libros vendidos
SELECT MIN(Precio) AS [Precio mínimo de los libros vendidos]
FROM Libro
INNER JOIN DetallePrestamo ON Libro.IdLibro = DetallePrestamo.IdLibro;

-- Cantidad total de libros vendidos
SELECT SUM(Cantidad) AS [Cantidad total de libros vendidos]
FROM DetallePrestamo;

-- Consultas con UNION
-- Lista de títulos de libros y nombres de usuarios, combinando dos consultas
SELECT Titulo AS Nombre FROM Libro
UNION
SELECT Nombre FROM Usuario;

-- Lista de géneros de libros y estados de préstamos, combinando dos consultas
SELECT Genero AS Descripcion FROM Libro
UNION
SELECT CASE Estado WHEN 1 THEN 'Activo' ELSE 'Inactivo' END FROM Prestamo;

-- Lista de direcciones de usuarios y títulos de libros, combinando dos consultas
SELECT Direccion FROM Usuario
UNION
SELECT Titulo FROM Libro;

-- Consultas con EXCEPT
-- Libros que no están en la lista de préstamos
SELECT Titulo FROM Libro
EXCEPT
SELECT L.Titulo FROM Libro L
INNER JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro;

-- Usuarios que no han realizado préstamos
SELECT Nombre FROM Usuario
EXCEPT
SELECT U.Nombre FROM Usuario U
INNER JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario;

-- Géneros de libros que no están prestados
SELECT Genero FROM Libro
EXCEPT
SELECT L.Genero FROM Libro L
INNER JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro;

-- Consultas con INTERSECT
-- Libros que están en la lista de préstamos
SELECT Titulo FROM Libro
INTERSECT
SELECT L.Titulo FROM Libro L
INNER JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro;

-- Usuarios que han realizado préstamos
SELECT Nombre FROM Usuario
INTERSECT
SELECT U.Nombre FROM Usuario U
INNER JOIN DetallePrestamo DP ON U.IdUsuario = DP.IdUsuario;

-- Géneros de libros que están prestados
SELECT Genero FROM Libro
INTERSECT
SELECT L.Genero FROM Libro L
INNER JOIN DetallePrestamo DP ON L.IdLibro = DP.IdLibro;

-- Consultas con COUNT
-- Contar el total de libros
SELECT COUNT(*) AS TotalLibros FROM Libro;

-- Contar el total de usuarios
SELECT COUNT(*) AS TotalUsuarios FROM Usuario;

-- Contar el total de préstamos
SELECT COUNT(*) AS TotalPrestamos FROM Prestamo;

-- Consultas con LIKE
-- Buscar materia específica
SELECT * FROM Materia
WHERE Nombre = 'GIBD';

-- Buscar materias que empiecen con 'G'
SELECT * FROM Materia
WHERE Nombre LIKE 'G%';

-- Buscar materias que terminen con 'BD'
SELECT * FROM Materia
WHERE Nombre LIKE '%BD';

-- Buscar materias que comiencen con 'F' o 'P'
SELECT * FROM Materia
WHERE Nombre LIKE 'P%' OR Nombre LIKE 'F%';

-- Buscar materias que empiecen con 'G' y terminen con 'D'
SELECT * FROM Materia
WHERE Nombre LIKE 'G%D';

-- Buscar materias con letra 'P' en cualquier parte del nombre
SELECT * FROM Materia
WHERE Nombre LIKE '%P%';

-- Triggers
-- Trigger para INSERT en Usuario
CREATE TABLE LogUsuario(
    IdUsuario INT,
    FechaAlta DATETIME
);

CREATE TRIGGER tgr_LogUsuario
ON Usuario
AFTER INSERT
AS
BEGIN
    INSERT INTO LogUsuario(IdUsuario, FechaAlta)
    SELECT IdUsuario, GETDATE() FROM inserted;
END
GO

-- Probar el trigger de INSERT
SELECT * FROM LogUsuario;
SELECT * FROM Usuario;
INSERT INTO Usuario (Nombre, Direccion, Correo) VALUES
('Nuevo Usuario', 'Direccion Nueva', 'nuevo.usuario@example.com');
GO

-- Trigger para DELETE en Prestamo
CREATE TABLE AuditPrestamo(
    IdPrestamo INT,
    FechaBaja DATETIME
);

CREATE TRIGGER tgr_AuditPrestamo
ON Prestamo
AFTER DELETE
AS
BEGIN
    INSERT INTO AuditPrestamo(IdPrestamo, FechaBaja)
    SELECT IdPrestamo, GETDATE() FROM deleted;
END
GO

-- Probar el trigger de DELETE
SELECT * FROM AuditPrestamo;
SELECT * FROM Prestamo;
DELETE FROM Prestamo WHERE IdPrestamo = 1;
GO

-- Trigger para UPDATE en DetallePrestamo
CREATE TABLE LogDetallePrestamo(
    IdDetallePrestamo INT,
    IdUsuario INT,
    IdLibro INT,
    IdPrestamo INT,
    FechaModificacion DATETIME
);

CREATE TRIGGER tgr_LogDetallePrestamo
ON DetallePrestamo
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogDetallePrestamo(IdDetallePrestamo, IdUsuario, IdLibro, IdPrestamo, FechaModificacion)
    SELECT 
        inserted.IdDetallePrestamo,
        inserted.IdUsuario,
        inserted.IdLibro,
        inserted.IdPrestamo,
        GETDATE()
    FROM 
        inserted;
END
GO

-- Probar el trigger de UPDATE
SELECT * FROM LogDetallePrestamo;
SELECT * FROM DetallePrestamo;
UPDATE DetallePrestamo SET IdUsuario = 2 WHERE IdDetallePrestamo = 1;
GO