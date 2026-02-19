let total = 0;

function scrollCardapio() {
    document.getElementById("cardapio").scrollIntoView({
        behavior: "smooth"
    });
}

function simularCompra() {
    total += 12; // simulação
    document.getElementById("total").innerText =
        "Total gasto hoje: R$" + total.toFixed(2);
}
