import './Header.css';
import React from 'react';
import { Link, useNavigate } from 'react-router-dom';

// Header for the entire App
const Header = (props) => {
    const history = useNavigate();
    const token = window.localStorage.getItem('token');

    function handleClick() {
        window.localStorage.removeItem('token');
        history('/');
        window.location.reload();
    }

    return (
        <header className="header">
            <Link
                className="header__logo"
                to={window.localStorage.getItem('token') ? '/home' : '/'}
            >
                Bruin Study
            </Link>
            <div className="header__group">
                <Link className="header__option" to="/about">
                    About
                </Link>
                {!token && (
                    <Link className="header__option" to="/login">
                        Login/Signup
                    </Link>
                )}
                {token && (
                    <a className="header__option" onClick={handleClick}>
                        Logout
                    </a>
                )}
                <Link className="header__option" to="/profile">
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
