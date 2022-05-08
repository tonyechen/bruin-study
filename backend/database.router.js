const express = require('express');
const api = require('./databaseDAO');

const router = express.Router();

router.route('/user/:uid').get(api.getStudentPofile);

module.exports = router;
