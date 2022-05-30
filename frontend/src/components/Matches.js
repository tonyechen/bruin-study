import React, { Component, useState } from 'react'
import db from'../data/dataAccess.js'
class UserLine extends Component
{
    render()
    {
        return(
        <div>
        <label>{this.props.username} ({this.props.name}) </label>    
        </div>
        )
    }
}
class MatchList extends Component
{
    state=
    {
        uid: 222222222,
        Matches: []
    };
    async componentDidMount()
    {
       let MatchObject= [111111111, 333333333]; 
       let Matches=[];
       for (var i=0; i<MatchObject.length;i++)
       {
           let obj = await db.getFullProfile(MatchObject[i]);
           let MatchElement={uid: MatchObject[i], name: obj.name, uname: obj.username};
           Matches = Matches.concat(MatchElement);
       }
       this.setState
       ({
        Matches: Matches
       })
    }
    render ()
    {
        console.log(this.state)
        return(
        <div>
         {this.state.Matches.map(ul => <UserLine key={ul.uid} username={ul.uname} name={ul.name}/>)}    
        </div>
        );
    }

}
export default MatchList;