import { createTheme } from "@mui/material/styles";

const theme = createTheme({
  palette: {
    primary: {
      main: "#5c2c7b", // Color principal (morado)
    },
    secondary: {
      main: "#1e81a6", // Color secundario (azul claro)
    },
    background: {
      default: "#f4f6f8", // Fondo gris claro
    },
  },
  typography: {
    fontFamily: "'Varela Round', sans-serif",
    h1: {
      fontSize: "2rem",
      fontWeight: 600,
    },
    h2: {
      fontSize: "1.8rem",
      fontWeight: 500,
    },
    body1: {
      fontSize: "1rem",
      fontWeight: 400,
    },
    button: {
      textTransform: "none",
      fontWeight: "bold",
    },
  },
});

export default theme;
