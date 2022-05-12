import React, { Component, useState } from 'react'
import './Profile.css'


class ClassLine extends Component
{
    state = {
        ClassName: this.props.ClassName
    };
    handleChange = (e) =>
    {
        this.setState( {[e.target.name]: e.target.value} );
    }
    render()
    {
        const {ClassName}=this.state;
        return(
            <div>
              {this.props.children}
              <input type="text" 
                     name="ClassName" 
                     value={ClassName} 
                     onChange={this.handleChange}/>
               <button onClick={()=>this.props.onDelete(this.props.id)} type="button">
                   Delete Class
               </button>
            </div>
        );
    }
}
class ClassList extends Component
{
    state={
        classlist: [
            {id: 1,  cn: ""},
            {id: 2, cn: ""},
            {id: 3, cn: ""},
            {id: 4, cn: ""}
        ]
    };
    handleDelete=(whichID)=>
    {
        if(this.state.classlist.length>1)
        {
            let classlist=this.state.classlist.filter(c => c.id!== whichID);
            for(var i=0; i<classlist.length;i++)
            {
                classlist[i].id=1+i;
            }
            this.setState({classlist: classlist});
        }
    }
    handleAdd=()=>
    {
        if (this.state.classlist.length<10)
        {
            var x= this.state.classlist[this.state.classlist.length-1].id+1;
            const classlist = this.state.classlist.concat({id: x, cn:""});
            this.setState({classlist: classlist});
        }
    }

    render() {
        return (
        <div>
            {this.state.classlist.map(cl => 
            <ClassLine key={cl.id} id={cl.id} onDelete={this.handleDelete} ClassName={cl.cn}>
                <label>Class {cl.id}: </label>
            </ClassLine>
            )}
            <button onClick={this.handleAdd}>Add Another Class</button>
        </div>
        )
    }
}

class editProfile extends Component
{
    state={
        email: '',
        bio:'',
        classlist: [
            {id: 1,  cn: ""},
            {id: 2, cn: ""},
            {id: 3, cn: ""},
            {id: 4, cn: ""}
        ]
        
    };
    handleEmailChange = (e) =>
    {
        this.setState({email: e.target.value});
    }
    handleBioChange = (e) =>
    {
        this.setState({bio: e.target.value});
    }
    handleDelete=(whichID)=>
    {
        if(this.state.classlist.length>1)
        {
            let classlist=this.state.classlist.filter(c => c.id!== whichID);
            for(var i=0; i<classlist.length;i++)
            {
                classlist[i].id=1+i;
            }
            this.setState({classlist: classlist});
        }
    }
    handleAdd=()=>
    {
        if (this.state.classlist.length<10)
        {
            var x= this.state.classlist[this.state.classlist.length-1].id+1;
            const classlist = this.state.classlist.concat({id: x, cn:""});
            this.setState({classlist: classlist});
        }
    }
    handleSubmit=()=>
    {
        alert(`${this.state.email} ${this.state.bio} ${this.state.classlist}`)
    }
    render()
    {
        const {ClassName}=this.state;
        return(
            
            <div>
            <h1>Edit Profile</h1>
            <form onSubmit={this.handleSubmit}>
                <div>
                    <label>UID: 999999999</label>
                    <br/>
                    <label>Name: Aditya Mehta</label>
                    <br/>
                    <label>Email: </label>
                    <input type="text" value={this.state.email} onChange={this.handleEmailChange}/>
                    <br/>
                    <label>Bio: </label>
                    <textarea  value={this.state.bio} onChange={this.handleBioChange}/>
                    {this.state.classlist.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handleDelete} ClassName={cl.cn}>
                    <label>Class {cl.id}: </label> </ClassLine>)}
                    <button onClick={this.handleAdd} type="button">Add Another Class</button>
                    <br/>
                    <button type="submit">Submit </button>
                </div>
            </form>
            </div>
        );
    }
}
export default editProfile;