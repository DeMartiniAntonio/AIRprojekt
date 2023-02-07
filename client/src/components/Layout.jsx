import React from "react";
import { Link } from "react-router-dom";

import "./layout.css";

const Layout = () => {
  return (
    <div className="nav-wrapper">
      <Link to="/">Dashboard</Link>
      <Link to="/devices">Devices</Link>
      <Link to="/events">Events</Link>
      <Link to="/statistics">Statistics</Link>
    </div>
  );
};

export default Layout;
