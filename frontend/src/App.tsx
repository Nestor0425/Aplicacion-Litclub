import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import Logs from "./pages/Logs";

const App = () => {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Ruta raíz redirige a /login */}
          <Route path="/" element={<Navigate to="/login" replace />} />
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/logs" element={<Logs />} /> {/* ✅ Nueva ruta de logs */}
        </Routes>
      </Router>
    </AuthProvider>
  );
};

export default App;
