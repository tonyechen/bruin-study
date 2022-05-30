import './Header.css';
import React from 'react';
import {Link} from 'react-router-dom';

// Header for the entire App
const Header = (props) => {
    return (
        <header className="header">
            <Link className="header__logo" to="/">Bruin Study</Link>
            <div className="header__group">
                <Link className = "header__option" to="/about">
                    About
                </Link>
                <Link className = "header__option" to="/login">
                    Login
                </Link>
                <Link className = "header__option" to="/signup">
                    Logout
                </Link>
                <Link className = "header__option" to="/profile">
                    <img
                        className="header__user_image"
                        src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png"
                        alt="user_icon"
                    />
                </Link>
            </div>
        </header>
    );
};

export default Header;
