const express = require('express');
const app = express();
const pool = require('./db');
const routes = require('./database.router');

app.use(express.json());

app.use('/api/v1', routes)

app.get('/', (req, res) => {
    res.end('<h1>Hello World!</h1>');
});

app.listen(5000, () => {
    console.log('Listening on Port 5000...');
});
