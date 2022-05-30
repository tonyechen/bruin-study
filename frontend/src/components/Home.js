import "./Home.css"
import db from "../data/dataAccess";
import React, { useState } from "react";
import getMatches from "../func/matching";

class Home extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            uid: 222222222,
            bio: null,
            username: null,
            name: null,
            major: null,
            currentClassList: null,
            previousClassList: null,
            pmatches: [],
            cmpScore: null,
            smCls: null,
            smTook: null,
            index: 1
        }
    }

    render() {
        return (
            <div className = "center">
                <h1 className = "square">{this.displayStudent()}</h1>
                <button id = "No" onClick = {() => this.handleClick("No", this.state.uid)} className = "buttons">
                    No
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
                    {this.state.name}<br></br>
                    <b>{this.state.cmpScore}<br></br><br></br>
                    About Me:</b><br></br>
                    {this.state.bio}<br></br><br></br>
                    <b>Major:<br></br></b>
                    {this.state.major}<br></br><br></br>
                    <b>Current Classes: ({this.state.smCls})<br></br></b>
                    {this.state.currentClassList}<br></br><br></br>
                    <b>Previous Classes: ({this.state.smTook})<br></br></b>
                    {this.state.previousClassList}<br></br><br></br>
                </h4>
            )
        }
        else {
            return(<h4 className = "profileBox"><b>NO MORE POTENTIAL USERS!</b></h4>)
        }
    }

    //Handles button clicks -> on Yes or no sends decisions to functions that update database information
    handleClick(buttonType, id) {
        console.log(buttonType);
        if (buttonType === "Yes" && this.state.index !== -1) {
            db.addMatch(this.state.uid, this.state.matches[this.state.index].id);
        }
        else if (buttonType === "No" && this.state.index !== -1) {
            db.addFailedMatch(this.state.uid, this.state.matches[this.state.index].id);
        }

        this.setState({index: (this.state.matches[this.state.index + 1]) ? this.state.index + 1 : -1})
    }

    async componentDidMount() {
        var ccl = [];
        var pcl = [];
        var matchesL = await getMatches(this.state.uid); 
        const obj = await db.getFullProfile(matchesL[this.state.index].id);
        console.log(matchesL[this.state.index]);

        ccl = obj.courseTaking.map((courses)=>{return (courses + " || ");});
        pcl = obj.courseTook.map((courses)=>{return (courses + " || ");});

        this.setState({
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                currentClassList: ccl,
                previousClassList: pcl,
                cmpScore: "Compatability: " + matchesL[this.state.index].compatability,
                smCls: "Same Classes: " + matchesL[this.state.index].sameTaking,
                smTook: "Same Classes Taken: " + matchesL[this.state.index].sameTook,
                matches: matchesL 
            }
        )
    }
}

export default Home;