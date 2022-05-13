const express = require('express');
const api = require('./databaseDAO');

const router = express.Router();

router.route('/user/:uid').get(api.getStudent);

module.exports = router;
