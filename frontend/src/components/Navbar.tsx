// import { AppBar, Toolbar, Typography, Button, Box } from "@mui/material";
// import { Link } from "react-router-dom";
// import "../styles/Navbar.css"; // ✅ Importa los estilos

// const Navbar = () => {
//   return (
//     <AppBar position="static" className="navbar">
//       <Toolbar className="navbar-toolbar">
//         <Typography variant="h6" className="navbar-title">
//           LitClub
//         </Typography>
//         <Box className="navbar-buttons">
//           <Button className="navbar-button" component={Link} to="/dashboard">Inicio</Button>
//           <Button className="navbar-button" component={Link} to="/login">Login</Button>
//         </Box>
//       </Toolbar>
//     </AppBar>
//   );
// };

// export default Navbar;

import { AppBar, Toolbar, Button, Typography, Menu, MenuItem, IconButton, Box } from '@mui/material';
import { AccountCircle } from '@mui/icons-material';
import { useState } from 'react';

// Puedes usar la fuente importada en el archivo index.css o directamente aquí


const Navbar = () => {
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  const handleMenu = (event: React.MouseEvent<HTMLElement>) => {
    setAnchorEl(event.currentTarget);
  };

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <Box sx={{ position: 'sticky', top: 0, zIndex: 1100 }}>
      <AppBar
        position="sticky"
        sx={{
          backgroundColor: '#232232', // Color personalizado
          boxShadow: 3,
        }}
      >
        <Toolbar>
          {/* Imagen en lugar del icono */}
          <Box component="img" src="/logo.png" alt="Logo" sx={{ width: 40, height: 40, mr: 2 }} />

          {/* Título con tipografía personalizada */}
          <Typography variant="h6" sx={{ flexGrow: 1, fontFamily: 'Varela Round, sans-serif' }}>
            LitClub
          </Typography>

          {/* Botones del Navbar */}
          <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }}>Inicio</Button>
          <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }}>Acerca de</Button>
          <Button color="inherit" sx={{ ':hover': { color: '#c4aecf' } }}>Contacto</Button>

          {/* Botón de perfil con menú desplegable */}
          <IconButton
            color="inherit"
            onClick={handleMenu}
          >
            <AccountCircle />
          </IconButton>

          {/* Menú desplegable */}
          <Menu
            anchorEl={anchorEl}
            open={Boolean(anchorEl)}
            onClose={handleClose}
          >
            <MenuItem onClick={handleClose}>Perfil</MenuItem>
            <MenuItem onClick={handleClose}>Cerrar sesión</MenuItem>
          </Menu>
        </Toolbar>
      </AppBar>
    </Box>
  );
};

export default Navbar;
