const Pool = require('pg').Pool;

const pool = new Pool({
    user: 'postgres',
    password: 'Iloveramen247',
    database: 'bruinstudy',
    host: 'localhost',
    port: 5432,
});

module.exports = pool;