import React from 'react';

import './Header.css';

// Header for the entire App
const Header = (props) => {
    return (
        <section className="header">
            <h1 className="header__logo">Bruin Study</h1>
            <div selection className="header__group">
                <a className="header__option" href="">
                    Login
                </a>
                <a className="header__option" href="">
                    Logout
                </a>
                <a className="header__option" href="">
                    <img
                        className="header__user_image"
                        src="https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png"
                        alt="user_icon"
                    />
                </a>
            </div>
        </section>
    );
};

export default Header;
