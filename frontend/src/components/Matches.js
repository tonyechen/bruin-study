import React, { Component, useState } from 'react';
import db from '../data/dataAccess.js';
import './Matches.css';
class UserLine extends Component {
    handleClick() {
        console.log('bro');
    }

    render() {
        return (
            <div className="matchElement" onClick={this.handleClick.bind(this)}>
                <p>{this.props.username}</p>
                <h3>{this.props.name}</h3>
                <hr />
            </div>
        );
    }
}
class MatchList extends Component {
    state = {
        uid: 222222222,
        Matches: [],
    };
    async componentDidMount() {
        let MatchObject = [111111111, 333333333];
        let Matches = [];
        for (var i = 0; i < MatchObject.length; i++) {
            let obj = await db.getFullProfile(MatchObject[i]);
            let MatchElement = {
                uid: MatchObject[i],
                name: obj.name,
                uname: obj.username,
            };
            Matches = Matches.concat(MatchElement);
        }
        this.setState({
            Matches: Matches,
        });
    }
    render() {
        console.log(this.state);
        return (
            <div className="matchBox">
                <div><h2>Successful Matches</h2></div>
                {this.state.Matches.map((ul) => (
                    <UserLine key={ul.uid} username={ul.uname} name={ul.name} />
                ))}
            </div>
        );
    }
}
export default MatchList;
