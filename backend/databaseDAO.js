const express = require('express');

const pool = require('./db');

class API {
    // get student profile
    // input: id
    static async getPofile(req, res) {
        try {
            const { id } = req.params;
            
            // Fetch all except password from student table
            // input: id
            const student = await pool.query(
                // ADD QUERY HERE, DELETE THIS COMMENT
                
            ).rows[0];

            // Fetch all course taking by the student
            // input: id
            student.coursetaking = await pool.query(
                // ADD QUERY HERE, DELETE THIS COMMENT
            ).rows[0];

            // Fetch all course taken by the student
            // input: id
            student.coursetaken = await pool.query (
                // ADD QUERY HERE
            ).rows[0];

            res.json(student);
        } catch (err) {
            console.error(err.message);
        }
    }

    // create student profile;
    // input: id, email, Name, major, username, password, introduction
    static async createProfile(req, res) {
        try {
            const {} = req.query;

            // insert into Student
            // input: id, email, Name, major, username, password
            await pool.query(
                // ADD QUERY HERE, DELETE THIS COMMENT
            );

            // insert into intro
            // input: intro
           await pool.query(
                // ADD QUERY HERE, DELETE THIS COMMENT
            );
        } catch (err) {
            console.error(err.message);
        }
    }

    //updateProfile;
    static async updateProfile(req, res) {
        try {
            const {} = req.query;

        } catch (err) {
            console.error(err.message);
        }
    }
    //getCourseTook;
    //addCourseTook;
    //updateCourseTook;
    //getCourseTaking;
    //addCourseTaking;
    //updateCourseTaking;
    //addFailedMatches;
    //getFailedMatches;
}

module.exports = API;
