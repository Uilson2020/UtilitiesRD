var displayBuffer = "";
var numero = "";
var termos = [undefined, undefined, undefined];
var resultado = undefined;

function pressionarNumero(num){
    numero = numero.concat(num.innerHTML);
    mostrarDisplay(num.innerHTML);
}
function pressionarOperador(op){
    if(termos[1]==undefined){
    termos[0] = numero;
    termos[1] = op.innerHTML;
    mostrarDisplay(op.innerHTML);
    numero="";
    }

}
function pressionarIgual(){
    if(termos[0] != undefined && termos[1] != undefined && numero != ""){
        termos[2] = numero;
        var keepresultado;
        switch(termos[1]){
            case '+':
                resultado = Number(termos[0])+Number(termos[2]);
                break;
            case '-':
                resultado = Number(termos[0])-Number(termos[2]);
                break;
            case '*':
                resultado = Number(termos[0])*Number(termos[2]);
                break;
            case '/':
                resultado = Number(termos[0])/Number(termos[2]);
                break;
        }
        keepresultado = resultado;
        limparDisplay();
        mostrarDisplay(resultado);
        limparMemoria();
        numero = keepresultado.toString();
    }
}

function limparMemoria(){
    numero = "";
    termos = [undefined, undefined, undefined];
    resultado = undefined;
}
function limparDisplay(){
    displayBuffer = "";
    var tela = document.getElementById('display');
    tela.value = displayBuffer;
}
function limparTudo(){
    limparDisplay();
    limparMemoria();
}
function mostrarDisplay(conteudo){
    displayBuffer = displayBuffer.concat(conteudo);
    var tela = document.getElementById('display');
    tela.value = displayBuffer;
}
