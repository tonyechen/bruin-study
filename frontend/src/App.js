import React, { useState, useEffect } from "react";
import { BrowserRouter as Router, Route, Routes, Navigate } from "react-router-dom";
import Header from "./components/Header";
import Login from "./components/Login";
import Home from "./components/Home";
import editProfile from "./components/Profile"
import Profile from "./components/ProfPage"
import Signup from "./components/Signup"
import Welcome from "./components/Welcome"
import About from "./components/About"

const App = () => {
  const [loggedIn, setLoggedin] = useState(false);

  useEffect(() => {
    setLoggedin((window.localStorage.getItem("token")) ? true : false);
    console.log("test");
    console.log(loggedIn);
  });

  return ( 
    <Router>
      <div className="App">
        <Header />
          <Routes>
            <Route path="/" element={window.localStorage.getItem("token") ? (<Home/>) : (<Welcome/>)}/>
            <Route path="/about" element={<About/>}/>
            <Route path="/login" element={<Login/>}/> 
            <Route path="/signup" element={<Signup/>}/> 
            <Route path="/profile" element={<Profile/>}/>
          </Routes>
      </div>
    </Router>
  )
};

export default App;
