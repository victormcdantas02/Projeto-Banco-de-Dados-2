# Projeto-Banco-de-Dados-2
Sistema de e-commerce de produtos diversos

1. Especialidade dos vendedores
Motivo: Evitar uma relação de muitos-para-muitos entre produtos e vendedores.

Descrição: Cada produto tem uma categoria (MPB, Rock Nacional, Jazz, Pop, Internacional) e cada vendedor tem uma especialidade correspondente. Isso garante que um produto só pode ser vendido por um vendedor adequado, simplificando o modelo e mantendo integridade.

2. Trigger de validação
Motivo: Garantir que as vendas respeitem a regra de negócio.

Descrição: Antes de inserir uma venda, o trigger verifica se a especialidade do vendedor corresponde à categoria do produto. Se não corresponder, a venda é bloqueada. Isso evita inconsistências e mantém o banco confiável.

3. View de Top 3 vendas
Motivo: Facilitar relatórios e consultas rápidas.

Descrição: A view mostra os três produtos mais vendidos, permitindo análises de desempenho sem precisar escrever consultas complexas toda vez.
