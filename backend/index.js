const express = require('express')
const cors = require('cors')
const mysql = require('mysql2')

const app = express()
const port = 3100

app.use(express.json())
app.use(cors())

// endpoint products
app.get('/api/products', (req, res) => {
    // Create the connection to database
    const connection = mysql.createConnection({
        host: 'localhost',
        user: 'alan',
        password: '1234',
        database: 'mplace_app',
    });

    // A simple SELECT query
    connection.query(
        'SELECT * FROM `products`',
        function (err, results, fields) {
            console.log(results); // results contains rows returned by server
            console.log(fields); // fields contains extra meta data about results, if available

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

app.listen(port, () => {
    console.log(`Example app listening on port ${port}`)
})