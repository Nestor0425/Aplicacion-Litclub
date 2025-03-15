
// import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
 import { AuthContext } from "./context/AuthContext";
 import { JSX, useContext, useEffect } from "react";
// import { ThemeProvider, CssBaseline } from "@mui/material";
// import theme from "./theme";
// import Login from "./pages/Login";
// import Register from "./pages/Register";
// import Dashboard from "./pages/Dashboard";
// import Logs from "./pages/Logs";
// import Navbar from "./components/Navbar";
// import UserDashboard from "./pages/UserDashboard";
// import BooksPage from "./pages/BooksPage"; // Nueva página
// import ReadBook from "./pages/./ReadBook";
// import BookViewer from "./pages/BookViewer";
// import EditBooksPage from "./pages/EditBooksPage";
// import UploadBooksPage from "./pages/UploadBooksPage";
// import Inicio from "./pages/Inicio";
// import { useNavbar } from "./context/NavbarContext";





// // ✅ Componente de Rutas Protegidas
// const ProtectedRoute = ({ element }: { element: JSX.Element }) => {
//   const auth = useContext(AuthContext);
//   return auth?.user ? element : <Navigate to="/login" replace />;
// };

// const App = () => {
//   const { showNavbar } = useNavbar();

//   return (
//     <AuthProvider>
//       <ThemeProvider theme={theme}>
//         <CssBaseline />
//         <Router>
//           {showNavbar && <Navbar />}
//           <Routes>
//             <Route path="/" element={<Navigate to="/login" replace />} />
//             <Route path="/login" element={<Login />} />
//             <Route path="/register" element={<Register />} />
//             <Route path="/inicio" element={<Inicio />} />
//             {/* ✅ Rutas protegidas */}
//             <Route path="/dashboard" element={<ProtectedRoute element={<Dashboard />} />} />
//             <Route path="/user-dashboard" element={<UserDashboard />} />
//             <Route path="/logs" element={<ProtectedRoute element={<Logs />} />} />
//             <Route path="/read" element={<ReadBook />} />
//             <Route path="/books" element={<BooksPage />} /> {/* Nueva ruta para ver todos los libros */}
//             <Route path="/viewer/:fileUrl" element={<BookViewer />} /> 
//             <Route path="/edit-books" element={<EditBooksPage />} />
//             <Route path="/upload-books" element={<UploadBooksPage />} />
      
//             {/* ❌ Ruta no encontrada */}
//             <Route path="*" element={<Navigate to="/login" replace />} />
//           </Routes>
//         </Router>
//       </ThemeProvider>
//     </AuthProvider>
//   );
// };

// export default App;
import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import { AuthProvider } from "./context/AuthContext";
import { NavbarProvider, NavbarWrapper } from "./context/NavbarContext"; // Importar el Provider
import { ThemeProvider, CssBaseline } from "@mui/material";
import theme from "./theme";
import Login from "./pages/Login";
import Register from "./pages/Register";
import Dashboard from "./pages/Dashboard";
import Logs from "./pages/Logs";
import UserDashboard from "./pages/UserDashboard";
import BooksPage from "./pages/BooksPage";
import ReadBook from "./pages/ReadBook";
import BookViewer from "./pages/BookViewer";
import EditBooksPage from "./pages/EditBooksPage";
import UploadBooksPage from "./pages/UploadBooksPage";
import Inicio from "./pages/Inicio";

const ProtectedRoute = ({ element }: { element: JSX.Element }) => {
  const auth = useContext(AuthContext);
  return auth?.user ? element : <Navigate to="/login" replace />;
};

const App = () => {
  useEffect(() => {
    console.log("🌎 Backend en:", import.meta.env.VITE_API_URL);
  }, []);
  return (
    <AuthProvider>
      <NavbarProvider>
        <ThemeProvider theme={theme}>
          <CssBaseline />
          <Router>
            <NavbarWrapper /> {/* ✅ Controla la visibilidad del Navbar */}
            <Routes>
              <Route path="/" element={<Navigate to="/login" replace />} />
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="/inicio" element={<Inicio />} />
              <Route path="/dashboard" element={<ProtectedRoute element={<Dashboard />} />} />
              <Route path="/user-dashboard" element={<UserDashboard />} />
              <Route path="/logs" element={<ProtectedRoute element={<Logs />} />} />
              <Route path="/read" element={<ReadBook />} />
              <Route path="/books" element={<BooksPage />} />
              <Route path="/viewer/:fileUrl" element={<BookViewer />} />
              <Route path="/edit-books" element={<EditBooksPage />} />
              <Route path="/upload-books" element={<UploadBooksPage />} />
              <Route path="*" element={<Navigate to="/login" replace />} />
            </Routes>
          </Router>
        </ThemeProvider>
      </NavbarProvider>
    </AuthProvider>
  );
};


export default App;
