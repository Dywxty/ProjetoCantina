from flask import Flask, render_template, request, redirect, session

app = Flask(__name__)
app.secret_key = "cantina_secret"

usuarios = {}
funcionarios = {"admin": "123"}

cardapio = {
    "Salgados": {
        "Coxinha": 6.00,
        "Enroladinho de Chocolate": 6.00,
        "Enroladinho de Presunto": 6.00,
        "Rissoles": 6.00,
        "Bauru": 6.00,
        "Enroladinho de Calabresa": 6.00,
        "Esfirra de Frango": 6.00,
        "Esfirra de Carne": 6.00,
        "Esfirra 3 Queijos": 6.00,
        "Pão de Queijo": 6.00,
        "Esfirra Aberta": 6.00
    },
    "Lanches": {
        "X-Tudo": 12.00,
        "X-Salada": 12.00,
        "X-Bacon": 12.00,
        "Lanche Natural": 12.00,
        "Sanduíche Simples": 12.00,
        "Sanduíche de Atum": 12.00
    },
    "Bebidas": {
        "Café": 2.50,
        "Suco Artificial": 3.50,
        "Suco Natural": 6.00,
        "Refri 300ml": 5.50,
        "Refri 2L": 15.00,
        "Energético": 12.00
    },
    "Almoço": {
        "Prato do Dia": 25.00
    }
}

@app.route("/")
def home():
    return render_template("index.html")

@app.route("/cadastro", methods=["GET", "POST"])
def cadastro():
    if request.method == "POST":
        nome = request.form["nome"]
        senha = request.form["senha"]
        usuarios[nome] = {
            "senha": senha,
            "gasto": 0,
            "divida": 0,
            "notificacoes": []
        }
        return redirect("/")
    return render_template("cadastro.html")

@app.route("/login", methods=["POST"])
def login():
    nome = request.form["nome"]
    senha = request.form["senha"]

    if nome in usuarios and usuarios[nome]["senha"] == senha:
        session["usuario"] = nome
        return redirect("/dashboard")
    return "Login inválido"

@app.route("/dashboard")
def dashboard():
    if "usuario" not in session:
        return redirect("/")
    user = usuarios[session["usuario"]]
    return render_template("dashboard_aluno.html", user=user, nome=session["usuario"])

@app.route("/cardapio")
def mostrar_cardapio():
    if "usuario" not in session:
        return redirect("/")
    return render_template("cardapio.html", cardapio=cardapio)

@app.route("/comprar/<item>/<float:preco>")
def comprar(item, preco):
    user = usuarios[session["usuario"]]
    user["gasto"] += preco
    return redirect("/dashboard")

@app.route("/login_funcionario", methods=["GET", "POST"])
def login_funcionario():
    if request.method == "POST":
        nome = request.form["nome"]
        senha = request.form["senha"]
        if nome in funcionarios and funcionarios[nome] == senha:
            session["funcionario"] = nome
            return redirect("/dashboard_funcionario")
    return render_template("login_funcionario.html")

@app.route("/dashboard_funcionario")
def dashboard_funcionario():
    if "funcionario" not in session:
        return redirect("/")
    return render_template("dashboard_funcionario.html", usuarios=usuarios)

if __name__ == "__main__":
    app.run(debug=True)