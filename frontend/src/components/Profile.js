import React, { Component, useState } from 'react';
import * as EmailValidator from 'email-validator';
import './Profile.css';
import Classes from '../data/Classes.js';
import Majors from '../data/Majors.js';
import db from '../data/dataAccess.js';
import { useNavigate } from 'react-router-dom'
import { decodeToken } from 'react-jwt';

class ClassLine extends Component {
    items = Classes;
    state = {
        suggestions: [],
        ClassName: this.props.ClassName,
    };
    handleChange = (e) => {
        const value = e.target.value;
        let suggestions = [];
        if (value.length > 0) {
            const regex = new RegExp(`^${value}`, 'i');
            suggestions = this.items.sort().filter((v) => regex.test(v));
        }
        this.setState({
            suggestions: suggestions,
            ClassName: value,
        });
        this.props.setClass(this.props.id, e.target.value);
    };
    suggestionSelected(value) {
        this.setState({
            suggestions: [],
            ClassName: value,
        });
        this.props.setClass(this.props.id, value);
    }
    renderSuggestions() {
        const { suggestions } = this.state;
        if (suggestions.length === 0) {
            return null;
        }
        return (
            <ul>
                {suggestions.map((item) => (
                    <li onClick={() => this.suggestionSelected(item)}>
                        {item}
                    </li>
                ))}
            </ul>
        );
    }
    render() {
        return (
            <div class="class">
                {this.props.children}
                <input
                    type="text"
                    name="ClassName"
                    placeholder="Class Name"
                    value={this.props.ClassName}
                    onChange={this.handleChange}
                />
                <button
                    onClick={() => this.props.onDelete(this.props.id)}
                    type="button"
                >
                    Delete
                </button>
                {this.state.suggestions.length > 0 && (
                    <div className="classList">{this.renderSuggestions()}</div>
                )}

                <label>{this.props.error}</label>
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
    majorError: '',
    formError: '',
    MajorSuggestions: [],

    CurrentClassList: [],
    PreviousClassList: [],
};

var majors = Majors;
class EditProfile extends Component {
    state = initialState;

    async componentDidMount() {
        const obj = await db.getFullProfile(this.state.uid);

        var ccl = [{ id: 1, cn: '', error: '' }];
        var pcl = [{ id: 1, cn: '', error: '' }];

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

    handleUsernameChange = (e) => {
        this.setState({ username: e.target.value });
    };
    handlePasswordChange = (e) => {
        this.setState({ password: e.target.value });
    };
    handleNameChange = (e) => {
        this.setState({ name: e.target.value });
    };

    handleEmailChange = (e) => {
        this.setState({ email: e.target.value });
    };
    handleBioChange = (e) => {
        this.setState({ bio: e.target.value });
    };
    handleMajorChange = (e) => {
        const value = e.target.value;
        let suggestions = [];
        if (value.length > 0) {
            const regex = new RegExp(`^${value}`, 'i');
            suggestions = Majors.sort().filter((v) => regex.test(v));
        }
        this.setState({
            MajorSuggestions: suggestions,
            major: value,
        });
    };

    majorSuggestionSelected(value) {
        this.setState({
            MajorSuggestions: [],
            major: value,
        });
    }
    renderMajorSuggestions() {
        if (this.state.MajorSuggestions.length === 0) {
            return null;
        }
        return (
            <ul>
                {this.state.MajorSuggestions.map((item) => (
                    <li onClick={() => this.majorSuggestionSelected(item)}>
                        {item}
                    </li>
                ))}
            </ul>
        );
    }
    handleCurrentDelete = (whichID) => {
        let CurrentClassList = this.state.CurrentClassList;
        if (CurrentClassList.length > 1) {
            CurrentClassList = CurrentClassList.filter((c) => c.id !== whichID);
            for (var i = 0; i < CurrentClassList.length; i++) {
                CurrentClassList[i].id = 1 + i;
            }
            this.setState({ CurrentClassList: CurrentClassList });
        }
    };
    handleCurrentAdd = () => {
        if (this.state.CurrentClassList.length) {
            var x =
                this.state.CurrentClassList[
                    this.state.CurrentClassList.length - 1
                ].id + 1;
            let CurrentClassList = this.state.CurrentClassList.concat({
                id: x,
                cn: '',
                error: '',
            });
            this.setState({ CurrentClassList: CurrentClassList });
        }
    };
    handlePreviousDelete = (whichID) => {
        if (this.state.PreviousClassList.length > 1) {
            let PreviousClassList = this.state.PreviousClassList.filter(
                (c) => c.id !== whichID
            );
            for (var i = 0; i < PreviousClassList.length; i++) {
                PreviousClassList[i].id = 1 + i;
            }
            this.setState({ PreviousClassList: PreviousClassList });
        }
    };
    handlePreviousAdd = () => {
        var x =
            this.state.PreviousClassList[
                this.state.PreviousClassList.length - 1
            ].id + 1;
        let PreviousClassList = this.state.PreviousClassList.concat({
            id: x,
            cn: '',
            error: '',
        });
        this.setState({ PreviousClassList: PreviousClassList });
    };
    //Validates information on submit
    validate = () => {
        var check = true;
        let majorError = '';
        if (!Majors.includes(this.state.major)) {
            majorError = 'Must enter valid UCLA Major';
            check = false;
        }
        let usernameError = '';
        if (this.state.username == '') {
            usernameError = 'Must enter a username';
            check = false;
        }
        let nameError = '';
        if (this.state.name == '') {
            nameError = 'Must fill in a name';
            check = false;
        }
        let bioError = '';
        if (this.state.bio == '') {
            bioError = 'Must fill in a bio';
            check = false;
        }
        let emailError = '';
        if (this.state.email == '') {
            emailError = 'Must fill in email';
            check = false;
        } else if (!EmailValidator.validate(this.state.email)) {
            emailError = 'Must fill in a valid email';
            check = false;
        }

        for (var i = 0; i < this.state.PreviousClassList.length; i++) {
            if (this.state.PreviousClassList[i].cn == '') {
                this.state.PreviousClassList[i].error =
                    'Must fill in class name';
                check = false;
            } else if (!Classes.includes(this.state.PreviousClassList[i].cn)) {
                this.state.PreviousClassList[i].error = 'Class not in list';
                check = false;
            } else {
                this.state.PreviousClassList[i].error = '';
            }
        }
        for (var i = 0; i < this.state.CurrentClassList.length; i++) {
            if (this.state.CurrentClassList[i].cn == '') {
                this.state.CurrentClassList[i].error =
                    'Must fill in class name';
                check = false;
            } else if (!Classes.includes(this.state.CurrentClassList[i].cn)) {
                this.state.CurrentClassList[i].error = 'Class not in list';
                check = false;
            } else {
                this.state.CurrentClassList[i].error = '';
            }
        }
        this.setState({
            emailError: emailError,
            bioError: bioError,
            nameError: nameError,
            majorError: majorError,
        });
        return check;
    };
    setCurrClass = (id, ClassName) => {
        let currClass = this.state.CurrentClassList;
        currClass[id - 1].cn = ClassName;
        this.setState({ CurrentClassList: currClass });
    };
    setPrevClass = (id, ClassName) => {
        let prevClass = this.state.PreviousClassList;
        prevClass[id - 1].cn = ClassName;
        this.setState({ PreviousClassList: prevClass });
    };
    handleSubmit = async (e) => {
       e.preventDefault();
        let validate = this.validate();
        console.log('Submitted');
        console.log(validate);
        if (validate == false) {
            console.log('Validate Failed');
            return;
        } else {
            let ensureCorrectProf = await db.updateProfile(
                this.state.uid,
                this.state.email,
                this.state.username,
                this.state.name,
                this.state.major,
                this.state.bio,
                this.state.introduction
            );

            if (this.state.password !== '') {
                let ensurePassword = await db.updatePassword(
                    this.state.uid,
                    this.state.password
                );
                if (!ensurePassword.success) {
                    return;
                }
            }
            if (ensureCorrectProf.success === false) {

                if (ensureCorrectProf.error.includes("email"))
                {
                    this.setState({ emailError: "Email already in use" });
                }
                else
                {
                    this.setState({ usernameError: "Username already in use" });
                }
                return;
            }
            let currCourses = [];
            for (var i = 0; i < this.state.CurrentClassList.length; i++) {
                currCourses = currCourses.concat(
                    this.state.CurrentClassList[i].cn
                );
            }
            let prevCourses = [];
            for (var i = 0; i < this.state.PreviousClassList.length; i++) {
                prevCourses = prevCourses.concat(
                    this.state.PreviousClassList[i].cn
                );
            }
            let ensureCurrClass = await db.updateCourseTaking(
                this.state.uid,
                currCourses
            );
            let ensurePrevClass = await db.updateCourseTook(
                this.state.uid,
                prevCourses
            );
            if (ensurePrevClass.success === false) {
                return;
            }
            if (ensureCurrClass.success === false) {
                return;
            }
        }
        let navigate= this.props.navigate;
        navigate('/profile');

    };
    render() {
        return (
            <div className="profile">
                <h1 className="header_1">Edit Profile</h1>
                <form onSubmit={this.handleSubmit}>
                    <div className="profile__form">
                        <label className="label_1">UID: {this.state.uid}</label>
                        <br />

                        <label className="label_1">Name: </label>
                        <input
                            type="text"
                            value={this.state.name}
                            onChange={this.handleNameChange}
                        />
                        <label class="error">{this.state.nameError}</label>
                        <br />

                        <label className="label_1">Email: </label>
                        <input
                            type="text"
                            value={this.state.email}
                            onChange={this.handleEmailChange}
                        />
                        <label class="error">{this.state.emailError}</label>
                        <br />

                        <label className="label_1">Username: </label>
                        <input
                            type="text"
                            value={this.state.username}
                            onChange={this.handleUsernameChange}
                        />
                        <label class="error">{this.state.usernameError}</label>
                        <br />

                        <label className="label_1">Major: </label>
                        <input
                            type="text"
                            value={this.state.major}
                            onChange={this.handleMajorChange}
                        />
                        {this.renderMajorSuggestions()}
                        <label class="error">{this.state.majorError}</label>
                        <br />

                        <label className="label_1">
                            New Password (optional):{' '}
                        </label>
                        <input
                            type="password"
                            value={this.state.password}
                            onChange={this.handlePasswordChange}
                        />
                        <br />

                        <label className="label_1">Bio: </label>
                        <textarea
                            className="bio__text"
                            value={this.state.bio}
                            onChange={this.handleBioChange}
                        />
                        <label class="error">{this.state.bioError}</label>

                        <dl className="class_headers">Current Classes</dl>
                        {this.state.CurrentClassList.map((cl) => (
                            <ClassLine
                                key={cl.id}
                                id={cl.id}
                                onDelete={this.handleCurrentDelete}
                                ClassName={cl.cn}
                                error={cl.error}
                                setClass={this.setCurrClass}
                            >
                                <label className="label_1">
                                    Class {cl.id}:{' '}
                                </label>{' '}
                            </ClassLine>
                        ))}
                        <button
                            className="add_button"
                            onClick={this.handleCurrentAdd}
                            type="button"
                        >
                            + Add Another Class
                        </button>
                        <br />

                        <dl className="class_headers">Previous Classes</dl>

                        {this.state.PreviousClassList.map((cl) => (
                            <ClassLine
                                key={cl.id}
                                id={cl.id}
                                onDelete={this.handlePreviousDelete}
                                ClassName={cl.cn}
                                error={cl.error}
                                setClass={this.setPrevClass}>
                                <label className="label_1">
                                    Class {cl.id}:{' '}
                                </label>{' '}
                            </ClassLine>
                        ))}

                        <button
                            className="add_button"
                            onClick={this.handlePreviousAdd}
                            type="button"
                        >
                            Add Another Class
                        </button>
                        <br />

                        <br />
                        <button className="submit_button" type="submit">
                            Submit{' '}
                        </button>
                        <label class="error">{this.formError}</label>
                    </div>
                </form>
            </div>
        );
    }
}
export default function(props)
{
    const navigate=useNavigate();
    return <EditProfile navigate={navigate}/>
};