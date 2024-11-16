#Cargar el paquete RPostgres

install.packages("DBI")
install.packages("RPostgres")

library(DBI)
library(RPostgres)


#Creando una conexión a la base de datos PostgreSQL 

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",  
                 host = "localhost",          
                 port = 5432,                  
                 user = "postgres",          
                 password = "postgres")

#Cargar tabla pacientes

tabla_paciente<-read.csv("TABLAS/pacientes.csv")

#Visualizar tabla pacientes 
tabla_paciente

#Cargar y Visualizar tabla diagnosticos
tabla_diagnosticos<-read.csv("TABLAS/diagnosticos.csv")
tabla_diagnosticos

#Cargar y visualizar tablas tratamientos

tabla_tto<-read.csv("TABLAS/diagnosticos.csv")
tabla_tto
