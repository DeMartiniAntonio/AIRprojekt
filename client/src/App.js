import { BrowserRouter, Routes, Route } from "react-router-dom";

import Layout from "./components/Layout";
import Home from "./pages";
import Devices from "./pages/devices";
import Events from "./pages/events";
import Statistics from "./pages/statistics";

function App() {
  return (
    <BrowserRouter>
      <Layout />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/devices" element={<Devices />} />
        <Route path="/events" element={<Events />} />
        <Route path="/statistics" element={<Statistics />} />
      </Routes>
    </BrowserRouter>
  );
}

export default App;
