CREATE DATABASE loja;
USE loja;

CREATE TABLE cliente(
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  idade INT NOT NULL,
  sexo CHAR(1) CHECK (sexo IN ('F','M')), /*Cuidado com o boolean, 0 e 1, para feminino e masculino, o padrão é (f e m)*/
  data_nascimento DATE
);

CREATE TABLE cliente_especial(
  id_cliente INT PRIMARY KEY,
  cashback DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE produto(
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  descricao TEXT,
  quantidade_estoque INT NOT NULL,
  valor DECIMAL(10,2),
  observacoes TEXT
);

CREATE TABLE vendedor(
  id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  causa_social VARCHAR,
  tipo VARCHAR,
  nota_media DECIMAL(3,2)
  );

CREATE TABLE vendedor_especial(
  id_vendedor iNT PRIMARY KEY, 
  bonus DECIMAL (10,2),
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

CREATE TABLE transportadora(
    id_transportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL
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


/* Faltam mais 90 clientes, podemos gerar eles em python*/
INSERT INTO cliente (nome, idade, sexo, data_nascimento)
VALUES
('Alice Souza', 25, 'F', '1999-03-15'),
('Bruno Lima', 30, 'M', '1994-07-22'),
('Carla Mendes', 28, 'F', '1996-11-05'),
('Daniel Rocha', 35, 'M', '1989-01-10'),
('Eduarda Silva', 22, 'F', '2002-09-18'),
('Felipe Santos', 40, 'M', '1984-06-30'),
('Gabriela Costa', 27, 'F', '1997-04-12'),
('Henrique Alves', 33, 'M', '1991-12-01'),
('Isabela Torres', 29, 'F', '1995-05-25'),
('João Pereira', 31, 'M', '1993-08-08');


INSERT INTO produto (nome, descricao, quantidade_estoque, valor, observacoes)
VALUES /*fiz categorias e observações mais variavies.*/

/* Discos Nacionais*/
('Acabou Chorare', 'Novos Baianos, 1972, MPB/Tropicalismo, edição remasterizada', 10, 150.00, 'Clássico da MPB'),
('Aquele Abraço', 'Gilberto Gil, 1969, Samba/MPB, gravação histórica', 8, 140.00, 'Primeiro grande sucesso solo'),
('Clube da Esquina', 'Milton Nascimento & Lô Borges, 1972, MPB, obra-prima brasileira', 12, 160.00, 'Influência internacional'),
('Construção', 'Chico Buarque, 1971, MPB, letras sociais e políticas', 9, 170.00, 'Álbum engajado'),
('Elis & Tom', 'Elis Regina e Tom Jobim, 1974, Bossa Nova, gravação em Los Angeles', 11, 180.00, 'Dueto histórico'),
('Secos & Molhados', 'Secos & Molhados, 1973, Rock brasileiro, capa icônica', 7, 150.00, 'Estilo teatral'),
('Tropicália ou Panis et Circensis', 'Coletivo Tropicália, 1968, MPB, manifesto tropicalista', 10, 160.00, 'Participação de Caetano e Gil'),
('Barão Vermelho', 'Barão Vermelho, 1982, Rock nacional, estreia da banda', 6, 140.00, 'Cazuza nos vocais'),
('Legião Urbana', 'Legião Urbana, 1985, Rock nacional, estreia da banda', 8, 150.00, 'Sucesso imediato'),
('Cabeça Dinossauro', 'Titãs, 1986, Rock nacional, letras críticas e ousadas', 7, 150.00, 'Álbum polêmico'),
('O Descobrimento do Brasil', 'Legião Urbana, 1993, Rock nacional, fase madura', 5, 160.00, 'Clássico dos anos 90'),
('Acústico MTV', 'Cássia Eller, 2001, Rock/MPB, versão acústica', 9, 170.00, 'Performance marcante'),

/*Discos Internacionais*/ 
('Abbey Road', 'The Beatles, 1969, Rock clássico, capa icônica', 8, 180.00, 'Travessia da Abbey Road'),
('Back in Black', 'AC/DC, 1980, Hard Rock, álbum mais vendido da banda', 6, 170.00, 'Homenagem a Bon Scott'),
('Dark Side of the Moon', 'Pink Floyd, 1973, Rock progressivo, edição com encarte original', 10, 150.00, 'Capa com prisma'),
('Hotel California', 'Eagles, 1976, Rock clássico, faixa título lendária', 8, 160.00, 'Sucesso mundial'),
('Kind of Blue', 'Miles Davis, 1959, Jazz, álbum revolucionário', 9, 200.00, 'Obra-prima do jazz'),
('Nevermind', 'Nirvana, 1991, Grunge, capa com bebê na piscina', 7, 190.00, 'Explosão do grunge'),
('Rumours', 'Fleetwood Mac, 1977, Rock, edição limitada', 9, 160.00, 'Sucesso de vendas'),
('Thriller', 'Michael Jackson, 1982, Pop, álbum mais vendido da história', 12, 200.00, 'Inclui Billie Jean e Beat It');

//view que criei para mostrar um top 3 de mais vendidos, tem que testar

CREATE VIEW visao_top3_vendas AS
SELECT p.id_produto, p.nome, p.valor,
COUNT (v.id_venda) AS total_vendas
FROM produto p
LEFT JOIN venda v ON p.id_produto =  v.id_produto
GROUP BY p.id_produto, p.nome.valor
ORDER BY total_vendas DESC
LIMIT 3;
