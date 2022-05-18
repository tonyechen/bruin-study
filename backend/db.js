const { Client } = require('pg');

const Pool = require('pg').Pool;

/*
DATABASE CREDENTIALs:

Host
ec2-54-172-175-251.compute-1.amazonaws.com
Database
d3dr6tbedof8qh
User
hiytaqdtykibbe
Port
5432
Password
394d3066ca88a97c0d8385410596dd65d38dd06bffb5682166e215b63e1b769d
URI
postgres://hiytaqdtykibbe:394d3066ca88a97c0d8385410596dd65d38dd06bffb5682166e215b63e1b769d@ec2-54-172-175-251.compute-1.amazonaws.com:5432/d3dr6tbedof8qh
Heroku CLI
heroku pg:psql postgresql-corrugated-63642 --app bruin-study
*/

/* code for local database

const pool = new Pool({
    user: 'postgres',
    password: 'Iloveramen247',
    database: 'bruinstudy',
    host: 'localhost',
    port: 5432,
});
*/

const pool = new Client({
    connectionString:
        'postgres://hiytaqdtykibbe:394d3066ca88a97c0d8385410596dd65d38dd06bffb5682166e215b63e1b769d@ec2-54-172-175-251.compute-1.amazonaws.com:5432/d3dr6tbedof8qh',
    ssl: {
        rejectUnauthorized: false,
    },
});

pool.connect();

module.exports = pool;
