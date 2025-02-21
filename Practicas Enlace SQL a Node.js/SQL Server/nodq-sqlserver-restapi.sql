CREATE DATABASE SQLSERVER_RESTAPI
GO

USE SQLSERVER_RESTAPI
GO

--TABLAS
CREATE TABLE Usuarios (
    IdUsuario INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(100) NOT NULL,
    Correo NVARCHAR(100) UNIQUE NOT NULL,
    Contrasenia NVARCHAR(255) NOT NULL
);
GO

CREATE TABLE Peliculas (
    IdPelicula INT PRIMARY KEY IDENTITY,
    Titulo NVARCHAR(255),
    Anio INT,
    IdDirector INT FOREIGN KEY REFERENCES Directores(DirectorID),
    Sinopsis NVARCHAR(1000),
    Duracion INT, -- duración en minutos
    IdGenero INT FOREIGN KEY REFERENCES Generos(GeneroID)
);
GO

CREATE TABLE Series (
    IdSerie INT PRIMARY KEY IDENTITY,
    Titulo NVARCHAR(255),
    Anio INT,
    IdDirector INT FOREIGN KEY REFERENCES Directores(DirectorID),
    Sinopsis NVARCHAR(1000),
    Temporadas INT,
    IdGenero INT FOREIGN KEY REFERENCES Generos(GeneroID)
);
GO

CREATE TABLE Documentales (
    IdDocumental INT PRIMARY KEY IDENTITY,
    Titulo NVARCHAR(255),
    Anio INT,
    IdDirector INT FOREIGN KEY REFERENCES Directores(DirectorID),
    Sinopsis NVARCHAR(1000),
    Duracion INT, -- duración en minutos
    IdGenero INT FOREIGN KEY REFERENCES Generos(GeneroID)
);
GO

CREATE TABLE Actores (
    IdActor INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(255),
    FechaNacimiento DATE,
    Nacionalidad NVARCHAR(100)
);
GO

CREATE TABLE Directores (
    IdDirector INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(255),
    FechaNacimiento DATE,
    Nacionalidad NVARCHAR(100)
);
GO

CREATE TABLE Generos (
    IdGenero INT PRIMARY KEY IDENTITY,
    Nombre NVARCHAR(100)
);
GO

CREATE TABLE PeliculasActores (
    PeliculaID INT FOREIGN KEY REFERENCES Peliculas(PeliculaID),
    ActorID INT FOREIGN KEY REFERENCES Actores(ActorID),
    PRIMARY KEY (PeliculaID, ActorID)
);
GO

CREATE TABLE SeriesActores (
    SerieID INT FOREIGN KEY REFERENCES Series(SerieID),
    ActorID INT FOREIGN KEY REFERENCES Actores(ActorID),
    PRIMARY KEY (SerieID, ActorID)
);
GO

CREATE TABLE DocumentalesActores (
    DocumentalID INT FOREIGN KEY REFERENCES Documentales(DocumentalID),
    ActorID INT FOREIGN KEY REFERENCES Actores(ActorID),
    PRIMARY KEY (DocumentalID, ActorID)
);
GO