// import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
// import { AuthProvider } from "./context/AuthContext";
// import Login from "./pages/Login";
// import Register from "./pages/Register";
// import Dashboard from "./pages/Dashboard";
// import Logs from "./pages/Logs";


// const App = () => {
//   return (
//     <AuthProvider>
//       <Router>
//         <Routes>
//           {/* Ruta raíz redirige a /login */}
//           <Route path="/" element={<Navigate to="/login" replace />} />
//           <Route path="/login" element={<Login />} />
//           <Route path="/register" element={<Register />} />
//           <Route path="/dashboard" element={<Dashboard />} />
//           <Route path="/logs" element={<Logs />} /> {/* ✅ Nueva ruta de logs */}
//         </Routes>
//       </Router>
//     </AuthProvider>
//   );
// };

// export default App;
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider, AuthContext } from "./context/AuthContext";
import { JSX, useContext } from "react";
import { ThemeProvider, CssBaseline } from "@mui/material";
import theme from "./theme";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import Logs from "./pages/Logs";
import Navbar from "./components/Navbar";

// ✅ Componente de Rutas Protegidas
const ProtectedRoute = ({ element }: { element: JSX.Element }) => {
  const auth = useContext(AuthContext);
  return auth?.user ? element : <Navigate to="/login" replace />;
};

const App = () => {
  return (
    <AuthProvider>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <Router>
          <Navbar />
          <Routes>
            <Route path="/" element={<Navigate to="/login" replace />} />
            <Route path="/login" element={<Login />} />
            <Route path="/register" element={<Register />} />
            {/* ✅ Rutas protegidas */}
            <Route path="/dashboard" element={<ProtectedRoute element={<Dashboard />} />} />
            <Route path="/logs" element={<ProtectedRoute element={<Logs />} />} />
            {/* ❌ Ruta no encontrada */}
            <Route path="*" element={<Navigate to="/login" replace />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </AuthProvider>
  );
};

export default App;
