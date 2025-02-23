import { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button, Container, Typography, Grid, Paper } from "@mui/material";
import axios from "axios";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement } from "chart.js";
import { Bar, Doughnut } from "react-chartjs-2";

// ✅ Registrar componentes necesarios de Chart.js
ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement);



interface DashboardStats {
  users: number;
  logins: number;
  failedLogins: number;
  twoFA: number;
}

const Dashboard = () => {
  const { user, logout } = useContext(AuthContext) || { user: null, logout: () => {} };
  const navigate = useNavigate();
  const [stats, setStats] = useState<DashboardStats>({ users: 0, logins: 0, failedLogins: 0, twoFA: 0 });

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const token = localStorage.getItem("token");
        const res = await axios.get<DashboardStats>(`${import.meta.env.VITE_API_URL}/dashboard`, {
          headers: { Authorization: `Bearer ${token}` },
        });
  
        if (res.status === 200) {
          setStats(res.data);
        } else {
          console.error("Error en API:", res.statusText);
        }
      } catch (error) {
        console.error("Error obteniendo estadísticas:", error);
      }
    };
  
    fetchStats();
  }, []);
  

  return (
    <Container sx={{ textAlign: "center", marginTop: 5 }}>
      <Typography variant="h3">📊 Dashboard</Typography>
      <Typography variant="h6">Bienvenido, {user?.nombre || "Usuario"}!</Typography>

      {/* ✅ Botón solo visible para administradores */}
      {user?.rol === "admin" && (
        <Button
          variant="contained"
          color="primary"
          sx={{ marginTop: 3, marginRight: 2 }}
          onClick={() => navigate("/logs")}
        >
          📜 Monitoreo de Logs
        </Button>
      )}

      {/* 🔴 Botón de Cerrar Sesión */}
      <Button
        variant="contained"
        color="error"
        sx={{ marginTop: 3 }}
        onClick={() => {
          logout();
          navigate("/login");
        }}
      >
        🚪 Cerrar Sesión
      </Button>

      {/* 📊 Gráficos de Estadísticas */}
      <Grid container spacing={4} sx={{ marginTop: 5 }}>
        <Grid item xs={12} md={6}>
          <Paper sx={{ padding: 3 }}>
            <Typography variant="h6">Usuarios y Logins</Typography>
            <Bar
              data={{
                labels: ["Usuarios Registrados", "Inicios de Sesión", "Intentos Fallidos", "2FA Enviados"],
                datasets: [
                  {
                    label: "Cantidad",
                    data: [stats.users, stats.logins, stats.failedLogins, stats.twoFA],
                    backgroundColor: ["#3498db", "#2ecc71", "#e74c3c", "#f1c40f"],
                  },
                ],
              }}
            />
          </Paper>
        </Grid>

        <Grid item xs={12} md={6}>
          <Paper sx={{ padding: 3 }}>
            <Typography variant="h6">Distribución de Accesos</Typography>
            <Doughnut
              data={{
                labels: ["Logins Exitosos", "Intentos Fallidos"],
                datasets: [
                  {
                    data: [stats.logins, stats.failedLogins],
                    backgroundColor: ["#2ecc71", "#e74c3c"],
                  },
                ],
              }}
            />
          </Paper>
        </Grid>
      </Grid>
    </Container>
  );
};

export default Dashboard;
