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
               <button onClick={()=>this.props.onDelete(this.props.id)}>
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

export default ClassList;