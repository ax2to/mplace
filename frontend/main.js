// obtener datos del json file
let data = []



async function getItems() {
    console.log("iniciando la llamada de items")
    // obtener datos del API
    data = await getApiData();

    // agregar datos al html
    let cardsEl = document.getElementById('cards')

    data.forEach((element) => {
        console.log(element.title)

        // add element
        const newDiv = document.createElement("div");
        newDiv.className = 'card'
        newDiv.innerHTML = `
     <div class="image">
             <img src="${element.image}" alt="image" />
     </div>
     <article>
         <div class="title">${element.title}</div>
         <div class="price">${element.price} USD</div>
     </article>
 `;

        cardsEl.appendChild(newDiv)
    })
}

async function getApiData() {
    const loaderEl = document.getElementById('loader')

    try {
        loaderEl.style.display = 'block'

        const response = await fetch("http://localhost:3100/api/products");
        const products = await response.json();

        return products;
    } catch (error) {
        console.log("error cargando los producstos", error)

        const errorEl = document.getElementById('error')
        errorEl.style.display = 'block'
    } finally {
        loaderEl.style.display = 'none'
    }

    return [];
}
