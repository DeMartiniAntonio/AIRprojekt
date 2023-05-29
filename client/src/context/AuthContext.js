import React, { createContext, useState, useEffect } from "react";

const AuthContext = createContext();

const AuthProvider = (props) => {
  const [isLoggedIn, setIsLoggedIn] = useState("pending");

  useEffect(() => {
    if (localStorage.getItem("token") !== null) {
      setIsLoggedIn(true);
    } else {
      setIsLoggedIn(false);
    }
  }, []);

  return (
    <AuthContext.Provider value={{ isLoggedIn, setIsLoggedIn }}>
      {props.children}
    </AuthContext.Provider>
  );
};

export { AuthContext, AuthProvider };
