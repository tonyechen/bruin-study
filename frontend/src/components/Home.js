import './Home.css';
import db from '../data/dataAccess';
import React, { useState } from 'react';
import getMatches from '../func/matching';
import { decodeToken } from 'react-jwt';

class Home extends React.Component {
    constructor(props) {
        super(props);

        const token = decodeToken(window.localStorage.getItem('token'));

        this.state = {
            uid: token ? token.id : '',
            bio: null,
            username: null,
            name: null,
            major: null,
            currentClassList: null,
            previousClassList: null,
            cmpScore: null,
            smCls: null,
            smTook: null,
            matches: [],
            index: 0,
            hasMatches: false,
        };
    }

    UNSAFE_componentWillMount() {
        console.log('mounting');
        if (this.state.index === 0) {
            const token = decodeToken(window.localStorage.getItem('token'));
            if (token != null) {
                getMatches(token.id).then((res, rej) => {
                    if (res.length > 0)
                        this.setState({ matches: res, hasMatches: true });
                    else this.setState({ hasMatch: false });
                });
            }
        }
    }

    render() {
        if (this.state.hasMatches && this.state.index === 0) {
            console.log('how many times?');
            this.updateComponent();
        }

        return (
            <div className="center">
                <h1 className="square">{this.displayStudent()}</h1>
                <button
                    id="No"
                    onClick={() => this.handleClick('No')}
                    className="buttons"
                >
                    No
                </button>
                <button
                    id="Yes"
                    onClick={() => this.handleClick('Yes')}
                    className="buttons"
                >
                    Yes
                </button>
            </div>
        );
    }

    displayStudent() {
        if (this.state.hasMatches) {
            if (this.state.index <= this.state.matches.length) {
                return (
                    <h4 className="profileBox">
                        {this.state.name}
                        <br></br>
                        <b>
                            {this.state.cmpScore}
                            <br></br>
                            <br></br>
                            About Me:
                        </b>
                        <br></br>
                        {this.state.bio}
                        <br></br>
                        <br></br>
                        <b>
                            Major:<br></br>
                        </b>
                        {this.state.major}
                        <br></br>
                        <br></br>
                        <b>
                            Current Classes: ({this.state.smCls})<br></br>
                        </b>
                        {this.state.currentClassList}
                        <br></br>
                        <br></br>
                        <b>
                            Previous Classes: ({this.state.smTook})<br></br>
                        </b>
                        {this.state.previousClassList}
                        <br></br>
                        <br></br>
                    </h4>
                );
            } else {
                return (
                    <h4 className="profileBox">
                        <b>NO MORE POTENTIAL USERS IN THE AREA!</b>
                    </h4>
                );
            }
        } else {
            return (
                <h4 className="profileBox">
                    <b>NO MORE POTENTIAL USERS IN THE AREA!</b>
                </h4>
            );
        }
    }

    //Handles button clicks -> on Yes or no sends decisions to functions that update database information
    handleClick(buttonType) {
        if (!this.state.hasMatches) return;
        if (buttonType === 'Yes') {
            db.addMatch(
                this.state.uid,
                this.state.matches[this.state.index - 1].id
            );
        } else if (buttonType === 'No') {
            db.addFailedMatch(
                this.state.uid,
                this.state.matches[this.state.index - 1].id
            );
        }
        this.updateComponent();
    }

    async updateComponent() {
        var ccl = [];
        var pcl = [];

        console.log(this.state.index);
        console.log(this.state.matches.length);

        if (this.state.index < this.state.matches.length) {
            let matchesL = this.state.matches;
            const obj = await db.getFullProfile(matchesL[this.state.index].id);

            ccl = obj.courseTaking.map((courses) => {
                return courses + ' || ';
            });
            pcl = obj.courseTook.map((courses) => {
                return courses + ' || ';
            });
            console.log('made it here');
            this.setState({
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                currentClassList: ccl,
                previousClassList: pcl,
                cmpScore:
                    'Compatability: ' +
                    matchesL[this.state.index].compatability,
                smCls: 'Same Classes: ' + matchesL[this.state.index].sameTaking,
                smTook:
                    'Same Classes Taken: ' +
                    matchesL[this.state.index].sameTook,
                matches: matchesL,
                index: this.state.index + 1,
            });
        } else if (this.state.index == this.state.matches.length) {
            this.setState({ index: this.state.index + 1, hasMatches: false });
        }
    }
}

export default Home;
