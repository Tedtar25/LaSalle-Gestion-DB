CREATE DATABASE GIBD_3P_PR03
GO

USE GIBD_3P_PR03
GO

-- Crear las tablas necesarias
CREATE TABLE Productos (
    IdProducto INT PRIMARY KEY,
    Nombre NVARCHAR(200),
    Precio MONEY
);

CREATE TABLE Ventas (
    IdVenta INT PRIMARY KEY,
    IdProducto INT,
    Cantidad INT,
    Fecha DATE
);

CREATE TABLE Inventario (
    IdInventario INT PRIMARY KEY,
    IdProducto INT,
    Cantidad INT
);

CREATE TABLE RegistroPrecios (
    IdRegistroPrecio INT PRIMARY KEY IDENTITY,
    IdProducto INT,
    PrecioAnterior MONEY,
    PrecioNuevo MONEY,
    FechaCambio DATETIME
);

-- Insertar registros en la tabla Productos e Inventario (Lego)
INSERT INTO Productos (IdProducto, Nombre, Precio) VALUES
(1, 'Lego City Police Station', 100.00),
(2, 'Lego Star Wars Millennium Falcon', 150.00),
(3, 'Lego Creator Expert Taj Mahal', 200.00),
(4, 'Lego Technic Bugatti Chiron', 350.00),
(5, 'Lego Friends Heartlake City Resort', 80.00);

INSERT INTO Inventario (IdInventario, IdProducto, Cantidad) VALUES
(1, 1, 50),
(2, 2, 30),
(3, 3, 20),
(4, 4, 10),
(5, 5, 40);

-- Crear el trigger para actualizar el inventario después de una venta
CREATE TRIGGER trg_update_inventario
ON Ventas
AFTER INSERT
AS
BEGIN
    UPDATE Inventario
    SET Inventario.Cantidad = Inventario.Cantidad - i.Cantidad
    FROM Inventario
    INNER JOIN inserted i ON Inventario.IdProducto = i.IdProducto;
END;

-- Insertar registros en la tabla Ventas para validar el trigger
INSERT INTO Ventas (IdVenta, IdProducto, Cantidad, Fecha) VALUES
(1, 1, 5, GETDATE()),
(2, 2, 3, GETDATE()),
(3, 3, 2, GETDATE()),
(4, 4, 1, GETDATE());

-- Crear el trigger para registrar cambios de precio
CREATE TRIGGER trg_RegistrarCambio
ON Productos
AFTER UPDATE
AS
BEGIN
    INSERT INTO RegistroPrecios (IdProducto, PrecioAnterior, PrecioNuevo, FechaCambio)
    SELECT d.IdProducto, d.Precio, i.Precio, GETDATE()
    FROM deleted d
    INNER JOIN inserted i ON d.IdProducto = i.IdProducto;
END;

-- Cambiar los precios de algunos productos para validar el trigger
UPDATE Productos SET Precio = 105.00 WHERE IdProducto = 1;
UPDATE Productos SET Precio = 155.00 WHERE IdProducto = 2;
UPDATE Productos SET Precio = 205.00 WHERE IdProducto = 3;

-- Consultar los registros para verificar los cambios
SELECT * FROM Productos;
SELECT * FROM Inventario;
SELECT * FROM RegistroPrecios;
SELECT * FROM Ventas;
