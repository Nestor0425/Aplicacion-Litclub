import { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button, Container, Typography, Grid, Paper, CircularProgress, Box } from "@mui/material";
import axios from "axios";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement } from "chart.js";
import { Bar, Doughnut } from "react-chartjs-2";
import * as XLSX from "xlsx";
import { saveAs } from "file-saver";

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
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

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
          setError("Error al obtener datos");
        }
      // eslint-disable-next-line @typescript-eslint/no-unused-vars
      } catch (err) {
        setError("No se pudo conectar con el servidor.");
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  // ✅ Función para Exportar los Datos a Excel
  const exportToExcel = () => {
    if (!stats) return;

    const data = [
      ["Categoría", "Cantidad"],
      ["Usuarios Registrados", stats.users],
      ["Inicios de Sesión", stats.logins],
      ["Intentos Fallidos", stats.failedLogins],
      ["2FA Enviados", stats.twoFA],
    ];

    const ws = XLSX.utils.aoa_to_sheet(data);
    const wb = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(wb, ws, "Estadísticas");

    const excelBuffer = XLSX.write(wb, { bookType: "xlsx", type: "array" });
    const dataBlob = new Blob([excelBuffer], { type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8" });
    saveAs(dataBlob, "dashboard_estadisticas.xlsx");
  };

  // ✅ Función para Exportar los Datos a CSV
  const exportToCSV = () => {
    if (!stats) return;

    const csvContent =
      "data:text/csv;charset=utf-8," +
      "Categoría,Cantidad\n" +
      `Usuarios Registrados,${stats.users}\n` +
      `Inicios de Sesión,${stats.logins}\n` +
      `Intentos Fallidos,${stats.failedLogins}\n` +
      `2FA Enviados,${stats.twoFA}\n`;

    const encodedUri = encodeURI(csvContent);
    const link = document.createElement("a");
    link.setAttribute("href", encodedUri);
    link.setAttribute("download", "dashboard_estadisticas.csv");
    document.body.appendChild(link);
    link.click();
  };

  return (
    <Container sx={{ textAlign: "center", marginTop: 5 }}>
      <Typography variant="h3">📊 Dashboard</Typography>
      <Typography variant="h6">Bienvenido, {user?.nombre || "Usuario"}!</Typography>

      {loading ? (
        <Box sx={{ display: "flex", justifyContent: "center", marginTop: 4 }}>
          <CircularProgress />
        </Box>
      ) : error ? (
        <Typography color="error" sx={{ marginTop: 3 }}>
          {error}
        </Typography>
      ) : (
        <>
          {/* ✅ Botón solo visible para administradores */}
          {user?.rol === "admin" && (
            <>
              <Button
                variant="contained"
                color="primary"
                sx={{ marginTop: 3, marginRight: 2 }}
                onClick={() => navigate("/logs")}
              >
                📜 Monitoreo de Logs
              </Button>

              {/* 📥 Botón para Exportar a Excel */}
              <Button
                variant="contained"
                color="secondary"
                sx={{ marginTop: 3, marginRight: 2 }}
                onClick={exportToExcel}
              >
                📥 Exportar Excel
              </Button>

              {/* 📂 Botón para Exportar a CSV */}
              <Button
                variant="contained"
                color="success"
                sx={{ marginTop: 3 }}
                onClick={exportToCSV}
              >
                📂 Exportar CSV
              </Button>
            </>
          )}

          {/* 🔴 Botón de Cerrar Sesión */}
          <Button
            variant="contained"
            color="error"
            sx={{ marginTop: 3, marginLeft: 2 }}
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
                        data: [stats?.users || 0, stats?.logins || 0, stats?.failedLogins || 0, stats?.twoFA || 0],
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
                        data: [stats?.logins || 0, stats?.failedLogins || 0],
                        backgroundColor: ["#2ecc71", "#e74c3c"],
                      },
                    ],
                  }}
                />
              </Paper>
            </Grid>
          </Grid>
        </>
      )}
    </Container>
  );
};

export default Dashboard;
