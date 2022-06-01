import React, { useState, useEffect } from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Header from './components/Header';
import Login from './components/Login';
import Home from './components/Home';
import EditProfile from './components/Profile'
import Profile from './components/ProfPage';
import Signup from './components/Signup';
import Welcome from './components/Welcome';
import About from './components/About';

const App = () => {

    return (
        <Router>
            <div className="App">
                <Header />
                <Routes>
                    <Route path="/" element={<Welcome />} />
                    <Route path="/home" element={<Home />} />
                    <Route path="/about" element={<About />} />
                    <Route path="/login" element={<Login />} />
                    <Route path="/signup" element={<Signup />} />
                    <Route path="/profile" element={<Profile />} />
                    <Route path="/profile/:id" element={<Profile />} />
                    <Route path="/editProfile" element={<EditProfile />} />
                </Routes>
            </div>
        </Router>
    );
};

export default App;
