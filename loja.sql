CREATE DATABASE loja;
USE loja;

CREATE TABLE cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
idade INT NOT NULL,
sexo BOOLEAN,
data_nascimento DATE,
);

CREATE TABLE vendedor(
  id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  causa_social VARCHAR,
  tipo VARCHAR,
  nota_media DECIMAL,
  );

CREATE TABLE produto(
 id_produto INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(30) NOT NULL,
 descricao TEXT,
 quantidade_estoque INT NOT NULL,
 valor DECIMAL,
 observacoes TEXT,
 );

CREATE TABLE transportadora(
    id_transportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
  );


