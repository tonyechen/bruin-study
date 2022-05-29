const express = require('express');
const { addPotentialMatch } = require('./databaseDAO');
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

// potentialMatch table endpoint
router
    .route('/match/potential')
    .get(api.getPotentialMatch)
    .post(api.addPotentialMatch)
    .delete(api.deletePotentialMatch);

// successfulMatch table endpoint
router
    .route('/match/success')
    .get(api.getSuccessfulMatch)
    .post(api.addSuccessfulMatch);

// generate potential matches from Took Take endpoints
router.route('/match/took').get(api.getPotentialMatchFromTook);
router.route('/match/taking').get(api.getPotentialMatchFromTaking);
router.route('/match/tooktaking').get(api.getPotentialMatchFromTookTaking);

module.exports = router;
