import React from "react";
import { BrowserRouter as Router, Route, Routes, useNavigate } from "react-router-dom";
import Header from "./components/Header";
import Login from "./components/Login";
import Home from "./components/Home";
import Profile from "./components/Profile"
import Signup from "./components/Signup"

const App = () => {
  // const history = useNavigate();
  return ( 
    <Router>
      <div className="App">
        <div className="navbad">
          <Header />
        </div>
        <div className="content">
          <Routes>
            <Route exact path="/" element={<Home/>}/>
            <Route exact path="/login" element={<Login/>}/> 
            <Route exact path="/signup" element={<Signup/>}/> 
            <Route exact path="/profile" element={<Profile/>}/>
          </Routes>
        </div>
      </div>
    </Router>
  )
};

export default App;
