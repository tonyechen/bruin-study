import http from './http';
import axios from 'axios';
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
     * Update the profile information associated with the student.This function only updates id, email, username, name, major, intro, and password
     * @param {int} id required
     * @param {string} email required
     * @param {string} username required
     * @param {string} name required
     * @param {string} major required
     * @param {string} intro required
     * @param {string} password required
     * @returns A JS Object indicating the status of the post request. This function only updates id, email, username, name, major, intro, and password
     */
    static async updateProfile(
        id,
        email,
        username,
        name,
        major,
        intro,
        password
    ) {
        let response = await http.put(
            `user?id=${id}&email=${email}&name=${name}&major=${major}&username=${username}&password=${password}`
        );

        // error checking when posting to student table
        if (response.data.error) {
            return response.data;
        }

        response = await http.put(`introduction?id=${id}&text=${intro}`);

        return response.data;
    }

    /**
     * Retrieve all the courses that the student with id is taking.
     * @param {int} id
     * @returns a list of all the courses that the student with id is taking. If the list is empty, either the user does not exist or the student is not taking any courses.
     */
    static async getCourseTaking(id) {
        let response = await http.get(`courseTaking?id=${id}`);
        return response.data;
    }

    /**
     * Add a course that the student with id is taking
     * @param {int} id
     * @param {string} course
     * @returns a JS object indicating success or failure. Success: { success: true }, Failure: { success: false, error: "error message"}
     */
    static async addCourseTaking(id, course) {
        let response = await http.post(
            `courseTaking?id=${id}&course=${course}`
        );
        return response.data;
    }

    /**
     * Retrieve all the courses that the student with id has taken
     * @param {int} id
     * @returns a list of all courses that the student with id has taken. If the list is empty, either the user does not exist or the student has not taken any courses.
     */
    static async getCourseTook(id) {
        let response = await http.get(`courseTook?id=${id}`);
        return response.data;
    }

    /**
     * Add a course that the student with id has taken
     * @param {int} id
     * @param {string} course
     * @returns a JS object indicating success or failure. Success: { success: true }, Failure: { success: false, error: "error message"}
     */
    static async addCourseTook(id, course) {
        let response = await http.post(`courseTook?id=${id}&course=${course}`);
        return response.data;
    }
}

export default db;
