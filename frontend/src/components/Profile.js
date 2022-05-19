import React, { Component, useState } from 'react'
import * as EmailValidator from 'email-validator';
import './Profile.css'
import Classes from '../data/Classes';

class ClassLine extends Component
{
    constructor(props)
    {
        super(props)
        this.items=Classes;
        this.state=
        {
            suggestions: [],
            ClassName: this.props.ClassName
        }
    }
    handleChange  = (e) =>
    {
      const value=e.target.value;
      let suggestions=[];
      if (value.length>0)
      {
          const regex = new RegExp(`^${value}`,'i');
          suggestions=this.items.sort().filter(v => regex.test(v));
      }
      this.setState({
          suggestions: suggestions,
          ClassName: value});
          this.props.setClass(this.props.id,e.target.value); 
    }
    suggestionSelected(value)
    {
        this.setState({
           suggestions: [],
           ClassName: value
            });
        this.props.setClass(this.props.id,value);
    }
    renderSuggestions()
    {
        const {suggestions}=this.state
        if (suggestions.length === 0)
        {
            return null;
        }
        return(
            <ul>
                {suggestions.map((item) => <li onClick={() => this.suggestionSelected(item)}>{item}</li>)}
            </ul>
        )
    }
    render ()
    {
    const {ClassName}=this.state
    return(
        <div>
            {this.props.children}
            <input type="text" 
                    name="ClassName"
                    placeholder= "Class Name" 
                     value={ClassName} 
                     onChange={this.handleChange}/>
            {this.renderSuggestions()}
            <button onClick={()=>this.props.onDelete(this.props.id)} type="button">
                   Delete Class
               </button>
               <label>{this.props.error}</label>
        </div>
    )
    }
}

let initialState=
{
email: '',
bio:'',
username: '',
password: '',
name: '',

emailError:'',
usernameError: '',
bioError: '',
nameError: '',
passwordError:'',

CurrentClassList:[
    {id: 1,  cn: "", error: ""},
    {id: 2, cn: "", error: ""},
    {id: 3, cn: "", error: ""},
    {id: 4, cn: "", error: ""}
],
PreviousClassList: [
    {id: 1,  cn: "", error: ""},
    {id: 2, cn: "", error: ""},
    {id: 3, cn: "", error: ""},
    {id: 4, cn: "", error: ""}
]
};



class editProfile extends Component
{
    state=initialState;

    handleUsernameChange =(e) =>
    {
        this.setState({username: e.target.value});
    }
    handlePasswordChange =(e) =>
    {
        this.setState({password: e.target.value});
    }
    handleNameChange =(e) =>
    {
        this.setState({name: e.target.value});
    }

    handleEmailChange = (e) =>
    {
        this.setState({email: e.target.value});
    }
    handleBioChange = (e) =>
    {
        this.setState({bio: e.target.value});
    }
    handleCurrentDelete=(whichID)=>
    {
        if(this.state.CurrentClassList.length>1)
        {
            let CurrentClassList=this.state.CurrentClassList.filter(c => c.id!== whichID);
            for(var i=0; i<CurrentClassList.length;i++)
            {
                CurrentClassList[i].id=1+i;
            }
            this.setState({CurrentClassList: CurrentClassList});
        }
    }
    handleCurrentAdd=()=>
    {
        if (this.state.CurrentClassList.length<10)
        {
            var x= this.state.CurrentClassList[this.state.CurrentClassList.length-1].id+1;
            let CurrentClassList = this.state.CurrentClassList.concat({id: x, cn:"",error:""});
            this.setState({CurrentClassList: CurrentClassList});
        }
    }
    handlePreviousDelete=(whichID)=>
    {
        if(this.state.PreviousClassList.length>1)
        {
            let PreviousClassList=this.state.PreviousClassList.filter(c => c.id!== whichID);
            for(var i=0; i<PreviousClassList.length;i++)
            {
                PreviousClassList[i].id=1+i;
            }
            this.setState({PreviousClassList: PreviousClassList});
        }
    }
    handlePreviousAdd=()=>
    {
            var x= this.state.PreviousClassList[this.state.PreviousClassList.length-1].id+1;
            let PreviousClassList = this.state.PreviousClassList.concat({id: x, cn:"", error:""});
            this.setState({PreviousClassList: PreviousClassList});
    }
    //Validates information on submit
    validate = () => 
    {
        var check=true;

        let passwordError="";
        if (this.state.password=="")
        {
            passwordError="Must enter a password";
            check=false;
        }
        let nameError ="";
        if (this.state.name=="")
        {
            nameError="Must fill in a name";
            check=false;
        }
        console.log(nameError)
        let bioError="";
        if (this.state.bio=="")
        {
            bioError="Must fill in a bio";
            check=false;
        }
        let emailError="";
        if (this.state.email=="")
        {
            emailError="Must fill in email";
            check=false;
        }
        else if(!EmailValidator.validate(this.state.email))
        {
            emailError="Must fill in a valid email";
            check=false;
        }

        for(var i=0; i<this.state.PreviousClassList.length;i++)
        {
            if (this.state.PreviousClassList[i].cn=="")
            {
                this.state.PreviousClassList[i].error="Must fill in class name";
                check=false;
            }
            else if (!Classes.includes(this.state.PreviousClassList[i].cn))
            {
                this.state.PreviousClassList[i].error="Not a UCLA class";
                check=false;
            }
            else
            {
                this.state.PreviousClassList[i].error="";
            }
        }
        for(var i=0; i<this.state.CurrentClassList.length;i++)
        {
            if (this.state.CurrentClassList[i].cn=="")
            {
                
                this.state.CurrentClassList[i].error="Must fill in class name";
                check=false;
            }
            else if (!Classes.includes(this.state.CurrentClassList[i].cn))
            {
                this.state.CurrentClassList[i].error="Class not in list";
                check=false;
            }
            else
            {
                this.state.CurrentClassList[i].error="";
            }
        }
        this.setState({
            emailError: emailError,
            bioError: bioError,
            nameError: nameError,
            passwordError: passwordError
        });
        return check;
    }
    setCurrClass = (id,ClassName) =>
    {
        let currClass=this.state.CurrentClassList;
        currClass[id-1].cn=ClassName
        this.setState({CurrentClassList: currClass});

    }
    setPrevClass = (id,ClassName) =>
    {
        let prevClass=this.state.PreviousClassList;
        prevClass[id-1].cn=ClassName
        this.setState({PreviousClassList: prevClass});

    }
    handleSubmit= e =>
    {
        e.preventDefault();
        let validate=this.validate();
        console.log(this.state);
    };
    render()
    {
        const {ClassName}=this.state;
        return(
            
            <div className='center'>
            <h1 className='header_1'>Edit Profile</h1>
            <form onSubmit={this.handleSubmit}>
                <div>
                    <label className='label_1'>UID: 999999999</label>
                    <br/>

                    <label className='label_1'>Name: </label>
                    <input type="text" value={this.state.name} onChange={this.handleNameChange}/>
                    <label>{this.state.nameError}</label>
                    <br/>

                    <label className='label_1'>Email: </label>
                    <input type="text" value={this.state.email} onChange={this.handleEmailChange}/>
                    <label>{this.state.emailError}</label>
                    <br/>

                    <label className='label_1'>Username: </label>
                    <input type="text" value={this.state.username} onChange={this.handleUsernameChange}/>
                    <br/>

                    <label className='label_1'>New Password: </label>
                    <input type="password" value={this.state.password} onChange={this.handlePasswordChange}/>
                    <label>{this.state.passwordError}</label>
                    <br/>

                    <dl className='class_headers'>Current Classes</dl>
                    {this.state.CurrentClassList.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handleCurrentDelete} ClassName={cl.cn} error={cl.error} setClass={this.setCurrClass}>
                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}
                    <button className='add_button' onClick={this.handleCurrentAdd} type="button">Add Another Class</button>
                    <br/>

                    <dl className='class_headers'>Previous Classes</dl>   

                    {this.state.PreviousClassList.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handlePreviousDelete} ClassName={cl.cn} error={cl.error} setClass={this.setPrevClass}>

                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}

                    <button className='add_button'onClick={this.handlePreviousAdd} type="button">Add Another Class</button>
                    <br/>

                    <label className='label_1'>Bio: </label>
                    <textarea  value={this.state.bio} onChange={this.handleBioChange}/>
                    <label>{this.state.bioError}</label>

                    <br/>
                    <button type="submit">Submit </button>
                </div>
            </form>
            </div>
        );
    }
}
export default editProfile;