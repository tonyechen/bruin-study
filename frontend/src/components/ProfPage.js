import React, { Component, useState } from 'react'
import db from'../data/dataAccess.js'


class ClassLine extends Component
{
    state=
    {
        ClassName: this.props.ClassName
    }
    render()
    {
        return(
            <div>
            <label>{this.props.ClassName}</label>
        </div>
        )
    }
}
let initialState=
{
uid: 111111111,
email: '',
bio:'',
username: '',
name: '',
major: '',

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
        this.setState(
            {
                email: obj.email,
                bio: obj.introduction,
                username: obj.username,
                name: obj.name,
                major: obj.major,
                CurrentClassList: obj.courseTaking,
                PreviousClassList: obj.CourseTook
            }
        )
    }
    render()
    {
        
       
        return(
            
            <div className='center'>
            <h1 className='header_1'>Edit Profile</h1>
                <div>
                    <label className='label_1'>UID: {this.state.uid}</label>
                    <br/>

                    <label className='label_1'>Name: {this.state.name}</label>
                    <br/>

           ż        <label className='label_1'>Email: {this.state.email}</label>
                    <br/>

                    <label className='label_1'>Username: {this.state.username}</label>
                    <br/>


                    <label className='label_1'>Major: {this.state.major}</label>
                    <br/>

                    <dl className='class_headers'>Current Classes</dl>
                    {this.state.CurrentClassList.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handleCurrentDelete} ClassName={cl.cn} error={cl.error} setClass={this.setCurrClass}>
                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}
                    <button className='add_button' onClick={this.handleCurrentAdd} type="button">Add Another Class</button>
                    <br/>

                    <dl className='class_headers'>Previous Classes</dl>   
                    {this.state.PreviousClassList.map(cl => <ClassLine key={cl.id} id={cl.id} ClassName={cl.cn}>
                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}
                    <br/>

                    <label className='label_1'>Bio: </label>
                    <p value={this.state.bio}/>

                    <br/>
                    <button>Edit Profile</button>
                </div>
            </div>
        );
    }
}
export default Profile;