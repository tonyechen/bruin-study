const express = require('express');
const api = require('./databaseDAO');

const router = express.Router();

// student table endpoint
router
    .route('/user')
    .get(api.getStudent)
    .post(api.createStudent)
    .put(api.updateStudent);

// cousre took table endpoint
router
    .route('/courseTook')
    .get(api.getCourseTook)
    .post(api.addCourseTook)
    .delete(api.deleteCourseTook);

// cousre taking table endpoint
router
    .route('/courseTaking')
    .get(api.getCourseTaking)
    .post(api.addCourseTaking)
    .delete(api.deleteCourseTaking);

// failed table endpoint
router.route('/failed').get(api.getFailedMatch).post(api.addFailedMatch);

// student introduction table endpoint
router
    .route('/introduction')
    .get(api.getIntroduction)
    .post(api.addIntroduction)
    .put(api.updateIntroduction);

module.exports = router;
