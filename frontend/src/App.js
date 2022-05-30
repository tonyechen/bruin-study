import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Header from "./components/Header";
import Login from "./components/Login";
import Home from "./components/Home";
import editfile from "./components/Profile"
import Profile from "./components/ProfPage"
import Signup from "./components/Signup"
import Welcome from "./components/Welcome"
import About from "./components/About"

const App = () => {
  return ( 
    <Router>
      <div className="App">
        <Header />
          <Routes>
            <Route exact path="/" element={<Welcome/>}/>
            <Route exact path="/home" element={<Home/>}/>
            <Route exact path="/about" element={<About/>}/>
            <Route exact path="/login" element={<Login/>}/> 
            <Route exact path="/signup" element={<Signup/>}/> 
            <Route exact path="/profile" element={<Profile/>}/>
          </Routes>
      </div>
    </Router>
  )
};

export default App;
