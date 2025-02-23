import { useEffect, useState } from "react";
import axios from "axios";
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography } from "@mui/material";

interface Log {
  id: number;
  level: string;
  message: string;
  timestamp: string;
}

const Logs = () => {
  const [logs, setLogs] = useState<Log[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchLogs = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) {
          setError("No tienes acceso a los logs o no estás autenticado.");
          return;
        }

        // ✅ Enviar token en headers y permitir credenciales
        const res = await axios.get<Log[]>(`${import.meta.env.VITE_API_URL}/logs`, {
          headers: { Authorization: `Bearer ${token}` },
          withCredentials: true, // ✅ Importante para evitar bloqueos de CORS
        });

        setLogs(res.data);
      } catch (error) {
        console.error("Error obteniendo logs:", error);
        setError("No tienes acceso a los logs o hubo un error.");
      }
    };

    fetchLogs();
  }, []);

  return (
    <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "80%", margin: "auto", marginTop: 5 }}>
      <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
        📜 Monitoreo de Logs
      </Typography>
      {error ? (
        <Typography color="error">{error}</Typography>
      ) : (
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>ID</TableCell>
              <TableCell>Nivel</TableCell>
              <TableCell>Mensaje</TableCell>
              <TableCell>Fecha</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {logs.map((log) => (
              <TableRow key={log.id}>
                <TableCell>{log.id}</TableCell>
                <TableCell>{log.level}</TableCell>
                <TableCell>{log.message}</TableCell>
                <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      )}
    </TableContainer>
  );
};

export default Logs;
