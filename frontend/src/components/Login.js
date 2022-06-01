import React, { useState } from 'react';
import db from "../data/dataAccess";
import { useNavigate } from "react-router-dom";

  import "../login.css";

function Login() {
  // React States
  const [errorMessages, setErrorMessages] = useState({});
  const [isSubmitted, setIsSubmitted] = useState(false);
  const history = useNavigate();
  console.log(window.localStorage);

  const handleSubmit = async (event) => {
    //Prevent page reload
    event.preventDefault();

    var { uname, pass } = document.forms[0];

    var response = await db.Authenticate(uname.value, pass.value);

    if(response.success === true) 
    {
      window.localStorage.setItem("token", response.token);
      setIsSubmitted(true);
      history("/");
    }
    else
    {
      setErrorMessages({name: "login", message: "Login failed, check the username or password"});
    }
  };

  // Generate JSX code for error message
  const renderErrorMessage = (name) =>
    name === errorMessages.name && (
      <div className="error">{errorMessages.message}</div>
    );

  // JSX code for login form
  const renderForm = (
    <div className="form">
      <form onSubmit={handleSubmit}>
        <div className="input-container">
          <label>Username </label>
          <input type="text" name="uname" required />
        </div>
        <div className="input-container">
          <label>Password </label>
          <input type="password" name="pass" required />
        </div>
                {renderErrorMessage("login")}
        <div className="button-container">
          <input type="submit" />
        </div>
      </form>
    </div>
  );

  return (
    <div className="login">
      <div className="login-form">
        <div className="title">Sign In</div>
        {(window.localStorage.getItem("token") || isSubmitted) ? <div>User is already logged in</div> : renderForm}
      </div>
    </div>
  );
}

export default Login;