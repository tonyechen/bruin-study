import http from './http';
import axios from 'axios';
class db {

    /**
     *
     * @param {int} id
     * @returns A promise that returns a JS object that contains a student profile information. If an error occur, it will return { success: false, error: "error message" }
     */
    static async getProfile(id) {
        let profile = {};
        const data = await axios.all([
            http.get(`/user?id=${id}`),
            http.get(`/introduction?id=${id}`),
            http.get(`/courseTook?id=${id}`),
            http.get(`/courseTaking?id=${id}`)
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


}

export default db;
