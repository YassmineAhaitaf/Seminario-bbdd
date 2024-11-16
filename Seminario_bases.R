#Cargar el paquete RPostgres

library(DBI)
install.packages("RPostgres")


#Creando una conexión a la base de datos PostgreSQL 

con <- dbConnect(RPostgreSQL::PostgreSQL(),
                 dbname = "postgres" ,
                 host = "localhost" ,
                 port = 5432 ,
                 user = "postgres" ,
                 password = "postgres")
