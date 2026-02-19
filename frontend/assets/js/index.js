document.getElementById("btnLogin").addEventListener("click", function() {

    const email = document.querySelector("input[type='email']").value;
    const senha = document.getElementById("senha").value;

    if(email === "" || senha === ""){
        alert("Preencha todos os campos!");
        return;
    }

    alert("Login realizado com sucesso!");
});
