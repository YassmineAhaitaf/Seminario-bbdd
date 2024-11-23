#Cargar el paquete RPostgres

install.packages("DBI")
install.packages("RPostgres")

library(DBI)
library(RPostgres)


#Creando una conexión a la base de datos PostgreSQL 

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",  
                 host = "localhost",          
                 port = 55708,                  
                 user = "postgres",          
                 password = "postgres")


dbListTables(con)
#CREANDO LA TABLA DE TRATAMIENTOS : 

tto<-read.csv("TABLAS/tratamientos.csv")

tto

tratamientos <- dbExecute(con, 
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



#CREANDO LA TABLA DE PACIENTES :


#CREANDO LA TABLA DE DIAGNOSTICOS : 





