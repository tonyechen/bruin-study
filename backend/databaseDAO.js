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
                ("SELECT id, email, name, major, username FROM Student WHERE id=' + id + ';--');

            res.json(student.rows[0]);
        } catch (err) {
            console.error(err.message);
        }
    }
	
	// Return the a profile 
	// input: username, password
	static async Authentication(req, res){
		try {
			const { username, password } = req.query;
			const id = await pool.query("SELECT id FROM Student WHERE username='" + username + "' AND password='" + password + "';--"); 
			res.json(courseTaking.rows[0]);
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
                ("INSERT INTO Student (id, email, name, major, username, password) VALUES(" + id + ",'" + emaiil + "','" + name + "','" + major + "','" + username + "','" + password + "');--");
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
                ("UPDATE Student SET email='" + email + "',name='" + name + "', Major='" + major +"'username='" + username +"',password='" + password +"' WHERE id=" + id +";--");
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
                ("SELECT course FROM Took WHERE id=" + id +";--");

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
                ("INSERT INTO Took(id, course) values (" + id + ",'" + course + "');--");
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
                .query 
                ("DELETE FROM Took WHERE id=" + id + "AND course='" + course +"';--");
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
                ("SELECT course FROM Taking WHERE id=" + id +";--");

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
                ("INSERT INTO Taking(id, course) values (" + id + ",'" + course + "');--");
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
                .query 
                ("DELETE FROM Taking WHERE id=" + id + "AND course='" + course +"';--");
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
                .query 
                ("SELECT id2 AS id FROM Failed WHERE id1=" + id +" UNION SELECT id1 AS id FROM FAILED WHERE id2=" + id +";--");

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
                .query 
                ("INSERT INTO Failed (id1,id2) values (" + id1 + "," + id2 +");--" );
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
                .query 
                ("SELECT Intro FROM Introduction WHERE id=" + id + ";--" );
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
                .query 
                ("INSERT INTO Introduction (id, Intro) values (" + id + ",'" + text + "');--" );
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
                .query 
                ("UPDATE Introduction SET Intro='" + text +"' WHERE id=" + id + ";--");
        } catch (err) {
            console.error(err.message);
        }
    }
}

module.exports = API;
