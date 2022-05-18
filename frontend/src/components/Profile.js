import React, { Component, useState } from 'react'
import * as EmailValidator from 'email-validator';
import './Profile.css'
import Classes from './Classes';


/*class ClassLine extends Component
{
    state = {
        ClassName: this.props.ClassName,
    };
    handleChange = (e) =>
    {
        this.setState( {[e.target.name]: e.target.value} );
    }
    render()
    {
        console.log(this.props.error)
        const {ClassName}=this.state;
        return(
            <div>
              {this.props.children}
              <input type="text" 
                     name="ClassName"
                     placeholder= "Class Name " 
                     ClassName="class_input"
                     value={ClassName} 
                     onChange={this.handleChange}/>
               <button onClick={()=>this.props.onDelete(this.props.id)} type="button">
                   Delete Class
               </button>
               <label>{this.props.error}</label>
            </div>
        );
    }
}*/
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
          ClassName: value})   
    }
    suggestionSelected(value)
    {
        this.setState({
           ClassName: value,
           suggestions: [],
            })
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


const initialState=
{
email: '',
bio:'',
emailError:'',
bioError: '',
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
    state=initialState

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
            const CurrentClassList = this.state.CurrentClassList.concat({id: x, cn:"",error:""});
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
            const PreviousClassList = this.state.PreviousClassList.concat({id: x, cn:"", error:""});
            this.setState({PreviousClassList: PreviousClassList});
    }
    validate = () => 
    {
        var check=true;
        let bioError="";
        if (this.state.bio==="")
        {
            bioError="Must fill in a bio";
            check=false;
        }
        let emailError="";
        if (this.state.email==="")
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
        }
        for(var i=0; i<this.state.CurrentClassList.length;i++)
        {
            if (this.state.CurrentClassList[i].cn=="")
            {
                
                this.state.CurrentClassList[i].error="Must fill in class name";
                check=false;
            }
        }
        this.setState({
            emailError: emailError,
            bioError: bioError,
        });
        return check;
            
        
    }
    handleSubmit= e =>
    {
        e.preventDefault();
        const isValid=this.validate();
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
                    <label className='label_1'>Name: Aditya Mehta</label>
                    <br/>
                    <label className='label_1'>Email: </label>
                    <input type="text" value={this.state.email} onChange={this.handleEmailChange}/>
                    <label>{this.state.emailError}</label>
                    <br/>

                    <dl className='class_headers'>Current Classes</dl>
                    {this.state.CurrentClassList.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handleCurrentDelete} ClassName={cl.cn} error={cl.error}>
                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}
                    <button className='add_button' onClick={this.handleCurrentAdd} type="button">Add Another Class</button>
                    <br/>

                    <dl className='class_headers'>Previous Classes</dl>   
                    {this.state.PreviousClassList.map(cl => <ClassLine key={cl.id} id={cl.id} onDelete={this.handlePreviousDelete} ClassName={cl.cn} error={cl.error}>
                    <label className='label_1'>Class {cl.id}: </label> </ClassLine>)}
                    <button className='add_button'onClick={this.handlePreviousAdd} type="button">Add Another Class</button>
                    <br/>

                    <label className='label_1'>Bio: </label>
                    <textarea  value={this.state.bio} onChange={this.handleBioChange}/>
                    <label>{this.state.emailError}</label>

                    <br/>
                    <button type="submit">Submit </button>
                </div>
            </form>
            </div>
        );
    }
}
export default editProfile;