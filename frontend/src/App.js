import React from "react";
import { BrowserRouter as Router, Route, Routes } from "react-router-dom";
import Header from "./components/Header";
import Login from "./components/Login";
import Home from "./components/Home"
const App = () => {
  return ( 
    <Router>
      <div className="App">
        <Header />
        <div className="content">
          <Routes>
            <Route exact path="/" element={<Home/>}/>
            <Route exact path="/login" element={<Login/>}/> 
          </Routes>
        </div>
      </div>
    </Router>
  )
};

export default App;
