import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { useContext } from "react";

import { AuthContext } from "./context/AuthContext";
import Layout from "./components/Layout";
import Home from "./pages";
import Devices from "./pages/devices";
import Events from "./pages/events";
import Statistics from "./pages/statistics";
import Login from "./pages/login";

function App() {
  const { isLoggedIn } = useContext(AuthContext);

  return (
    <BrowserRouter>
      <Layout />
      {isLoggedIn ? (
        <Routes>
          <Route path="/" element={<Home />} />
          <Route path="/devices" element={<Devices />} />
          <Route path="/events" element={<Events />} />
          <Route path="/statistics" element={<Statistics />} />
          <Route path="/*" element={<Navigate to="/" />} />
        </Routes>
      ) : (
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/*" element={<Navigate to="/login" />} />
        </Routes>
      )}
    </BrowserRouter>
  );
}

export default App;
