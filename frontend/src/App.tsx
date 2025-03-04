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
import UserDashboard from "./pages/UserDashboard";
import BooksPage from "./pages/BooksPage"; // Nueva página
import ReadBook from "./pages/./ReadBook";
import BookViewer from "./pages/BookViewer";
import EditBooksPage from "./pages/EditBooksPage";
import UploadBooksPage from "./pages/UploadBooksPage";




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
            <Route path="/user-dashboard" element={<UserDashboard />} />
            <Route path="/logs" element={<ProtectedRoute element={<Logs />} />} />
            <Route path="/read" element={<ReadBook />} />
            <Route path="/books" element={<BooksPage />} /> {/* Nueva ruta para ver todos los libros */}
            <Route path="/viewer/:fileUrl" element={<BookViewer />} /> 
            <Route path="/edit-books" element={<EditBooksPage />} />
            <Route path="/upload-books" element={<UploadBooksPage />} />
      
            {/* ❌ Ruta no encontrada */}
            <Route path="*" element={<Navigate to="/login" replace />} />
          </Routes>
        </Router>
      </ThemeProvider>
    </AuthProvider>
  );
};

export default App;
