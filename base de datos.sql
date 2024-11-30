CREATE DATABASE GESTION_EVENTOS;
USE GESTION_EVENTOS;

CREATE TABLE EVENTOS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(255) ,
    DESCRIPCION TEXT,
    FECHA_HORA DATETIME,
    LUGAR VARCHAR(255),
    CAPACIDAD_MAX INT
);

CREATE TABLE USUARIOS (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(255),
    CORREO VARCHAR(255),
    ROL ENUM('administrador', 'usuario')
);


CREATE TABLE INSCRIPCIONES (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    ID_EVENTO INT,
    ID_USUARIO INT,
    FECHA_INSCRIPCION TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ESTADO ENUM('Activo', 'Cancelado'),
    FOREIGN KEY (ID_EVENTO) REFERENCES EVENTOS(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIOS(ID) ON DELETE CASCADE
);

  SELECT 
          e.ID AS evento_id,
          e.NOMBRE AS nombre_evento,
          COUNT(i.ID) AS numero_de_inscripciones
        FROM 
          EVENTOS e
        LEFT JOIN 
          INSCRIPCIONES i ON e.ID = i.ID_EVENTO
        GROUP BY 
          e.ID
        ORDER BY 
          numero_de_inscripciones DESC
        LIMIT 5;
        
        UPDATE INSCRIPCIONES
         SET ESTADO = 'Cancelado'
         WHERE ID_USUARIO = ? AND ID_EVENTO = ? AND ESTADO = 'Activo'
   