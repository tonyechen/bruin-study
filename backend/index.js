const express = require('express');
const app = express();
const pool = require('./db');

app.use(express.json());

app.get('/user/:uid', async (req, res) => {
    try {
        const {uid} = req.params;
        console.log(uid)
        const student = await pool.query("SELECT * FROM students WHERE uid = ($1)", [uid]);
        res.json(student);
    } catch (err) {
        console.error(err.message);
    }
});

app.get('/', (req, res) => {
    res.end('<h1>Hello World!</h1>');
});

app.listen(5000, () => {
    console.log('Listening on Port 5000...');
});
