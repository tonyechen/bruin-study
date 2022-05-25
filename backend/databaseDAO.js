const express = require('express');

const pool = require('./db');

class API {
    // get student profile
    // input: id
    static async getStudent(req, res) {
        try {
            const { id } = req.query;

            // Fetch all except password from student table
            // input: id
            const student = await pool.query(
                'SELECT id, email, name, major, username FROM Student WHERE id= $1;--', [id]
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

    // Return the a profile
    // input: username, password
    static async Authentication(req, res) {
        try {
            const { username, password } = req.query;
            const id = await pool.query(
                "SELECT id FROM Student WHERE username= $1 AND password = $2;--", [username, password]
            );
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
            await pool.query(
                'INSERT INTO Student (id, email, name, major, username, password) VALUES($1, $2, $3, $4, $5, $6);--', [id, email, name, major, username, password] 
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // update Student Profile;
    // input: id, email, name, major, username, password
    static async updateStudent(req, res) {
        try {
            const { id, email, name, major, username, password } = req.query;

            // update existing student:
            // input: id, email, name, major, username, password
            await pool.query(
				"UPDATE Student SET email= $1 ,name= $2, Major= $3, username= $4, password= $5 WHERE id= $6;--",[email, name, major, username, password, id]
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
                'SELECT course FROM Took WHERE id= $1;--', [id]
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
                'INSERT INTO Took(id, course) values ( $1, $2);--', [id, course]
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

            // delete a course taken by a student
            // input: id, course
            await pool.query(
                'DELETE FROM Took WHERE id= $1 AND course= $2; --', [id, course]
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
                'SELECT course FROM Taking WHERE id= $1; --', [id]
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

            // Add a course the student is taking
            // input: id, course
            await pool.query(
                'INSERT INTO Taking(id, course) values ($1, $2);--', [id, course]
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

            // delete a course the student is taking
            // input: id, course
            await pool.query(
                'DELETE FROM Taking WHERE id= $1 AND course= $2;--', [id, course]
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
                'SELECT id2 AS id FROM Failed WHERE id1= $1 UNION SELECT id1 AS id FROM FAILED WHERE id2= $1; --', [id] 
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
                'INSERT INTO Failed (id1,id2) values ( $1, $2);--', [id1, id2]
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
                'SELECT Intro FROM Introduction WHERE id= $1;--', [id]
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

            // add the introduction of the student
            // input: id, text
            await pool.query(
                'INSERT INTO Introduction (id, Intro) values ($1, $2);--', [id, text]
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

            // update the intro of the student
            // input: id, text
            await pool.query(
                "UPDATE Introduction SET Intro= $1 WHERE id= $2;--", [text, id]
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
                'INSERT INTO potentialMatches (id1,id2) values ($1, $2);--', [id1, id2]
            );

            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Check if [id1,id2] already exist in potential match (i.e: check if id1 already wanted to match with id2)
	// Return a list whose length is 0 or 1
    // input: id1, id2
    static async getPotentialMatch(req, res) {
        try {
            const { id1, id2 } = req.query;
            const match = await pool
                .query
                ('SELECT 1 FROM potentialMatches WHERE id1= $1 AND id2= $2;--',[id1, id2]);

            res.json(match);
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
                'DELETE FROM potentialMatches WHERE ((id1= $1) AND (id2= $2)) OR ((id1= $2) AND (id2= $1));--', [id1, id2]
            );
            res.json({ success: true });
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Print out the potential matches for a person with id based on the classes that 2 people TOOK, we have excluded people from Successful Matches as well as Failed 
    static async getPotentialMatchFromTook(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool
                .query
                (
					'SELECT id, count FROM (SELECT b.id AS ID, COUNT(b.course) FROM Took AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) GROUP BY b.id) AS C LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS D ON ((D.id1 = $1) AND (C.id = D.id2)) OR ((D.id2 = $1) AND (C.id = D.id1)) WHERE D.id1 is NULL ORDER BY count DESC; --', [id]
				);

            res.json(potentialMatch);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

    // Print out the potential matches for a person with id based on the classes that 2 people are TAKING, we have excluded people from Successful Matches as well as Failed
    static async getPotentialMatchFromTaking(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool
                .query
                (
				'SELECT id, count FROM (SELECT b.id AS ID, COUNT(b.course) FROM Taking AS A INNER JOIN Taking AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) GROUP BY b.id) AS C LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS D ON ((D.id1 = $1) AND (C.id = D.id2)) OR ((D.id2 = $1) AND (C.id = D.id1)) WHERE D.id1 is NULL ORDER BY count DESC; --', [id]
				);

            res.json(potentialMatch);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }
	
	// Print out the potential matches for a person with id based on the classes that a person TOOK that the other is TAKING, we have excluded people from successful Matches as well as failed
    static async getPotentialMatchFromTookTaking(req, res) {
        try {
            const { id } = req.query;
            const potentialMatch = await pool
                .query
                (
				'SELECT id, count FROM (SELECT id, COUNT(C.id) FROM (SELECT B.id AS ID FROM Taking AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id = $1) AND (B.id != $1) UNION ALL SELECT A.id AS ID FROM Taking AS A INNER JOIN Took AS B ON (a.course = b.course) AND (A.id != $1) AND (B.id = $1)) AS C GROUP BY c.id) AS D LEFT JOIN (SELECT * FROM Failed UNION SELECT * FROM successfulMatches) AS E ON ((E.id1 = $1) AND (D.id = E.id2)) OR ((E.id2 = $1) AND (D.id = E.id1)) WHERE E.id1 IS NULL ORDER BY count DESC;--',[id]
				);

            res.json(potentialMatch);
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
            await pool
                .query
                ('INSERT INTO successfulMatches (id1, id2) VALUES ($1, $2);--', [id1, id2]);

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
            const successfulMatch = await pool
                .query
                ('SELECT id2 AS id FROM successfulMatches WHERE id1= $1 UNION SELECT id1 AS id FROM successfulMatches WHERE id2= $1; --', [id] );

            res.json(successfulMatch);
        } catch (err) {
            console.error(err.message);
            res.json({ success: false, error: err.message });
        }
    }

}

module.exports = API;
