import React, { useContext } from "react";
import { Link, NavLink } from "react-router-dom";
import { UserOutlined } from "@ant-design/icons";

import { AuthContext } from "../context/AuthContext";
import "./layout.css";

const Layout = () => {
  const { isLoggedIn, setIsLoggedIn } = useContext(AuthContext);

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    setIsLoggedIn(false);
  };

  return (
    <div className="nav-wrapper">
      {isLoggedIn ? (
        <>
          <NavLink
            to="/"
            className={({ isActive }) => (isActive ? "active-link" : "")}
          >
            Dashboard
          </NavLink>
          <NavLink
            to="/devices"
            className={({ isActive }) => (isActive ? "active-link" : "")}
          >
            Devices
          </NavLink>
          <NavLink
            to="/events"
            className={({ isActive }) => (isActive ? "active-link" : "")}
          >
            Events
          </NavLink>
          <NavLink
            to="/statistics"
            className={({ isActive }) => (isActive ? "active-link" : "")}
          >
            Statistics
          </NavLink>
          <div className="userNavigation">
            <NavLink
              to="/profile"
              className={({ isActive }) => (isActive ? "active-link" : "")}
            >
              <UserOutlined style={{ color: "white" }} />
            </NavLink>
            <Link href="/login" onClick={handleLogout}>
              Logout
            </Link>
          </div>
        </>
      ) : (
        <div className="userNavigation">
          <NavLink
            to="/login"
            className={({ isActive }) => (isActive ? "active-link" : "")}
          >
            Login
          </NavLink>
        </div>
      )}
    </div>
  );
};

export default Layout;
