import React, { Component, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {decodeToken} from "react-jwt"
import db from'../data/dataAccess.js'
import "./ProfPage.css"

class ClassLine extends Component
{
        state=
        {
            ClassName: this.props.ClassName
        }
    render ()
    {
    return(
        <div>
            {this.props.children}
            <label type="text">{this.props.ClassName}</label> 
        </div>
    )
    }
}
const mytoken = decodeToken(window.localStorage.getItem("token"));

let initialState=
{
uid: mytoken ? mytoken.id : '',
email: '',
bio:'',
username: '',
password: '',
name: '',
major: '',

emailError:'',
usernameError: '',
bioError: '',
nameError: '',
passwordError:'',
majorError:'',
formError:'',
MajorSuggestions: [],

CurrentClassList:[
],
PreviousClassList: [
]};
class Profile extends Component
{

    state=initialState;

    async componentDidMount()
    {
        const obj = await db.getFullProfile(this.state.uid);
        var ccl=[{id: 1,  cn: ""} ];
        var pcl=[{id: 1,  cn: ""} ];

        for (var i =0; i<obj.courseTaking.length; i++)
        {
            if (i==0)
            {
                ccl[i].cn=obj.courseTaking[i];
            }
            else
            {
                ccl = ccl.concat({id: i+1, cn:obj.courseTaking[i], error:""});
            }
        }
    
        for (var i =0; i<obj.courseTook.length; i++)
        {
            if (i==0)
            {
                pcl[i].cn=obj.courseTook[i];
            }
            else
            {
            pcl = pcl.concat({id: i+1, cn:obj.courseTook[i], error:""});
            }
        }
        this.setState(
            {
                email: obj.email,
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                CurrentClassList: ccl,
                PreviousClassList: pcl
            }
        )
}

handleClick = () =>
{
    let navigate= this.props.navigate
    navigate('/editProfile')
}
    render()
    {
        
       
        return(
            <div>
                <img
                    className = "userImage"
                    src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png"
                    alt="user_icon"
                />
                <button className = "buttStyle" onClick={this.handleClick}>Edit Profile</button>
                <br></br>
                <h1 className = "infoLabel">Name: </h1>
                <h1 className = "data_style">{this.state.name}</h1>
                <br/>

                <h1 className = "infoLabel">Email: </h1>
                <h1 className = "data_style">{this.state.email}</h1>
                <br/>

                <h1 className = "infoLabel">Username: </h1>
                <h1 className = "data_style">{this.state.username}</h1>
                <br/>


                <h1 className = "infoLabel">Major: </h1>
                <h1 className = "data_style">{this.state.major}</h1>
                <br/>

                <h1 className = "infoLabel">Current Classes</h1>
                {this.state.CurrentClassList.map(cl => <ClassLine key={cl.id} id={cl.id} ClassName={cl.cn}>
                <h1 className = "data_style">Class {cl.id}: </h1> </ClassLine>)}
                <br/>

                <h1 className = "infoLabel">Previous Classes</h1>   

                {this.state.PreviousClassList.map(cl => <ClassLine key={cl.id} id={cl.id} ClassName={cl.cn}>
                <h1 className = "data_style">Class {cl.id}: </h1> </ClassLine>)}
                <br/>

                <h1 className = "infoLabel">Bio: </h1>
                <h1 className = "data_style">{this.state.bio}</h1>
                <br/>
            </div>
        );
    }
}
export default function(props)
{
    const navigate=useNavigate();
    return <Profile navigate={navigate}/>
}