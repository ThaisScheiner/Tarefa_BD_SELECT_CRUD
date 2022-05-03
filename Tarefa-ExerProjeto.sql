CREATE DATABASE projeto
go
use projeto

CREATE TABLE users
(
	Id			int				not null			identity(1,1),
	nome		varchar(45)		not null,
	username	varchar(45)		not null			UNIQUE,
	passwords	varchar(45)		not null			DEFAULT('123MUDAR'),
	email		varchar(45)		not null
	PRIMARY KEY(Id)
)
go

CREATE TABLE projects
(
	Id			int				not null			identity(10001,1),
	nome		varchar(45)		not null,
	descricao	varchar(45),
	data_Proj	date			not null			CHECK(data_Proj > '2014-09-01')
	PRIMARY KEY (Id)
)
go 

CREATE TABLE users_has_projects
(
	users_Id		int		not null,
	projects_Id		int		not null
	PRIMARY KEY (users_Id, projects_Id),
	FOREIGN KEY (users_Id)		REFERENCES users (Id),
	FOREIGN KEY (projects_Id)	REFERENCES 	projects (Id)
)

ALTER TABLE users
ALTER COLUMN username varchar(10)

ALTER TABLE users
ALTER COLUMN passwords varchar(8)


--inserindo na tb users

INSERT INTO users (nome, username, passwords, email) values
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com')

--dárá erro, pois o password padrao está incorreto
INSERT INTO users (nome, username, passwords, email) values
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')

INSERT INTO users (nome, username, passwords, email) values
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com')

INSERT INTO users (nome, username, passwords, email) values
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com')

--dárá erro, pois o password padrao está incorreto
INSERT INTO users (nome, username, passwords, email) values
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')


--inserindo projects
INSERT INTO projects (nome, descricao, data_Proj) values
('Re-folha', 'Refatoração das Folhas', '05/09/2014')

INSERT INTO projects (nome, descricao, data_Proj) values
('Manutenção PC´s', 'Manutenção PC´s', '06/09/2014')

INSERT INTO projects (nome, descricao, data_Proj) values
('Auditoria', '', '07/09/2014')


--inserindo na tb users_has_projects

INSERT INTO users_has_projects (users_Id, projects_Id) values
(1, 10001)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(5, 10001)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(3, 10003)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(4, 10002)

INSERT INTO users_has_projects (users_Id, projects_Id) values
(2, 10002)

-- O projeto de Manutenção atrasou, mudar a data para 12/09/2014
update projects
set data_Proj = 12/09/2014
where id = 10002

-- O username de aparecido (usar o nome como condição de mudança) está feio, mudar para Rh_cido
update users
set username = 'Rh_cido'
where nome = 'Aparecido'


-- Mudar o password do username Rh_maria (usar o username como condição de mudança) para 888@*, mas a condição deve verificar se o password dela ainda é 123mudar
update users
set passwords = 888@* 
where id = 1 and passwords = '123mudar'

-- O user de id 2 não participa mais do projeto 10002, removê-lo da associativa
delete users
where id = 2


