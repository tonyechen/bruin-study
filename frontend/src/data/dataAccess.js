import http from './http';
import axios from 'axios';

async function checkID(id) {
    // check if the id exists
    const profile = await http.get(`/user?id=${id}`);
    if (profile.data.error) {
        return profile.data;
    }
    return null;
}

function reformatString(string) {
    // & is a special character for query string, and ' is one for sql
    return string.replaceAll('&', '%26').replaceAll("'", "''");
}
class db {
    /**
     * Get the full profile information associated with the user id
     * @param {int} id
     * @returns A JS object that contains the full student profile information: id, email, name, major, username, introduction, courseTook, and courseTaking.  If an error occur, it will return { success: false, error: "error message" }
     */
    static async getFullProfile(id) {
        let profile = {};
        const data = await axios.all([
            http.get(`/user?id=${id}`),
            http.get(`/introduction?id=${id}`),
            http.get(`/courseTook?id=${id}`),
            http.get(`/courseTaking?id=${id}`),
        ]);
        for (let item of data) {
            if (item.data == null) continue;
            if (item.data.error) {
                return item.data;
            }
        }
        profile = data[0].data;
        profile.introduction = data[1].data;
        profile.courseTook = data[2].data;
        profile.courseTaking = data[3].data;

        return profile;
    }

    /**
     * Create a new profile, should only be used when the user first sign up. This function only add id, email, username, name, major, intro, and password
     * @param {int} id required
     * @param {string} email required
     * @param {string} username required
     * @param {string} name required
     * @param {string} major OPTIONAL, default to ''
     * @param {string} intro OPTIONAL, default to ''
     * @param {string} password required
     * @returns A JS Object indicating the status of the post request. This function only add id, email, username, name, major, intro, and password
     */
    static async createProfile(
        id,
        email,
        username,
        name,
        major = '',
        intro = '',
        password
    ) {
        // ' is a special character in sql
        intro = reformatString(intro);

        let response = await http.post(
            `user?id=${id}&email=${email}&name=${name}&major=${major}&username=${username}&password=${password}`
        );

        // error checking when posting to student table
        if (response.data.error) {
            return response.data;
        }
        response = await http.post(`introduction?id=${id}&text=${intro}`);

        return response.data;
    }

    /**
     * Update the profile information associated with the student.This function only updates id, email, username, name, major, intro
     * @param {int} id required
     * @param {string} email required
     * @param {string} username required
     * @param {string} name required
     * @param {string} major required
     * @param {string} intro required
     * @returns A JS Object indicating the status of the post request. This function only updates id, email, username, name, major, intro
     */
    static async updateProfile(id, email, username, name, major, intro) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        // ' is a special character in sql
        intro = reformatString(intro);

        // update student table
        let response = await http.put(
            `user?id=${id}&email=${email}&name=${name}&major=${major}&username=${username}`
        );

        // error checking when posting to student table
        if (response.data.error) {
            return response.data;
        }

        // fetch from intro table
        response = await http.put(`introduction?id=${id}&text=${intro}`);

        // auto error checking here
        return response.data;
    }

    static async updatePassword(id, password) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        password = reformatString(password);

        let response = await http.put(
            `password?id=${id}&password=${password}`
        );

        return response.data;
    }

    /**
     * Retrieve all the courses that the student with id is taking.
     * @param {int} id
     * @returns a list of all the courses that the student with id is taking. If the list is empty, either the user does not exist or the student is not taking any courses.
     */
    static async getCourseTaking(id) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        let response = await http.get(`courseTaking?id=${id}`);
        return response.data;
    }

    /**
     * Take in a list of course that the student is TAKING. Add the new courses and remove the deleted courses.
     * @param {int} id
     * @param {string[]} courses
     * @returns a JS object indicating success or failure. Success: { success: true }, Failure: { success: false, error: "error message"}
     */
    static async updateCourseTaking(id, courses) {
        const courseTaking = await this.getCourseTaking(id);
        if (courseTaking.error) return courseTaking;

        // add new
        // find new courses added
        const newCourses = courses.filter(
            (course) => !courseTaking.includes(course)
        );
        console.log('add: ', newCourses);

        let response;
        for (let course of newCourses) {
            course = reformatString(course);

            response = await http.post(
                `courseTaking?id=${id}&course=${course}`
            );

            // error checking
            if (response.data.error) return response.data;
        }

        // delete deleted courses
        // find dleted courses
        const deletedCourses = courseTaking.filter(
            (course) => !courses.includes(course)
        );
        console.log('delete:', deletedCourses);

        for (let course of deletedCourses) {
            course = reformatString(course);

            response = await http.delete(
                `courseTaking?id=${id}&course=${course}`
            );

            if (response.data.error) return response.data;
        }

        // there is nothing to add or delete, response is empty
        if (!response) {
            return { success: true };
        }
        return response.data;
    }

    /**
     * Retrieve all the courses that the student with id has taken
     * @param {int} id
     * @returns a list of all courses that the student with id has taken. If the list is empty, either the user does not exist or the student has not taken any courses.
     */
    static async getCourseTook(id) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        let response = await http.get(`courseTook?id=${id}`);
        return response.data;
    }

    /**
     * Take in a list of course that the student TOOK. Add the new courses and remove the deleted courses.
     * @param {int} id
     * @param {string[]} courses
     * @returns a JS object indicating success or failure. Success: { success: true }, Failure: { success: false, error: "error message"}
     */
    static async updateCourseTook(id, courses) {
        const courseTook = await this.getCourseTook(id);
        if (courseTook.error) return courseTook;

        // add new
        // find new courses added
        const newCourses = courses.filter(
            (course) => !courseTook.includes(course)
        );
        console.log('add: ', newCourses);

        let response;
        for (let course of newCourses) {
            course = reformatString(course);

            response = await http.post(`courseTook?id=${id}&course=${course}`);

            // error checking
            if (response.data.error) return response.data;
        }

        // delete deleted courses
        // find dleted courses
        const deletedCourses = courseTook.filter(
            (course) => !courses.includes(course)
        );
        console.log('delete:', deletedCourses);

        for (let course of deletedCourses) {
            course = reformatString(course);

            response = await http.delete(
                `courseTook?id=${id}&course=${course}`
            );

            if (response.data.error) return response.data;
        }

        // there is nothing to add or delete, response is empty
        if (!response) {
            return { success: true };
        }
        return response.data;
    }

    /**
     * Get potential matches of id based on same courses took
     * @param {int} id
     * @returns A list of JSON objects containing the id with and number of same courses took
     */
    static async getPotentialMatchFromCourseTook(id) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        const response = await http.get(`match/took?id=${id}`);
        return response.data;
    }

    /**
     * Get potential matches of id based on same courses taking
     * @param {int} id
     * @returns A list of JSON objects containing the id with and number of same courses taking
     */
    static async getPotentialMatchFromCourseTaking(id) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        const response = await http.get(`match/taking?id=${id}`);
        return response.data;
    }

    /**
     * Get potential matches of id based on overlapping courses took or taken (i.e one person took the course and another is taking the course)
     * @param {int} id
     * @returns A list of JSON objects containing the id with and number of overlapping courses
     */
    static async getPotentialMatchFromCourseTookTaking(id) {
        const error = await checkID(id);
        if (error) {
            return error;
        }

        const response = await http.get(`match/tooktaking?id=${id}`);
        return response.data;
    }

    /**
     * Automatically handle matching as a potential match or a successful match, and update the database accordingly
     * @param {int} id1
     * @param {int} id2
     * @returns return an object indicating the success of the function
     */
    static async addMatch(id1, id2) {
        if (id1 === id2)
            return { success: false, error: 'An id cannot match with itself' };

        let error = await checkID(id1);
        if (error) {
            return error;
        }
        error = await checkID(id2);
        if (error) {
            return error;
        }

        // check if id2 and id1 exist
        const pmatchList = (await http.get(`match/potential?id=${id2}`)).data;
        const hasMatch = pmatchList.includes(id1.toString());

        // if [id2, id1] exists, it means that we have a 2 way match of [id1, id2] and [id2, id1]
        // this indicates a successful match
        if (hasMatch) {
            await http.delete(`match/potential?id1=${id1}&id2=${id2}`);
            const response = await http.post(
                `match/success?id1=${id1}&id2=${id2}`
            );
            return response.data;
        } else {
            // if [id2, id1] doesn't exist, simply add [id1, id2]
            const response = await http.post(
                `match/potential?id1=${id1}&id2=${id2}`
            );
            return response.data;
        }
    }

    /**
     * Add [id1, id2] as a failed matching pair into the Database
     * @param {int} id1
     * @param {int} id2
     * @returns a JSON object indicating success or failure
     */
    static async addFailedMatch(id1, id2) {
        let error = await checkID(id1);
        if (error) {
            return error;
        }
        error = await checkID(id2);
        if (error) {
            return error;
        }

        const response = await http.post(`failed?id1=${id1}&id2=${id2}`);
        return response.data;
    }

    static async getSucessfulMatches(id) {
        let error = await checkID(id);
        if (error) {
            return error;
        }

        const response = await http.get(`match/success?id=${id}`);
        return response.data;
    }

    static async getPotentialMatches(id) {
        let error = await checkID(id);
        if (error) {
            return error;
        }

        const response = await http.get(`match/potential?id=${id}`);
        return response.data;
    }
}

export default db;
