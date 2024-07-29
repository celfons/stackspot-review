import sqlite3
from flask import Flask, request, redirect, url_for, render_template

app = Flask(__name__)

# Configuração do banco de dados
DATABASE = 'users.db'

def get_db_connection():
    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

# Rota para listar todos os usuários
@app.route('/')
def index():
    conn = get_db_connection()
    users = conn.execute('SELECT * FROM users').fetchall()
    conn.close()
    return render_template('index.html', users=users)

# Rota para criar um novo usuário
@app.route('/create', methods=('GET', 'POST'))
def create():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        conn = get_db_connection()
        conn.execute('INSERT INTO users (username, password) VALUES (?, ?)', (username, password))
        conn.commit()
        conn.close()
        return redirect(url_for('index'))

    return render_template('create.html')

# Rota para atualizar um usuário
@app.route('/<int:id>/update', methods=('GET', 'POST'))
def update(id):
    conn = get_db_connection()
    user = conn.execute('SELECT * FROM users WHERE id = ?', (id,)).fetchone()

    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        conn.execute('UPDATE users SET username = ?, password = ? WHERE id = ?', (username, password, id))
        conn.commit()
        conn.close()
        return redirect(url_for('index'))

    conn.close()
    return render_template('update.html', user=user)

# Rota para deletar um usuário
@app.route('/<int:id>/delete', methods=('POST',))
def delete(id):
    conn = get_db_connection()
    conn.execute('DELETE FROM users WHERE id = ?', (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))

if __name__ == '__main__':
    app.run(debug=True)
