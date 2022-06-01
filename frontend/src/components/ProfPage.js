import React, { Component, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { decodeToken } from 'react-jwt';
import db from '../data/dataAccess.js';

class ClassLine extends Component {
    state = {
        ClassName: this.props.ClassName,
    };
    render() {
        return (
            <div>
                {this.props.children}
                <label type="text">{this.props.ClassName}</label>
            </div>
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
                <div className="center">
                    <h1 className="header_1">User Profile</h1>
                    <div>
                        <div>
                            <label className="label_1">Name: </label>
                            <label>{this.state.name}</label>
                            <br />

                            <label className="label_1">Email: </label>
                            <text>{this.state.email}</text>
                            <br />

                            <label className="label_1">Username: </label>
                            <text>{this.state.username}</text>
                            <br />

                            <label className="label_1">Major: </label>
                            <text>{this.state.major}</text>
                            <br />

                            <dl className="class_headers">Current Classes</dl>
                            {this.state.CurrentClassList.map((cl) => (
                                <ClassLine
                                    key={cl.id}
                                    id={cl.id}
                                    ClassName={cl.cn}
                                >
                                    <label className="label_1">
                                        Class {cl.id}:{' '}
                                    </label>{' '}
                                </ClassLine>
                            ))}
                            <br />

                            <dl className="class_headers">Previous Classes</dl>

                            {this.state.PreviousClassList.map((cl) => (
                                <ClassLine
                                    key={cl.id}
                                    id={cl.id}
                                    ClassName={cl.cn}
                                >
                                    <label className="label_1">
                                        Class {cl.id}:{' '}
                                    </label>{' '}
                                </ClassLine>
                            ))}
                            <br />

                            <label className="label_1">Bio: </label>
                            <p>{this.state.bio}</p>
                            <br />

                            <button onClick={this.handleClick}>
                                Edit Profile
                            </button>
                        </div>
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
