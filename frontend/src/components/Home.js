import React, { useState } from "react";
import "./Home.css"
import db from "../data/dataAccess";

class Home extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            uid: 111111111,
            email: null,
            bio: null,
            username: null,
            name: null,
            major: null,
            currentClassList: null,
            previousClassList: null,
            yesSwp: null,
            noSwp: null,
            userIds: [111111111, 222222222, 333333333]
        }
    }

    render() {
        return (
            <div className = "center">
                <h1 className="square">{this.displayStudent(this.state.uid)}</h1>,
                <button id = "Yes" onClick = {() => this.handleClick("Yes", this.state.uid)} className = "buttons">
                    Yes
                </button>
                <button id = "No" onClick = {() => this.handleClick("No", this.state.uid)} className = "buttons">
                    No
                </button>
            </div>
        )
    }

    displayStudent(id) {
        //var ccl = [];
        //var pcl = [];
        /*for (var i = 0; i < this.state.CurrentClassList; i++) {
            ccl.concat(this.state.CurrentClassList[i] + " | ");
            console.log(ccl[i]);
        }*/
        if (this.state.uid !== 0) {
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

    handleClick(buttonType, id) {
        console.log(buttonType);
        if (buttonType === "Yes") {
            //this.setState({yesSwp: [yesSwp].concat(id)})
            //console.log(this.state.yesSwp);
        }
        else if (buttonType === "No") {
            //this.setState({noSwp: [noSwp].concat(id)})
            //console.log(this.state.noSwp);
        }
        if (this.state.userIds[1]) {
            this.state.userIds.splice(0, 1);
            this.setState({
                uid: this.state.userIds[0],
            })
        }
        else {
            this.setState({uid: 0})
        }
    }

    async componentDidMount() {
        const obj = await db.getFullProfile(this.state.uid);
        var ccl = obj.courseTaking;
        var pcl = obj.courseTook;

        this.setState(
            {
                email: obj.email,
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                currentClassList: ccl,
                previousClassList: pcl
            }
        )
    }
}

export default Home;