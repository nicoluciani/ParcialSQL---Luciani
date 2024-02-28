--Codificar el modelo obtenido.

create database PARCIAL2

use PARCIAL2

--TABLAS

create table Provincias(
id_provincia int primary key,
provincia nvarchar(60))

create table Localidades(
id_localidad int primary key,
localidad nvarchar (60),
id_provincia int foreign key references Provincias(id_provincia))

create table Empresas(
id_empresa int primary key,
nombre_empresa nvarchar(60),
direccion_calle_empresa nvarchar(60),
direccion_numero_empresa nvarchar(12),
tel_empresa nvarchar(12),
cant_empleados nvarchar(12),
id_localidad int foreign key references Localidades(id_localidad))

create table Contactos(
id_contacto int primary key,
nombre_contacto nvarchar(60),
tel_contacto nvarchar(12))

create table Cursos(
id_curso int primary key,
descripcion nvarchar(200),
temario nvarchar(200),
carga_horaria nvarchar(12),
precio_curso nvarchar(12))

create table Campus(
id_campus int primary key,
direccion_campus nvarchar(60),
telefono_campus nvarchar(12),
descripcion_campus nvarchar(200),
id_localidad int foreign key references Localidades(id_localidad))

create table Respuestas(
id_respuesta int primary key,
respuesta nvarchar(60),
fecha date,
id_curso int foreign key references Cursos(id_curso),
id_empresa int foreign key references Empresas(id_empresa))

create table Contactos_Empresas(
id_contacto int foreign key references Contactos(id_contacto),
id_empresa int foreign key references Empresas(id_empresa),
cargo_contacto nvarchar(60),
primary key(id_contacto,id_empresa))

--CARGA DE DATOS

insert into Provincias
values(1,'Santa Fe'),(2,'Buenos Aires'),(3,'Cordoba')

insert into Localidades
values(1,'Rosario',1),(2,'Pergamino',2),(3,'Rio Cuarto',3),(4,'Venado Tuerto',1)

insert into Empresas
values(1,'Garbarino','Callao','1050','3416859716','10',1),(2,'Compumundo','Balcarce','645','3416859789','15',2),(3,'Musimundo','Dorrego','2589','3416859514','6',3)

insert into Contactos
values(1,'Juan Perez','3415481269'),(2,'Candela Robles','3415481684'),(3,'Ramiro Dominguez','3415481823')

insert into Cursos
values(1,'Fotografia','Photoshop','20','8000'),(2,'Escritura','Cuentos Cortos','40','5000'),(3,'Programacion','Java','120','10000')

insert into Campus
values(1,'Santa Fe 568','3419726814','Fotos',1),(2,'Santa Fe 902','3419726817','Literatura',2),(3,'San Lorenzo 185','3419726826','Computadoras',3)

insert into Respuestas
values(1,'Si','06/07/2022',1,1),(2,'No','01/07/2022',1,2),(3,'Si','04/07/2022',2,3)

insert into Contactos_Empresas
values(1,1,'Dueño'),(1,2,'Contador'),(2,3,'Recursos Humanos')

--Se pide, nombre de Empresa con su localidad, provincia, nombre y telefono del contacto.

select nombre_empresa,localidad,provincia,nombre_contacto,tel_contacto from Contactos_Empresas
inner join Empresas on Contactos_Empresas.id_empresa = Empresas.id_empresa
inner join Localidades on Empresas.id_localidad = Localidades.id_localidad
inner join Provincias on Localidades.id_provincia = Provincias.id_provincia
inner join Contactos on Contactos_Empresas.id_contacto = Contactos.id_contacto

--Dado un numero de curso, mostrar el nombre de las empresas que respondieron sobre el mismo.

select id_curso,nombre_empresa,respuesta from Respuestas
inner join Empresas on Empresas.id_empresa = Respuestas.id_empresa
where id_curso=1