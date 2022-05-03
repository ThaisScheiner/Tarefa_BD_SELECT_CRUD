CREATE DATABASE Locadora
GO
USE Locadora
GO

CREATE TABLE cliente
(
	num_cadastro	int					not null		identity(5501,1),
	nome			varchar(100)		not null,
	logradouro		varchar(150)		not null,
	num				int				    not null		check(num >= 0),
	cep				char(8)								CHECK(LEN(cep) = 8)
	PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE filme
(
	id		int			not null	identity(1001,1),
	titulo	varchar(40)	not null,
	ano		int						check(ano <= 2021)
	PRIMARY KEY(id)
)
GO
CREATE TABLE estrela
(
	id	int	not null	identity(9901,1),
	nome varchar(50) not null
	PRIMARY KEY(id)
)
GO
CREATE TABLE filme_estrela
(
	filmeId		int		not null,
	estrelaId	int		not null
	FOREIGN KEY (filmeId) REFERENCES filme (id),
	FOREIGN KEY (estrelaId) REFERENCES estrela (id)
)
GO
CREATE TABLE dvd
(
	num					int			not null	identity(10001,1),
	data_fabricacao	    date	    not null	check(data_fabricacao < getdate()),
	idFilme				int			not null
	PRIMARY KEY(num),
	FOREIGN KEY (idFilme) REFERENCES filme (id)
)
GO
CREATE TABLE locacao
(
	DVDnum				int				not null,
	Clientenum_cadastro	int				not null,
	data_locacao		date			not null	check(data_locacao = getdate()),
	data_devolucao		date			not null,
	valor				decimal(7,2)	not null	check(valor >= 0)
	
	PRIMARY KEY(data_locacao, DVDnum, Clientenum_cadastro),
	FOREIGN KEY(DVDnum) REFERENCES dvd(num),
	FOREIGN KEY (Clientenum_cadastro) REFERENCES cliente (num_cadastro)
	
)

alter table filme
alter column titulo varchar(80)


--inserindo filme na tabela
INSERT INTO filme (titulo, ano) VALUES
('Whiplash', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Birdman', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Interestelar', 2014)

INSERT INTO filme (titulo, ano) VALUES
('A Culpa é das estrelas', 2015)

INSERT INTO filme (titulo, ano) VALUES
('Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2016)

INSERT INTO filme (titulo, ano) VALUES
('Sing', 2016)

INSERT INTO filme (titulo, ano) VALUES
('Aaaaaaaa', 2020)

select *
from filme

select *
from estrela

--inserindo estrela na tabela
alter table estrela
add nomeReal varchar(50) 

INSERT INTO estrela(nome, nomeReal) VALUES
('Michael Keaton', 'Michael John Douglas')

INSERT INTO estrela(nome, nomeReal) VALUES
('Emma Stone', 'Emily Jean Stone')

INSERT INTO estrela(nome, nomeReal) VALUES
('Miles Teller')

INSERT INTO estrela(nome, nomeReal) VALUES
('Steve Carell', 'Steven John Carell')

INSERT INTO estrela(nome, nomeReal) VALUES
('Jennifer Garner', 'Jennifer Anne Garner')

--inserindo cliente
INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Matilde Luz', 'Rua Síria', 150, 03086040)

INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, 04419110)

INSERT INTO cliente(nome, logradouro, num) VALUES
('Daniel Ramalho', 'Rua Itajutiba', 169)

INSERT INTO cliente(nome, logradouro, num) VALUES
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36)

INSERT INTO cliente(nome, logradouro, num, cep) VALUES
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, 02917110)

--inserindo dvd
INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1001)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1003)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1001)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1004)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-12-02', 1005)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2019-10-18', 1002)

INSERT INTO dvd(data_fabricacao, idFilme) VALUES
('2020-04-03', 1003)

--inserindo filme_estrela
INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1002, 9901)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1002, 9902)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1001, 9903)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1005, 9904)

INSERT INTO filme_estrela(filmeId, estrelaId) VALUES
(1005, 9905)

--inserindo locacao
INSERT INTO locacao(DVDnum, Clientenum_cadastro, data_devolucao, valor) VALUES
(10001, 5501,'2022-04-30', 3.50)

update cliente
set cep = 08411150
where num_cadastro = 5503

update cliente
set cep = 02918190
where num_cadastro = 5504

--erro A locação de 2021-02-18 do cliente 5502 teve o valor de 3.25 para cada DVD alugado
update locacao
set valor = 3.25
where data_Locacao = '2021-02-18' and ClienteNum_Cadastro = 5502

--erro A locação de 2021-02-24 do cliente 5501 teve o valor de 3.10 para cada DVD alugado
update locacao
set valor = 3.10
where data_Locacao = '2021-02-24' and ClienteNum_Cadastro = 5501

--erro O DVD 10005 foi fabricado em 2019-07-14
update dvd 
set Data_fabricacao = '2019-07-14'
where num = 10005

update estrela
set nomeReal = 'Miles Alexander Teller'
where id = 9903

delete dvd
where num = 1006

--Consultas
select * from dvd

select titulo, ano
from filme
where ano = 2014

select id, ano
from filme
where titulo = 'Birdman'

select id, ano
from filme
where titulo like '%plash'

select id, nome, nomeReal
from estrela
where nome like 'Steve%' 

select idFilme, convert (char(11), data_fabricacao, 103) as fab
from dvd
where data_fabricacao >= '2020-01-01'
order by fab

select DVDnum, data_locacao, data_devolucao, valor
from locacao
where Clientenum_cadastro = 5505

select logradouro, num, cep 
from cliente
where nome = 'Matilde Luz'

select nomeReal
from estrela
where nome = 'Michael Keaton'

select num_cadastro, nome, logradouro + ' ' + cast(num as varchar(5)) + ' ' + cep + ' ' as end_completo
from cliente
where num_cadastro >= 5503
