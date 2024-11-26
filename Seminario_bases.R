#Cargar el paquete RPostgres

install.packages("DBI")
install.packages("RPostgres")

library(DBI)
library(RPostgres)


#Creando una conexión a la base de datos PostgreSQL 

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "postgres",  
                 host = "localhost",          
                 port = 51971,               
                 user = "postgres",          
                 password = "postgres")


#CREANDO LA TABLA DE TRATAMIENTOS : 



dbExecute(con, "DROP TABLE IF EXISTS tratamientos cascade;")
dbExecute(con, 
          "
          create table tratamientos (
          id_tratamiento SERIAL PRIMARY KEY , 
          ID_Paciente integer references pacientes(ID_pacientes) ON DELETE CASCADE ON UPDATE CASCADE,
          tipo_tratamiento varchar(50) unique not null,
          detalle varchar(50),
          duracion_meses smallint check (duracion_meses >=0 and duracion_meses<=24) , 
          frecuencia varchar(30) check (frecuencia in ('Diario','Única','Semanal','Mensual')) , 
          resultado_esperado varchar(70) not null ,
          CONSTRAINT fk_paciente FOREIGN KEY (ID_Paciente) 
        REFERENCES pacientes(ID_pacientes) 
        ON UPDATE CASCADE 
        ON DELETE CASCADE
          ;" )




#AGREGANDO LOS VALORES A LA TABLA TRATAMIENTOS :
dbExecute(con,"INSERT INTO tratamientos (id_paciente, tipo_tratamiento, detalle, duracion_meses, frecuencia, resultado_esperado)
VALUES 
('001', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 7, 'Diario', 'Reducir colesterol'),
('002', 'Farmacológico', 'Atorvastatina', 16, 'Diario', 'Reducir colesterol'),
('003', 'Intervención Quirúrgica', 'Colocación de Stent', 21, 'Única', 'Reducir colesterol'),
('004', 'Farmacológico', 'Bisoprolol', 11, 'Única', 'Mejorar flujo sanguíneo'),
('005', 'Farmacológico', 'Aspirina', 19, 'Diario', 'Reducir presión arterial'),
('006', 'Intervención Quirúrgica', 'Bypass Coronario', 24, 'Diario', 'Reducir presión arterial'),
('007', 'Farmacológico', 'Atorvastatina', 9, 'Diario', 'Mejorar flujo sanguíneo'),
('008', 'Farmacológico', 'Metformina', 10, 'Diario', 'Mejorar flujo sanguíneo'),
('009', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 19, 'Diario', 'Reducir colesterol'),
('010', 'Intervención Quirúrgica', 'Colocación de Stent', 18, 'Única', 'Reducir colesterol'),
('011', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 4, 'Única', 'Reducir colesterol'),
('012', 'Farmacológico', 'Losartán', 13, 'Semanal', 'Reducir colesterol'),
('013', 'Farmacológico', 'Aspirina', 15, 'Única', 'Mejorar flujo sanguíneo'),
('014', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 20, 'Única', 'Reducir colesterol'),
('015', 'Cambio de Estilo de Vida', 'Dieta Mediterránea', 16, 'Diario', 'Reducir presión arterial'),
('016', 'Cambio de Estilo de Vida', 'Dieta Mediterránea', 19, 'Semanal', 'Mejorar flujo sanguíneo'),
('017', 'Intervención Quirúrgica', 'Colocación de Stent', 23, 'Semanal', 'Mejorar flujo sanguíneo'),
('018', 'Farmacológico', 'Aspirina', 5, 'Semanal', 'Reducir colesterol'),
('019', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 6, 'Diario', 'Reducir colesterol'),
('020', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 8, 'Diario', 'Reducir presión arterial'),
('021', 'Intervención Quirúrgica', 'Bypass Coronario', 7, 'Diario', 'Reducir presión arterial'),
('022', 'Intervención Quirúrgica', 'Colocación de Stent', 21, 'Única', 'Reducir colesterol'),
('023', 'Intervención Quirúrgica', 'Colocación de Stent', 18, 'Única', 'Mejorar flujo sanguíneo'),
('024', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 9, 'Diario', 'Mejorar flujo sanguíneo'),
('025', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 3, 'Semanal', 'Mejorar flujo sanguíneo'),
('026', 'Farmacológico', 'Bisoprolol', 8, 'Única', 'Mejorar flujo sanguíneo'),
('027', 'Farmacológico', 'Bisoprolol', 20, 'Diario', 'Reducir colesterol'),
('028', 'Farmacológico', 'Bisoprolol', 17, 'Semanal', 'Mejorar flujo sanguíneo'),
('029', 'Cambio de Estilo de Vida', 'Ejercicio Aeróbico', 22, 'Diario', 'Mejorar flujo sanguíneo'),
('030', 'Cambio de Estilo de Vida', 'Reducción de Sodio', 8, 'Diario', 'Reducir colesterol'),
('031', 'Farmacológico', 'Aspirina', 1, 'Semanal', 'Reducir presión arterial'),
('032', 'Intervención Quirúrgica', 'Bypass Coronario', 7, 'Semanal', 'Reducir colesterol'),
('033', 'Intervención Quirúrgica', 'Bypass Coronario', 21, 'Semanal', 'Reducir colesterol'),
('034', 'Farmacológico', 'Metformina', 16, 'Diario', 'Reducir colesterol'),
('035', 'Farmacológico', 'Metformina', 13, 'Semanal', 'Reducir presión arterial');
")



#CREANDO LA TABLA DE PACIENTES :
dbExecute(con, "DROP TABLE IF EXISTS pacientes cascade;")
dbExecute(con,"CREATE TABLE pacientes(ID_pacientes SERIAL PRIMARY KEY,
          Nombre varchar(100) unique not null, 
          Edad integer CHECK (edad >= 0),
          Genero varchar(10) check (Genero in ('M', 'F')),
          IMC decimal(3,1) check (IMC > 0),
          Presion_Arterial varchar(10),
          Colesterol integer,
          Antecedentes_familiar varchar(3) check (Antecedentes_familiar in ('No','Sí')),
          Fumador varchar(3) check (Fumador in ('No','Sí')),
          Diabetico varchar(3) check (Diabetico in ('No','Sí')), 
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
          (018, 'Kathleen Miller', 68,'F',18.2,'141/88', null,'No','Sí','No'),
          (019,'Dr Candace Guerrero',62,'F',30.9,'145/96', 211, 'Sí', 'No', 'Sí'),
          (020, 'Duane Mcmillan', 53, 'M', 41.9, '152/88', 214, 'Sí', 'Sí', 'Sí'),
          (021, 'Matthew Walker', 77, 'F', 31.2, '155/83', 164,'No', 'Sí', 'No'),
          (022,'Zachary Byrd', 62, 'M',39.0, '152/99',187, 'Sí', 'No', 'No'),
          (023, 'Joyce Figueroa', 41, 'M', 21.8, '132/83', 197, 'Sí', 'Sí', 'Sí'),
          (024,'Gerald Patel',42,'F', 23.8, '158/100' , 226, 'No', 'No', 'Sí'),
          (025,'Rhonda Jones', 47, 'M', 22.3, '150/82', 253, 'Sí', 'Sí', 'No'),
          (026, 'Lauren Garcia', 73, 'M', 32.1, '127/92', 157, 'No', 'No', 'Sí'),
          (027, 'Brian Wright', 53, 'M', 28.0, '124/95',254, 'No', 'No', 'Sí'),
          (028, 'Daniel Allen', 68, 'M', 28.7, '131/92', 179, 'Sí', 'Sí', 'Sí' ),
          (029, 'Travis Bishon', 73, 'M', 33.8, '157/94', 169, 'Sí','No','No'),
          (030,'Morgan Walsh', 84,'M', 45.2, '125/92', 209, 'Sí', 'Sí', 'Sí' ),
          (031, 'Laarbi Nejar', 66, 'M', 33.6, '149/97', 211, 'Sí', 'Sí', 'No'),
          (032, 'Samira Boueza', 61, 'F',14.5, '157/96', 199, 'Sí', 'No', 'Sí'),
          (033, 'Tibari Khelkhoul', 74, 'M', 20.5, '145/87', 219,'No','Sí','Sí'),
          (034, 'Nasera Elmeqali', 85, 'F', 15.7,'127/80', 158, 'No', 'Sí','No'),
          (035, 'Lalla Menana', 44, 'F', 19.6, '125/96', 159, 'No', 'No','Sí');")
resultado <- dbGetQuery(con, "SELECT * FROM pacientes;")
print(resultado)


#CREANDO LA TABLA DE DIAGNOSTICOS : 

dbExecute(con, "DROP TABLE IF EXISTS diagnosticos;")
dbExecute(con, "CREATE TABLE diagnosticos(Id_diagnostico SERIAL PRIMARY KEY, 
          ID_Paciente integer references pacientes(ID_pacientes),
          Fecha DATE NOT NULL check (Fecha < current_date),
          Enfermedad_cardiovascular varchar(255),
          Gravedad varchar(25) check (Gravedad in ('Moderada','Alta','Crítica')),
          Riesgo_asociado varchar(25) check (Riesgo_asociado in ('Muerte súbita', 'Edema pulmonar','IAM','ACV','Angina de pecho') ),
          Plan_de_seguimiento varchar(50),
          		CONSTRAINT fk_paciente_diag FOREIGN KEY (ID_Paciente) 
        REFERENCES pacientes(ID_pacientes)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
          );")
#Agregando valores a la tabla diagnosticos:
dbExecute(con,"Insert into diagnosticos values(001,001,'2024-06-14','Hypertensión Arterial','Alta','Muerte súbita','Hospitalización recurrente'),
          (002, 002, '2013-06-11','Hipertensión Arterial','Alta','Edema pulmonar','Rehabilitación cardiovascular'),
          (003, 003, '2021-06-10','Infarta Agudo de Miocardio','Crítica','Muerte súbita','Consulta trimestral'),
          (004, 004, '2021-03-04','Hipertensión Arterial','Crítica','Muerte súbita','Consulta trimestral'),
          (005, 005, '2022-01-16','Hipertensión Arterial','Alta','ACV','Control semestral de lípidos'),
          (006, 006, '2024-04-21','Hipertensión Arterial','Crítica','Angina de pecho','Rehabilitación cardiovascular'),
          (007, 007, '2022-01-06','Insuficiencia Cardíaca','Moderada','Muerte súbita','Seguimiento anual'),
          (008, 008, '2021-02-26','Insuficiencia Cardíaca','Moderada','IAM','consulta trimestral'),
          (009, 009, '2021-12-24', 'Hipercolesterolemia', 'Moderada', 'IAM', 'Seguimiento anual' ),
          (010, 010, '2020-03-25','Insuficiencia Cardíaca', 'Crítica', 'IAM','Rehabilitación cardiovascular'),
          (011, 011, '2022-06-25', 'Infarto Agudo de Miocardio', 'Alta', 'Angina de pecho', 'Seguimiento anual'),
          (012, 012, '2022-08-06', 'Infarto Agudo de Miocardio', 'Moderada', 'ACV', 'Rehabilitación cardiovascular'),
          (013, 013, '2020-01-18', 'Insuficiencia Cardíaca', 'Crítica', 'Angina de pecho', 'Hospitalización recurrente'),
          (014, 014, '2019-11-27', 'Aterosclerosis Coronaria', 'Alta', 'Edema pulmonar', 'Consulta trimestral'),
          (015, 015, '2023-07-18', 'Hipertensión Arterial', 'Crítica', 'Angina de pecho', 'Control semestral de lípidos'),
          (016, 016, '2021-03-02', 'Hipercolesterolemia', 'Alta', 'ACV', 'Rehabilitación cardiovascular'),
          (017, 017, '2021-01-06', 'Hipercolesterolemia', 'Moderada', 'Edema pulmonar', 'Rehabilitación cardiovascular'),
          (018, 018, '2021-09-24', 'Infarto Agudo de Miocardio', 'Moderada', 'Edema pulmonar', 'Control semestral de lípidos'),
          (019, 019, '2021-08-18', 'Hipertensión Arterial', 'Moderada', 'IAM', 'Consulta trimestral'),
          (020, 020, '2021-01-24', 'Insuficiencia Cardíaca', 'Alta', 'IAM', 'Rehabilitación cardiovascular'),
          (021, 021,  '2020-01-24', 'Hipercolesterolemia', 'Alta', 'ACV', 'Rehabilitación cardiovascular'),
          (022, 022, '2020-07-03', 'Hipertensión Arterial',  'Crítica', 'IAM',  'Rehabilitación cardiovascular'),
          (023, 023, '2024-03-24', 'Insuficiencia Cardíaca', 'Moderada', 'Muerte súbita', 'Hospitalización recurrente'),
          (024, 024, '2021-04-17', 'Insuficiencia Cardíaca', 'Crítica', 'IAM', 'Control semestral de lípidos'),
          (025, 025, '2023-04-02', 'Hipertensión Arterial', 'Moderada', 'ACV', 'Hospitalización recurrente'),
          (026, 026, '2021-12-31', 'Infarto Agudo de Miocardio', 'Moderada', 'Edema pulmonar', 'Control semestral de lípidos'),
          (027, 027, '2021-12-09', 'Insuficiencia Cardíaca', 'Crítica', 'Muerte súbita', 'Hospitalización recurrente'),
          (028, 028, '2021-07-15', 'Insuficiencia Cardíaca', 'Alta', 'Edema pulmonar', 'Control semestral de lípidos'),
          (029, 029, '2024-02-12', 'Infarto Agudo de Miocardio', 'Moderada', 'IAM', 'Rehabilitación cardiovascular'),
          (030, 030, '2023-09-16', 'Hipertensión Arterial', 'Alta', 'Edema pulmonar', 'Hospitalización recurrente'),
          (031, 031, '2020-10-02', 'Insuficiencia Cardíaca', 'Crítica',  'ACV', 'Control semestral de lípidos'),
          (032, 032, '2024-07-10', 'Infarto Agudo de Miocardio', 'Crítica', 'ACV', 'Hospitalización recurrente'),
          (033, 033, '2023-01-14', 'Hipercolesterolemia', 'Alta', 'ACV', 'Rehabilitación cardiovascular'),
          (034, 034, '2023-10-29', 'Hipercolesterolemia','Alta', 'IAM', 'Rehabilitación cardiovascular'),
          (035, 035, '2021-01-04', 'Hipertensión Arterial', 'Crítica', 'ACV', 'Control semestral de lípidos');") 


#PREGUNTA : ¿ QUE TRATAMIENTO TIENE MAYOR EXITO EN PACIENTES CON RIESGO ASOCIADO DE MUERTE SÚBITA (ORDENADOS)?

tto_riesgo <- dbGetQuery(con,"SELECT t.tipo_tratamiento, COUNT(*) AS frecuencia
FROM tratamientos t
JOIN diagnosticos d
ON t.id_paciente = d.id_paciente
WHERE d.riesgo_asociado = 'Muerte súbita'
GROUP BY t.tipo_tratamiento
ORDER BY frecuencia DESC;")

View(tto_riesgo)
print(tto_riesgo)




#PREGUNTA: ¿Qué pacientes tienen un diagnóstico de gravedad "Crítica", un tratamiento quirúrgico y antecedentes familiares ,en base a edad y género?



pacientes_criticos_quiro <- dbGetQuery(con, "
    SELECT p.ID_pacientes, p.Nombre, p.Edad, p.Genero, p.Antecedentes_familiar , d.Gravedad, t.tipo_tratamiento
    FROM pacientes p
    JOIN diagnosticos d ON p.ID_pacientes = d.ID_Paciente
    JOIN tratamientos t ON p.ID_pacientes = t.id_paciente
    WHERE d.Gravedad = 'Crítica'
    AND t.tipo_tratamiento = 'Intervención Quirúrgica'
    AND p.Antecedentes_familiar  = 'Sí';
")

# Mostrar los resultados
print(pacientes_criticos_quiro)
View(pacientes_criticos_quiro)

#PREGUNTA: ¿Qué pacientes tienen un diagnóstico de "Insuficiencia Cardíaca" con gravedad "Alta" y además son fumadores?

pacientes_fumadores <- dbGetQuery(con, "
    SELECT p.ID_pacientes, p.Nombre, p.Edad, p.Genero, p.Fumador, d.Enfermedad_cardiovascular, d.Gravedad
    FROM pacientes p
    JOIN diagnosticos d ON p.ID_pacientes = d.ID_Paciente
    WHERE d.Enfermedad_cardiovascular =  'Insuficiencia Cardíaca'
    AND d.Gravedad = 'Alta'
    AND p.Fumador = 'Sí';
")

# Mostrar los resultados
print(pacientes_fumadores)
View(pacientes_fumadores)

#¿Cuántos pacientes con un IMC mayor a 30 tienen diagnósticos con riesgo asociado de "Edema pulmonar"?


#esta tabla demuestra todos los pacientes que tienen riesgo de edema , y clasificando los IMCs  . 

edema_total <- dbGetQuery(con , "CREATE VIEW PacientesEdema AS
SELECT 
    p.ID_pacientes, 
    p.Nombre, 
    p.IMC ,  
	CASE 
        WHEN p.IMC < 18.5 THEN 'Bajo peso'
        WHEN p.IMC BETWEEN 18.5 AND 24.9 THEN 'Normal'
        WHEN p.IMC BETWEEN 25 AND 29.9 THEN 'Sobrepeso'
        WHEN p.IMC >= 30 THEN 'Obesidad'
    END AS Categoria_IMC,
    p.Edad,
    p.Genero,
    d.Riesgo_asociado,
FROM pacientes p
JOIN diagnosticos d ON p.ID_pacientes = d.ID_Paciente
AND d.Riesgo_asociado = 'Edema pulmonar';
" )

print(edema_total)

# esta tabla demuetsra solo cuantos pacientes tienen edema y IMC>30 
IMC_edema <- dbGetQuery(con , "CREATE VIEW Edema_IMC 
                   AS SELECT * FROM PacientesEdema
                              WHERE IMC>30;")

print(IMC_edema)
#cuantos pacientes con edema y IMC>30 

IMC_edema_count<- dbGetQuery(con , "SELECT COUNT(*) AS total_pacientes_edema_imc FROM Edema_IMC;" )

print(IMC_edema_count)


#FINALMENTE ALTERAMOS LA TABLA ELIMINANDO LA COLUMNA CORRESPONDIENTE A FECHAS COMO NO SE HA USADO : 

diagnosticos_alterada <- dbExecute(con , " ALTER TABLE diagnosticos
                                   DROP COLUMN Fecha;")


# Obtener la lista de todas las tablas en la base de datos
tables <- dbListTables(con)
print(tables)

# Borrar todas las tablas
for (table in tables) {
  dbExecute(con, paste0("DROP TABLE IF EXISTS ", table, " CASCADE;"))
}

# Verificar que no queden tablas
tables_after <- dbListTables(con)
print(tables_after)

# Cerrar la conexión
dbDisconnect(con)
