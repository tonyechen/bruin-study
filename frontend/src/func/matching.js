import db from '../data/dataAccess';

/*
Pseuducode:
- Initialize the list MATCHES that stores an array of js object that records ID of potential matches(key), same courses taking, same courses took, and compatability scores (value) 
- Fetch list of ids with number of same courses taking with the user from Database 
- add match id to the MATCHES list and update the corresponding value:
    - number of same classes currently taking
    - campatability scores (weight = 3)
- Fetch list of ids with the number of same courses took with the user from Database
- update the value of the existing match ID, and add the new match ID (not already in our list) and add their values
    - number of same classes took
    - compatability scores (weight = 1)
- Fetch a list of ids with number of overlapping courses with the user, excluding the same courses taking and same courses took 
- (i.e. one user is taking the course and the other took the course)
- update values of existing match ID, and add new match ID
    - number of additioanl overlapping classes
    - compatability scores (weight = 2)
*/

async function getMatches(id) {
    let matches = [];

    // rank the importance of each factor of picking desired matches
    const weightTaking = 3;
    const weightTook = 1;
    const weightAdditional = 2;

    // Fetch id with number of same class Taking from Database
    const matchFromTaking = await db.getPotentialMatchFromCourseTaking(id);
    for (let match of matchFromTaking) {
        let entry = {};
        entry.id = match.id;
        entry.sameTaking = parseInt(match.count);
        entry.sameTook = 0;
        entry.additionalMatches = 0;
        entry.compatability = parseInt(match.count) * weightTaking;
        matches.push(entry);
    }

    // Fetch id the number of same class Took from Database
    const matchFromTook = await db.getPotentialMatchFromCourseTook(id);
    for (let match of matchFromTook) {
        // check if the id already exist
        let entry = matches.find((item) => item.id === match.id);
        if (entry) {
            entry.sameTook = parseInt(match.count);
            entry.compatability += entry.sameTook * weightTook;
        } else {
            entry = {};
            entry.id = match.id;
            entry.sameTaking = 0;
            entry.sameTook = parseInt(match.count);
            entry.additionalMatches = 0;
            entry.compatability = entry.sameTook * weightTook;
            matches.push(entry);
        }
    }

    // Fetch id the number of additional overlapping courses from Database
    const additionalMatches = await db.getPotentialMatchFromCourseTookTaking(
        id
    );
    for (let match of additionalMatches) {
        // check if the id already exist
        let entry = matches.find((item) => item.id === match.id);
        if (entry) {
            entry.additionalMatches = parseInt(match.count);
            entry.compatability += entry.additionalMatches * weightAdditional;
        } else {
            entry = {};
            entry.id = match.id;
            entry.sameTaking = 0;
            entry.sameTook = 0;
            entry.additionalMatches = parseInt(match.count);
            entry.compatability = entry.additionalMatches * weightAdditional;
            matches.push(entry);
        }
    }

    // sort the final list from most compatible to least compatible
    matches.sort((a, b) => b.compatability - a.compatability);
    return matches;
}

export default getMatches;
