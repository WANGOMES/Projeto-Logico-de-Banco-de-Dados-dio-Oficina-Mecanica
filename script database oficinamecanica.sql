CREATE DATABASE OficinaMecanica;

USE OficinaMecanica;

CREATE TABLE Peca (
	idPeca int not null auto_increment primary key,
	DescPeca varchar(45) not null,
	PrecoPeca decimal(6,2) not null
);

CREATE TABLE Pecas_em (
	Peca_id int not null,
	Os_id int not null,
	constraint fk_idpeca_id foreign key(Peca_id) references Peca(idPeca),
	constraint fk_ospecas_id foreign key(Os_id) references OS(idOs)
);

CREATE TABLE Servico(
	idServico int not null auto_increment primary key,
	DescServico enum("CONSERTO", "REVISÃO") not null,
	PrecoServico decimal(6,2) not null
);

CREATE TABLE Servico_em(
	Servico_id int not null,
	Os_id int not null,
	constraint fk_servico_id foreign key(Servico_id) references Servico(idServico),
	constraint fk_os_id foreign key(Os_id) references OS(idOs)
);


CREATE TABLE Mecanico(
	idMecanico int not null auto_increment primary key,
	NomeMecanico varchar(45) not null,
	Endereco varchar(200) not null,
	Especialidade varchar(45) not null
);

CREATE TABLE Cliente(
	idCliente int not null auto_increment,
	NomeCliente varchar(45) not null,
	Endereco varchar(200) not null,
	Telefone varchar(45) not null,
	VeiculoPlaca varchar(45) not null,
	constraint pk_cliente primary key(idCliente, VeiculoPlaca)
);


CREATE TABLE Trabalha_em(
	Equipe_id int not null,
	Mecanico_id int not null,
	constraint fk_mecanico_id foreign key(Mecanico_id) references Mecanico(idMecanico),
	constraint fk_equipe_id foreign key(Equipe_id) references Equipe(idEquipe)
);

CREATE TABLE Equipe(
	idEquipe int not null auto_increment primary key,
	DescEquipe varchar(45) not null
);


CREATE TABLE OS(
	idOs int not null auto_increment primary key,
	DataEmissao date DEFAULT(CURRENT_DATE),
	DataEntrega date DEFAULT(DATE_ADD(CURRENT_DATE, INTERVAL 7 DAY)),
	Status ENUM("Concluída", "Em Andamento", "Cancelada", "Pendente") not null DEFAULT "Em Andamento",
	Autorizacao BOOL,
	Preco decimal(6,2) DEFAULT (0.00) 
);


-- TRIGGERS --
-- Tables OS and Servico_em --

DELIMITER $
CREATE TRIGGER Preco_Os AFTER INSERT
ON Servico_em
FOR EACH ROW
BEGIN
UPDATE OS SET Preco = Preco + (SELECT PrecoServico FROM Servico 
	WHERE NEW.Servico_id=idServico)
	WHERE idOs=NEW.Os_id;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER Delete_Preco_Os AFTER DELETE
ON Servico_em
FOR EACH ROW
BEGIN
UPDATE OS SET Preco = Preco - (SELECT PrecoServico FROM Servico 
	WHERE OLD.Servico_id=idServico)
	WHERE idOs=OLD.Os_id;
END$
DELIMITER ;

-- TRIGGERS --
-- Tables OS and Pecas_em --

DELIMITER $
CREATE TRIGGER Increment_Pecas_Os AFTER INSERT
ON Pecas_em
FOR EACH ROW
BEGIN
UPDATE OS SET Preco = Preco + (SELECT PrecoPeca FROM Peca
	WHERE NEW.Peca_id=idPeca)
	WHERE idOs=NEW.Os_id;
END$
DELIMITER ;

DELIMITER $
CREATE TRIGGER Decrement_Pecas_Os AFTER DELETE
ON Pecas_em
FOR EACH ROW
BEGIN
UPDATE OS SET Preco = Preco - (SELECT PrecoPeca FROM Peca
	WHERE OLD.Peca_id=idPeca)
	WHERE idOs=OLD.Os_id;
END$
DELIMITER ;
