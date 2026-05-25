from flask import Flask, render_template, request, jsonify
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

# config do banco
DB_CONFIG = {
    'host': '127.0.0.1',
    'port': 3306,
    'user': 'admin',
    'password': '123',
    'database': 'loja'
}

def get_connection():
    return mysql.connector.connect(**DB_CONFIG)

# função pra rodar query
def execute_query(query, params=None, fetchall=True, commit=False):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute(query, params or ())
        if commit:
            conn.commit()
            return cursor.rowcount
        if fetchall:
            return cursor.fetchall()
        return cursor.fetchone()
    except Error as e:
        print("Erro na query:", e)
        return []
    finally:
        cursor.close()
        conn.close()

# pagina inicial
@app.route('/')
def index():
    return render_template('index.html')

# criar banco
@app.route('/api/criar-banco', methods=['POST'])
def criar_banco():
    try:
        with open('loja.sql', 'r', encoding='utf-8') as f:
            sql_raw = f.read()

        conn = mysql.connector.connect(
            host=DB_CONFIG['host'],
            port=DB_CONFIG['port'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        conn.autocommit = True
        cursor = conn.cursor()

        import re
        sql_limpo = re.sub(r'DELIMITER\s*//\s*', '', sql_raw)
        sql_limpo = re.sub(r'DELIMITER\s*;\s*', '', sql_limpo)
        blocos = re.split(r'//', sql_limpo)

        for bloco in blocos:
            statements = bloco.split(';')
            for stmt in statements:
                stmt = stmt.strip()
                if not stmt or stmt.startswith('--') or stmt.startswith('/*'):
                    continue
                try:
                    cursor.execute(stmt)
                except Error as e:
                    print("Erro ignorado:", e)

        cursor.close()
        conn.close()
        return jsonify({'ok': True, 'msg': 'Banco criado!'})
    except Exception as e:
        return jsonify({'ok': False, 'msg': str(e)})

# destruir banco
@app.route('/api/destruir-banco', methods=['POST'])
def destruir_banco():
    try:
        conn = mysql.connector.connect(
            host=DB_CONFIG['host'],
            port=DB_CONFIG['port'],
            user=DB_CONFIG['user'],
            password=DB_CONFIG['password']
        )
        cursor = conn.cursor()
        cursor.execute("DROP DATABASE IF EXISTS loja")
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'ok': True, 'msg': 'Banco apagado!'})
    except Exception as e:
        return jsonify({'ok': False, 'msg': str(e)})

# clientes
@app.route('/api/clientes', methods=['GET'])
def listar_clientes():
    dados = execute_query("""
        SELECT c.*, 
               CASE WHEN ce.id_cliente IS NOT NULL THEN 1 ELSE 0 END AS especial,
               ce.cashback
        FROM cliente c
        LEFT JOIN cliente_especial ce ON c.id_cliente = ce.id_cliente
        ORDER BY c.id_cliente DESC
        LIMIT 100
    """)
    return jsonify(dados)

@app.route('/api/clientes', methods=['POST'])
def cadastrar_cliente():
    d = request.json
    try:
        execute_query(
            "INSERT INTO cliente (nome, idade, sexo, data_nascimento) VALUES (%s, %s, %s, %s)",
            (d['nome'], d['idade'], d['sexo'], d['data_nascimento']),
            commit=True, fetchall=False
        )
        return jsonify({'ok': True, 'msg': 'Cliente adicionado :)'})
    except Exception as e:
        print("Erro cliente:", e)
        return jsonify({'ok': False, 'msg': 'Erro no cadastro'})

# produtos
@app.route('/api/produtos', methods=['GET'])
def listar_produtos():
    dados = execute_query("""
        SELECT p.*, v.nome AS vendedor_nome
        FROM produto p
        LEFT JOIN vendedor v ON p.id_vendedor = v.id_vendedor
        ORDER BY p.id_produto ASC
    """)
    return jsonify(dados)

@app.route('/api/produtos', methods=['POST'])
def cadastrar_produto():
    d = request.json
    try:
        execute_query(
            """INSERT INTO produto (nome, descricao, categoria, quantidade_estoque, valor, observacoes, id_vendedor)
               VALUES (%s, %s, %s, %s, %s, %s, %s)""",
            (d['nome'], d['descricao'], d['categoria'], d['quantidade_estoque'],
             d['valor'], d.get('observacoes', ''), d.get('id_vendedor')),
            commit=True, fetchall=False
        )
        return jsonify({'ok': True, 'msg': 'Produto cadastrado!'})
    except Exception as e:
        print("Erro produto:", e)
        return jsonify({'ok': False, 'msg': 'Erro no cadastro'})

# vendas
@app.route('/api/vendas', methods=['GET'])
def listar_vendas():
    dados = execute_query("""
        SELECT v.id_venda, v.data_hora, v.endereco, v.valor_frete,
               c.nome AS cliente,
               p.nome AS produto,
               p.valor AS valor_produto,
               ve.nome AS vendedor,
               t.nome AS transportadora
        FROM venda v
        JOIN cliente c ON v.id_cliente = c.id_cliente
        JOIN produto p ON v.id_produto = p.id_produto
        JOIN vendedor ve ON v.id_vendedor = ve.id_vendedor
        JOIN transportadora t ON v.id_transportadora = t.id_transportadora
        ORDER BY v.data_hora DESC
        LIMIT 50
    """)
    return jsonify(dados)

@app.route('/api/vendas', methods=['POST'])
def realizar_venda():
    d = request.json
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.callproc('realizar_venda', [
            d['id_cliente'], d['id_produto'],
            d['id_transportadora'], d['id_vendedor'],
            d['endereco'], d['valor_frete']
        ])
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'ok': True, 'msg': 'Venda feita!'})
    except Error as e:
        print("Erro venda:", e)
        return jsonify({'ok': False, 'msg': 'Erro na venda'})

# views
@app.route('/api/views/top3', methods=['GET'])
def view_top3():
    dados = execute_query("SELECT * FROM visao_top3_vendas")
    return jsonify(dados)

@app.route('/api/views/cliente-vendas', methods=['GET'])
def view_cliente_vendas():
    dados = execute_query("SELECT * FROM visao_cliente_vendas ORDER BY total_compras DESC LIMIT 10")
    return jsonify(dados)

@app.route('/api/views/vendedor-vendas', methods=['GET'])
def view_vendedor_vendas():
    dados = execute_query("SELECT * FROM visao_vendedor_vendas ORDER BY total_vendido DESC")
    return jsonify(dados)

# procedures
@app.route('/api/sorteio', methods=['POST'])
def sorteio():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.callproc('sorteio')
        result = None
        for r in cursor.stored_results():
            result = r.fetchone()
        cursor.close()
        conn.close()
        if result:
            cliente = execute_query(
                "SELECT nome FROM cliente WHERE id_cliente = %s",
                (result['cliente'],), fetchall=False
            )
            return jsonify({
                'ok': True,
                'cliente_id': result['cliente'],
                'nome': cliente['nome'] if cliente else '?',
                'voucher': result['voucher']
            })
        return jsonify({'ok': False, 'msg': 'Nenhum cliente'})
    except Exception as e:
        print("Erro sorteio:", e)
        return jsonify({'ok': False, 'msg': 'Erro no sorteio'})

@app.route('/api/reajuste', methods=['POST'])
def reajuste():
    d = request.json
    try:
        conn = get_connection()
        cursor = conn.cursor()
        cursor.callproc('reajuste', [d['percentual'], d['categoria']])
        conn.commit()
        cursor.close()
        conn.close()
        return jsonify({'ok': True, 'msg': f"Reajuste de {d['percentual']}% aplicado na categoria {d['categoria']}"})
    except Exception as e:
        print("Erro reajuste:", e)
        return jsonify({'ok': False, 'msg': 'Erro no reajuste'})

@app.route('/api/estatisticas', methods=['GET'])
def estatisticas():
    try:
        conn = get_connection()
        cursor = conn.cursor(dictionary=True)
        cursor.callproc('estatisticas')
        ranking = []
        for r in cursor.stored_results():
         ranking = r.fetchall()
        cursor.close()
        conn.close()

        if not ranking:
            return jsonify({'ranking': [], 'mais_vendido': None, 'menos_vendido': None})

        mais  = ranking[0]
        menos = ranking[-1]

        def get_detalhes(nome_produto):
            vendedor = execute_query("""
                SELECT ve.nome AS vendedor
                FROM produto p
                LEFT JOIN vendedor ve ON p.id_vendedor = ve.id_vendedor
                WHERE p.nome = %s LIMIT 1
            """, (nome_produto,), fetchall=False)

            meses = execute_query("""
                SELECT DATE_FORMAT(v.data_hora, '%Y-%m') AS mes, COUNT(*) AS total
                FROM venda v
                JOIN produto p ON v.id_produto = p.id_produto
                WHERE p.nome = %s
                GROUP BY mes
                ORDER BY total DESC
            """, (nome_produto,))

            return {
                'vendedor':  vendedor['vendedor'] if vendedor else 'N/A',
                'mes_maior': meses[0]['mes']  if meses else 'N/A',
                'mes_menor': meses[-1]['mes'] if meses else 'N/A'
            }

        return jsonify({
            'ranking':       ranking,
            'mais_vendido':  {**mais,  **get_detalhes(mais['nome'])},
            'menos_vendido': {**menos, **get_detalhes(menos['nome'])}
        })
    except Exception as e:
        return jsonify({'ok': False, 'msg': str(e)})

# Auxiliares
@app.route('/api/vendedores', methods=['GET'])
def listar_vendedores():
    rows = execute_query("SELECT * FROM vendedor ORDER BY nome")
    return jsonify(rows)

@app.route('/api/transportadoras', methods=['GET'])
def listar_transportadoras():
    rows = execute_query("SELECT * FROM transportadora ORDER BY nome")
    return jsonify(rows)

if __name__ == '__main__':
    app.run(debug=True, port=5000)