import React from "react";
import {decodeToken} from "react-jwt";
function Home() {
    const mytoken = decodeToken(window.localStorage.getItem("token"));
    return (
        <div>{mytoken ? <div>{mytoken.id}</div> : <div>Home</div>}</div>
    )
}

export default Home;