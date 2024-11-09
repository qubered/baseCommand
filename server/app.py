from flask import Flask, request, jsonify
import sqlite3
import uuid

app = Flask(__name__)

# Initialize the database
def init_db():
    conn = sqlite3.connect('computers.db')
    c = conn.cursor()
    c.execute('''CREATE TABLE IF NOT EXISTS computers
                 (id TEXT PRIMARY KEY, name TEXT)''')
    conn.commit()
    conn.close()

@app.route('/register', methods=['POST'])
def register_computer():
    data = request.json
    computer_name = data.get('name')
    computer_id = str(uuid.uuid4())
    
    conn = sqlite3.connect('computers.db')
    c = conn.cursor()
    c.execute("INSERT INTO computers (id, name) VALUES (?, ?)", (computer_id, computer_name))
    conn.commit()
    conn.close()
    
    return jsonify({'id': computer_id, 'name': computer_name})

if __name__ == '__main__':
    init_db()
    app.run(debug=True, port=8081)