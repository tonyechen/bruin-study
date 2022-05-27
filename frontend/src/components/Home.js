import React, { useState } from "react";
import "./Home.css"
import db from "../data/dataAccess";

class Home extends React.Component {
    constructor(props) {
        super(props);
        this.students = db.id;
    }

    render() {
        return (
            <div class = "center">
                <h2>HOME</h2>
                <button id = "Yes" onClick = {() => this.handleClick("Yes")} class = "#Yes">
                    Yes
                </button>
                <button id = "No" onClick = {() => this.handleClick("No")} class = "#No">
                    No
                </button>
            </div>
        )
    }

    displayStudents(id) {
        const [list, setList] = useState([]);
        const [student, setStudent] = useState("");
        //db.getFullProfile(2);
        /*if (db.checkID(id)) {
            setStudent();
        }*/
    }

    handleClick(buttonType) {
        console.log(buttonType);
    }
}

export default Home;