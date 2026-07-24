
CREATE DATABASE IF NOT EXISTS HogarAmigoPeludo;
USE HogarAmigoPeludo;


CREATE TABLE administradores (
    id INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,

    correo VARCHAR(120) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,

    rol ENUM(
        'Administrador',
        'Transportista'
    ) DEFAULT 'Transportista',

    estado BOOLEAN DEFAULT TRUE,

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE mascotas (

    id INT PRIMARY KEY AUTO_INCREMENT,

    nombre VARCHAR(80),

    especie ENUM(
        'Perro',
        'Gato'
    ) NOT NULL,

    raza VARCHAR(80),

    genero ENUM(
        'Macho',
        'Hembra'
    ),

    edad INT,

    tamano ENUM(
        'Pequeño',
        'Mediano',
        'Grande'
    ),

    peso DECIMAL(5,2),

    salud TEXT,

    descripcion TEXT,

    foto VARCHAR(255),

    estado ENUM(

        'Disponible',
        'Reservado',
        'En proceso de adopción',
        'Adoptado'

    ) DEFAULT 'Disponible',

    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);



CREATE TABLE solicitudes (

    id INT PRIMARY KEY AUTO_INCREMENT,

    codigo VARCHAR(20) UNIQUE NOT NULL,

    mascota_id INT NOT NULL,

    nombre VARCHAR(80) NOT NULL,

    apellido VARCHAR(80) NOT NULL,

    documento VARCHAR(20) NOT NULL,

    edad INT,

    correo VARCHAR(120),

    telefono VARCHAR(20),

    ciudad VARCHAR(80),

    direccion VARCHAR(150),

    vivienda VARCHAR(80),

    tipo_vivienda VARCHAR(80),

    horas_solo INT,

    mascotas_actuales TEXT,

    comentario TEXT,

    estado ENUM(

        'En revisión',
        'Aceptada',
        'Negada',
        'Proceso de entrega',
        'Adoptada'

    ) DEFAULT 'En revisión',

    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (mascota_id)
        REFERENCES mascotas(id)
);


CREATE TABLE entregas (

    id INT PRIMARY KEY AUTO_INCREMENT,

    solicitud_id INT NOT NULL,

    transportista_id INT,

    fecha_programada DATE,

    fecha_entrega DATE,

    observaciones TEXT,

    estado ENUM(

        'Pendiente',
        'En camino',
        'Entregado',
        'Cancelado'

    ) DEFAULT 'Pendiente',

    FOREIGN KEY (solicitud_id)
        REFERENCES solicitudes(id),

    FOREIGN KEY (transportista_id)
        REFERENCES administradores(id)
);


CREATE TABLE historial_estados (

    id INT PRIMARY KEY AUTO_INCREMENT,

    solicitud_id INT NOT NULL,

    administrador_id INT,

    estado ENUM(

        'En revisión',
        'Aceptada',
        'Negada',
        'Proceso de entrega',
        'Adoptada'

    ),

    comentario TEXT,

    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (solicitud_id)
        REFERENCES solicitudes(id),

    FOREIGN KEY (administrador_id)
        REFERENCES administradores(id)
);