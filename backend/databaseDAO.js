const express = require('express');

const pool = require('./db');

class API {
    // get student profile
    static async getStudentPofile(req, res) {
        try {
            const { uid } = req.params;
            const student = await pool.query(
                'SELECT * FROM students WHERE uid = ($1)',
                [uid]
            );
            delete student.rows[0].password;
            res.json(student.rows[0]);
        } catch (err) {
            console.error(err.message);
        }
    }
}

module.exports = API;
