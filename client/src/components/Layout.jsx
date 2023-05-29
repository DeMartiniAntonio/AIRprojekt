import React, { useContext } from "react";
import { Link } from "react-router-dom";

import { AuthContext } from "../context/AuthContext";
import "./layout.css";

const Layout = () => {
  const { isLoggedIn, setIsLoggedIn } = useContext(AuthContext);

  const handleLogout = () => {
    localStorage.removeItem("token");
    setIsLoggedIn(false);
  };

  return (
    <div className="nav-wrapper">
      {isLoggedIn ? (
        <>
          <Link to="/">Dashboard</Link>
          <Link to="/devices">Devices</Link>
          <Link to="/events">Events</Link>
          <Link to="/statistics">Statistics</Link>
          <Link href="/login" onClick={handleLogout}>
            Logout
          </Link>
        </>
      ) : (
        <Link to="/login">Login</Link>
      )}
    </div>
  );
};

export default Layout;
