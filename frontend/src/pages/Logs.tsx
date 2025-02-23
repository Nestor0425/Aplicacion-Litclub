// import { useEffect, useState } from "react";
// import axios from "axios";
// import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography } from "@mui/material";

// interface Log {
//   id: number;
//   level: string;
//   message: string;
//   timestamp: string;
// }

// const Logs = () => {
//   const [logs, setLogs] = useState<Log[]>([]);
//   const [error, setError] = useState<string | null>(null);

//   useEffect(() => {
//     const fetchLogs = async () => {
//       try {
//         const token = localStorage.getItem("token");
//         if (!token) {
//           setError("No tienes acceso a los logs o no estás autenticado.");
//           return;
//         }

//         // ✅ Enviar token en headers y permitir credenciales
//         const res = await axios.get<Log[]>(`${import.meta.env.VITE_API_URL}/logs`, {
//           headers: { Authorization: `Bearer ${token}` },
//           withCredentials: true, // ✅ Importante para evitar bloqueos de CORS
//         });

//         setLogs(res.data);
//       } catch (error) {
//         console.error("Error obteniendo logs:", error);
//         setError("No tienes acceso a los logs o hubo un error.");
//       }
//     };

//     fetchLogs();
//   }, []);

//   return (
//     <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "80%", margin: "auto", marginTop: 5 }}>
//       <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
//         📜 Monitoreo de Logs
//       </Typography>
//       {error ? (
//         <Typography color="error">{error}</Typography>
//       ) : (
//         <Table>
//           <TableHead>
//             <TableRow>
//               <TableCell>ID</TableCell>
//               <TableCell>Nivel</TableCell>
//               <TableCell>Mensaje</TableCell>
//               <TableCell>Fecha</TableCell>
//             </TableRow>
//           </TableHead>
//           <TableBody>
//             {logs.map((log) => (
//               <TableRow key={log.id}>
//                 <TableCell>{log.id}</TableCell>
//                 <TableCell>{log.level}</TableCell>
//                 <TableCell>{log.message}</TableCell>
//                 <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
//               </TableRow>
//             ))}
//           </TableBody>
//         </Table>
//       )}
//     </TableContainer>
//   );
// };

// export default Logs;
import { useEffect, useState } from "react";
import axios from "axios";
import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography, Select, MenuItem, TextField, FormControl, InputLabel } from "@mui/material";

interface Log {
  id: number;
  level: string;
  message: string;
  timestamp: string;
}

const Logs = () => {
  const [logs, setLogs] = useState<Log[]>([]);
  const [filteredLogs, setFilteredLogs] = useState<Log[]>([]);
  const [levelFilter, setLevelFilter] = useState<string>("");
  const [searchQuery, setSearchQuery] = useState<string>("");

  useEffect(() => {
    const fetchLogs = async () => {
      try {
        const token = localStorage.getItem("token");
        if (!token) return;
        
        const res = await axios.get<Log[]>(`${import.meta.env.VITE_API_URL}/logs`, {
          headers: { Authorization: `Bearer ${token}` },
          withCredentials: true,
        });

        setLogs(res.data);
        setFilteredLogs(res.data);
      } catch (error) {
        console.error("Error obteniendo logs:", error);
      }
    };

    fetchLogs();
  }, []);

  // ✅ Aplicar filtros cada vez que el usuario cambia el nivel o la búsqueda
  useEffect(() => {
    let filtered = logs;

    if (levelFilter) {
      filtered = filtered.filter(log => log.level === levelFilter);
    }

    if (searchQuery) {
      filtered = filtered.filter(log => log.message.toLowerCase().includes(searchQuery.toLowerCase()));
    }

    setFilteredLogs(filtered);
  }, [levelFilter, searchQuery, logs]);

  return (
    <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "90%", margin: "auto", marginTop: 5 }}>
      <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
        📜 Monitoreo de Logs
      </Typography>

      {/* 🔍 Filtros */}
      <div style={{ display: "flex", gap: "10px", marginBottom: "10px", justifyContent: "center" }}>
        <FormControl variant="outlined">
          <InputLabel>Nivel</InputLabel>
          <Select value={levelFilter} onChange={(e) => setLevelFilter(e.target.value)} label="Nivel">
            <MenuItem value="">Todos</MenuItem>
            <MenuItem value="info">Info</MenuItem>
            <MenuItem value="warn">Warning</MenuItem>
            <MenuItem value="error">Error</MenuItem>
          </Select>
        </FormControl>

        <TextField 
          label="Buscar..." 
          variant="outlined" 
          onChange={(e) => setSearchQuery(e.target.value)} 
          sx={{ width: "300px" }} 
        />
      </div>

      {/* 📜 Tabla de Logs */}
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
          {filteredLogs.map((log) => (
            <TableRow key={log.id}>
              <TableCell>{log.id}</TableCell>
              <TableCell>{log.level.toUpperCase()}</TableCell>
              <TableCell>{log.message}</TableCell>
              <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
            </TableRow>
          ))}
        </TableBody>
      </Table>
    </TableContainer>
  );
};

export default Logs;
