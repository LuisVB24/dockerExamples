# Creamos la base de datos
CREATE database VuelosMexico;

# Procedemos a usar la base de datos 
USE VuelosMexico;

#Creacion de las diferentes tablas

# Tabla Aerolineas
CREATE table aerolineas(
    id_aerolinea int(10) not null primary key,
    nombre_aerolinea varchar(20)
);

# Tabla Aeropuertos
CREATE table aeropuertos(
    id_aeropuerto int(10) not null primary key,
    ciudad varchar(20)
);

# Tabla Movimientos
CREATE table movimientos(
    id_movimientos int(10) not null primary key,
    descripcion varchar(20)
);

# Tabla de Cardinalidad Vuelos
CREATE table vuelos(
    id_aerolinea int(10),
    id_aeropuerto int(10),
    id_movimientos int(10),
    dia date
);

# Agregemos ahora la informacion

# Tabla Aerolineas
INSERT into aerolineas(id_aerolinea,nombre_aerolinea)
VALUES
    (1,'Volaris'),
    (2,'Aeromar'),
    (3,'Interjet'),
    (4,'Aeromexico');

# Tabla Aeropuertos
INSERT into aeropuertos(id_aeropuerto,ciudad)
VALUES
    (1,'Benito Juarez'),
    (2,'Guanajuato'),
    (3,'La paz'),
    (4,'Oaxaca');

# Tabla Movimientos
INSERT into movimientos(id_movimientos,descripcion)
VALUES 
    (1,'Salida'),
    (2,'Llegada');

# Ahora toca a la tabla de Cardinalidad llamada Vuelos
# Lo primero es agregar las llaves foraneas
ALTER table vuelos ADD foreign key (id_aerolinea) REFERENCES aerolineas(id_aerolinea);
ALTER table vuelos ADD foreign key (id_aeropuerto) REFERENCES aeropuertos(id_aeropuerto);
ALTER table vuelos ADD foreign key (id_movimientos) REFERENCES movimientos(id_movimientos);
SHOW CREATE table vuelos;

# Insertemos ahora los datos en esta tabla
INSERT into vuelos(id_aerolinea,id_aeropuerto,id_movimientos,dia)
VALUES
    (1,1,1,'2021-05-02'),
    (2,1,1,'2021-05-02'),
    (3,2,2,'2021-05-02'),
    (4,3,2,'2021-05-02'),
    (1,3,2,'2021-05-02'),
    (2,1,1,'2021-05-02'),
    (2,3,1,'2021-05-04'),
    (3,4,1,'2021-05-04'),
    (3,4,1,'2021-05-04');


#  Tablas creadas !! Es tiempo de los querys

# Nombre del Aeropuerto (Ciudad) con mayor movimiento en el año
SELECT ciudad from aeropuertos where id_aeropuerto in 
    (SELECT id_aeropuerto from 
        (SELECT id_aeropuerto, count(id_aeropuerto) contador from vuelos group by id_aeropuerto) AS T1 
            WHERE contador IN (SELECT max(contador) from
                (SELECT id_aeropuerto, count(id_aeropuerto) contador from vuelos group by id_aeropuerto) AS T2));

# Nombre de la Aerolinea con mayor num vuelos en el año
SELECT nombre_aerolinea from aerolineas WHERE id_aerolinea in
    (SELECT id_aerolinea from 
        (SELECT id_aerolinea, count(id_aerolinea) contador from vuelos group by id_aerolinea) AS T1
            WHERE contador IN (SELECT max(contador) from 
                (SELECT id_aerolinea,count(id_aerolinea) contador from vuelos group by id_aerolinea) AS T2));

# Dia con mayor numero de vuelos
SELECT dia from (SELECT dia,count(dia) contador from vuelos group by dia) AS T1 
    WHERE contador IN (SELECT max(contador) from (SELECT dia,count(dia) contador from vuelos group by dia) AS T2);

# Aerolineas con más de 2 vuelos por día
SELECT nombre_aerolinea from aerolineas WHERE id_aerolinea in (SELECT id_aerolinea from vuelos group by id_aerolinea Having count(dia)>1);



