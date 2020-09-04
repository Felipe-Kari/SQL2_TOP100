--(1)Crear base de datos llamada películas

CREATE DATABASE peliculas;

--(2)Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,determinando la relación entre ambas tablas.

CREATE TABLE peliculas(
id SERIAL NOT NULL UNIQUE,
pelicula VARCHAR(60) NOT NULL,
año_estreno INT NOT NULL,
director VARCHAR(30) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE reparto(
id_pelicula INT NOT NULL,
nombre VARCHAR(30) NOT NULL,
FOREIGN KEY(id_pelicula) REFERENCES peliculas(id)
);

--(3)Cargar ambos archivos a su tabla correspondiente.

\copy peliculas FROM '/home/felipe/Documentos/desafiolatam/c_DBs/D02_Top 100/peliculas.csv' CSV HEADER;

\copy reparto FROM '/home/felipe/Documentos/desafiolatam/c_DBs/D02_Top 100/reparto.csv' CSV;


--(4)Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,año de estreno, director y todo el reparto.

SELECT peliculas.*, reparto.nombre AS reparto FROM peliculas
JOIN reparto ON peliculas.id = reparto.id_pelicula
WHERE id_pelicula = 2;

--(5)Listar los titulos de las películas donde actúe Harrison Ford.

SELECT peliculas.pelicula FROM peliculas
JOIN reparto ON peliculas.id = reparto.id_pelicula
WHERE reparto.nombre = 'Harrison Ford';

--(6)Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en eltop 100.

SELECT peliculas.director, COUNT(peliculas.director) FROM peliculas
GROUP BY peliculas.director
ORDER BY COUNT(peliculas.director) DESC
LIMIT(10);

--(7)Indicar cuantos actores distintos hay.

SELECT COUNT(DISTINCT nombre) FROM reparto;

--(8)Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas portítulo de manera ascendente.

SELECT pelicula FROM peliculas
WHERE año_estreno BETWEEN 1990 AND 1999
ORDER BY año_estreno;

--(9)Listar el reparto de las películas lanzadas el año 2001.

SELECT reparto.nombre FROM reparto
JOIN peliculas ON reparto.id_pelicula = peliculas.id
WHERE año_estreno = 2001;

--(10)Listar los actores de la película más nueva.

SELECT reparto.nombre FROM reparto
INNER JOIN peliculas ON reparto.id_pelicula = peliculas.id
WHERE peliculas.año_estreno = (SELECT MAX(peliculas.año_estreno) FROM peliculas);