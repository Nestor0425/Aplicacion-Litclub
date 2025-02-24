import { AppBar, Toolbar, Typography, Button, Box } from "@mui/material";
import { Link } from "react-router-dom";
import "../styles/Navbar.css"; // ✅ Importa los estilos

const Navbar = () => {
  return (
    <AppBar position="static" className="navbar">
      <Toolbar className="navbar-toolbar">
        <Typography variant="h6" className="navbar-title">
          LitClub
        </Typography>
        <Box className="navbar-buttons">
          <Button className="navbar-button" component={Link} to="/dashboard">Inicio</Button>
          <Button className="navbar-button" component={Link} to="/login">Login</Button>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default Navbar;
