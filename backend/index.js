const express = require('express')
const cors = require('cors')
const mysql = require('mysql2')

const app = express()
const port = 3100

app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(cors())

// endpoint products index -> /api/products
// endpoint product search -> /api/products?search={termino}
app.get('/api/products', (req, res) => {
    // Create the connection to database
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'alan',
        password: '1234',
        database: 'mplace_app',
    });

    // get search params
    const search = req.query.search;
    console.log('el termino buscado es: ', search);

    // build query
    let query;

    if (search != undefined) {
        query = `SELECT * FROM products WHERE title like '%${search}%' or description like '%${search}%'`
    } else {
        query = 'SELECT * FROM `products`'
    }
    console.log('Query form products', query);

    // get products from database
    connection.query(
        query,
        function (err, results, fields) {
            //console.log(results); // results contains rows returned by server
            //console.log(fields); // fields contains extra meta data about results, if available

            res.send(results)
        }
    );
})

// endpoint product detail
app.get('/api/products/:id', (req, res) => {
    // Create the connection to database
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'alan',
        password: '1234',
        database: 'mplace_app',
    });

    // product id
    const productId = req.params.id;

    // simple query to get a product
    const query = 'SELECT * FROM `products` WHERE id = ?';
    connection.query(query, [productId], function (err, results, fields) {
        //console.log(results); // results contains rows returned by server
        //console.log(fields); // fields contains extra meta data about results, if available

        res.send(results)
    });
})

// endpoint login
app.post('/api/login', (req, res) => {
    // init
    let data = { auth: false, user: null };

    // Create the connection to database
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'alan',
        password: '1234',
        database: 'mplace_app',
    });

    // receive data (email and password)
    const email = req.body.email;
    const password = req.body.password;

    // validate data (query to database)
    // SELECT * FROM users where email = 'alan.tello@gmail.com' and password = '1234';
    const query = 'SELECT id, email FROM users WHERE email = ? AND password = ?';
    connection.query(query, [email, password], function (error, response) {
        if (response.length > 0) {
            data.auth = true;
            data.user = response[0];
        }

        // response
        res.send(data);
    });
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})