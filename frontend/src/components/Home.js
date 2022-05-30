import React, { useState } from "react";
import db from "../data/dataAccess";
import getMatches from "../func/matching";
import "./Home.css"

class Home extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            uid: 222222222,
            email: null,
            bio: null,
            username: null,
            name: null,
            major: null,
            currentClassList: null,
            previousClassList: null,
            pmatches: [],
            index: 1
        }
    }

    render() {
        return (
            <div className = "center">
                <h1 className = "square">{this.displayStudent()}</h1>,
                <button id = "No" onClick = {() => this.handleClick("No", this.state.uid)} className = "buttons">
                    No
                </button>
                <button id = "Rewind" onClick = {() => this.handleClick("Rewind")} className = "buttons">
                    Rewind
                </button>
                <button id = "Yes" onClick = {() => this.handleClick("Yes")} className = "buttons">
                    Yes
                </button>
            </div>
        )
    }

    displayStudent() {
        if (this.state.index !== -1 && this.state.index !== this.state.matches) {
            this.componentDidMount();
            return(
                <h4 className = "profileBox">
                    {this.state.name}<br></br><br></br>
                    <h4>About Me: </h4>
                    {this.state.bio}<br></br><br></br>
                    <h4>Major: </h4>
                    {this.state.major}<br></br><br></br>
                    <h4>Current Classes: </h4>
                    {this.state.currentClassList}<br></br><br></br>
                    <h4>Previous Classes: </h4>
                    {this.state.previousClassList}<br></br><br></br>
                </h4>
            )
        }
        else {
            return(<h4 className = "profileBox">NO MORE USERS!</h4>)
        }
    }

    //Handles button clicks -> on Yes or no sends decisions to functions that update database information
    handleClick(buttonType, id) {
        console.log(buttonType);
        if (buttonType === "Yes" && this.state.index !== -1) {
            db.addMatch(this.state.uid, this.state.matches[this.state.index].id);
        }
        else if (buttonType === "Rewind") {
            //Set up pop up notification stuff
        }
        else if (buttonType === "No" && this.state.index !== -1) {
            db.addFailedMatch(this.state.uid, this.state.matches[this.state.index].id);
        }

        this.setState({index: (this.state.matches[this.state.index + 1]) ? this.state.index + 1 : -1})
    }

    async componentDidMount() {
        var matchesL = await getMatches(this.state.uid); 
        const obj = await db.getFullProfile(matchesL[this.state.index].id);
        
        var ccl = [];
        var pcl = obj.courseTook;

        ccl = obj.courseTaking.map((courses)=>{return (courses + " || ");});
        pcl = obj.courseTook.map((courses)=>{return (courses + " || ");});

        this.setState(
            {
                email: obj.email,
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                currentClassList: ccl,
                previousClassList: pcl,
                matches: matchesL 
            }
        )
    }
}

export default Home;