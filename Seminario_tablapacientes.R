# Cargar el paquete RPostgres
library(DBI)
library(RPostgres)

# Conectar a la base de datos PostgreSQL
con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",  # Nombre de la base de datos
                 host = "localhost",           # Dirección del host
                 port = 5432,                  # Puerto de PostgreSQL
                 user = "postgres",          # Tu usuario de PostgreSQL
                 password = "postgres")   # Tu contraseña de PostgreSQL
dbExecute(con, "DROP TABLE IF EXISTS pacientes;")
dbExecute(con,"CREATE TABLE pacientes(ID_pacientes SERIAL PRIMARY KEY,
          Nombre varchar(100), 
          Edad integer CHECK (edad >= 0),
          Genero varchar(10) check (Genero in ('M', 'F')),
          IMC decimal(3,1) check (IMC > 0),
          Presion_Arterial varchar(10),
          Colesterol integer,
          Antecedentes_familiar varchar(3) check (Antecedentes_familiar in ('No','Sí')),
          Fumador varchar(3) check (Fumador in ('No','Sí')),
          Diabetico varchar(3) check (Diabetico in ('No','Sí'))
);
")
dbExecute(con,"insert into pacientes values (001, 'Thomas Johnston', 64, 'M', 21.4,'131/87',255,'No','No','Sí'),
          (002, 'George Simmons', 67, 'M', 37.3, '151/96', 199, 'No', 'No', 'No'),
          (003, 'Lisa Coleman',41, 'F', 30.5, '131/96', 205, 'No', 'No','No'),
          (004, 'Danielle Burnett', 85, 'M', 32.4, '127/88',252,'Sí','Sí','Sí'),
          (005, 'Heather Scott',55,'M',28.7,'125/95', 252,'Sí','Sí','Sí'),
          (006, 'Brett Williams', 45, 'M',32.4,'157/99',211, 'No','No','Sí'),
          (007, 'David Dominguez', 70, 'M',32.8,'120/93',null, 'Sí', 'Sí','No'),
          (008,'Robert Burton',51, 'M',33.9,'152/88',191,'Sí','No','No'),
          (009, 'Sonya Larson',53,'F',25.4, '158/90',198,'No','Sí','Sí'),
          (010, 'Tonya Green',68,'F',29.7,'136/87',197,'No','Sí','Sí'),
          (011, 'Stephanie Weeks',50,'F',26.3, '152/91',192,'No','No','Sí'),
          (012, 'Samantha Mcconell', 61, 'F', 41.5,'137/90', 190,'No','No','Sí'),
          (013,'Amy Whitehead', 75,'F',33.8,null, 189,'Sí','Sí','No'),
          (014, 'Willam Fry',72,'M',43.0,'139/97',254,'No','No','No'),
          (015,'John Pachec0',48,'F',36.2,'141/96',171,'No','No','Sí'),
          (016,'Joshua Hernandez', 50, 'M',28.4,'134/82',186,'Sí','No','Sí'),
          (017, 'Ryan Baker',76,'M',33.9,'136/89',226,'No','No','No'),
          (018, 'Kathleen Miller', 68,'F',18.2,'141/88', null,'No','Sí','No')")
resultado <- dbGetQuery(con, "SELECT * FROM pacientes;")
print(resultado)