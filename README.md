# Projeto Banco de Dados 2 — Loja de Vinil

Este projeto foi desenvolvido para a disciplina de Banco de Dados II com o objetivo de implementar um sistema completo de gerenciamento para uma loja de discos de vinil utilizando SQL.

O sistema foi modelado seguindo conceitos de banco de dados relacional, integridade referencial, regras de negócio, procedures, triggers, views e controle de permissões de usuários.

### Integrantes

- Gregório de Albuquerque Borba Cavalcanti
- João Martins de Ataíde Bisneto
- Sérgio Augusto Leite de Melo Filho
- Victor de Macêdo Claudino Dantas
## Modelo Visual

<img src="/assets/Projeto.png" >


# Objetivos do Projeto

- Modelar um banco de dados relacional completo
- Implementar regras de negócio diretamente no banco
- Utilizar procedures e triggers para automação
- Criar consultas otimizadas com views
- Garantir integridade e consistência dos dados
- Simular um sistema real de vendas de vinis

---

# Estrutura do Banco de Dados

O sistema é composto pelas seguintes entidades:

| Tabela | Descrição |
|---|---|
| `cliente` | Armazena os clientes da loja |
| `cliente_especial` | Clientes com cashback ativo |
| `produto` | Catálogo de discos de vinil |
| `vendedor` | Funcionários responsáveis pelas vendas |
| `vendedor_especial` | Vendedores com bônus por desempenho |
| `transportadora` | Empresas responsáveis pelas entregas |
| `venda` | Registro das vendas realizadas |

---

# Regras de Negócio

## Especialidade dos Vendedores

Cada vendedor possui uma especialidade correspondente a uma categoria musical específica, como:

- MPB
- Rock Nacional
- Rock Internacional
- Jazz
- Pop

Essa abordagem foi adotada para evitar relações muitos-para-muitos entre vendedores e produtos, simplificando a modelagem do banco e garantindo maior organização dos dados.

---

## Validação de Especialidade

O sistema utiliza uma trigger para validar automaticamente se o vendedor responsável pela venda possui especialidade compatível com a categoria do produto.

Caso a categoria do produto seja diferente da especialidade do vendedor, a venda é bloqueada automaticamente.

Essa validação garante:
- integridade das regras de negócio
- consistência dos dados
- controle sobre as operações realizadas

---

## Cashback para Clientes Especiais

Clientes que ultrapassam determinado valor acumulado em compras tornam-se clientes especiais automaticamente.

Ao atingir esse critério:
- o cliente é inserido na tabela `cliente_especial`
- um cashback é gerado proporcionalmente ao valor gasto

---

## Bônus para Vendedores

Vendedores que ultrapassam um valor mínimo em vendas recebem bônus automaticamente.

O sistema registra:
- o vendedor
- o valor acumulado
- o bônus gerado

---

# Views Implementadas

## Top 3 Produtos Mais Vendidos

A view `visao_top3_vendas` foi criada para facilitar análises rápidas de desempenho comercial.

Ela retorna:
- produtos mais vendidos
- quantidade total de vendas
- valor dos produtos

Essa abordagem evita a necessidade de consultas complexas repetitivas.

---

## Clientes e Quantidade de Compras

A view `visao_cliente_vendas` apresenta:
- clientes cadastrados
- total de compras realizadas

---

## Vendas por Vendedor

A view `visao_vendedor_vendas` exibe:
- vendedores
- total vendido por cada um

---

# Procedures Implementadas

| Procedure | Função |
|---|---|
| `realizar_venda` | Registra vendas e atualiza estoque |
| `reajuste` | Realiza reajustes por categoria |
| `sorteio` | Seleciona clientes para vouchers |
| `estatisticas` | Gera relatórios estatísticos |

---

# Triggers Implementadas

| Trigger | Função |
|---|---|
| `trg_validar_especialidade` | Valida especialidade do vendedor |
| `trg_cliente_cashback` | Gera cashback automaticamente |
| `trg_vendedor_bonus` | Gera bônus para vendedores |
| `trg_remover_cliente_especial` | Remove clientes sem cashback |

---

# Controle de Usuários

O sistema possui três níveis de acesso:

| Usuário | Permissões |
|---|---|
| Admin | Controle total do banco |
| Gerente | Consulta, atualização e remoção |
| Funcionário | Inserção e consulta de vendas |

---

# Tecnologias Utilizadas


- SQL
- Flask
- MySql

---

# Considerações Finais

