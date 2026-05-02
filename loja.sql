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
  nota_media DECIMAL(3,2),
  );

CREATE TABLE produto(
 id_produto INT PRIMARY KEY AUTO_INCREMENT,
 nome VARCHAR(30) NOT NULL,
 descricao TEXT,
 quantidade_estoque INT NOT NULL,
 valor DECIMAL(10,2),
 observacoes TEXT,
 );

CREATE TABLE transportadora(
    id_transportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
  );

CREATE TABLE venda(
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    id_transportadora INT,
    data_hora DATETIME,
    endereco TEXT,
    valor_frete DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
    FOREIGN KEY (id_transportadora) REFERENCES transportadora(id_transportadora)
);


