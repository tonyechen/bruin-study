import React from 'react';

import './Header.css';

// Header for the entire App
const Header = () => {
    return (
        <section className="header">
            <li className="header_logo">Bruin Study</li>
            <ul className='header_group'>
                <li className='header_option'>Login</li>
                <li className='header_option'>Logout</li>
                <li className='header_option'>Profile Pics/DropDown</li>
            </ul>
        </section>
    );
};

export default Header;
