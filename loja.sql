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

CREATE TABLE produto(
  id_produto INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(100) NOT NULL,
  categoria VARCHAR(50) NOT NULL, -- Ex: "MPB", "Rock Nacional", "Internacional", etc.
  descricao TEXT,
  quantidade_estoque INT NOT NULL,
  valor DECIMAL(10,2),
  observacoes TEXT,
  id_vendedor INT,
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);

CREATE TABLE transportadora(
    id_transportadora INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    tempo_medio_entrega INT DEFAULT 5, -- (Lembrete: 5 dias)
    valor_frete DECIMAL(10,2) DEFAULT 20.00
);

CREATE TABLE venda(
  id_venda INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT,
  id_produto INT,
  id_transportadora INT,
  id_vendedor INT,
  quantidade INT NOT NULL DEFAULT 1,
  data_hora DATETIME,
  endereco TEXT,
  valor_frete DECIMAL(10,2),
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
  FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
  FOREIGN KEY (id_transportadora) REFERENCES transportadora(id_transportadora),
  FOREIGN KEY (id_vendedor) REFERENCES vendedor(id_vendedor)
);


-- 100 Clientes, gerados em Phyton
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
('JoÃ£o Pereira', 31, 'M', '1993-08-08'),
('Karen Oliveira', 24, 'F', '2000-01-20'),
('Leonardo Melo', 38, 'M', '1986-03-05'),
('Marina Dias', 26, 'F', '1998-07-14'),
('Nicolas Ferreira', 32, 'M', '1992-10-30'),
('Olivia Ramos', 23, 'F', '2001-06-18'),
('Paulo Cardoso', 45, 'M', '1979-02-28'),
('Quezia Lima', 20, 'F', '2004-11-09'),
('Rafael Souza', 36, 'M', '1988-04-22'),
('Sara Nunes', 29, 'F', '1995-08-17'),
('Thiago Castro', 42, 'M', '1982-12-03'),
('Ursula Pinto', 27, 'F', '1997-05-11'),
('Vitor Almeida', 33, 'M', '1991-09-25'),
('Wendy Rocha', 21, 'F', '2003-03-07'),
('Xavier Lima', 39, 'M', '1985-07-19'),
('Yasmin Costa', 25, 'F', '1999-01-30'),
('Zeca Pereira', 50, 'M', '1974-06-15'),
('Amanda Silva', 28, 'F', '1996-02-10'),
('Bernardo Melo', 34, 'M', '1990-08-27'),
('Cintia Alves', 22, 'F', '2002-04-05'),
('Diego Torres', 37, 'M', '1987-11-13'),
('Elisa Santos', 26, 'F', '1998-09-01'),
('Fabio Nunes', 41, 'M', '1983-03-18'),
('Gisele Ramos', 30, 'F', '1994-12-22'),
('Hugo Cardoso', 29, 'M', '1995-06-07'),
('Ivone Souza', 44, 'F', '1980-10-14'),
('Jose Ferreira', 55, 'M', '1969-01-28'),
('Kelly Lima', 23, 'F', '2001-07-04'),
('Luiz Almeida', 32, 'M', '1992-05-16'),
('Marcia Pinto', 47, 'F', '1977-02-03'),
('Nelson Costa', 36, 'M', '1988-08-20'),
('Odete Rocha', 52, 'F', '1972-04-09'),
('Pedro Melo', 28, 'M', '1996-11-25'),
('Quiteria Alves', 19, 'F', '2005-03-12'),
('Rodrigo Torres', 43, 'M', '1981-09-06'),
('Simone Santos', 31, 'F', '1993-07-23'),
('Tiago Nunes', 38, 'M', '1986-01-17'),
('Ulisses Ramos', 25, 'M', '1999-05-29'),
('Vera Cardoso', 49, 'F', '1975-10-08'),
('Wilson Souza', 35, 'M', '1989-04-14'),
('Ximena Ferreira', 27, 'F', '1997-12-01'),
('Ygor Lima', 22, 'M', '2002-06-18'),
('Zilda Almeida', 59, 'F', '1966-08-25'),
('Andre Pinto', 33, 'M', '1991-02-07'),
('Bianca Costa', 26, 'F', '1998-10-14'),
('Caio Rocha', 30, 'M', '1994-04-2 8'),
('Daniele Melo', 24, 'F', '2000-12-05'),
('Emanuel Alves', 40, 'M', '1984-06-19'),
('Fabiana Torres', 35, 'F', '1989-02-23'),
('Gilson Santos', 46, 'M', '1978-09-10'),
('Helena Nunes', 28, 'F', '1996-07-04'),
('Ivan Ramos', 32, 'M', '1992-11-17'),
('Juliana Cardoso', 29, 'F', '1995-03-30'),
('Kevin Souza', 21, 'M', '2003-08-12'),
('Lara Ferreira', 27, 'F', '1997-01-25'),
('Marcos Lima', 44, 'M', '1980-05-08'),
('Natalia Almeida', 33, 'F', '1991-10-21'),
('Orlando Pinto', 50, 'M', '1974-04-03'),
('Patricia Costa', 38, 'F', '1986-12-16'),
('Quintino Rocha', 25, 'M', '1999-06-29'),
('Renata Melo', 30, 'F', '1994-02-11'),
('Samuel Alves', 35, 'M', '1989-08-24'),
('Tatiane Torres', 23, 'F', '2001-04-07'),
('Umberto Santos', 42, 'M', '1982-10-20'),
('Vanessa Nunes', 27, 'F', '1997-06-02'),
('Wagner Ramos', 48, 'M', '1976-01-15'),
('Xuxa Cardoso', 55, 'F', '1969-07-28'),
('Yuri Souza', 20, 'M', '2004-03-10'),
('Zelma Ferreira', 61, 'F', '1963-09-23'),
('Arthur Lima', 29, 'M', '1995-05-06'),
('Beatriz Almeida', 24, 'F', '2000-11-19'),
('Claudio Pinto', 37, 'M', '1987-07-01'),
('Debora Costa', 32, 'F', '1992-02-14'),
('Eduardo Rocha', 45, 'M', '1979-08-27'),
('Flavia Melo', 26, 'F', '1998-04-09'),
('Gustavo Alves', 31, 'M', '1993-10-22'),
('Heloisa Torres', 28, 'F', '1996-06-05'),
('Igor Santos', 36, 'M', '1988-12-18'),
('Jaqueline Nunes', 22, 'F', '2002-08-01'),
('Kaua Ramos', 19, 'M', '2005-04-14'),
('Leticia Cardoso', 33, 'F', '1991-10-27'),
('Melissa Andrade', 27, 'F', '1999-12-11'),
('Otavio Barros', 34, 'M', '1992-03-08'),
('Priscila Gomes', 23, 'F', '2001-09-27'),
('Renan Azevedo', 28, 'M', '1996-05-19'),
('Sofia Martins', 31, 'F', '1993-07-02'),
('Tadeu Carvalho', 40, 'M', '1984-11-15'),
('Ubiraci Souza', 36, 'M', '1988-02-21'),
('Valeria Monteiro', 25, 'F', '1999-04-30'),
('William Duarte', 29, 'M', '1995-08-12'),
('Yara Barbosa', 22, 'F', '2002-10-05'),
('Yves Saint-Laurent', 50, 'M', '1976-24-05');

-- fiz categorias e observações mais variavies.
INSERT INTO produto (nome, descricao, categoria, quantidade_estoque, valor, observacoes)
VALUES 

-- Discos Nacionais
('Acabou Chorare', 'Novos Baianos, 1972, MPB/Tropicalismo, edição remasterizada','MPB', 10, 150.00, 'Clássico da MPB'),
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

INSERT INTO transportadora (nome, cidade, tempo_medio_entrega, valor_frete) VALUES 
('TransExpress', 'Recife', 5, 25.00),
('Entregou', 'Olinda', 4, 20.00),
('Rapidão', 'Jaboatão', 3, 15.00),
('Frete Fácil', 'Recife', 6, 30.00),
('Entrega Rápida', 'Olinda', 4, 18.00);

-- Aqui usei endereços fictícios, e o frete é calculado de forma aleatória, mas tem um valor razoavél.
INSERT INTO venda (id_cliente, id_produto, id_transportadora, id_vendedor, data_hora, endereco, valor_frete)
VALUES
(1, 1, 1, 2, NOW(), 'Rua do Amparo, Olinda - PE', 20.00),
(2, 6, 2, 1, NOW(), 'Rua da Boa Hora, Olinda - PE', 25.00),
(3, 17, 3, 4, NOW(), 'Rua da Aurora, Recife - PE', 15.00),
(4, 13, 4, 3, NOW(), 'Rua do Sol, Recife - PE', 30.00),
(5, 20, 5, 5, NOW(), 'Rua de São Bento, Olinda - PE', 18.00);


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

/*Criei uma view da visão do cliente e vendas onde ele pode ver o total das compras ja foi testado*/

CREATE VIEW visao_cliente_vendas AS
SELECT c.nome AS cliente,
COUNT(v.id_venda) AS total_compras
FROM cliente c
LEFT JOIN venda v ON c.id_cliente = v.id_cliente
GROUP BY c.nome;

/*Visão do vendedor sobre as sua vendas, ja foi testado tbm*/
CREATE VIEW visao_vendedor_vendas AS
SELECT ve.nome AS vendedor,
SUM(p.valor) AS total_vendido
FROM venda v
JOIN vendedor ve ON v.id_vendedor = ve.id_vendedor
JOIN produto p ON v.id_produto = p.id_produto
GROUP BY ve.nome;

-- Fiz a Trigger para atualizar o estoque. 
DELIMITER //
CREATE TRIGGER TRG_ATUALIZAR_ESTOQUE
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
    UPDATE produto
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade
    WHERE id_produto = NEW.id_produto;
END;
//
DELIMITER ;

-- Fiz essa para impedir que venda mais do que o tenha em estoque.
DELIMITER //
CREATE TRIGGER TRG_VERIFICAR_ESTOQUE
BEFORE INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE qtd INT;
    SELECT quantidade_estoque INTO qtd
    FROM produto
    WHERE id_produto = NEW.id_produto;

    IF qtd < NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estoque insuficiente para realizar a venda';
    END IF;
END;
//
DELIMITER ;

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
    IF LOWER(prod_categoria) <> LOWER(vend_especialidade) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Vendedor não tem especialidade para este produto';
    END IF;
  END;
//

DELIMITER ;

-- adicionada trigger cashback
DELIMITER //

CREATE TRIGGER trg_cliente_cashback
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE total_gasto DECIMAL(10,2);

    SELECT SUM(p.valor * v.quantidade)
    INTO total_gasto
    FROM venda v
    JOIN produto p ON v.id_produto = p.id_produto
    WHERE v.id_cliente = NEW.id_cliente;

    IF total_gasto > 500 THEN
        INSERT INTO cliente_especial (id_cliente, cashback)
        VALUES (NEW.id_cliente, total_gasto * 0.02)
        ON DUPLICATE KEY UPDATE cashback = total_gasto * 0.02;
    END IF;
END;
//

DELIMITER ;

-- adicionada trigger bonus vendedor
DELIMITER //

CREATE TRIGGER trg_vendedor_bonus
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
    DECLARE total_vendido DECIMAL(10,2);

    SELECT SUM(p.valor * v.quantidade)
    INTO total_vendido
    FROM venda v
    JOIN produto p ON v.id_produto = p.id_produto
    WHERE v.id_vendedor = NEW.id_vendedor;

    IF total_vendido > 1000 THEN
        INSERT INTO vendedor_especial (id_vendedor, bonus)
        VALUES (NEW.id_vendedor, total_vendido * 0.05)
        ON DUPLICATE KEY UPDATE bonus = total_vendido * 0.05;
    END IF;
END;
//

-- adicionada trigger remover cliente especial
DELIMITER //

CREATE TRIGGER trg_remover_cliente_especial
AFTER UPDATE ON cliente_especial
FOR EACH ROW
BEGIN
    IF NEW.cashback <= 0 THEN
        DELETE FROM cliente_especial
        WHERE id_cliente = NEW.id_cliente;
    END IF;
END;
//

DELIMITER; 

-- adicionada procedure venda
DELIMITER //

CREATE PROCEDURE realizar_venda(
    IN p_cliente INT,
    IN p_produto INT,
    IN p_transportadora INT,
    IN p_vendedor INT,
    IN p_endereco TEXT,
    IN p_frete DECIMAL(10,2)
)
BEGIN
    INSERT INTO venda (
        id_cliente,
        id_produto,
        id_transportadora,
        id_vendedor,
        data_hora,
        endereco,
        valor_frete
    )
    VALUES (
        p_cliente,
        p_produto,
        p_transportadora,
        p_vendedor,
        NOW(),
        p_endereco,
        p_frete
    );

    UPDATE produto
    SET quantidade_estoque = quantidade_estoque - 1
    WHERE id_produto = p_produto;
END;
//

DELIMITER ;

-- adicionada procedure sorteio
DELIMITER //

CREATE PROCEDURE sorteio()
BEGIN
    DECLARE cliente_sorteado INT;

    SELECT id_cliente
    INTO cliente_sorteado
    FROM cliente
    ORDER BY RAND()
    LIMIT 1;

    IF EXISTS (
        SELECT *
        FROM cliente_especial
        WHERE id_cliente = cliente_sorteado
    ) THEN
        SELECT cliente_sorteado AS cliente, 200 AS voucher;
    ELSE
        SELECT cliente_sorteado AS cliente, 100 AS voucher;
    END IF;
END;
//

DELIMITER ;

-- adicionada procedure reajuste
DELIMITER //

CREATE PROCEDURE reajuste(
    IN percentual DECIMAL(5,2),
    IN categoria VARCHAR(50)
)
BEGIN
    UPDATE vendedor
    SET nota_media = nota_media + (nota_media * percentual / 100)
    WHERE especialidade = categoria;
END;
//

DELIMITER ;

-- adicionada procedure estatisticas
DELIMITER //

CREATE PROCEDURE estatisticas()
BEGIN
    SELECT p.nome,
    COUNT(v.id_venda) AS total_vendas,
    SUM(p.valor) AS valor_total
    FROM venda v
    JOIN produto p ON v.id_produto = p.id_produto
    GROUP BY p.nome
    ORDER BY total_vendas DESC;
END;
//

DELIMITER ;

-- adicionados usuarios
CREATE USER 'admin'@'localhost' IDENTIFIED BY '123';

CREATE USER 'gerente'@'localhost' IDENTIFIED BY '123';

CREATE USER 'funcionario'@'localhost' IDENTIFIED BY '123';

GRANT ALL PRIVILEGES ON loja.* TO 'admin'@'localhost';

GRANT SELECT, UPDATE, DELETE
ON loja.* TO 'gerente'@'localhost';

GRANT INSERT, SELECT
ON loja.venda TO 'funcionario'@'localhost';

FLUSH PRIVILEGES;
