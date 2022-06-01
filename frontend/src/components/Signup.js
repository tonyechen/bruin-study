import db from '../data/dataAccess';
import Majors from '../data/Majors.js';
import React, { useState } from 'react';
import { useNavigate, Link } from "react-router-dom";

  function Signup() {
    const items = Majors;
    const [errorMessages, setErrorMessages] = useState({});
    const [isSubmitted, setIsSubmitted] = useState(false);
    const history = useNavigate();
    const [suggestions, setSuggestions] = useState([]);
    const [major, setMajor] = useState('');
    const validEmail = new RegExp(
        '^[a-zA-Z0-9._:$!%-]+@[a-zA-Z0-9.-]+.[a-zA-Z]$'
     );

     const validID = new RegExp(
        '^[0-9]{9}$'
     );

     const handleChange = (e) => {
      const value = e.target.value;
      let suggestions = [];
      if (value.length > 0) {
          const regex = new RegExp(`^${value}`, 'i');
          suggestions = items.sort().filter((v) => regex.test(v));
      }
      setMajor(e.value)
      setSuggestions(suggestions);
  };
  const suggestionSelected = (value) => {
      setSuggestions([]);
      setMajor(value);
  }
    async function handleSubmit(event) {
        //Prevent page reload
        event.preventDefault();

        var { id, email, name, major, username, pass, confirmpass } = document.forms[0];

        if(pass.value !== confirmpass.value) 
        {
            setErrorMessages({name: "confirmpass", message: "Passwords do not match"});
            return;
        }   

        if(!validID.test(id.value)) 
        {
            setErrorMessages({name: "id", message: "Invalid ID"});
            return;
        }

        if(!validEmail.test(email.value)) 
        {
            setErrorMessages({name: "email", message: "Invalid Email"});
            return;
        }

        var response = await db.createProfile(id.value, email.value, username.value, name.value, major.value, '', pass.value);
        
        if(response.success === false)
        {
            setErrorMessages({name: "signupfail", message: "Signup failed, try again or with different values"});
        }
        else if(response.success === true)
        {
          var response = await db.Authenticate(username.value, pass.value);
          if(response.success === true) 
          {
            window.localStorage.setItem("token", response.token);
            setIsSubmitted(true);
            history("/editProfile");
          }
          else
          {
            setErrorMessages({name: "signupfail", message: "Auto-log in failed, try logging in manually"});
          }
        }
        else
        {
          setErrorMessages({name: "signupfail", message: "Unknown error"});
        }
    }

    const renderErrorMessage = (name) =>
    name === errorMessages.name && (
      <div className="error">{errorMessages.message}</div>
    );

    function renderSuggestions() {
      const suggestions2 = suggestions;
      if (suggestions2.length === 0) {
          return null;
      }
      return (
          <ul className="majors">
              {suggestions2.map((item) => (
                  <li onClick={() => suggestionSelected(item)}>
                      {item}
                  </li>
              ))}
          </ul>
      );
  }
    const renderForm = (
        <div className="form">
          <form onSubmit={handleSubmit}>
            <div className="input-container">
              <label>UCLA ID </label>
              <input type="text" name="id" required />
            </div>
            {renderErrorMessage("id")}
            <div className="input-container">
              <label>Email </label>
              <input type="text" name="email" required />
            </div>
            {renderErrorMessage("email")}
            <div className="input-container">
              <label>Name </label>
              <input type="text" name="name" required />
            </div>
            <div className="input-container">
              <label>Major </label>
              <input type="text" name="major" onChange={handleChange} value={major} required />
              {renderSuggestions()}
            </div>
            <div className="input-container">
              <label>Username </label>
              <input type="text" name="username" required />
            </div>
            <div className="input-container">
              <label>Password </label>
              <input type="password" name="pass" required />
            </div>
            <div className="input-container">
              <label>Confirm Password </label>
              <input type="password" name="confirmpass" required />
              {renderErrorMessage("confirmpass")}
            </div>
            {renderErrorMessage("signupfail")}
            <div className="button-container">
              <input type="submit" />
            </div>
          </form>
        </div>
      );
    return (
      <div className="login">
        <div className="login-form">
          <div className="title">Sign Up</div>
            {isSubmitted ? <div>User is successfully signed up</div> : renderForm}
        </div>
        <Link to="/login">
            Login
        </Link>
      </div>
    );
  }

  export default Signup;