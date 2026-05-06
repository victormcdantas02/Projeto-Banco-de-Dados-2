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
  categoria VARCHAR(50) NOT NULL, -- Ex: "MPB", "Rock Nacional", "Internacional", etc.
  descricao TEXT,
  quantidade_estoque INT NOT NULL,
  valor DECIMAL(10,2),
  observacoes TEXT
);

CREATE TABLE vendedor(
  id_vendedor INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  especialidade VARCHAR(50), -- área de atuação do vendedor, como "MPB", "Rock Nacional", "Internacional", etc.
  tipo ENUM('Titular','Assistente','Estagiário'),
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


-- Faltam mais 90 clientes, podemos gerar eles em python
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

-- fiz categorias e observações mais variavies.
INSERT INTO produto (nome, descricao, categoria, quantidade_estoque, valor, observacoes)
VALUES 

-- Discos Nacionais
('Acabou Chorare', 'Novos Baianos, 1972, MPB/Tropicalismo, edição remasterizada',' MPB', 10, 150.00, 'Clássico da MPB'),
('Aquele Abraço', 'Gilberto Gil, 1969, Samba/MPB, gravação histórica', 'MPB', 8, 140.00, 'Primeiro grande sucesso solo'),
('Clube da Esquina', 'Milton Nascimento & Lô Borges, 1972, MPB, obra-prima brasileira', 'MPB', 12, 160.00, 'Influência internacional'),
('Construção', 'Chico Buarque, 1971, MPB, letras sociais e políticas', 'MPB', 9, 170.00, 'Álbum engajado'),
('Elis & Tom', 'Elis Regina e Tom Jobim, 1974, Bossa Nova, gravação em Los Angeles', 'MPB', 11, 180.00, 'Dueto histórico'),
('Secos & Molhados', 'Secos & Molhados, 1973, Rock brasileiro, capa icônica', 'Rock Nacional', 7, 150.00, 'Estilo teatral'),
('Tropicália ou Panis et Circensis', 'Coletivo Tropicália, 1968, MPB, manifesto tropicalista', 'MPB', 10, 160.00, 'Participação de Caetano e Gil'),
('Barão Vermelho', 'Barão Vermelho, 1982, Rock nacional, estreia da banda', 'Rock Nacional', 6, 140.00, 'Cazuza nos vocais'),
('Legião Urbana', 'Legião Urbana, 1985, Rock nacional, estreia da banda', 'Rock Nacional', 8, 150.00, 'Sucesso imediato'),
('Cabeça Dinossauro', 'Titãs, 1986, Rock nacional, letras críticas e ousadas', 'Rock Nacional', 7, 150.00, 'Álbum polêmico'),
('O Descobrimento do Brasil', 'Legião Urbana, 1993, Rock nacional, fase madura', 'Rock Nacional', 5, 160.00, 'Clássico dos anos 90'),
('Acústico MTV', 'Cássia Eller, 2001, Rock/MPB, versão acústica', 'MPB', 9, 170.00, 'Performance marcante'),

-- Discos Internacionais
('Abbey Road', 'The Beatles, 1969, Rock clássico, capa icônica', 'Rock Internacional', 8, 180.00, 'Travessia da Abbey Road'),
('Back in Black', 'AC/DC, 1980, Hard Rock, álbum mais vendido da banda', 'Rock Internacional', 6, 170.00, 'Homenagem a Bon Scott'),
('Dark Side of the Moon', 'Pink Floyd, 1973, Rock progressivo, edição com encarte original', 'Rock Internacional', 10, 150.00, 'Capa com prisma'),
('Hotel California', 'Eagles, 1976, Rock clássico, faixa título lendária', 'Rock Internacional', 8, 160.00, 'Sucesso mundial'),
('Kind of Blue', 'Miles Davis, 1959, Jazz, álbum revolucionário', 'Jazz', 9, 200.00, 'Obra-prima do jazz'),
('Nevermind', 'Nirvana, 1991, Grunge, capa com bebê na piscina', 'Rock Internacional', 7, 190.00, 'Explosão do grunge'),
('Rumours', 'Fleetwood Mac, 1977, Rock, edição limitada', 'Rock Internacional', 9, 160.00, 'Sucesso de vendas'),
('Thriller', 'Michael Jackson, 1982, Pop, álbum mais vendido da história', 'Pop', 12, 200.00, 'Inclui Billie Jean e Beat It');

-- Aqui determinei as categorias aos vendedores, para que a trigger funcione, caso contrário, não teria como validar a especialidade do vendedor.
INSERT INTO  vendedor (nome, especialidade, tipo, nota_media) 
VALUES
('Carlos Silva', 'Rock Nacional', 'Titular', 4.8),
('Fernanda Lima', 'MPB', 'TItular', 4.5),
('Lucas Pereira', 'Rock Internacional', 'Assistente', 4.2),
('Pamela Silva', 'Jazz', 'Assistente', 4.7),
('Ricardo Alves', 'POP', 'Estagiário', 4.6),
('Vanessa Martins', 'MPB', 'Estagiário', 4.0);

-- Aqui usei endereços fictícios, e o frete é calculado de forma aleatória, mas tem um valor razoavél.
INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES (1, 1, 1, 2, NOW(), 'Rua do Amparo, Olinda - PE', 20.00);

INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES (2, 6, 2, 1, NOW(), 'Rua da Boa Hora, Olinda - PE', 25.00);

INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES (3, 17, 3, 4, NOW(), 'Rua da Aurora, Recife - PE', 15.00);

INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES (4, 13, 4, 1, NOW(), 'Rua do Sol, Recife - PE', 30.00);

INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES (5, 20, 5, 2, NOW(), 'Rua de São Bento, Olinda - PE', 18.00);


/*view que criei para mostrar um top 3 de mais vendidos, tem que testar*/
-- Fiz ajustes e correções.

CREATE VIEW visao_top3_vendas AS
SELECT p.id_produto, p.nome, p.valor,
COUNT(v.id_venda) AS total_vendas
FROM produto p
LEFT JOIN venda v ON p.id_produto =  v.id_produto
GROUP BY p.id_produto, p.nome, p.valor
ORDER BY total_vendas DESC
LIMIT 3;


-- Fiz a Trigger para validar a especialidade do vendedor.
DELIMITER //
CREATE TRIGGER trg_validar_especialidade
BEFORE INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE prod_categoria VARCHAR(50);
    DECLARE vend_especialidade VARCHAR(50);

    SELECT categoria INTO prod_categoria 
    FROM produto 
    WHERE id_produto = NEW.id_produto;
    
    SELECT especialidade INTO vend_especialidade
    FROM vendedor
    WHERE id_vendedor = NEW.id_vendedor;

-- Um IF para checar se a especialidade bate.
    IF prod_categoria <> vend_especialidade THEN
      SIGNAL SQLSTATE '45000' 
      SET MESSAGE_TEXT = 'Vendedor não tem especialidade para este produto';
    END IF;
  END;
    //
DELIMITER ;