drop database laboratorioSQL;

create database laboratorioSQL;

use laboratorioSQL;

/* Create */

create table profesor
(
	doc_prof varchar(11) primary key,
	nom_prof varchar(30),
	ape_prof varchar(30),
	cate_prof int,
	sal_prof int
)

create table curso
(
	cod_cur int identity(1,1) primary key,
	nom_cur varchar(100),
	hora_cur int,
	valor_cur int
)

create table estudiante
(
	doc_est varchar(11) primary key,
	nom_est varchar(30),
	ape_est varchar(30),
	edad_est int
)

create table estudiantexcurso
(
	fec_ini_estcur date,
	cod_cur_estcur int foreign key references curso(cod_cur),
	doc_est_estcur varchar(11) foreign key references estudiante(doc_est)
)

create table cliente
(
	id_cli varchar(11) primary key,
	nom_cli varchar(30),
	ape_cli varchar(30),
	dir_cli varchar(100),
	dep_cli varchar(20),
	mes_cum_cli varchar(10)
)

create table articulo
(
	id_art int identity primary key,
	tit_art varchar(100),
	aut_art varchar(100),
	edi_art varchar(300),
	prec_art int
)

create table pedido
(
	id_ped int identity(1,1) primary key,
	fec_ped date,
	val_ped int,
	id_cli_ped varchar(11) foreign key references cliente (id_cli)
)

create table articuloxpedido
(
	can_art_artped int,
	val_ven_art_arped int,
	id_ped_artped int foreign key references pedido(id_ped),
	id_art_artped int foreign key references articulo(id_art)
)

create table compania
(
	comnit varchar(11) primary key,
	comnombre varchar(30),
	comaniofun int,
	comreplegal varchar(100)
)

create table tiposAutomotores
(
	auttipo int primary key
)

create table automotores
(
	autoplaca varchar(6) primary key,
	automarca varchar(30),
	automodelo int,
	autopasajeros int,
	autocilindraje int,
	autonumchasis varchar(20),
	autotipo int foreign key references tiposAutomotores(auttipo)
)

create table aseguramientos
(
	asecodigo int identity(1,1) primary key,
	asefechainicio date,
	asefechaexpiracion date,
	asevalorasegurado int,
	aseestado varchar(40),
	asecosto int,
	aseplaca varchar(6) foreign key references automotores(autoplaca)
)

create table incidentes
(
	incicodigo int identity(1,1) primary key,
	incifecha date,
	incilugar varchar(40),
	inciantheridos int,
	incicanfatalidades int,
	incicanautosinvolucrados int,
	inciplaca varchar(6) foreign key references automotores(autoplaca)
)

/* INSERT */

select * from profesor;

insert into profesor values ('63.502.720', 'Martha', 'Rojas', 2, 690000);
insert into profesor values ('91.216.904', 'Carlos', 'P�rez', 3, 950000);
insert into profesor values ('13.826.789', 'Maritza', 'Angarita', 1, 550000);

exec sp_help profesor; -- Muestra la informaci�n de la tabla, nos interesa saber el nombre de la pk para quitarle la restricci�n 

alter table profesor drop constraint PK__profesor__08241E30A60EB501; -- Se altera la restricci�n de la pk
alter table profesor alter column doc_prof varchar(15) not null; -- Se altera la columna indicando que no se permitan nulos 
alter table profesor add constraint PK_profesor primary key (doc_prof); -- Se asigna la restricci�n a la pk d�ndole un nombre

insert into profesor values ('1.098.765.789', 'Alejandra', 'Torres', 4, 1100000);
		
select * from curso;

set identity_insert curso on; -- Se habilita el identity insert para poder ingresar el cod int

insert into curso (cod_cur, nom_cur, hora_cur, valor_cur) values (149842, 'Fundamentos de bases de datos', 40, 500000);
insert into curso (cod_cur, nom_cur, hora_cur, valor_cur) values (250067, 'Fundamentos de SQL', 20, 700000);
insert into curso (cod_cur, nom_cur, hora_cur, valor_cur) values (289011, 'Manejo de Mysql', 45, 550000);
insert into curso (cod_cur, nom_cur, hora_cur, valor_cur) values (345671, 'Fundamentals of Oracle', 60, 3000000);

set identity_insert curso off; -- Se quita el indentity insert

select * from estudiante;

exec sp_help estudiante; -- Muestra la informaci�n de la tabla, nos interesa saber el nombre de la pk para quitarle la restricci�n 

insert into estudiante values ('63.502.720', 'Mar�a', 'P�rez', 2);
insert into estudiante values ('91.245.678', 'Carlos Jos�', 'L�pez', 3);

exec sp_help estudiantexcurso;

alter table estudiantexcurso drop constraint FK__estudiant__doc_e__4F7CD00D; -- Se elimina la restricci�n de la fk de la tabla estudiante 
alter table estudiante drop constraint PK__estudian__75DA98B06BA17741; -- Se altera la restricci�n de la pk

alter table estudiante alter column doc_est varchar(15) not null; -- Se altera la columna indican que no se permitan nulos 
alter table estudiantexcurso alter column doc_est_estcur varchar(15) not null; -- Se altera la columna y se indica que no se permitan nulos 

alter table estudiante add constraint PK_estudiante primary key (doc_est); -- Se asigna la restricci�n a la pk d�ndole un nombre
alter table estudiantexcurso add constraint FK_estudiante_doc foreign key (doc_est_estcur) references estudiante (doc_est) -- Se crea la restricci�n de la for�nea

insert into estudiante values ('1.098.098.097', 'Jonatan', 'Ardila', 1);
insert into estudiante values ('1.098.765.679', 'Carlos', 'Mart�nez', 4);

select * from estudiantexcurso;

insert into estudiantexcurso values ( '01/02/2011', 289011, '1.098.765.679');
insert into estudiantexcurso values ( '01/03/2011', 250067, '63.502.720');
insert into estudiantexcurso values ( '01/02/2011', 289011, '1.098.098.097');
insert into estudiantexcurso values ( '01/04/2011', 345671, '63.502.720');

select * from cliente;

insert into cliente values ('63502718', 'Maritza', 'Rojas', 'Calle 34 No.14-45', 'Santander', 'Abril');
insert into cliente values ('13890234', 'Roger', 'Ariza', 'Cra 30 No.13-45', 'Antioquia', 'Junio');
insert into cliente values ('77191956', 'Juan Carlos', 'Arenas', 'Diagonal 23 No. 12-34 apto 101', 'Valle', 'Marzo');
insert into cliente values ('1098765789', 'Catalina', 'Zapata', 'Av. El Libertador No.30-14', 'Cauca', 'Marzo');

select * from articulo;

insert into articulo values ('Redes cisco', 'Ernesto Arigasello', 'Alfaomega - Rama', 60000);
insert into articulo values ('Facebook y Twitter para adultos', 'Veloso Claudio', 'Alfaomega', 52000);
insert into articulo values ('Creaci�n de un portal con php y mysql', 'Jacob Pav�n Puertas', 'Alfaomega - Rama', 40000);
insert into articulo values ('Administraci�n de sistemas operativos', 'Julio G�mez L�pez', 'Alfaomega - Rama', 55000);

set dateformat dmy;

select * from pedido;

insert into pedido values ('25/02/2012', 120000, '63502718');
insert into pedido values ('30/04/2012', 55000, '77191956');
insert into pedido values ('10/12/2011', 260000, '63502718');
insert into pedido values ('25/02/2012', 1800000, '1098765789');

select * from articuloxpedido;

insert into articuloxpedido values (5, 40000, 1, 3);
insert into articuloxpedido values (12, 55000, 1, 4);
insert into articuloxpedido values (5, 65000, 2, 1);
insert into articuloxpedido values (10, 55000, 3, 2);
insert into articuloxpedido values (12, 45000, 3, 3);
insert into articuloxpedido values (20, 65000, 4, 1);

select * from compania;

insert into compania values ('800890890-2', 'Seguros Atlantida', 1998, 'Carlos L�pez');
insert into compania values ('899999999-1', 'Aseguradora Rojas', 1991, 'Luis Fernando Rojas');
insert into compania values ('899999999-5', 'Seguros del Estado', 2001, 'Mar�a Margarita P�rez');

select * from tiposAutomotores;

alter table tiposAutomotores add autnombre varchar(20);

insert into tiposAutomotores values (1, 'Automoviles');
insert into tiposAutomotores values (2, 'Camperos');
insert into tiposAutomotores values (3, 'Camiones');

select * from automotores;

insert into automotores values ('FLL420', 'chevrolet corsa', 2003, 5, 1400, 'wywzzz167kk009d25', 1);
insert into automotores values ('DKZ820', 'renault stepway', 2008, 5, 1600, 'wywwzz157kk009d45', 1);
insert into automotores values ('KJQ920', 'renault stepway', 2009, 7, 2000, 'wywzzz157kk009d25', 2);

select * from aseguramientos;

insert into aseguramientos values ('2012-09-30', '2013-09-30', 30000000, 'Vigente', 500000, 'FLL420');
insert into aseguramientos values ('2012-09-27', '2013-09-27', 35000000, 'Vigente', 600000, 'DKZ820');
insert into aseguramientos values ('2011-09-28', '2012-09-28', 50000000, 'Vigente', 800000, 'KJQ920');

select * from incidentes;

insert into incidentes values ('2012-09-30', 'Bucaramanga', 0, 0, 2, 'DKZ820');
insert into incidentes values ('2012-09-27', 'Gir�n', 1, 0, 1, 'FLL420');
insert into incidentes values ('2011-09-28', 'Bucaramanga', 1, 0, 2, 'FLL420');

/* 8. Siguiendo con la base datos del taller 1 desarrollar las siguiente practica: */

/* a. Dise�a un procedimientos almacenados para crear, editar, eliminar un registro en la 
tablas Compa�ia, Cliente, CURSO */

-- Compa��a

create procedure sp_insertar_compania
(
	@nit varchar(11),
	@nombre varchar(30),
	@aniofun int,
	@replegal varchar(100)
)
as
begin
	insert into compania values (@nit, @nombre, @aniofun, @replegal);
end

exec sp_insertar_compania '899999999-7', 'Seguros del Pueblo', 2000, 'Ana Sof�a';

create procedure sp_actualizar_compania
(
	@nit varchar(11),
	@nombre varchar(30),
	@aniofun int,
	@replegal varchar(100)
)
as
begin
	update compania set comnombre = @nombre, comaniofun = @aniofun, comreplegal = @replegal where comnit = @nit;
end

exec sp_actualizar_compania '899999999-7', 'Seguros Ciudadanos', 2001, 'Ana Sofia';

create procedure sp_eliminar_compania
(
	@nit varchar(11)
)
as
begin
	delete from compania where comnit = @nit;
end

exec sp_eliminar_compania '899999999-7';

-- Cliente

create procedure sp_insertar_cliente
(
	@id_cli varchar(11),
	@nom_cli varchar(30),
	@ape_cli varchar(30),
	@dir_cli varchar(100),
	@dep_cli varchar(20),
	@mes_cum_cli varchar(10)
)
as
begin
	insert into cliente values (@id_cli, @nom_cli, @ape_cli, @dir_cli, @dep_cli, @mes_cum_cli);
end

exec sp_insertar_cliente '5421245', 'Juana', 'Restrepo', 'Calle 34 No.14-45', 'Santander', 'Mayo';

create procedure sp_actualizar_client
(
	@id_cli varchar(11),
	@nom_cli varchar(30),
	@ape_cli varchar(30),
	@dir_cli varchar(100),
	@dep_cli varchar(20),
	@mes_cum_cli varchar(10)
)
as
begin 
	update cliente set nom_cli = @nom_cli, ape_cli = @ape_cli, dir_cli = @dir_cli, dep_cli = @dep_cli, mes_cum_cli = @mes_cum_cli where id_cli = @id_cli;
end

exec sp_actualizar_client '5421245', 'Juana', 'Restrepo', 'Calle 34 No.14-45', 'Santander', 'Abril';

create procedure sp_eliminar_cliente
(
	@id_cli varchar(11)
)
as
begin
	delete from cliente where id_cli = @id_cli;
end

exec sp_eliminar_cliente '5421245';

/* Curso */

create procedure sp_insertar_curso
(
	@nom_cur varchar(100),
	@hora_cur int,
	@valor_cur int
)
as
begin
	insert into curso values (@nom_cur, @hora_cur, @valor_cur);
end

exec sp_insertar_curso 'Fundamentos de programacion', 30, 500000;

create procedure sp_actualizar_curso
(
	@cod_cur int,
	@nom_cur varchar(100),
	@hora_cur int,
	@valor_cur int
)
as
begin
	update curso set nom_cur = @nom_cur, hora_cur = @hora_cur, valor_cur = @valor_cur where cod_cur = @cod_cur;
end

exec sp_actualizar_curso 345672, 'Fundamentos de programacion', 50, 700000;

create procedure sp_eliminar_curso
(
	@cod_cur int
)
as
begin
	delete from curso where cod_cur = @cod_cur;
end

exec sp_eliminar_curso 345672;

/* b. Cree 50 registros para cada una de las tablas con datos variados (para todas). */

/* Profesor */

insert into profesor values ('1004827001', 'Manuel', 'L�pez', 1, 600000);
insert into profesor values ('1004827002', 'Mar�a', 'Garc�a', 2, 720000);
insert into profesor values ('1004827003', 'Jorge', 'Fern�ndez', 3, 950000);
insert into profesor values ('1004827004', 'Luz', 'Mart�nez', 1, 580000);
insert into profesor values ('1004827005', 'Diego', 'Ram�rez', 2, 710000);
insert into profesor values ('1004827006', 'Sandra', 'P�rez', 3, 920000);
insert into profesor values ('1004827007', 'Luisa', 'S�nchez', 1, 570000);
insert into profesor values ('1004827008', 'Andr�s', 'Hern�ndez', 2, 700000);
insert into profesor values ('1004827009', 'Elena', 'G�mez', 3, 980000);
insert into profesor values ('1004827010', 'Alejandro', 'D�az', 1, 550000);
insert into profesor values ('1004827011', 'Carolina', 'Su�rez', 2, 730000);
insert into profesor values ('1004827012', 'Gabriel', 'Torres', 3, 970000);
insert into profesor values ('1004827013', 'Ana', 'Jim�nez', 1, 540000);
insert into profesor values ('1004827014', 'Mauricio', 'Ortega', 2, 690000);
insert into profesor values ('1004827015', 'Isabella', 'Londo�o', 3, 940000);
insert into profesor values ('1004827016', 'Ricardo', 'Pineda', 1, 520000);
insert into profesor values ('1004827017', 'Daniela', 'Giraldo', 2, 680000);
insert into profesor values ('1004827018', 'Luc�a', 'Molina', 3, 970000);
insert into profesor values ('1004827019', 'Santiago', 'Arroyo', 1, 530000);
insert into profesor values ('1004827020', 'Valentina', 'Castro', 2, 740000);
insert into profesor values ('1004827021', 'Camilo', 'Herrera', 3, 960000);
insert into profesor values ('1004827022', 'Lorena', 'P�rez', 1, 560000);
insert into profesor values ('1004827023', 'Andrea', 'Mart�nez', 2, 710000);
insert into profesor values ('1004827024', 'Roberto', 'G�mez', 3, 950000);
insert into profesor values ('1004827025', 'Laura', 'Gonz�lez', 1, 600000);
insert into profesor values ('1004827026', 'Manuel', 'L�pez', 1, 600000);
insert into profesor values ('1004827027', 'Mar�a', 'Garc�a', 2, 720000);
insert into profesor values ('1004827028', 'Jorge', 'Fern�ndez', 3, 950000);
insert into profesor values ('1004827029', 'Luz', 'Mart�nez', 1, 580000);
insert into profesor values ('1004827030', 'Diego', 'Ram�rez', 2, 710000);
insert into profesor values ('1004827031', 'Sandra', 'P�rez', 3, 920000);
insert into profesor values ('1004827032', 'Luisa', 'S�nchez', 1, 570000);
insert into profesor values ('1004827033', 'Andr�s', 'Hern�ndez', 2, 700000);
insert into profesor values ('1004827034', 'Elena', 'G�mez', 3, 980000);
insert into profesor values ('1004827035', 'Alejandro', 'D�az', 1, 550000);
insert into profesor values ('1004827036', 'Carolina', 'Su�rez', 2, 730000);
insert into profesor values ('1004827037', 'Gabriel', 'Torres', 3, 970000);
insert into profesor values ('1004827038', 'Ana', 'Jim�nez', 1, 540000);
insert into profesor values ('1004827039', 'Mauricio', 'Ortega', 2, 690000);
insert into profesor values ('1004827040', 'Isabella', 'Londo�o', 3, 940000);
insert into profesor values ('1004827041', 'Ricardo', 'Pineda', 1, 520000);
insert into profesor values ('1004827042', 'Daniela', 'Giraldo', 2, 680000);
insert into profesor values ('1004827043', 'Luc�a', 'Molina', 3, 970000);
insert into profesor values ('1004827044', 'Santiago', 'Arroyo', 1, 530000);
insert into profesor values ('1004827045', 'Valentina', 'Castro', 2, 740000);
insert into profesor values ('1004827046', 'Lorena', 'G�mez', 3, 960000);
insert into profesor values ('1004827047', 'Andrea', 'Herrera', 1, 550000);
insert into profesor values ('1004827048', 'Roberto', 'Su�rez', 2, 710000);
insert into profesor values ('1004827049', 'Laura', 'Ortega', 3, 950000);
insert into profesor values ('1004827050', 'Carlos', 'Pineda', 1, 520000);

/* Curso */

insert into curso values ('Introducci�n a Java', 30, 600000);
insert into curso values ('Fundamentos de Python', 25, 550000);
insert into curso values ('Programaci�n en C#', 40, 700000);
insert into curso values ('Desarrollo Web con HTML y CSS', 35, 650000);
insert into curso values ('JavaScript Avanzado', 50, 850000);
insert into curso values ('Dise�o de Interfaces de Usuario', 30, 600000);
insert into curso values ('Programaci�n en Ruby', 35, 700000);
insert into curso values ('Desarrollo de Aplicaciones M�viles', 45, 900000);
insert into curso values ('Fundamentos de PHP', 30, 550000);
insert into curso values ('Python para Ciencia de Datos', 40, 800000);
insert into curso values ('Desarrollo de Juegos con Unity', 60, 1200000);
insert into curso values ('Programaci�n en Swift', 30, 650000);
insert into curso values ('Desarrollo de Aplicaciones de Escritorio', 45, 850000);
insert into curso values ('Introducci�n a SQL', 20, 500000);
insert into curso values ('Desarrollo de Aplicaciones Web con Django', 55, 950000);
insert into curso values ('Programaci�n en TypeScript', 40, 750000);
insert into curso values ('Desarrollo de Aplicaciones de Android', 50, 1100000);
insert into curso values ('Introducci�n a la Programaci�n en R', 35, 600000);
insert into curso values ('Desarrollo de Aplicaciones de iOS', 55, 1000000);
insert into curso values ('Programaci�n en Kotlin', 40, 700000);
insert into curso values ('Desarrollo de Aplicaciones de Windows', 45, 850000);
insert into curso values ('Programaci�n en JavaScript', 30, 550000);
insert into curso values ('Desarrollo de Aplicaciones de Linux', 45, 900000);
insert into curso values ('Dise�o de Experiencia de Usuario (UX)', 30, 650000);
insert into curso values ('Programaci�n en Go', 35, 750000);
insert into curso values ('Desarrollo de Aplicaciones de macOS', 40, 800000);
insert into curso values ('Introducci�n a Ruby on Rails', 20, 500000);
insert into curso values ('Desarrollo de Aplicaciones de Realidad Virtual', 60, 1200000);
insert into curso values ('Programaci�n en PHP', 30, 600000);
insert into curso values ('Desarrollo de Aplicaciones de Realidad Aumentada', 55, 950000);
insert into curso values ('Programaci�n en Perl', 40, 700000);
insert into curso values ('Desarrollo de Chatbots', 25, 550000);
insert into curso values ('Desarrollo de Aplicaciones de Blockchain', 50, 1100000);
insert into curso values ('Programaci�n en Dart', 30, 650000);
insert into curso values ('Introducci�n a la Inteligencia Artificial', 45, 850000);
insert into curso values ('Programaci�n en Scala', 40, 750000);
insert into curso values ('Desarrollo de Aplicaciones de Internet de las Cosas (IoT)', 35, 700000);
insert into curso values ('Programaci�n en Rust', 40, 800000);
insert into curso values ('Desarrollo de Aplicaciones de Machine Learning', 50, 1000000);
insert into curso values ('Introducci�n a la Ciberseguridad', 30, 600000);
insert into curso values ('Programaci�n en Elixir', 40, 750000);
insert into curso values ('Desarrollo de Aplicaciones de Realidad Mixta', 60, 1200000);
insert into curso values ('Programaci�n en Lua', 30, 600000);
insert into curso values ('Desarrollo de Aplicaciones de Automatizaci�n', 35, 700000);
insert into curso values ('Introducci�n a la Ciencia de Datos', 45, 900000);
insert into curso values ('Programaci�n en Erlang', 40, 800000);
insert into curso values ('Desarrollo de Aplicaciones de Rob�tica', 55, 950000);

/* Estudiante */

insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827001', 'Camila', 'G�mez', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827002', 'Santiago', 'Rodr�guez', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827003', 'Valentina', 'Hern�ndez', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827004', 'Mateo', 'Fern�ndez', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827005', 'Luciana', 'Mart�nez', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827006', 'Juan', 'P�rez', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827007', 'Sof�a', 'Guti�rrez', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827008', 'Dylan', 'S�nchez', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827009', 'Mariana', 'L�pez', 24);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827010', 'Mat�as', 'Garc�a', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827011', 'Isabella', 'Ram�rez', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827012', 'Diego', 'D�az', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827013', 'Valent�n', 'Gonz�lez', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827014', 'Luna', 'Torres', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827015', 'Lucas', 'Ochoa', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827016', 'Martina', 'Soto', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827017', 'Joaqu�n', 'Londo�o', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827018', 'Camilo', 'Montoya', 24);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827019', 'Ana', 'Arroyo', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827020', 'Andr�s', 'Vargas', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827021', 'Sara', 'G�mez', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827022', 'Juan Pablo', 'Herrera', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827023', 'Valeria', 'Molina', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827024', 'Luis', 'Arias', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827025', 'Renata', 'Rojas', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827026', 'Sebasti�n', 'Moreno', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827027', 'Isabel', 'Ortega', 24);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827028', 'Samuel', 'Bernal', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827029', 'Mariano', 'G�lvez', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827030', 'Valentino', 'Silva', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827031', 'Luc�a', 'Gir�n', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827032', 'Emiliano', 'Su�rez', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827033', 'Danna', 'Linares', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827034', 'Mat�as', 'Jaramillo', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827035', 'Valentina', 'Le�n', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827036', 'Max', 'Villamizar', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827037', 'Julieta', 'Salazar', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827038', 'Lucas', 'Aguirre', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827039', 'Valeria', 'Bustos', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827040', 'Juan Diego', 'Mej�a', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827041', 'M�a', 'Zuluaga', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827042', 'Joaqu�n', 'Santos', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827043', 'Sof�a', 'Castillo', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827044', 'Lucas', 'Rinc�n', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827045', 'Valentina', 'Paredes', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827046', 'Sim�n', 'S�nchez', 20);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827047', 'Valeria', 'Herrera', 22);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827048', 'Luciano', 'G�mez', 21);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827049', 'Sof�a', 'Fern�ndez', 23);
insert into estudiante (doc_est, nom_est, ape_est, edad_est) values ('1004827050', 'Diego', 'Mart�nez', 20);

/* Estudiante por curso */

insert into estudiantexcurso values ('2011-02-01', 345679, '1004827001');
insert into estudiantexcurso values ('2011-02-02', 345682, '1004827002');
insert into estudiantexcurso values ('2011-02-03', 345684, '1004827003');
insert into estudiantexcurso values ('2011-02-04', 345686, '1004827004');
insert into estudiantexcurso values ('2011-02-05', 345689, '1004827005');
insert into estudiantexcurso values ('2011-02-06', 345691, '1004827006');
insert into estudiantexcurso values ('2011-02-07', 345693, '1004827007');
insert into estudiantexcurso values ('2011-02-08', 345695, '1004827008');
insert into estudiantexcurso values ('2011-02-09', 345697, '1004827009');
insert into estudiantexcurso values ('2011-02-10', 345701, '1004827010');
insert into estudiantexcurso values ('2011-02-11', 345703, '1004827011');
insert into estudiantexcurso values ('2011-02-12', 345705, '1004827012');
insert into estudiantexcurso values ('2011-02-13', 345707, '1004827013');
insert into estudiantexcurso values ('2011-02-14', 345709, '1004827014');
insert into estudiantexcurso values ('2011-02-15', 345711, '1004827015');
insert into estudiantexcurso values ('2011-02-16', 345713, '1004827016');
insert into estudiantexcurso values ('2011-02-17', 345715, '1004827017');
insert into estudiantexcurso values ('2011-02-18', 345717, '1004827018');
insert into estudiantexcurso values ('2011-02-19', 345719, '1004827019');
insert into estudiantexcurso values ('2011-02-20', 345682, '1004827020');
insert into estudiantexcurso values ('2011-02-21', 345684, '1004827021');
insert into estudiantexcurso values ('2011-02-22', 345686, '1004827022');
insert into estudiantexcurso values ('2011-02-23', 345689, '1004827023');
insert into estudiantexcurso values ('2011-02-24', 345691, '1004827024');
insert into estudiantexcurso values ('2011-02-25', 345693, '1004827025');
insert into estudiantexcurso values ('2011-02-26', 345695, '1004827026');
insert into estudiantexcurso values ('2011-02-27', 345697, '1004827027');
insert into estudiantexcurso values ('2011-02-28', 345699, '1004827028');
insert into estudiantexcurso values ('2011-03-01', 345701, '1004827029');
insert into estudiantexcurso values ('2011-03-02', 345703, '1004827030');
insert into estudiantexcurso values ('2011-03-03', 345705, '1004827031');
insert into estudiantexcurso values ('2011-03-04', 345707, '1004827032');
insert into estudiantexcurso values ('2011-03-05', 345709, '1004827033');
insert into estudiantexcurso values ('2011-03-06', 345711, '1004827034');
insert into estudiantexcurso values ('2011-03-07', 345713, '1004827035');
insert into estudiantexcurso values ('2011-03-08', 345715, '1004827036');
insert into estudiantexcurso values ('2011-03-09', 345717, '1004827037');
insert into estudiantexcurso values ('2011-03-10', 345682, '1004827038');
insert into estudiantexcurso values ('2011-03-11', 345684, '1004827039');
insert into estudiantexcurso values ('2011-03-12', 345686, '1004827040');
insert into estudiantexcurso values ('2011-03-13', 345689, '1004827041');
insert into estudiantexcurso values ('2011-03-14', 345691, '1004827042');
insert into estudiantexcurso values ('2011-03-15', 345693, '1004827043');
insert into estudiantexcurso values ('2011-03-16', 345695, '1004827044');
insert into estudiantexcurso values ('2011-03-17', 345697, '1004827045');
insert into estudiantexcurso values ('2011-03-18', 345699, '1004827046');
insert into estudiantexcurso values ('2011-03-19', 345701, '1004827047');
insert into estudiantexcurso values ('2011-03-20', 345703, '1004827048');
insert into estudiantexcurso values ('2011-03-21', 345705, '1004827049');
insert into estudiantexcurso values ('2011-03-22', 345707, '1004827050');

/* Cliente */

insert into cliente values ('1004827001', 'Camila', 'G�mez', 'Carrera 34 No.14-45', 'Bogot�', 'Abril');
insert into cliente values ('1004827002', 'Santiago', 'Rodr�guez', 'Calle 30 No.13-45', 'Medell�n', 'Junio');
insert into cliente values ('1004827003', 'Valentina', 'Hern�ndez', 'Diagonal 23 No. 12-34 apto 101', 'Cali', 'Marzo');
insert into cliente values ('1004827004', 'Mateo', 'Fern�ndez', 'Avenida El Libertador No.30-14', 'Bucaramanga', 'Marzo');
insert into cliente values ('1004827005', 'Luciana', 'Mart�nez', 'Carrera 28 No.8-56', 'Barranquilla', 'Mayo');
insert into cliente values ('1004827006', 'Juan', 'P�rez', 'Calle 12 No.45-23 apto 202', 'C�cuta', 'Agosto');
insert into cliente values ('1004827007', 'Sof�a', 'Guti�rrez', 'Avenida 5 No.18-30', 'Cartagena', 'Diciembre');
insert into cliente values ('1004827008', 'Dylan', 'S�nchez', 'Calle 10 No.3-25', 'Pereira', 'Julio');
insert into cliente values ('1004827009', 'Mariana', 'L�pez', 'Carrera 15 No.24-15', 'Manizales', 'Febrero');
insert into cliente values ('1004827010', 'Mat�as', 'Garc�a', 'Calle 9 No.17-40', 'Armenia', 'Noviembre');
insert into cliente values ('1004827011', 'Isabella', 'Ram�rez', 'Carrera 7 No.11-5', 'Santa Marta', 'Abril');
insert into cliente values ('1004827012', 'Diego', 'D�az', 'Diagonal 8 No.6-10', 'Barranquilla', 'Junio');
insert into cliente values ('1004827013', 'Valent�n', 'Gonz�lez', 'Calle 5 No.9-20', 'Bogot�', 'Agosto');
insert into cliente values ('1004827014', 'Luna', 'Torres', 'Avenida 6 No.12-15', 'Medell�n', 'Diciembre');
insert into cliente values ('1004827015', 'Lucas', 'Ochoa', 'Carrera 18 No.7-30', 'Cali', 'Julio');
insert into cliente values ('1004827016', 'Martina', 'Soto', 'Calle 20 No.16-25', 'Bucaramanga', 'Febrero');
insert into cliente values ('1004827017', 'Joaqu�n', 'Londo�o', 'Diagonal 10 No.5-18', 'Barranquilla', 'Abril');
insert into cliente values ('1004827018', 'Camilo', 'Montoya', 'Carrera 12 No.22-12 apto 301', 'C�cuta', 'Marzo');
insert into cliente values ('1004827019', 'Ana', 'Arroyo', 'Calle 15 No.14-8', 'Cartagena', 'Mayo');
insert into cliente values ('1004827020', 'Andr�s', 'Vargas', 'Avenida 8 No.13-5', 'Pereira', 'Junio');
insert into cliente values ('1004827021', 'Sara', 'G�mez', 'Carrera 14 No.7-15', 'Manizales', 'Noviembre');
insert into cliente values ('1004827022', 'Juan Pablo', 'Herrera', 'Calle 30 No.26-20', 'Armenia', 'Marzo');
insert into cliente values ('1004827023', 'Valeria', 'Molina', 'Diagonal 7 No.18-30', 'Santa Marta', 'Abril');
insert into cliente values ('1004827024', 'Luis', 'Arias', 'Avenida 3 No.5-10', 'Bogot�', 'Mayo');
insert into cliente values ('1004827025', 'Renata', 'Rojas', 'Calle 11 No.10-22', 'Medell�n', 'Julio');
insert into cliente values ('1004827026', 'Sebasti�n', 'Moreno', 'Carrera 25 No.12-45', 'Cali', 'Febrero');
insert into cliente values ('1004827027', 'Isabel', 'Ortega', 'Diagonal 10 No.22-18', 'Bucaramanga', 'Diciembre');
insert into cliente values ('1004827028', 'Samuel', 'Bernal', 'Avenida 6 No.16-30', 'Barranquilla', 'Marzo');
insert into cliente values ('1004827029', 'Mariano', 'G�lvez', 'Calle 22 No.9-15', 'C�cuta', 'Agosto');
insert into cliente values ('1004827030', 'Valentino', 'Silva', 'Carrera 7 No.5-10', 'Pereira', 'Mayo');
insert into cliente values ('1004827031', 'Luc�a', 'Gir�n', 'Diagonal 12 No.14-22', 'Cartagena', 'Julio');
insert into cliente values ('1004827032', 'Emiliano', 'Su�rez', 'Avenida 9 No.20-30', 'Manizales', 'Febrero');
insert into cliente values ('1004827033', 'Danna', 'Linares', 'Calle 8 No.11-18', 'Armenia', 'Abril');
insert into cliente values ('1004827034', 'Mat�as', 'Jaramillo', 'Carrera 10 No.15-25', 'Santa Marta', 'Noviembre');
insert into cliente values ('1004827035', 'Valentina', 'Le�n', 'Diagonal 5 No.18-22', 'Bogot�', 'Marzo');
insert into cliente values ('1004827036', 'Max', 'Villamizar', 'Calle 15 No.11-5', 'Medell�n', 'Abril');
insert into cliente values ('1004827037', 'Julieta', 'Salazar', 'Avenida 7 No.16-30', 'Cali', 'Julio');
insert into cliente values ('1004827038', 'Lucas', 'Aguirre', 'Carrera 12 No.10-22', 'Bucaramanga', 'Diciembre');
insert into cliente values ('1004827039', 'Valeria', 'Bustos', 'Diagonal 6 No.22-10', 'Barranquilla', 'Mayo');
insert into cliente values ('1004827040', 'Juan Diego', 'Mej�a', 'Calle 30 No.20-15', 'C�cuta', 'Febrero');
insert into cliente values ('1004827041', 'M�a', 'Zuluaga', 'Carrera 14 No.8-40', 'Cartagena', 'Junio');
insert into cliente values ('1004827042', 'Joaqu�n', 'Santos', 'Calle 22 No.16-25', 'Pereira', 'Agosto');
insert into cliente values ('1004827043', 'Sof�a', 'Castillo', 'Avenida 8 No.7-30', 'Manizales', 'Julio');
insert into cliente values ('1004827044', 'Lucas', 'Rinc�n', 'Diagonal 5 No.10-22', 'Armenia', 'Diciembre');
insert into cliente values ('1004827045', 'Valentina', 'Paredes', 'Carrera 18 No.22-15', 'Santa Marta', 'Febrero');
insert into cliente values ('1004827046', 'Sim�n', 'S�nchez', 'Calle 11 No.14-30', 'Bogot�', 'Abril');
insert into cliente values ('1004827047', 'Valeria', 'Herrera', 'Calle 14 No.20-5', 'Medell�n', 'Mayo');
insert into cliente values ('1004827048', 'Luciano', 'G�mez', 'Diagonal 3 No.11-18', 'Cali', 'Marzo');
insert into cliente values ('1004827049', 'Sof�a', 'Fern�ndez', 'Avenida 12 No.5-10', 'Bucaramanga', 'Junio');
insert into cliente values ('1004827050', 'Diego', 'Mart�nez', 'Carrera 10 No.16-22', 'Barranquilla', 'Julio');

/* Articulo */

insert into articulo values ('Aprende a usar las redes', 'Ana Mar�a G�mez', 'Editorial Colombia', 45000);
insert into articulo values ('Aprende a crear contenido', 'Juan Carlos L�pez', 'Editorial Nacional', 55000);
insert into articulo values ('Programaci�n en Python', 'Luisa Mart�nez', 'Editorial Andina', 65000);
insert into articulo values ('Introducci�n a la Inteligencia Artificial', 'Santiago Torres', 'Editorial Pac�fico', 70000);
insert into articulo values ('Dise�o de Interfaces de Usuario', 'Mar�a Rodr�guez', 'Editorial Occidente', 48000);
insert into articulo values ('Aprende a programar en C#', 'Carlos P�rez', 'Editorial Colombiana', 62000);
insert into articulo values ('Desarrollo Web con HTML y CSS', 'Valentina Hern�ndez', 'Editorial Cali', 57000);
insert into articulo values ('Fundamentos de SQL', 'Diego G�mez', 'Editorial Medell�n', 50000);
insert into articulo values ('Desarrollo de Aplicaciones M�viles', 'Mariano Ram�rez', 'Editorial Bogot�', 73000);
insert into articulo values ('Introducci�n a la Programaci�n en R', 'Isabella Rodr�guez', 'Editorial Barranquilla', 49000);
insert into articulo values ('Desarrollo de Aplicaciones de iOS', 'Luciano Mart�nez', 'Editorial Cartagena', 80000);
insert into articulo values ('Programaci�n en Kotlin', 'Camila G�mez', 'Editorial Pereira', 64000);
insert into articulo values ('Desarrollo de Aplicaciones de Windows', 'Juan Pablo Herrera', 'Editorial C�cuta', 75000);
insert into articulo values ('Programaci�n en JavaScript', 'Andr�s Vargas', 'Editorial Armenia', 58000);
insert into articulo values ('Desarrollo de Aplicaciones de Linux', 'Sara G�mez', 'Editorial Santa Marta', 67000);
insert into articulo values ('Dise�o de Experiencia de Usuario (UX)', 'Diego G�mez', 'Editorial Bogot�', 50000);
insert into articulo values ('Programaci�n en Go', 'Valentina Hern�ndez', 'Editorial Cali', 70000);
insert into articulo values ('Desarrollo de Aplicaciones de macOS', 'Luciana Mart�nez', 'Editorial Medell�n', 68000);
insert into articulo values ('Introducci�n a Ruby on Rails', 'Diego G�mez', 'Editorial Bogot�', 50000);
insert into articulo values ('Desarrollo de Aplicaciones de Realidad Virtual', 'Lucas Soto', 'Editorial C�cuta', 90000);
insert into articulo values ('Programaci�n en PHP', 'Danna Linares', 'Editorial Santa Marta', 62000);
insert into articulo values ('Desarrollo de Aplicaciones de Realidad Aumentada', 'Valent�n Gonz�lez', 'Editorial Pereira', 86000);
insert into articulo values ('Programaci�n en Perl', 'Mariana L�pez', 'Editorial Armenia', 55000);
insert into articulo values ('Desarrollo de Chatbots', 'Mat�as Jaramillo', 'Editorial Barranquilla', 73000);
insert into articulo values ('Desarrollo de Aplicaciones de Blockchain', 'Ana Arroyo', 'Editorial Cartagena', 94000);
insert into articulo values ('Programaci�n en Dart', 'Santiago Torres', 'Editorial Pac�fico', 65000);
insert into articulo values ('Introducci�n a la Inteligencia Artificial', 'Camila G�mez', 'Editorial Colombia', 70000);
insert into articulo values ('Programaci�n en Scala', 'Carlos P�rez', 'Editorial Nacional', 75000);
insert into articulo values ('Desarrollo de Aplicaciones de Internet de las Cosas (IoT)', 'Valentina Hern�ndez', 'Editorial Andina', 88000);
insert into articulo values ('Programaci�n en Rust', 'Diego G�mez', 'Editorial Bogot�', 65000);
insert into articulo values ('Desarrollo de Aplicaciones de Machine Learning', 'Luciano Mart�nez', 'Editorial Medell�n', 92000);
insert into articulo values ('Introducci�n a la Ciberseguridad', 'Santiago Torres', 'Editorial Pac�fico', 70000);
insert into articulo values ('Programaci�n en Elixir', 'Mariano Ram�rez', 'Editorial Bogot�', 74000);
insert into articulo values ('Desarrollo de Aplicaciones de Realidad Mixta', 'Ana Arroyo', 'Editorial Cartagena', 86000);
insert into articulo values ('Programaci�n en Lua', 'Juan Carlos L�pez', 'Editorial Nacional', 57000);
insert into articulo values ('Desarrollo de Aplicaciones de Automatizaci�n', 'Diego G�mez', 'Editorial Bogot�', 65000);
insert into articulo values ('Introducci�n a la Ciencia de Datos', 'Luciana Mart�nez', 'Editorial Medell�n', 80000);
insert into articulo values ('Programaci�n en Erlang', 'Sara G�mez', 'Editorial Santa Marta', 75000);
insert into articulo values ('Desarrollo de Aplicaciones de Rob�tica', 'Lucas Soto', 'Editorial C�cuta', 90000);
insert into articulo values ('Seguridad en Redes', 'Danna Linares', 'Editorial Santa Marta', 62000);
insert into articulo values ('Desarrollo de Sistemas Embebidos', 'Valent�n Gonz�lez', 'Editorial Pereira', 84000);
insert into articulo values ('Programaci�n en Swift', 'Mat�as Jaramillo', 'Editorial Barranquilla', 67000);
insert into articulo values ('Desarrollo de Aplicaciones de Escritorio', 'Ana Arroyo', 'Editorial Cartagena', 85000);
insert into articulo values ('Introducci�n a SQL', 'Santiago Torres', 'Editorial Pac�fico', 55000);
insert into articulo values ('Desarrollo de Aplicaciones Web con Django', 'Camila G�mez', 'Editorial Colombia', 72000);
insert into articulo values ('Programaci�n en TypeScript', 'Carlos P�rez', 'Editorial Nacional', 65000);
insert into articulo values ('Desarrollo de Aplicaciones de Android', 'Valentina Hern�ndez', 'Editorial Andina', 88000);
insert into articulo values ('Introducci�n a la Programaci�n en R', 'Diego G�mez', 'Editorial Bogot�', 58000);
insert into articulo values ('Desarrollo de Aplicaciones de iOS', 'Luciano Mart�nez', 'Editorial Medell�n', 76000);
insert into articulo values ('Programaci�n en Kotlin', 'Mariano Ram�rez', 'Editorial Bogot�', 64000);
insert into articulo values ('Desarrollo de Aplicaciones de Windows', 'Juan Pablo Herrera', 'Editorial C�cuta', 78000);
insert into articulo values ('Programaci�n en JavaScript', 'Andr�s Vargas', 'Editorial Armenia', 59000);
insert into articulo values ('Desarrollo de Aplicaciones de Linux', 'Sara G�mez', 'Editorial Santa Marta', 70000);

/* Pedido */ 

insert into pedido values ('2023-01-15', 125000, '1004827001');
insert into pedido values ('2023-02-28', 55000, '1004827007');
insert into pedido values ('2023-03-10', 215000, '1004827021');
insert into pedido values ('2023-04-05', 1800000, '1004827024');
insert into pedido values ('2023-05-20', 87000, '1004827003');
insert into pedido values ('2023-06-18', 320000, '1004827028');
insert into pedido values ('2023-07-07', 122000, '1004827034');
insert into pedido values ('2023-08-12', 1980000, '1004827006');
insert into pedido values ('2023-09-25', 93000, '1004827010');
insert into pedido values ('2023-10-05', 170000, '1004827022');
insert into pedido values ('2023-11-30', 2140000, '1004827013');
insert into pedido values ('2023-12-14', 102000, '1004827039');
insert into pedido values ('2024-01-03', 145000, '1004827026');
insert into pedido values ('2024-02-17', 1680000, '1004827036');
insert into pedido values ('2024-03-21', 78000, '1004827009');
insert into pedido values ('2024-04-02', 260000, '1004827028');
insert into pedido values ('2024-05-09', 132000, '1004827032');
insert into pedido values ('2024-06-28', 1760000, '1004827023');
insert into pedido values ('2024-07-15', 69000, '1004827017');
insert into pedido values ('2024-08-09', 310000, '1004827031');
insert into pedido values ('2024-09-27', 2350000, '1004827035');
insert into pedido values ('2024-10-30', 112000, '1004827037');
insert into pedido values ('2024-11-10', 175000, '1004827040');
insert into pedido values ('2024-12-24', 2200000, '1004827019');
insert into pedido values ('2025-01-08', 67000, '1004827025');
insert into pedido values ('2025-02-04', 197000, '1004827024');
insert into pedido values ('2025-03-15', 1860000, '1004827020');
insert into pedido values ('2025-04-29', 98000, '1004827027');
insert into pedido values ('2025-05-10', 285000, '1004827032');
insert into pedido values ('2025-06-19', 162000, '1004827016');
insert into pedido values ('2025-07-22', 1950000, '1004827014');
insert into pedido values ('2025-08-02', 74000, '1004827004');
insert into pedido values ('2025-09-11', 235000, '1004827037');
insert into pedido values ('2025-10-26', 124000, '1004827025');
insert into pedido values ('2025-11-09', 1880000, '1004827001');
insert into pedido values ('2025-12-31', 84000, '1004827029');
insert into pedido values ('2026-01-12', 268000, '1004827043');
insert into pedido values ('2026-02-27', 142000, '1004827035');
insert into pedido values ('2026-03-15', 2040000, '1004827038');
insert into pedido values ('2026-04-08', 71000, '1004827007');
insert into pedido values ('2026-05-19', 293000, '1004827031');
insert into pedido values ('2026-06-24', 155000, '1004827022');
insert into pedido values ('2026-07-23', 1970000, '1004827033');
insert into pedido values ('2026-08-05', 69000, '1004827036');
insert into pedido values ('2026-09-16', 282000, '1004827020');
insert into pedido values ('2026-10-30', 128000, '1004827026');

/* Articulo por pedido */

insert into articuloxpedido values (7, 56000, 1, 3);
insert into articuloxpedido values (3, 65000, 1, 10);
insert into articuloxpedido values (8, 71000, 2, 7);
insert into articuloxpedido values (5, 50000, 2, 14);
insert into articuloxpedido values (10, 72000, 3, 13);
insert into articuloxpedido values (6, 58000, 3, 8);
insert into articuloxpedido values (12, 78000, 4, 4);
insert into articuloxpedido values (4, 49000, 4, 12);
insert into articuloxpedido values (9, 60000, 5, 6);
insert into articuloxpedido values (14, 67000, 5, 9);
insert into articuloxpedido values (7, 59000, 6, 15);
insert into articuloxpedido values (11, 73000, 6, 2);
insert into articuloxpedido values (3, 49000, 7, 19);
insert into articuloxpedido values (8, 60000, 7, 26);
insert into articuloxpedido values (15, 78000, 8, 11);
insert into articuloxpedido values (6, 58000, 8, 4);
insert into articuloxpedido values (12, 72000, 9, 28);
insert into articuloxpedido values (4, 50000, 9, 24);
insert into articuloxpedido values (10, 68000, 10, 17);
insert into articuloxpedido values (7, 56000, 10, 16);
insert into articuloxpedido values (13, 76000, 11, 12);
insert into articuloxpedido values (4, 49000, 11, 21);
insert into articuloxpedido values (9, 60000, 12, 30);
insert into articuloxpedido values (14, 67000, 12, 25);
insert into articuloxpedido values (6, 58000, 13, 27);
insert into articuloxpedido values (12, 72000, 13, 23);
insert into articuloxpedido values (5, 50000, 14, 22);
insert into articuloxpedido values (10, 65000, 14, 20);
insert into articuloxpedido values (11, 73000, 15, 29);
insert into articuloxpedido values (3, 49000, 15, 1);
insert into articuloxpedido values (8, 60000, 16, 17);
insert into articuloxpedido values (15, 78000, 16, 5);
insert into articuloxpedido values (7, 56000, 17, 9);
insert into articuloxpedido values (13, 67000, 17, 18);
insert into articuloxpedido values (5, 50000, 18, 24);
insert into articuloxpedido values (10, 68000, 18, 7);
insert into articuloxpedido values (11, 73000, 19, 19);
insert into articuloxpedido values (4, 49000, 19, 11);
insert into articuloxpedido values (8, 60000, 20, 16);
insert into articuloxpedido values (15, 78000, 20, 12);
insert into articuloxpedido values (6, 58000, 21, 21);
insert into articuloxpedido values (12, 72000, 21, 14);
insert into articuloxpedido values (9, 60000, 22, 4);
insert into articuloxpedido values (14, 67000, 22, 10);
insert into articuloxpedido values (7, 56000, 23, 26);
insert into articuloxpedido values (3, 65000, 23, 15);
insert into articuloxpedido values (8, 60000, 24, 6);
insert into articuloxpedido values (13, 67000, 24, 26);
insert into articuloxpedido values (5, 50000, 25, 2);
insert into articuloxpedido values (11, 73000, 25, 5);

/* Compa��a */

insert into compania values ('800890891-3', 'Seguros Colombianos', 2005, 'Jorge Mart�nez');
insert into compania values ('900001000-4', 'Aseguradora Barranquilla', 1997, 'Sandra G�mez');
insert into compania values ('899999900-6', 'Seguros Medell�n', 2000, 'Luis Carlos Guti�rrez');
insert into compania values ('899999902-7', 'Aseguradora Nacional', 1992, 'Mar�a Fern�ndez');
insert into compania values ('899999905-1', 'Seguros del Caribe', 2008, 'Carlos Rojas');
insert into compania values ('800890893-2', 'Aseguradora Cali', 1995, 'Luc�a Su�rez');
insert into compania values ('800890894-8', 'Seguros Bogot�', 1990, 'Juan P�rez');
insert into compania values ('900001005-2', 'Aseguradora Occidente', 2006, 'Laura Herrera');
insert into compania values ('899999910-5', 'Seguros Pacifico', 2003, 'Luisa Mart�nez');
insert into compania values ('899999915-9', 'Aseguradora Andina', 1998, 'Diego Soto');
insert into compania values ('800890900-7', 'Seguros Cartagena', 1996, 'Valentina Hern�ndez');
insert into compania values ('800890903-1', 'Aseguradora C�cuta', 2007, 'Miguel �ngel L�pez');
insert into compania values ('900001010-7', 'Seguros Pereira', 2004, 'Camila G�mez');
insert into compania values ('800890910-5', 'Aseguradora Cali', 2001, 'Andr�s Vargas');
insert into compania values ('899999920-2', 'Seguros Medell�n', 1994, 'Sof�a Torres');
insert into compania values ('900001015-1', 'Aseguradora Santander', 1999, 'Juli�n Ram�rez');
insert into compania values ('899999925-0', 'Seguros Barranquilla', 2002, 'Valent�n Soto');
insert into compania values ('899999930-4', 'Aseguradora Bogot�', 1993, 'Luc�a Mart�nez');
insert into compania values ('800890920-4', 'Seguros Armenia', 2006, 'Esteban Su�rez');
insert into compania values ('899999935-3', 'Aseguradora Valle', 1995, 'Natalia Guti�rrez');
insert into compania values ('800890925-9', 'Seguros Cauca', 2003, 'Sim�n L�pez');
insert into compania values ('899999940-7', 'Aseguradora Antioquia', 1998, 'Ana Mar�a Torres');
insert into compania values ('899999945-1', 'Seguros Bol�var', 2005, 'Andr�s P�rez');
insert into compania values ('899999950-1', 'Aseguradora Caldas', 2002, 'Valentina Ram�rez');
insert into compania values ('800890930-0', 'Seguros Caquet�', 1991, 'Luis Torres');
insert into compania values ('800890935-4', 'Aseguradora Huila', 2007, 'Mar�a Rodr�guez');
insert into compania values ('899999955-8', 'Seguros Casanare', 1992, 'Juan G�mez');
insert into compania values ('800890940-2', 'Aseguradora Meta', 2004, 'Santiago Mart�nez');
insert into compania values ('900001020-4', 'Seguros Guaviare', 1999, 'Valeria G�mez');
insert into compania values ('800890945-9', 'Aseguradora Putumayo', 1994, 'Camilo L�pez');
insert into compania values ('899999960-7', 'Seguros Choc�', 2008, 'Mar�a Fern�ndez');
insert into compania values ('800890950-5', 'Aseguradora Nari�o', 2006, 'Carlos G�mez');
insert into compania values ('899999965-1', 'Seguros Risaralda', 1990, 'Mariana L�pez');
insert into compania values ('899999970-1', 'Aseguradora Quind�o', 1995, 'Miguel �ngel Ram�rez');
insert into compania values ('899999975-6', 'Seguros Guain�a', 2001, 'Luc�a Mart�nez');
insert into compania values ('900001025-9', 'Aseguradora Vaup�s', 1996, 'Diego P�rez');
insert into compania values ('800890955-0', 'Seguros Amazonas', 1993, 'Sof�a G�mez');
insert into compania values ('800890960-0', 'Aseguradora San Andr�s', 2007, 'Andr�s Ram�rez');
insert into compania values ('899999980-4', 'Seguros Providencia', 2003, 'Natalia L�pez');
insert into compania values ('899999985-8', 'Aseguradora Arauca', 2009, 'Sim�n G�mez');
insert into compania values ('899999990-5', 'Seguros Vichada', 1991, 'Ana Mar�a Ram�rez');
insert into compania values ('900001030-0', 'Aseguradora Cesar', 1997, 'Andr�s Torres');
insert into compania values ('800890965-5', 'Seguros Magdalena', 2004, 'Valentina Guti�rrez');
insert into compania values ('800890970-5', 'Aseguradora Sucre', 1994, 'Juan Fernando L�pez');
insert into compania values ('900001035-5', 'Seguros La Guajira', 2002, 'Mariana P�rez');
insert into compania values ('899999995-1', 'Aseguradora Caquet�', 1998, 'Diego Torres');

/* Tipos Automotores */

insert into tiposAutomotores values (4, 'Motocicletas');
insert into tiposAutomotores values (5, 'Furgonetas');
insert into tiposAutomotores values (6, 'Autobuses');
insert into tiposAutomotores values (7, 'Motos de Agua');
insert into tiposAutomotores values (8, 'Bicicletas');
insert into tiposAutomotores values (9, 'Ciclomotores');
insert into tiposAutomotores values (10, 'Remolques');
insert into tiposAutomotores values (11, 'Constructor');
insert into tiposAutomotores values (12, 'Cuatrimotos');
insert into tiposAutomotores values (13, 'Barcos');
insert into tiposAutomotores values (14, 'Motocarros');
insert into tiposAutomotores values (15, 'Ciclomotores');
insert into tiposAutomotores values (16, 'Camiones Cisterna');
insert into tiposAutomotores values (17, 'Buggies');
insert into tiposAutomotores values (18, 'Camionetas');
insert into tiposAutomotores values (19, 'Gr�as');
insert into tiposAutomotores values (20, 'Taxis');
insert into tiposAutomotores values (21, 'Tractores');
insert into tiposAutomotores values (22, 'Caravanas');
insert into tiposAutomotores values (23, 'Helic�pteros');
insert into tiposAutomotores values (24, 'Scooters');
insert into tiposAutomotores values (25, 'Motocicletas');
insert into tiposAutomotores values (26, 'Camiones de Basura');
insert into tiposAutomotores values (27, 'Lanchas');
insert into tiposAutomotores values (28, 'Ciclo Monta�a');
insert into tiposAutomotores values (29, 'Monopatines');
insert into tiposAutomotores values (30, 'Carros de Golf');
insert into tiposAutomotores values (31, 'Autocaravanas');
insert into tiposAutomotores values (32, 'Veleros');
insert into tiposAutomotores values (33, 'Monopatines');
insert into tiposAutomotores values (34, 'Camiones de Bomberos');
insert into tiposAutomotores values (35, 'Coche de Caballos');
insert into tiposAutomotores values (36, 'Barcos de Vela');
insert into tiposAutomotores values (37, 'Carros de Tiro');
insert into tiposAutomotores values (38, 'Ferrocarriles');
insert into tiposAutomotores values (39, 'Triciclos');
insert into tiposAutomotores values (40, 'Canoas');
insert into tiposAutomotores values (41, 'Submarinos');
insert into tiposAutomotores values (42, 'Carros a Pedales');
insert into tiposAutomotores values (43, 'Funiculares');
insert into tiposAutomotores values (44, 'Coches sin Carnet');
insert into tiposAutomotores values (45, 'Carros de gas');
insert into tiposAutomotores values (46, 'Trolebuses');
insert into tiposAutomotores values (47, 'Autos Locos');
insert into tiposAutomotores values (48, 'Motocicletas');
insert into tiposAutomotores values (49, 'Motos de Nieve');
insert into tiposAutomotores values (50, 'Barcos');
insert into tiposAutomotores values (51, 'Camionetas 4x4');
insert into tiposAutomotores values (52, 'Motocross');
insert into tiposAutomotores values (53, 'Mini Kart');

/* Automotores */

insert into automotores values ('HJL730', 'Toyota Corolla', 2015, 5, 1800, 'W5XYZZ157KK009D12', 18);
insert into automotores values ('MNO890', 'Honda Civic', 2019, 5, 2000, 'W5XYZZ167KK009D23', 18);
insert into automotores values ('PQR120', 'Nissan Altima', 2018, 5, 2200, 'W5XYZZ177KK009D34', 18);
insert into automotores values ('XYZ456', 'Ford Focus', 2020, 5, 1700, 'W5XYZZ187KK009D45', 18);
insert into automotores values ('ABC789', 'Hyundai Elantra', 2016, 5, 1900, 'W5XYZZ197KK009D56', 18);
insert into automotores values ('EFG123', 'Chevrolet Malibu', 2017, 5, 2100, 'W5XYZZ207KK009D67', 18);
insert into automotores values ('LMN451', 'Mazda 3', 2015, 5, 1600, 'W5XYZZ217KK009D78', 18);
insert into automotores values ('STU789', 'Volkswagen Jetta', 2021, 5, 2000, 'W5XYZZ227KK009D89', 18);
insert into automotores values ('UVW012', 'Kia Forte', 2019, 5, 1800, 'W5XYZZ237KK009D90', 18);
insert into automotores values ('XYZ345', 'Subaru Impreza', 2016, 5, 1700, 'W5XYZZ247KK009D01', 18);
insert into automotores values ('BCD678', 'Mercedes-Benz C-Class', 2020, 5, 2200, 'W5XYZZ257KK009D12', 18);
insert into automotores values ('DEF901', 'Audi A4', 2018, 5, 2000, 'W5XYZZ267KK009D23', 18);
insert into automotores values ('GHI234', 'Lexus IS', 2017, 5, 2100, 'W5XYZZ277KK009D34', 18);
insert into automotores values ('JKL567', 'BMW 3 Series', 2019, 5, 1800, 'W5XYZZ287KK009D45', 18);
insert into automotores values ('MOP890', 'Porsche Panamera', 2020, 5, 2200, 'W5XYZZ297KK009D56', 18);
insert into automotores values ('TUV123', 'Jaguar XE', 2016, 5, 1600, 'W5XYZZ307KK009D67', 18);
insert into automotores values ('WXZ456', 'Volvo S60', 2018, 5, 1900, 'W5XYZZ317KK009D78', 18);
insert into automotores values ('YBC789', 'Cadillac CTS', 2021, 5, 2000, 'W5XYZZ327KK009D89', 18);
insert into automotores values ('OPQ062', 'Lincoln MKZ', 2017, 5, 2100, 'W5XYZZ337KK009D90', 18);
insert into automotores values ('JKL345', 'Acura ILX', 2015, 5, 1800, 'W5XYZZ347KK009D01', 18);
insert into automotores values ('DEF678', 'Infiniti Q50', 2016, 5, 1700, 'W5XYZZ357KK009D12', 18);
insert into automotores values ('GHI901', 'Maserati Ghibli', 2019, 5, 2200, 'W5XYZZ367KK009D23', 18);
insert into automotores values ('MOP234', 'Alfa Romeo Giulia', 2020, 5, 2000, 'W5XYZZ377KK009D34', 18);
insert into automotores values ('TRV567', 'Tesla Model 3', 2018, 5, 2100, 'W5XYZZ387KK009D45', 18);
insert into automotores values ('WXZ890', 'Karma Revero', 2017, 5, 1900, 'W5XYZZ397KK009D56', 18);
insert into automotores values ('YBC123', 'Rivian R1S', 2018, 5, 2000, 'W5XYZZ407KK009D67', 18);
insert into automotores values ('LMR456', 'Polestar 2', 2020, 5, 1800, 'W5XYZZ417KK009D78', 18);
insert into automotores values ('SHU789', 'Lucid Air', 2019, 5, 1700, 'W5XYZZ427KK009D89', 18);
insert into automotores values ('O5Q012', 'Rimac C_Two', 2016, 5, 2100, 'W5XYZZ437KK009D90', 18);
insert into automotores values ('JJL345', 'NIO ET7', 2021, 5, 2200, 'W5XYZZ447KK009D01', 18);
insert into automotores values ('DBF678', 'Canoo Lifestyle Vehicle', 2018, 5, 2000, 'W5XYZZ457KK009D12', 18);
insert into automotores values ('GWI901', 'Alpha Motor Corporation Ace', 2020, 5, 1900, 'W5XYZZ467KK009D23', 18);
insert into automotores values ('M5P234', 'Atlis XT', 2015, 5, 1800, 'W5XYZZ477KK009D34', 18);
insert into automotores values ('TUV167', 'Karma SC2', 2016, 5, 1700, 'W5XYZZ487KK009D45', 18);
insert into automotores values ('WXF890', 'Atlis Motor Vehicles XP', 2017, 5, 2100, 'W5XYZZ497KK009D56', 18);
insert into automotores values ('YBC623', 'Faraday Future FF 91', 2018, 5, 2000, 'W5XYZZ507KK009D67', 18);
insert into automotores values ('LM2456', 'Lucid Motors Air', 2019, 5, 2200, 'W5XYZZ517KK009D78', 18);
insert into automotores values ('STH789', 'Workhorse W-15', 2020, 5, 2000, 'W5XYZZ527KK009D89', 18);
insert into automotores values ('KPQ062', 'Rivian R1T', 2017, 5, 2100, 'W5XYZZ537KK009D90', 18);
insert into automotores values ('JKL145', 'Alpha Wolf', 2016, 5, 1900, 'W5XYZZ547KK009D01', 18);
insert into automotores values ('DER678', 'Neuron EV T.One', 2015, 5, 1800, 'W5XYZZ557KK009D12', 18);
insert into automotores values ('GHH901', 'Rivian R1S', 2019, 5, 1700, 'W5XYZZ567KK009D23', 18);
insert into automotores values ('MOP734', 'Lucid Air', 2018, 5, 2200, 'W5XYZZ577KK009D34', 18);
insert into automotores values ('YUV167', 'Polestar 2', 2016, 5, 2000, 'W5XYZZ587KK009D45', 18);
insert into automotores values ('WXY890', 'Tesla Model 3', 2017, 5, 2100, 'W5XYZZ597KK009D56', 18);
insert into automotores values ('YBS123', 'Audi A4', 2018, 5, 1900, 'W5XYZZ607KK009D67', 18);
insert into automotores values ('LMH456', 'Mazda 3', 2019, 5, 1800, 'W5XYZZ617KK009D78', 18);

/* Aseguramientos */

insert into aseguramientos values ('2022-09-01', '2023-09-01', 35000000, 'Vigente', 600000, 'HJL730');
insert into aseguramientos values ('2022-09-02', '2023-09-02', 40000000, 'Vigente', 700000, 'MNO890');
insert into aseguramientos values ('2022-09-03', '2023-09-03', 45000000, 'Vigente', 800000, 'PQR120');
insert into aseguramientos values ('2022-09-04', '2023-09-04', 50000000, 'Vigente', 900000, 'XYZ456');
insert into aseguramientos values ('2022-09-05', '2023-09-05', 55000000, 'Vigente', 1000000, 'ABC789');
insert into aseguramientos values ('2022-09-06', '2023-09-06', 30000000, 'Vigente', 500000, 'EFG123');
insert into aseguramientos values ('2022-09-07', '2023-09-07', 35000000, 'Vigente', 600000, 'LMN451');
insert into aseguramientos values ('2022-09-08', '2023-09-08', 40000000, 'Vigente', 700000, 'STU789');
insert into aseguramientos values ('2022-09-09', '2023-09-09', 45000000, 'Vigente', 800000, 'UVW012');
insert into aseguramientos values ('2022-09-10', '2023-09-10', 50000000, 'Vigente', 900000, 'XYZ345');
insert into aseguramientos values ('2022-09-11', '2023-09-11', 35000000, 'Vigente', 600000, 'BCD678');
insert into aseguramientos values ('2022-09-12', '2023-09-12', 30000000, 'Vigente', 500000, 'DEF901');
insert into aseguramientos values ('2022-09-13', '2023-09-13', 40000000, 'Vigente', 700000, 'GHI234');
insert into aseguramientos values ('2022-09-14', '2023-09-14', 45000000, 'Vigente', 800000, 'JKL567');
insert into aseguramientos values ('2022-09-15', '2023-09-15', 50000000, 'Vigente', 900000, 'MOP890');
insert into aseguramientos values ('2022-09-16', '2023-09-16', 35000000, 'Vigente', 600000, 'TUV123');
insert into aseguramientos values ('2022-09-17', '2023-09-17', 40000000, 'Vigente', 700000, 'WXZ456');
insert into aseguramientos values ('2022-09-18', '2023-09-18', 45000000, 'Vigente', 800000, 'YBC789');
insert into aseguramientos values ('2022-09-19', '2023-09-19', 50000000, 'Vigente', 900000, 'OPQ062');
insert into aseguramientos values ('2022-09-20', '2023-09-20', 35000000, 'Vigente', 600000, 'JKL345');
insert into aseguramientos values ('2022-09-21', '2023-09-21', 30000000, 'Vigente', 500000, 'DEF678');
insert into aseguramientos values ('2022-09-22', '2023-09-22', 40000000, 'Vigente', 700000, 'GHI901');
insert into aseguramientos values ('2022-09-23', '2023-09-23', 45000000, 'Vigente', 800000, 'MOP234');
insert into aseguramientos values ('2022-09-24', '2023-09-24', 50000000, 'Vigente', 900000, 'TRV567');
insert into aseguramientos values ('2022-09-25', '2023-09-25', 35000000, 'Vigente', 600000, 'WXZ890');
insert into aseguramientos values ('2022-09-26', '2023-09-26', 40000000, 'Vigente', 700000, 'YBC123');
insert into aseguramientos values ('2022-09-27', '2023-09-27', 45000000, 'Vigente', 800000, 'LMR456');
insert into aseguramientos values ('2022-09-28', '2023-09-28', 50000000, 'Vigente', 900000, 'SHU789');
insert into aseguramientos values ('2022-09-29', '2023-09-29', 35000000, 'Vigente', 600000, 'O5Q012');
insert into aseguramientos values ('2022-09-30', '2023-09-30', 40000000, 'Vigente', 700000, 'JJL345');
insert into aseguramientos values ('2022-09-01', '2023-09-01', 45000000, 'Vigente', 800000, 'DBF678');
insert into aseguramientos values ('2022-09-02', '2023-09-02', 50000000, 'Vigente', 900000, 'GWI901');
insert into aseguramientos values ('2022-09-03', '2023-09-03', 35000000, 'Vigente', 600000, 'M5P234');
insert into aseguramientos values ('2022-09-04', '2023-09-04', 40000000, 'Vigente', 700000, 'TUV167');
insert into aseguramientos values ('2022-09-05', '2023-09-05', 45000000, 'Vigente', 800000, 'WXF890');
insert into aseguramientos values ('2022-09-06', '2023-09-06', 50000000, 'Vigente', 900000, 'YBC623');
insert into aseguramientos values ('2022-09-07', '2023-09-07', 35000000, 'Vigente', 600000, 'LM2456');
insert into aseguramientos values ('2022-09-08', '2023-09-08', 40000000, 'Vigente', 700000, 'STH789');
insert into aseguramientos values ('2022-09-09', '2023-09-09', 45000000, 'Vigente', 800000, 'OPQ062');
insert into aseguramientos values ('2022-09-10', '2023-09-10', 50000000, 'Vigente', 900000, 'JKL145');
insert into aseguramientos values ('2022-09-11', '2023-09-11', 35000000, 'Vigente', 600000, 'DER678');
insert into aseguramientos values ('2022-09-12', '2023-09-12', 40000000, 'Vigente', 700000, 'GHH901');
insert into aseguramientos values ('2022-09-13', '2023-09-13', 45000000, 'Vigente', 800000, 'MOP734');
insert into aseguramientos values ('2022-09-14', '2023-09-14', 50000000, 'Vigente', 900000, 'TUV167');
insert into aseguramientos values ('2022-09-15', '2023-09-15', 35000000, 'Vigente', 600000, 'WXY890');
insert into aseguramientos values ('2022-09-16', '2023-09-16', 40000000, 'Vigente', 700000, 'YBS123');
insert into aseguramientos values ('2022-09-17', '2023-09-17', 45000000, 'Vigente', 800000, 'LMH456');

/* Incidentes */

insert into incidentes values ('2023-11-01', 'Bogot�', 2, 1, 3, 'HJL730');
insert into incidentes values ('2023-11-02', 'Medell�n', 1, 0, 2, 'MNO890');
insert into incidentes values ('2023-11-03', 'Cali', 0, 0, 1, 'PQR120');
insert into incidentes values ('2023-11-04', 'Barranquilla', 3, 1, 2, 'XYZ456');
insert into incidentes values ('2023-11-05', 'Cartagena', 0, 0, 0, 'ABC789');
insert into incidentes values ('2023-11-06', 'Bucaramanga', 1, 0, 1, 'EFG123');
insert into incidentes values ('2023-11-07', 'Pereira', 2, 0, 2, 'LMN451');
insert into incidentes values ('2023-11-08', 'Santa Marta', 1, 1, 1, 'STU789');
insert into incidentes values ('2023-11-09', 'C�cuta', 0, 0, 0, 'UVW012');
insert into incidentes values ('2023-11-10', 'Manizales', 0, 0, 1, 'XYZ345');
insert into incidentes values ('2023-11-11', 'Ibagu�', 1, 0, 2, 'BCD678');
insert into incidentes values ('2023-11-12', 'Villavicencio', 3, 2, 3, 'DEF901');
insert into incidentes values ('2023-11-13', 'Pasto', 1, 0, 1, 'GHI234');
insert into incidentes values ('2023-11-14', 'Neiva', 0, 0, 1, 'JKL567');
insert into incidentes values ('2023-11-15', 'Popay�n', 0, 0, 0, 'MOP890');
insert into incidentes values ('2023-11-16', 'Armenia', 1, 0, 2, 'TUV123');
insert into incidentes values ('2023-11-17', 'Riohacha', 2, 1, 3, 'WXZ456');
insert into incidentes values ('2023-11-18', 'Tunja', 0, 0, 1, 'YBC789');
insert into incidentes values ('2023-11-19', 'Quibd�', 1, 0, 2, 'OPQ062');
insert into incidentes values ('2023-11-20', 'Sincelejo', 2, 2, 3, 'JKL345');
insert into incidentes values ('2023-11-21', 'Mocoa', 0, 0, 1, 'DEF678');
insert into incidentes values ('2023-11-22', 'Puerto Carre�o', 0, 0, 0, 'GHI901');
insert into incidentes values ('2023-11-23', 'Leticia', 1, 1, 2, 'MOP234');
insert into incidentes values ('2023-11-24', 'Arauca', 0, 0, 0, 'TRV567');
insert into incidentes values ('2023-11-25', 'Yopal', 0, 0, 1, 'WXZ890');
insert into incidentes values ('2023-11-26', 'San Andr�s', 1, 0, 2, 'YBC123');
insert into incidentes values ('2023-11-27', 'Turbo', 3, 2, 3, 'LMR456');
insert into incidentes values ('2023-11-28', 'Valledupar', 2, 1, 3, 'SHU789');
insert into incidentes values ('2023-11-29', 'Valledupar', 1, 0, 2, 'O5Q012');
insert into incidentes values ('2023-11-30', 'Ci�naga', 0, 0, 1, 'JJL345');
insert into incidentes values ('2023-12-01', 'Duitama', 1, 0, 2, 'DBF678');
insert into incidentes values ('2023-12-02', 'Manizales', 2, 1, 3, 'GWI901');
insert into incidentes values ('2023-12-03', 'Armenia', 0, 0, 0, 'M5P234');
insert into incidentes values ('2023-12-04', 'Tunja', 0, 0, 1, 'TUV167');
insert into incidentes values ('2023-12-05', 'Riohacha', 1, 0, 2, 'WXF890');
insert into incidentes values ('2023-12-06', 'Santa Marta', 2, 1, 3, 'YBC623');
insert into incidentes values ('2023-12-07', 'C�cuta', 0, 0, 1, 'LM2456');
insert into incidentes values ('2023-12-08', 'Arauca', 0, 0, 0, 'STH789');
insert into incidentes values ('2023-12-09', 'Leticia', 1, 1, 2, 'OPQ062');
insert into incidentes values ('2023-12-10', 'San Andr�s', 2, 1, 3, 'JKL145');
insert into incidentes values ('2023-12-11', 'Turbo', 0, 0, 1, 'DER678');
insert into incidentes values ('2023-12-12', 'Duitama', 0, 0, 0, 'GHH901');
insert into incidentes values ('2023-12-13', 'Duitama', 1, 0, 2, 'MOP734');
insert into incidentes values ('2023-12-14', 'Valledupar', 2, 1, 3, 'TUV167');
insert into incidentes values ('2023-12-15', 'Valledupar', 0, 0, 1, 'WXY890');
insert into incidentes values ('2023-12-16', 'Ci�naga', 1, 0, 2, 'YBS123');
insert into incidentes values ('2023-12-17', 'Bucaramanga', 2, 1, 3, 'LMH456');

/* c. Crear 5 procedimientos almacenados para las siguientes consultas: */

/* i. Visualizar los clientes que cumplen a�os seg�n un mes ingresado por 
par�metros. */

create procedure sp_clientes_mes
(
	@mes_cum_cli varchar(10)
)
as
begin
	select * from cliente where mes_cum_cli = @mes_cum_cli;
end

exec sp_clientes_mes 'Marzo';

/* ii. Visualizar el nombre del cliente, la fecha y el valor seg�n id del cliente ingresado */

create procedure sp_ver_cliente_pedido
(
	@id_cli varchar(11)
)
as
begin
	select c.nom_cli as 'Nombre', p.fec_ped as 'Fecha', p.val_ped as 'Valor' from cliente c join pedido p on c.id_cli = p.id_cli_ped where id_cli = @id_cli;
end

exec sp_ver_cliente_pedido '1004827031';

/* iii. Visualizar los datos de las empresas fundadas seg�n a�o ingresado. */

create procedure sp_ver_datos_empresas_anio
(
	@comaniofun int
)
as
begin
	select * from compania where comaniofun = @comaniofun;
end

exec sp_ver_datos_empresas_anio 2002;

/* iv. Visualizar los datos de la empresa seg�n nit ingresado. */

create procedure sp_ver_empresas_nit
(
	@comnit varchar(11) 
)
as
begin
	select * from compania where comnit = @comnit;
end

exec sp_ver_empresas_nit '800890935-4';

/* v. Visualizar los pedidos que se han realizado seg�n id de articulo ingresado, el 
listado debe mostrar el nombre y direcci�n del cliente, el respectivo n�mero de 
pedido y la cantidad solicitada. */

create procedure sp_ver_datos_pedidos
(
	@id_art int
)
as
begin
	select c.nom_cli as 'Nombre', c.dir_cli 'Direccion', p.id_ped 'Pedido', ar.can_art_artped 'Cantidad' from articuloxpedido ar join pedido p on ar.id_ped_artped = p.id_ped join cliente c on p.id_cli_ped = c.id_cli where id_art_artped = @id_art;
end

exec sp_ver_datos_pedidos 12;