import React from 'react';
import Home from './components/Home';
import Login from './components/Login';
import About from './components/About';
import Header from './components/Header';
import Signup from './components/Signup';
import Welcome from './components/Welcome';
import Profile from './components/ProfPage';
import EditProfile from './components/Profile'
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';

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
