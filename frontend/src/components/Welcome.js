import React from 'react';
import { Link } from 'react-router-dom';
import './Welcome.css';

//MOVE FETCH OUTSIDE OF DISPLAY STUDENT TO PREVENT CONSTANT FETCHES
class Welcome extends React.Component {
    render() {
        return (
            <div class="container">
                <h1 className="txtStyle">WELCOME</h1>
                <div clasName="welcome-center">
                    <Link className="getStarted" to="/signup">
                        GET STARTED
                    </Link>
                    <Link className="login_button" to="/login">
                        LOGIN
                    </Link>
                </div>
            </div>
        );
    }
}

export default Welcome;
