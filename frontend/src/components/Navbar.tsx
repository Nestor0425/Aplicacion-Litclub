// import { AppBar, Toolbar, Button, Typography, Menu, MenuItem, IconButton, Box } from '@mui/material';
// import { AccountCircle } from '@mui/icons-material';
// import { useState, useContext } from 'react';
// import { useNavigate } from 'react-router-dom';
// import { AuthContext } from '../context/AuthContext';

// const Navbar = () => {
//   const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
//   const navigate = useNavigate();
//   const authContext = useContext(AuthContext); // ✅ Obtenemos el contexto de autenticación

//   const user = authContext?.user || null;
//   const logout = authContext?.logout || (() => {});

//   const handleMenu = (event: React.MouseEvent<HTMLElement>) => {
//     setAnchorEl(event.currentTarget);
//   };

//   const handleClose = () => {
//     setAnchorEl(null);
//   };

//   const handleLogout = () => {
//     logout(); // ✅ Cerrar sesión
//     handleClose();
//     navigate("/login"); // ✅ Redirigir al login después de cerrar sesión
//   };

//   return (
//     <Box sx={{ position: 'sticky', top: 0, zIndex: 1100 }}>
//       <AppBar position="sticky" sx={{ backgroundColor: 'black', boxShadow: 3 }}>
//         <Toolbar>
//           {/* Logo */}
//           <Box
//             component="img"
//             src="/logo.png"
//             alt="Logo"
//             sx={{ width: 40, height: 40, mr: 2, cursor: "pointer" }}
//             onClick={() => navigate("/")}
//           />

//           {/* Título */}
//           <Typography
//             variant="h6"
//             sx={{ flexGrow: 1, fontFamily: 'Varela Round, sans-serif', cursor: "pointer" }}
//             onClick={() => navigate("/")}
//           >
//             LitClub
//           </Typography>

//           {/* Botones de Navegación */}
//           <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/")}>
//   Inicio
// </Button>

//           <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/about")}>
//             Acerca de LitClub
//           </Button>
//           <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/contact")}>
//             Contacto
//           </Button>

//           {/* Mostrar solo si el usuario está autenticado */}
//           {user ? (
//             <>
//               <IconButton color="inherit" aria-label="Abrir menú de usuario" onClick={handleMenu}>
//                 <AccountCircle />
//               </IconButton>

//               {/* Menú desplegable */}
//               <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleClose}>
//                 <MenuItem onClick={() => { handleClose(); navigate("/profile"); }}>Perfil</MenuItem>
//                 <MenuItem onClick={handleLogout}>🚪 Cerrar sesión</MenuItem>
//               </Menu>
//             </>
//           ) : (
//             <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/login")}>
//               Iniciar Sesión
//             </Button>
//           )}
//         </Toolbar>
//       </AppBar>
//     </Box>
//   );
// };

// export default Navbar;
import { AppBar, Toolbar, Button, Typography, Menu, MenuItem, IconButton, Box } from '@mui/material';
import { AccountCircle } from '@mui/icons-material';
import { useState, useContext } from 'react';
import { useNavigate } from 'react-router-dom';
import { AuthContext } from '../context/AuthContext';

const Navbar = () => {
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
  const navigate = useNavigate();
  const authContext = useContext(AuthContext);

  const user = authContext?.user || null;
  const logout = authContext?.logout || (() => {});

  const handleMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  const handleLogout = () => {
    logout();
    handleClose();
    navigate("/login");
  };

  return (
    <Box sx={{ position: 'sticky', top: 0, zIndex: 1100 }}>
      <AppBar position="sticky" sx={{ backgroundColor: 'black', boxShadow: 3 }}>
        <Toolbar>
          {/* Logo */}
          <Box
            component="img"
            src="/logo.png"
            alt="Logo"
            sx={{ width: 40, height: 40, mr: 2, cursor: "pointer" }}
            onClick={() => navigate("/")}
          />

          {/* Título */}
          <Typography
            variant="h6"
            sx={{ flexGrow: 1, fontFamily: 'Varela Round, sans-serif', cursor: "pointer" }}
            onClick={() => navigate("/")}
          >
            LitClub
          </Typography>

          {/* 📌 Ocultar los botones de navegación si el usuario es admin */}
          {!user?.rol || user.rol !== "admin" ? (
            <>
              <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/")}>
                Inicio
              </Button>
              <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/about")}>
                Acerca de LitClub
              </Button>
              <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/contact")}>
                Contacto
              </Button>
            </>
          ) : null}

          {/* 📌 Botón de Dashboard (visible solo si está autenticado) */}
          {user && (
            <Button variant="contained" color="info" sx={{ ml: 2 }} onClick={() => navigate("/dashboard")}>
              Dashboard
            </Button>
          )}

          {/* 📌 Botones de administrador (visible solo si el usuario es admin) */}
          {user?.rol === "admin" && (
            <Box sx={{ display: "flex", gap: 2, ml: 3 }}>
              <Button variant="contained" color="secondary" onClick={() => navigate("/upload-books")}>
                Subir Libros CSV
              </Button>
              <Button variant="contained" color="primary" onClick={() => navigate("/edit-books")}>
                Editar Libros
              </Button>
              <Button variant="contained" color="warning" onClick={() => navigate("/logs")}>
                Ver Logs
              </Button>
            </Box>
          )}

          {/* 📌 Menú de usuario */}
          {user ? (
            <>
              <IconButton color="inherit" aria-label="Abrir menú de usuario" onClick={handleMenu}>
                <AccountCircle />
              </IconButton>

              {/* Menú desplegable */}
              <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleClose}>
                <MenuItem onClick={() => { handleClose(); navigate("/profile"); }}>Perfil</MenuItem>
                <MenuItem onClick={handleLogout}>Cerrar sesión</MenuItem>
              </Menu>
            </>
          ) : (
            <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }} onClick={() => navigate("/login")}>
              Iniciar Sesión
            </Button>
          )}
        </Toolbar>
      </AppBar>
    </Box>
  );
};

export default Navbar;
