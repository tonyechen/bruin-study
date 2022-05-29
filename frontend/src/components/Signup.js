import react, { Profiler, useState } from 'react';
import createProfile from '../data/dataAccess';
import {
    Redirect
  } from "react-router-dom";

  function Signup() {
    const [errorMessages, setErrorMessages] = useState({});
    const [isSubmitted, setIsSubmitted] = useState(false);
    
    function handleSubmit(event) {
        //Prevent page reload
        event.preventDefault();

        var { id, email, name, major, username, pass, confirmpass } = document.forms[0];

        if(pass.value !== confirmpass.value) 
        {
            setErrorMessages({name: "confirmpass", message: "Passwords do not match"});
            return;
        }   
        
        var response = createProfile(id.value, email.value, username.value, name.value, major.value, '', pass.value);
        if(response.success === false)
        {
            setErrorMessages({name: "signupfail", message: "Signup failed, try again or with different values"});
        }
        else
        {
            setIsSubmitted(true);
            <Redirect to="/login"/>
        }
    }

    const renderErrorMessage = (name) =>
    name === errorMessages.name && (
      <div className="error">{errorMessages.message}</div>
    );

    const renderForm = (
        <div className="form">
          <form onSubmit={handleSubmit}>
            <div className="input-container">
              <label>UCLA ID </label>
              <input type="text" name="id" required />
            </div>
            <div className="input-container">
              <label>Email </label>
              <input type="text" name="email" required />
            </div>
            <div className="input-container">
              <label>Name </label>
              <input type="text" name="name" required />
            </div>
            <div className="input-container">
              <label>Major </label>
              <input type="text" name="major" required />
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
      <div className="app">
        <div className="login-form">
          <div className="title">Sign In</div>
            {isSubmitted ? <div>User is successfully logged signed up</div> : renderForm}
        </div>
      </div>
    );
  }

  export default Signup;