import sqlite3
from flask import Flask, request, render_template_string

app = Flask(__name__)

# SQL Injection Vulnerability
@app.route('/login')
def login():
    
    conn = sqlite3.connect('users.db')
    cursor = conn.cursor()

    # Vulnerable query (susceptible to SQL Injection)
    query = "SELECT * FROM users WHERE username='123' AND password='123"
    cursor.execute(query)
    user = cursor.fetchone()

    conn.close()

    if user:
        return "Login successful!"
    else:
        return "Invalid credentials."

# Cross-Site Scripting (XSS) Vulnerability
@app.route('/search')
def search():
    query = request.args.get('query')

    # Vulnerable code (XSS)
    return render_template_string('<h1>Search results for: {{ query }}</h1>', query=query)

if __name__ == '__main__':
    app.run(debug=True)
