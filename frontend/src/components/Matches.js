import './Matches.css';
import db from '../data/dataAccess.js';
import { decodeToken } from 'react-jwt';
import { Link } from 'react-router-dom';
import React, { Component } from 'react';

class UserLine extends Component {
    render() {
        console.log(this);
        return (
            <Link className="matchElement" to={`/profile/${this.props.uid}`}>
                <p>{this.props.username}</p>
                <h3>{this.props.name}</h3>
                <hr />
            </Link>
        );
    }
}
class MatchList extends Component {
    constructor(props) {
        super(props);
        const token = decodeToken(window.localStorage.getItem('token'));
        this.state = {
            uid: token ? token.id : null,
            currMatches: [],
            Matches: [],
        };
    }

    async componentDidMount() {
        if (this.state.uid == null) return;
        let MatchObject = await db.getSucessfulMatches(this.state.uid);
        if (this.state.currMatches.length == MatchObject) return;
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
        console.log(Matches);
        this.setState({
            currMatches: MatchObject,
            Matches: Matches,
        });
    }

    updateComponent() {
        this.componentDidMount();
        window.location.reload();
    }

    render() {
        return (
            <div className="matchBox">
                <div>
                    <h2>Successful Matches</h2>
                    <button
                        className="updateButton"
                        onClick={this.updateComponent.bind(this)}
                    >
                        update
                    </button>
                </div>
                {this.state.Matches.map((ul) => (
                    <UserLine key={ul.uid} uid={ul.uid} username={ul.uname} name={ul.name} />
                ))}
            </div>
        );
    }
}
export default MatchList;
