import React, { Component, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { decodeToken } from 'react-jwt';
import db from '../data/dataAccess.js';
import "./ProfPage.css"

class ClassLine extends Component {
    state = {
        ClassName: this.props.ClassName,
    };
    render() {
        return (
            <span className = "course">{this.props.ClassName}</span>
        );
    }
}
const mytoken = decodeToken(window.localStorage.getItem('token'));

let initialState = {
    uid: mytoken ? mytoken.id : '',
    email: '',
    bio: '',
    username: '',
    password: '',
    name: '',
    major: '',

    emailError: '',
    usernameError: '',
    bioError: '',
    nameError: '',
    passwordError: '',
    majorError: '',
    formError: '',
    MajorSuggestions: [],

    CurrentClassList: [],
    PreviousClassList: [],
};
class Profile extends Component {
    state = initialState;

    async componentDidMount() {
        const obj = await db.getFullProfile(this.state.uid);
        var ccl = [{ id: 1, cn: '' }];
        var pcl = [{ id: 1, cn: '' }];

        for (var i = 0; i < obj.courseTaking.length; i++) {
            if (i == 0) {
                ccl[i].cn = obj.courseTaking[i];
            } else {
                ccl = ccl.concat({
                    id: i + 1,
                    cn: obj.courseTaking[i],
                    error: '',
                });
            }
        }

        for (var i = 0; i < obj.courseTook.length; i++) {
            if (i == 0) {
                pcl[i].cn = obj.courseTook[i];
            } else {
                pcl = pcl.concat({
                    id: i + 1,
                    cn: obj.courseTook[i],
                    error: '',
                });
            }
        }
        this.setState({
            email: obj.email,
            bio: obj.introduction,
            username: obj.username,
            name: obj.name,
            major: obj.major,
            CurrentClassList: ccl,
            PreviousClassList: pcl,
        });
    }

    handleClick = () => {
        let navigate = this.props.navigate;
        navigate('/editProfile');
    };
    render() {
        if (window.localStorage.getItem('token')) {
            return (
                <div className="profBox">
                    <h1 className="profileHeader">My Profile</h1>
                        <div>
                            <img 
                                className = "userImage" src
                                src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png"
                                alt="user_icon">
                            </img>
                            <label className="infoLabel">Name: </label>
                            <text className= "info">{this.state.name}</text>
                            <br /><br />

                            <label className="infoLabel">Email: </label>
                            <text className = "info">{this.state.email}</text>
                            <br /><br />

                            <label className="infoLabel">Username: </label>
                            <text className = "info">{this.state.username}</text>
                            <br /><br />

                            <label className="infoLabel">Major: </label>
                            <text className = "info">{this.state.major}</text>
                            <br /><br />

                            <label className="infoLabel">Bio: </label>
                            <p className = "bioStyle">{this.state.bio}</p>
                            <br />

                            <dl className="infoLabel">Current Classes</dl>
                            <div>
                            {this.state.CurrentClassList.map((cl) => (
                                <ClassLine
                                    key={cl.id}
                                    id={cl.id}
                                    ClassName={cl.cn}
                                >
                                    <label className="infoLabel">
                                        {' '}
                                    </label>{' '}
                                </ClassLine>
                            ))}
                            </div>
                            <br /><br />

                            <dl className="infoLabel">Previous Classes</dl>

                            <div>
                            {this.state.PreviousClassList.map((cl) => (
                                <ClassLine
                                    key={cl.id}
                                    id={cl.id}
                                    ClassName={cl.cn}
                                >
                                    <label className="infoLabel">
                                        {' '}
                                    </label>{' '}
                                </ClassLine>
                            ))}
                            </div>

                            <button className = "btnStyle" onClick={this.handleClick}>
                                Edit Profile
                            </button>
                        </div>
                    </div>
            );
        } else {
            return <p>You are not signed in</p>;
        }
    }
}
export default function (props) {
    const navigate = useNavigate();
    return <Profile navigate={navigate} />;
}
