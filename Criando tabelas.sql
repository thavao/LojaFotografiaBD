create database LojaFotografia
use LojaFotografia
create table Pessoa(
	codigo int not null identity(1,1),
	nome varchar (60) not null,
	telefoneResidencial varchar(8),
	telefoneComercial varchar(9),
	telefoneCelular varchar(9),
	logradouro varchar(50),
	numero varchar(5),
	complemento varchar(30),
	bairro varchar (30),
	cidade varchar (30),
	UF char (2),
	CEP varchar (8),
	constraint PK_Pessoa PRIMARY KEY (codigo)
);
go

create table Cliente_PF(
	CPF varchar (11) not null,
	codigoPessoa int not null,
	RG varchar (9),
	dataNascimento date,
	sexo char(1)
	constraint PK_Cliente_PF PRIMARY KEY (CPF, codigoPessoa),
	constraint FK_codigoPessoaPF FOREIGN KEY (codigoPessoa) references Pessoa (codigo)
);
go

create table Cliente_PJ(
	CNPJ varchar (14) not null,
	codigoPessoa int not null,
	inscEstadual varchar (12),
	nomeResponsavel varchar (40),
	constraint PK_Cliente_PJ PRIMARY KEY (CNPJ, codigoPessoa),
	constraint FK_codigoPessoaPJ FOREIGN KEY (codigoPessoa) references Pessoa (codigo)
);
go

create table Funcionario(
	codigoPessoa int not null,
	contato varchar (40),
	funcao varchar (30),
	departamento varchar (30),
	constraint PK_Funcionario PRIMARY KEY (codigoPessoa),
	constraint FK_codigoPessoaFunc FOREIGN KEY (codigoPessoa) references Pessoa (codigo)
);
go

create table Produto (
	codigo int not null,
	nome varchar(50),
	tipor varchar(40),
	descricao varchar (70),
	precoCusto numeric (10,2),
	precoVenda numeric (10,2),
	qtdMinima int,
	qtdEstoque int,
	constraint PK_Produto PRIMARY KEY (codigo)
);
go

create table Venda (
	numero int not null,
	cliente int not null,
	funcionario int not null,
	dataVenda date,
	valor numeric (10,2),
	condicaoPagamento varchar (10)
	constraint PK_Venda PRIMARY KEY (numero),
	constraint FK_Cliente FOREIGN KEY (cliente) REFERENCES Pessoa (codigo),
	constraint FK_Funcionario FOREIGN KEY (funcionario) REFERENCES Funcionario (codigoPessoa)
);
go

create table ItemVenda( 
	produtoCodigo int not null,
	numeroVenda int not null,
	quantidade int not null,
	valorUnitario numeric (10,2),
	valorTotal numeric (10,2),
	constraint PK_ItemVenda PRIMARY KEY (produtoCodigo, numeroVenda),
	constraint FK_Produto FOREIGN KEY (produtoCodigo) REFERENCES Produto (codigo),
	constraint FK_Venda FOREIGN KEY (numeroVenda) REFERENCES Venda (numero)
);
go
