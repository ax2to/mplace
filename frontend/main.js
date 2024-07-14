// obtener datos del json file
let data = []

async function getItems(search = null) {
    console.log("iniciando la llamada de items")
    console.log("el valor de search es: ", search);

    // obtener datos del API
    data = await getApiData(search);

    // agregar datos al html
    let cardsEl = document.getElementById('cards')
    cardsEl.innerHTML = '';

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

async function getApiData(search = null) {
    const loaderEl = document.getElementById('loader')

    try {
        loaderEl.style.display = 'block'

        let endpoint;
        if (search === null) {
            endpoint = 'http://localhost:3100/api/products';
        } else {
            endpoint = `http://localhost:3100/api/products?search=${search}`;
        }

        const response = await fetch(endpoint);
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

async function getItemDetail(productId) {
    console.log("obtener informacion de producto: ", productId)

    let data = {}

    data = await getApiItemData()
    console.log("data es: ", data)

    const mainEl = document.getElementById('main')
    const titleEl = document.getElementById('title')
    const priceEl = document.getElementById('price')

    titleEl.innerHTML = data[0].title;
    priceEl.innerHTML = data[0].price;

    mainEl.style.display = 'block'
}

async function getApiItemData() {
    console.log('api para obtener informacion de producto')

    const loaderEl = document.getElementById('loader')

    try {
        loaderEl.style.display = 'block'


        const endpoint = "http://localhost:3100/api/products/" + productId;

        const response = await fetch(endpoint);
        const product = await response.json();

        return product;
    } catch (error) {
        console.log("error cargando el producsto", error)

        const errorEl = document.getElementById('error')
        errorEl.style.display = 'block'
    } finally {
        loaderEl.style.display = 'none'
    }
}

function addSearchBehavior() {
    // get search icon element
    const searchIconEl = document.getElementById('searchIcon');

    // add event listener (clik)
    searchIconEl.addEventListener('click', function () {
        // hide logo
        const logoEl = document.getElementById('logo');
        logoEl.style.display = 'none';

        // hide search icon
        searchIconEl.style.display = 'none';

        // display search
        const searchFormEl = document.getElementById('searchForm');
        searchFormEl.style.display = 'block';
    });

    // add event listener (search)
    const searchInputEl = document.getElementById('searchInput');
    searchInputEl.addEventListener('keyup', function (event) {
        if (event.keyCode === 13) {
            getItems(searchInputEl.value)
        }
    })
}

async function addLoginEvents() {
    console.log('addLoginEvents');

    // get form reference
    const formEl = document.getElementById('loginForm');

    // update submit event
    formEl.addEventListener('submit', async function (event) {
        // avoid default behavior
        event.preventDefault();

        // get form data
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;

        // call api
        try {
            const endpoint = 'http://localhost:3100/api/login';
            const response = await fetch(endpoint, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `email=${email}&password=${password}`
            });

            let data = await response.json();

            // redirect
            if (data.auth == true) {
                window.location.replace("/frontend/admin/index.html");
            }

            // display fail
            if (data.auth == false) {
                const errorEl = document.querySelector('.login form .error');
                errorEl.style.display = 'block'
            }

        } catch (error) {
            console.log(error)
        }
    });
}