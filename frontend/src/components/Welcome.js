import React from "react";
import {Link} from 'react-router-dom';
import "./Welcome.css";

class Welcome extends React.Component {

    render() {
        return(
        <div class = "container">
        <img 
            className = "imgStyle"
            src = "https://s3.amazonaws.com/cms.ipressroom.com/173/files/20198/5d72b4772cfac209ff04c634_Royce+Quad/Royce+Quad_hero.jpg"
        />
        <h1 className = "txtStyle">WELCOME</h1>
        <button class="login" onClick = {() => this.handleClick("Login")}>LOGIN</button>
        <Link className = "getStarted" to="/signup">
            GET STARTED
        </Link>
        <Link className = "login" to="/login">
            LOGIN
        </Link>
        </div>
        )
    }
}

export default Welcome;