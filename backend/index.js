const express = require('express')
const cors = require('cors')
const mysql = require('mysql2')
const bcrypt = require('bcryptjs')
const config = require('./config')

const app = express()
const port = 3100

app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.use(cors())

// endpoint products index -> /api/products
// endpoint product search -> /api/products?search={termino}
app.get('/api/products', (req, res) => {
    // Create the connection to database
    const connection = mysql.createConnection(config.db);

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
    const connection = mysql.createConnection(config.db);

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
    const connection = mysql.createConnection(config.db);

    // receive data (email and password)
    const email = req.body.email;
    const password = req.body.password;

    // validate data (query to database)
    const query = 'SELECT id, email, password FROM users WHERE email = ?';
    connection.query(query, [email], function (error, response) {
        if (!error && response.length > 0) {
            const isValidPassword = bcrypt.compareSync(password, response[0].password);
            if (isValidPassword) {
                data.auth = true;
                data.user = { id: response[0].id, email: response[0].email };
            }
        }

        if (error) {
            console.log('login error', error)
        }

        // response
        res.send(data);
    });
})

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})
