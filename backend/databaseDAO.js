const express = require('express');
const jwt = require('jsonwebtoken');
const pool = require('./db');

const SECRET = '26deaa6bef2ed0fe2116bf10b766fc4e15a970e72413185e48b7a2d61f2f07f5e70b2f1f69f6867594743ee7f2d044990b014c8e0f552770c5bbe56e65ee3443';

class API {
    // get student profile
    // input: id
    static async getStudent(req, res) {
        try {
            const { id } = req.query;

            // Fetch all except password from student table
            // input: id
            const student = await pool.query(
                'SELECT id, email, name, major, username FROM Student WHERE id= $1;--',
                [id]
            );

            // make sure the id exists
            if (student.rows[0]) {
                res.json(student.rows[0]);
            } else {
                res.json({
                    success: false,
                    error: `User with id = ${id} does not exists.`,
                });
            }
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Return the id if the password and username are both inside the table
    // input: username, password
    static async Authentication(req, res) {
        try {
            const { username, password } = req.query;
            const ids = await pool.query(
                'SELECT id FROM Student WHERE username= $1 AND password = $2;--',
                [username, password]
            );

            var id = ids.rows[0].id;
            
            if(id) {
                const token = jwt.sign({id}, SECRET);
                res.json({ success: true, token: `Bearer ${token}` });
            } else {
                res.json({success:false});
            }
            } catch (err) {
                res.json({success:false});
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
            await pool.query(
                'INSERT INTO Student (id, email, name, major, username, password) VALUES($1, $2, $3, $4, $5, $6);--',
                [id, email, name, major, username, password]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // update Student Profile;
    // input: id, email, name, major, username
    static async updateStudent(req, res) {
        try {
            const { id, email, name, major, username } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];
            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });

            if (id !== data.id) return res.sendStatus(401);
            // update existing student:
            // input: id, email, name, major, username, password
            await pool.query(
                'UPDATE Student SET email= $1 ,name= $2, Major= $3, username= $4 WHERE id= $5;--',
                [email, name, major, username, id]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // update student password, separate from profile information
    static async updatePassword(req, res) {
        try {
            const { id, password } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];
            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);

            // update password of a student
            await pool.query(
                'UPDATE Student SET password= $2 WHERE id= $1;--',
                [id, password]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // retrieve all courses taken by student;
    // input: id
    static async getCourseTook(req, res) {
        try {
            const { id } = req.query;

            // fetch all courses taken by a student
            // input: id
            const courseTook = await pool.query(
                'SELECT course FROM Took WHERE id= $1;--',
                [id]
            );

            if (courseTook) {
                // organize courses into one list
                const courses = courseTook.rows.map((course) => {
                    return course.course;
                });
                res.json(courses);
            } else {
                res.json({
                    success: false,
                    error: `User with id = ${id} does not exists.`,
                });
            }
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // add a course took by a student;
    // input: id, course
    static async addCourseTook(req, res) {
        try {
            const { id, course } = req.query;

            // add a course taken by a student
            // input: id, course
            await pool.query(
                'INSERT INTO Took(id, course) values ( $1, $2);--',
                [id, course]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({
                success: false,
                error: err.message,
            });
        }
    }

    // delete a Course Took by a student;
    // input: id, course
    static async deleteCourseTook(req, res) {
        try {
            const { id, course } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];

            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);

            // delete a course taken by a student
            // input: id, course
            await pool.query(
                'DELETE FROM Took WHERE id= $1 AND course= $2; --',
                [id, course]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // retrieve all courses student is taking;
    // input: id
    static async getCourseTaking(req, res) {
        try {
            const { id } = req.query;

            // fetch all courses a student is taking
            // input: id
            const courseTaking = await pool.query(
                'SELECT course FROM Taking WHERE id= $1; --',
                [id]
            );

            if (courseTaking) {
                // organize courses into one list
                const courses = courseTaking.rows.map((course) => {
                    return course.course;
                });
                res.json(courses);
            } else {
                res.json({
                    success: false,
                    error: `User with id = ${id} does not exists.`,
                });
            }
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // add a course the student is taking;
    // input: id, course
    static async addCourseTaking(req, res) {
        try {
            const { id, course } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];


            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);


            // Add a course the student is taking
            // input: id, course
            await pool.query(
                'INSERT INTO Taking(id, course) values ($1, $2);--',
                [id, course]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({
                success: false,
                error: err.message,
            });
        }
    }

    // delete a Course the student is taking;
    // input: id, course
    static async deleteCourseTaking(req, res) {
        try {
            const { id, course } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];

            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);


            // delete a course the student is taking
            // input: id, course
            await pool.query(
                'DELETE FROM Taking WHERE id= $1 AND course= $2;--',
                [id, course]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // fetch all failed matches of the student
    // input: id
    static async getFailedMatch(req, res) {
        try {
            const { id } = req.query;

            // get all failed matches of the student
            // input: id
            const failed = await pool.query(
                'SELECT id2 AS id FROM Failed WHERE id1= $1 UNION SELECT id1 AS id FROM FAILED WHERE id2= $1; --',
                [id]
            );

            if (failed.rows[0]) {
                const failedMatches = failed.rows.map((fail) => {
                    return fail.id;
                });
                res.json(failedMatches);
            } else {
                res.json({
                    success: false,
                    error: 'There is no failed matches, or the ID does not exist',
                });
            }
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // insert a failed match of a student
    // input: id1, id2
    static async addFailedMatch(req, res) {
        try {
            const { id1, id2 } = req.query;

            // Insert a failed match of the student(id1)
            // input: id1, id2
            await pool.query(
                'INSERT INTO Failed (id1,id2) values ( $1, $2);--',
                [id1, id2]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // get the intro of a student
    // input: id
    static async getIntroduction(req, res) {
        try {
            const { id } = req.query;

            // get the introudciont of the student
            // input: id
            const intro = await pool.query(
                'SELECT Intro FROM Introduction WHERE id= $1;--',
                [id]
            );

            if (intro.rows[0]) {
                res.json(intro.rows[0].intro);
            } else {
                res.json({ success: false, error: 'ID does not exist' });
            }
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Add the intro of a student
    // input: id, text
    static async addIntroduction(req, res) {
        try {
            const { id, text } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];

            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);


            // add the introduction of the studentauth
            // input: id, text
            await pool.query(
                'INSERT INTO Introduction (id, Intro) values ($1, $2);--',
                [id, text]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // update the intro of a student
    // input: id, text
    static async updateIntroduction(req, res) {
        try {
            const { id, text } = req.query;

            const authHeader = req.headers["authorization"];
            
            const token = authHeader && authHeader.split(" ")[1];

            var data;
            if (token == null) return res.sendStatus(401);

            jwt.verify(token, SECRET, (err, decoded) => {
                if(err) return res.sendStatus(403);
                data = decoded;
            });
            if (id !== data.id) return res.sendStatus(401);

            // update the intro of the student
            // input: id, text
            await pool.query(
                'UPDATE Introduction SET Intro= $1 WHERE id= $2;--',
                [text, id]
            );
            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Add a one-sided matches from id1 to id2 (id1 want to match with id2)
    // input: id1, id2
    static async addPotentialMatch(req, res) {
        try {
            const { id1, id2 } = req.query;
            await pool.query(
                'INSERT INTO potentialMatches (id1,id2) values ($1, $2);--',
                [id1, id2]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Return a list of id that the user wants to match with
    // input: id1, id2
    static async getPotentialMatch(req, res) {
        try {
            const { id } = req.query;
            const response = await pool.query(
                'SELECT id2 FROM potentialMatches WHERE id1= $1;--',
                [id]
            );
            const potential = response.rows.map((item) => {
                return item.id2;
            });
            res.json(potential);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Delete the single Matches between id1 and id2 (due to eiter rejection or a successful 2-sided match)
    // input: id1, id2
    static async deletePotentialMatch(req, res) {
        try {
            const { id1, id2 } = req.query;

            await pool.query(
                'DELETE FROM potentialMatches WHERE ((id1= $1) AND (id2= $2)) OR ((id1= $2) AND (id2= $1));--',
                [id1, id2]
            );
            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Print out the potential matches for a person with id based on the classes that 2 people TOOK,
    // we have excluded people from Successful Matches as well as Failed
    static async getPotentialMatchFromTook(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool.query(
                'SELECT id, count FROM (SELECT b.id AS ID, COUNT(b.course) FROM Took AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) GROUP BY b.id) AS C LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS D ON ((D.id1 = $1) AND (C.id = D.id2)) OR ((D.id2 = $1) AND (C.id = D.id1)) WHERE D.id1 is NULL ORDER BY count DESC; --',
                [id]
            );

            res.json(potentialMatch.rows);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Print out the potential matches for a person with id based on the classes that 2 people are TAKING, we have excluded people from Successful Matches as well as Failed
    static async getPotentialMatchFromTaking(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool.query(
                'SELECT id, count FROM (SELECT b.id AS ID, COUNT(b.course) FROM Taking AS A INNER JOIN Taking AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) GROUP BY b.id) AS C LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS D ON ((D.id1 = $1) AND (C.id = D.id2)) OR ((D.id2 = $1) AND (C.id = D.id1)) WHERE D.id1 is NULL ORDER BY count DESC; --',
                [id]
            );

            res.json(potentialMatch.rows);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Print out the potential matches for a person with id based on the classes that a person TOOK that the other is TAKING,
    // we have excluded people from successful Matches as well as failed
    static async getPotentialMatchFromTookTaking(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool.query(
                'SELECT id, count FROM (SELECT id, COUNT(C.id) FROM (SELECT B.id AS ID FROM Taking AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) UNION ALL SELECT A.id AS ID FROM Taking AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id != $1) AND (B.id = $1)) AS C GROUP BY c.id) AS D LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS E ON ((E.id1 = $1) AND (D.id = E.id2)) OR ((E.id2 = $1) AND (D.id = E.id1)) WHERE E.id1 IS NULL ORDER BY count DESC;--',
                [id]
            );

            res.json(potentialMatch.rows);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Add a successful matches of id1 and id2 (should it be [id1, id2] or [id2, id1]? You decide!)
    // input: id1, id2
    static async addSuccessfulMatch(req, res) {
        try {
            const { id1, id2 } = req.query;
            await pool.query(
                'INSERT INTO successfulMatches (id1, id2) VALUES ($1, $2);--',
                [id1, id2]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Get all the succesful matches of id
    // input: id1, id2
    static async getSuccessfulMatch(req, res) {
        try {
            const { id } = req.query;
            let successfulMatch = await pool.query(
                'SELECT id2 AS id FROM successfulMatches WHERE id1= $1 UNION SELECT id1 AS id FROM successfulMatches WHERE id2= $1; --',
                [id]
            );

            successfulMatch = successfulMatch.rows.map((item) => {
                return item.id;
            });
            res.json(successfulMatch);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }
}

module.exports = API;
