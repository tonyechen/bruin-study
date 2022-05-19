import React from 'react';

import './Header.css';
import {Link} from 'react-router-dom';

// Header for the entire App
const Header = (props) => {
    return (
        <section className="header">
            <Link className="header__logo" to="/">Bruin Study</Link>
            <div className="header__group">
                <Link  to="/login">
                    Login
                </Link>
                <Link to="/signup">
                    Logout
                </Link>
                <Link to="/profile">
                    <img
                        className="header__user_image"
                        src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png"
                        alt="user_icon"
                    />
                </Link>
            </div>
        </section>
    );
};

export default Header;
