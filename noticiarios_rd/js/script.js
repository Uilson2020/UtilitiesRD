const API_KEY = "3f7b8564d51a4e58be5554609c8b2721";

let config = {
    method: "GET"
}
let noticia2=document.querySelector('#news')
let boardNoticias = document.querySelector('#boardNoticias')
let btnCarregar = document.querySelector('#botao')

// let resposta = fetch('https://newsapi.org/v2/top-headlines?country=br&apiKey='+ API_KEY, config)
// .then((resposta)=>{
//     return resposta.json()
// })
// .then((json)=>{
//     mostrarNaTela(json.articles)
// })

function mostrarNaTela(listaNoticias){
    listaNoticias.forEach(listaNoticias=>{
    let noticia = `
    <div class="col-md-4">
        <div class="card">
            <img src="${listaNoticias.urlToImage}" class="card-img" alt="imagem da noticia">
                <h3.>${listaNoticias.title}</h3.>
            <div class="card-body text-justify">
            ${listaNoticias.content}
                Guia do Mundial de Clubes do FIFA 20: brasileiros em times separados e feras em ação
                Guia do Mundial de Clubes do FIFA 20: brasileiros em times separados e feras em ação
                Guia do Mundial de Clubes do FIFA 20: brasileiros em times separados e feras em ação
            </div>
            <button class="btn btn-primary">Ver noticia completa</button>
        </div>
    </div>`

        noticia2.insertAdjacentHTML('beforeend',noticia)  
    });
}

btnCarregar.onclick = ()=>{
    let resposta = fetch('https://newsapi.org/v2/top-headlines?country=br&apiKey='+ API_KEY, config)
    .then((resposta)=>{
        return resposta.json()
    })
    .then((json)=>{
        mostrarNaTela(json.articles)
    })

}