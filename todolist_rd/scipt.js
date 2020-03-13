let btnAddTarefa = document.querySelector('#adicionar-tarefa')
let tarefas = document.querySelector('#tarefas')
let inputTarefa = document.getElementById('tarefa-digitada')
let listaTarefas = localStorage.getItem('listaTarefas')?JSON.parse(localStorage.getItem
('listaTarefas')):[]

const salvarLocalStorage = tarefas => {
    let tarefasEmJson = JSON.stringify(tarefas)
    localStorage.setItem("listaTarefas",tarefasEmJson)
    console.log("Lista de tarefas salva com sucesso!")
}

const mostrarNaTela = arrayTarefas =>{
    arrayTarefas.forEach(textoTarefa => {
        let tarefaNova = `<div class="col-md-4">
        <div class="card-tarefa" class="row">
        <div class="texto-tarefa">
            ${textoTarefa}
        </div>
        <div class="botao-tarefa">
            <img src="img/check.png" width="32" alt="Botão para finalizar tarefa" title="Botão para finalizar tarefa">
        </div>
        </div>
        </div>`
        
        tarefas.insertAdjacentHTML('beforeend',tarefaNova) 
        let objTarefaNova = tarefas.lastElementChild
        let btnCheckTarefaNova = objTarefaNova.lastElementChild.lastElementChild
        btnCheckTarefaNova.onclick =(event)=>{

            tarefas.removeChild(event.target.parentNode.parentNode.parentNode)
            listaTarefas = listaTarefas.filter(valor => valor != textoTarefa )

            salvarLocalStorage(listaTarefas)
        }
    })
}

mostrarNaTela(listaTarefas)
const criarTarefaComEnter = (event)=>{

    if(event.keyCode == 13 || event.type == 'click'){
        let valorDigitado = inputTarefa.value
            if(valorDigitado == ""){
                alert('Você deve digitar uma tarefa!');
                return
            }
        listaTarefas.push(valorDigitado)
        salvarLocalStorage(listaTarefas)
        inputTarefa.value = ""
        let tarefaNova = `<div class="col-md-4">
        <div class="card-tarefa" class="row">
        <div class="texto-tarefa">
            ${valorDigitado}
        </div>
        <div class="botao-tarefa">
            <img src="img/check.png" width="32" alt="Botão para finalizar tarefa" title="Botão para finalizar tarefa">
        </div>
        </div>
        </div>`
        tarefas.insertAdjacentHTML('beforeend',tarefaNova) 

        let objTarefaNova = tarefas.lastElementChild
        let btnCheckTarefaNova = objTarefaNova.lastElementChild.lastElementChild
        btnCheckTarefaNova.onclick =(event)=>{
        
        tarefas.removeChild(event.target.parentNode.parentNode.parentNode)
        listaTarefas = listaTarefas.filter(valor => valor != valorDigitado )
        
        salvarLocalStorage(listaTarefas)
        }
    }
}

inputTarefa.addEventListener('keypress', criarTarefaComEnter)
btnAddTarefa.addEventListener('click', criarTarefaComEnter )



