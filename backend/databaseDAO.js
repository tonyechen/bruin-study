const express = require('express');

const pool = require('./db');

class API {
    // get student profile
    // input: id
    static async getStudent(req, res) {
        try {
            const { id } = req.params;

            // Fetch all except password from student table
            // input: id
            const student = await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();

            res.json(student.rows[0]);
        } catch (err) {
            console.error(err.message);
        }
    }

    // create student profile;
    // input: id, email, name, major, username, password
    static async createStudent(req, res) {
        try {
            const { id, email, name, major, username, password } = req.query;

            // insert into Student
            // input: id, email, name, major, username, password
            await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // update Student Profile;
    // input: id, email, name, major, username, password
    static async updateStudent(req, res) {
        try {
            const { id, email, name, major, username, password } = req.query;

            // update existing student:
            // input: id, email, name, major, username, password
            await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // retrieve all courses taken by student;
    // input: id
    static async getCourseTook(req, res) {
        try {
            const { id } = req.params;

            // fetch all courses taken by a student
            // input: id
            const courseTook = await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();

            res.json(courseTook.rows[0]);
        } catch (err) {
            console.error(err.message);
        }
    }

    // add a course took by a student;
    // input: id, course
    static async addCourseTook(req, res) {
        try {
            const { id, course } = req.query;

            // add a course taken by a student
            // input: id, course
            await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // delete a Course Took by a student;
    // input: id, course
    static async deleteCourseTook(req, res) {
        try {
            const { id, course } = req.query;

            // delete a course taken by a student
            // input: id, course
            await pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // retrieve all courses student is taking;
    // input: id
    static async getCourseTaking(req, res) {
        try {
            const { id } = req.params;

            // fetch all courses a student is taking
            // input: id
            const courseTaking = await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();

            res.json(courseTaking.rows[0]);
        } catch (err) {
            console.error(err.message);
        }
    }

    // add a course the student is taking;
    // input: id, course
    static async addCourseTaking(req, res) {
        try {
            const { id, course } = req.query;

            // Add a course the student is taking
            // input: id, course
            await pool
                .query
                // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // delete a Course the student is taking;
    // input: id, course
    static async deleteCourseTaking(req, res) {
        try {
            const { id, course } = req.query;

            // delete a course the student is taking
            // input: id, course
            await pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // fetch all failed matches of the student
    // input: id
    static async getFailedMatch(req, res) {
        try {
            const { id } = req.params;

            // get all failed matches of the student
            // input: id
            const failed = await pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();

            res.json(failed)
        } catch (err) {
            console.error(err.message);
        }
    }

    // insert a failed match of a student
    // input: id1, id2
    static async addFailedMatch(req, res) {
        try {
            const { id1, id2 } = req.query;

            // Insert a failed match of the student(id1)
            // input: id1, id2
            await pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // get the intro of a student
    // input: id
    static async getIntroduction(req, res) {
        try {
            const { id } = req.params;

            // get the introudciont of the student
            // input: id
            const intro = pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();

            res.json(intro)
        } catch (err) {
            console.error(err.message);
        }
    }

    // update the intro of a student
    // input: id, text
    static async addIntroduction(req, res) {
        try {
            const { id, text } = req.query;

            // add the introduction of the student
            // input: id, text
            const intro = pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }

    // update the intro of a student
    // input: id, text
    static async updateIntroduction(req, res) {
        try {
            const { id, text } = req.params;

            // update the intro of the student
            // input: id, text
            const intro = pool
                .query // ADD QUERY INSIDE PARENTHESIS, DELETE THIS COMMENT
                ();
        } catch (err) {
            console.error(err.message);
        }
    }
}

module.exports = API;
