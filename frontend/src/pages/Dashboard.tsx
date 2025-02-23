import { useContext } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button, Container, Typography } from "@mui/material";

const Dashboard = () => {
  const { user } = useContext(AuthContext) || { user: null };
  const navigate = useNavigate();

  return (
    <Container sx={{ textAlign: "center", marginTop: 5 }}>
      <Typography variant="h3">📊 Dashboard</Typography>
      <Typography variant="h6">Bienvenido, {user?.nombre || "Usuario"}!</Typography>

      {/* ✅ Botón solo visible para administradores */}
      {user?.rol === "admin" && (
        <Button
          variant="contained"
          color="primary"
          sx={{ marginTop: 3 }}
          onClick={() => navigate("/logs")}
        >
          📜 Monitoreo de Logs
        </Button>
      )}
    </Container>
  );
};

export default Dashboard;
