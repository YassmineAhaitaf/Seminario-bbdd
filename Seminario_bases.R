#Cargar el paquete RPostgres

install.packages("DBI")
install.packages("RPostgres")

library(DBI)
library(RPostgres)


#Creando una conexión a la base de datos PostgreSQL 

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",  
                 host = "localhost",          
                 port = 56914,               
                 user = "postgres",          
                 password = "postgres")


dbListTables(con)
#CREANDO LA TABLA DE TRATAMIENTOS : 

tto<-read.csv("TABLAS/tratamientos.csv")

tto
dbExecute(con, "DROP TABLE IF EXISTS diagnosticos;")
dbExecute(con, 
          "
          create table tratamientos (
          id_tratamiento SERIAL PRIMARY KEY , 
          id_paciente varchar(50),
          tipo_tratamiento varchar(50),
          detalle varchar(50),
          duracion_meses smallint check (duracion_meses >=0 and duracion_meses<=24) , 
          frecuencia varchar(30) check (frecuencia in ('Diario','Única','Semanal','Mensual')) , 
          resultado_esperado varchar(70) not null 
          )" )

#AGREGANDO LOS VALORES A LA TABLA TRATAMIENTOS :
dbExecute(con,"INSERT INTO tratamientos (id_paciente, tipo_tratamiento, detalle, duracion_meses, frecuencia, resultado_esperado)
VALUES 
('P001', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 7, 'Diario', 'Reducir colesterol'),
('P002', 'Farmacológico', 'Atorvastatina', 16, 'Diario', 'Reducir colesterol'),
('P003', 'Intervención Quirúrgica', 'Colocación de Stent', 21, 'Única', 'Reducir colesterol'),
('P004', 'Farmacológico', 'Bisoprolol', 11, 'Única', 'Mejorar flujo sanguíneo'),
('P005', 'Farmacológico', 'Aspirina', 19, 'Diario', 'Reducir presión arterial'),
('P006', 'Intervención Quirúrgica', 'Bypass Coronario', 24, 'Diario', 'Reducir presión arterial'),
('P007', 'Farmacológico', 'Atorvastatina', 9, 'Diario', 'Mejorar flujo sanguíneo'),
('P008', 'Farmacológico', 'Metformina', 10, 'Diario', 'Mejorar flujo sanguíneo'),
('P009', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 19, 'Diario', 'Reducir colesterol'),
('P010', 'Intervención Quirúrgica', 'Colocación de Stent', 18, 'Única', 'Reducir colesterol'),
('P011', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 4, 'Única', 'Reducir colesterol'),
('P012', 'Farmacológico', 'Losartán', 13, 'Semanal', 'Reducir colesterol'),
('P013', 'Farmacológico', 'Aspirina', 15, 'Única', 'Mejorar flujo sanguíneo'),
('P014', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 20, 'Única', 'Reducir colesterol'),
('P015', 'Cambio de Estilo de Vida', 'Dieta Mediterránea', 16, 'Diario', 'Reducir presión arterial'),
('P016', 'Cambio de Estilo de Vida', 'Dieta Mediterránea', 19, 'Semanal', 'Mejorar flujo sanguíneo'),
('P017', 'Intervención Quirúrgica', 'Colocación de Stent', 23, 'Semanal', 'Mejorar flujo sanguíneo'),
('P018', 'Farmacológico', 'Aspirina', 5, 'Semanal', 'Reducir colesterol'),
('P019', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 6, 'Diario', 'Reducir colesterol'),
('P020', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 8, 'Diario', 'Reducir presión arterial'),
('P021', 'Intervención Quirúrgica', 'Bypass Coronario', 7, 'Diario', 'Reducir presión arterial'),
('P022', 'Intervención Quirúrgica', 'Colocación de Stent', 21, 'Única', 'Reducir colesterol'),
('P023', 'Intervención Quirúrgica', 'Colocación de Stent', 18, 'Única', 'Mejorar flujo sanguíneo'),
('P024', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 9, 'Diario', 'Mejorar flujo sanguíneo'),
('P025', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 3, 'Semanal', 'Mejorar flujo sanguíneo'),
('P026', 'Farmacológico', 'Bisoprolol', 8, 'Única', 'Mejorar flujo sanguíneo'),
('P027', 'Farmacológico', 'Bisoprolol', 20, 'Diario', 'Reducir colesterol'),
('P028', 'Farmacológico', 'Bisoprolol', 17, 'Semanal', 'Mejorar flujo sanguíneo'),
('P029', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 22, 'Diario', 'Mejorar flujo sanguíneo'),
('P030', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 8, 'Diario', 'Reducir colesterol'),
('P031', 'Farmacológico', 'Aspirina', 1, 'Semanal', 'Reducir presión arterial'),
('P032', 'Intervención Quirúrgica', 'Bypass Coronario', 7, 'Semanal', 'Reducir colesterol'),
('P033', 'Intervención Quirúrgica', 'Bypass Coronario', 21, 'Semanal', 'Reducir colesterol'),
('P034', 'Farmacológico', 'Metformina', 16, 'Diario', 'Reducir colesterol'),
('P035', 'Farmacológico', 'Metformina', 13, 'Semanal', 'Reducir presión arterial');
")



#CREANDO LA TABLA DE PACIENTES :
dbExecute(con, "DROP TABLE IF EXISTS pacientes;")
dbExecute(con,"CREATE TABLE pacientes(ID_pacientes SERIAL PRIMARY KEY,
          Nombre varchar(100) not null, 
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


#CREANDO LA TABLA DE DIAGNOSTICOS : 
dbExecute(con, "DROP TABLE IF EXISTS diagnosticos;")
dbExecute(con, "Create table diagnosticos(Id_diagnostico SERIAL PRIMARY KEY, 
          ID_Paciente integer references pacientes(ID_pacientes),
          Fecha DATE NOT NULL,
          Enfermedad_cardiovascular varchar(255),
          Gravedad varchar(25) check (Gravedad in ('Moderada','Alta','Crítica')),
          Riesgo_asociado varchar(25) check (Riesgo_asociado in ('Muerte súbita', 'Edema pulmonar','IAM') ),
          Plan_de_seguimiento varchar(25)
          );")





