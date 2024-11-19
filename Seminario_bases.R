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


#CREANDO LA TABLA DE TRATAMIENTOS : 






