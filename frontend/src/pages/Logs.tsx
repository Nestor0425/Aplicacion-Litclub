// // // import { useEffect, useState } from "react";
// // // import axios from "axios";
// // // import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography } from "@mui/material";

// // // interface Log {
// // //   id: number;
// // //   level: string;
// // //   message: string;
// // //   timestamp: string;
// // // }

// // // const Logs = () => {
// // //   const [logs, setLogs] = useState<Log[]>([]);
// // //   const [error, setError] = useState<string | null>(null);

// // //   useEffect(() => {
// // //     const fetchLogs = async () => {
// // //       try {
// // //         const token = localStorage.getItem("token");
// // //         if (!token) {
// // //           setError("No tienes acceso a los logs o no estás autenticado.");
// // //           return;
// // //         }

// // //         // ✅ Enviar token en headers y permitir credenciales
// // //         const res = await axios.get<Log[]>(`${import.meta.env.VITE_API_URL}/logs`, {
// // //           headers: { Authorization: `Bearer ${token}` },
// // //           withCredentials: true, // ✅ Importante para evitar bloqueos de CORS
// // //         });

// // //         setLogs(res.data);
// // //       } catch (error) {
// // //         console.error("Error obteniendo logs:", error);
// // //         setError("No tienes acceso a los logs o hubo un error.");
// // //       }
// // //     };

// // //     fetchLogs();
// // //   }, []);

// // //   return (
// // //     <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "80%", margin: "auto", marginTop: 5 }}>
// // //       <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
// // //         📜 Monitoreo de Logs
// // //       </Typography>
// // //       {error ? (
// // //         <Typography color="error">{error}</Typography>
// // //       ) : (
// // //         <Table>
// // //           <TableHead>
// // //             <TableRow>
// // //               <TableCell>ID</TableCell>
// // //               <TableCell>Nivel</TableCell>
// // //               <TableCell>Mensaje</TableCell>
// // //               <TableCell>Fecha</TableCell>
// // //             </TableRow>
// // //           </TableHead>
// // //           <TableBody>
// // //             {logs.map((log) => (
// // //               <TableRow key={log.id}>
// // //                 <TableCell>{log.id}</TableCell>
// // //                 <TableCell>{log.level}</TableCell>
// // //                 <TableCell>{log.message}</TableCell>
// // //                 <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
// // //               </TableRow>
// // //             ))}
// // //           </TableBody>
// // //         </Table>
// // //       )}
// // //     </TableContainer>
// // //   );
// // // };

// // // export default Logs;
// // import { useEffect, useState } from "react";
// // import axios from "axios";
// // import { Table, TableBody, TableCell, TableContainer, TableHead, TableRow, Paper, Typography, Select, MenuItem, TextField, FormControl, InputLabel } from "@mui/material";

// // interface Log {
// //   id: number;
// //   level: string;
// //   message: string;
// //   timestamp: string;
// // }

// // const Logs = () => {
// //   const [logs, setLogs] = useState<Log[]>([]);
// //   const [filteredLogs, setFilteredLogs] = useState<Log[]>([]);
// //   const [levelFilter, setLevelFilter] = useState<string>("");
// //   const [searchQuery, setSearchQuery] = useState<string>("");

// //   useEffect(() => {
// //     const fetchLogs = async () => {
// //       try {
// //         const token = localStorage.getItem("token");
// //         if (!token) return;
        
// //         const res = await axios.get<Log[]>(`${import.meta.env.VITE_API_URL}/logs`, {
// //           headers: { Authorization: `Bearer ${token}` },
// //           withCredentials: true,
// //         });

// //         setLogs(res.data);
// //         setFilteredLogs(res.data);
// //       } catch (error) {
// //         console.error("Error obteniendo logs:", error);
// //       }
// //     };

// //     fetchLogs();
// //   }, []);

// //   // ✅ Aplicar filtros cada vez que el usuario cambia el nivel o la búsqueda
// //   useEffect(() => {
// //     let filtered = logs;

// //     if (levelFilter) {
// //       filtered = filtered.filter(log => log.level === levelFilter);
// //     }

// //     if (searchQuery) {
// //       filtered = filtered.filter(log => log.message.toLowerCase().includes(searchQuery.toLowerCase()));
// //     }

// //     setFilteredLogs(filtered);
// //   }, [levelFilter, searchQuery, logs]);

// //   return (
// //     <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "90%", margin: "auto", marginTop: 5 }}>
// //       <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
// //         📜 Monitoreo de Logs
// //       </Typography>

// //       {/* 🔍 Filtros */}
// //       <div style={{ display: "flex", gap: "10px", marginBottom: "10px", justifyContent: "center" }}>
// //         <FormControl variant="outlined">
// //           <InputLabel>Nivel</InputLabel>
// //           <Select value={levelFilter} onChange={(e) => setLevelFilter(e.target.value)} label="Nivel">
// //             <MenuItem value="">Todos</MenuItem>
// //             <MenuItem value="info">Info</MenuItem>
// //             <MenuItem value="warn">Warning</MenuItem>
// //             <MenuItem value="error">Error</MenuItem>
// //           </Select>
// //         </FormControl>

// //         <TextField 
// //           label="Buscar..." 
// //           variant="outlined" 
// //           onChange={(e) => setSearchQuery(e.target.value)} 
// //           sx={{ width: "300px" }} 
// //         />
// //       </div>

// //       {/* 📜 Tabla de Logs */}
// //       <Table>
// //         <TableHead>
// //           <TableRow>
// //             <TableCell>ID</TableCell>
// //             <TableCell>Nivel</TableCell>
// //             <TableCell>Mensaje</TableCell>
// //             <TableCell>Fecha</TableCell>
// //           </TableRow>
// //         </TableHead>
// //         <TableBody>
// //           {filteredLogs.map((log) => (
// //             <TableRow key={log.id}>
// //               <TableCell>{log.id}</TableCell>
// //               <TableCell>{log.level.toUpperCase()}</TableCell>
// //               <TableCell>{log.message}</TableCell>
// //               <TableCell>{new Date(log.timestamp).toLocaleString()}</TableCell>
// //             </TableRow>
// //           ))}
// //         </TableBody>
// //       </Table>
// //     </TableContainer>
// //   );
// // };

// // export default Logs;
// import { useEffect, useState, useMemo } from "react";

// import {
//   Table,
//   TableBody,
//   TableCell,
//   TableContainer,
//   TableHead,
//   TableRow,
//   Paper,
//   Typography,
//   Select,
//   MenuItem,
//   TextField,
//   FormControl,
//   InputLabel,
//   CircularProgress,
// } from "@mui/material";

// // Interfaz para los logs
// interface Log {
//   id: number;
//   level: string;
//   message: string;
//   timestamp: string;
// }

// // Componente principal
// const Logs = () => {
//   const [logs, setLogs] = useState<Log[]>([]);
//   const [levelFilter, setLevelFilter] = useState<string>("");
//   const [searchQuery, setSearchQuery] = useState<string>("");
//   const [loading, setLoading] = useState<boolean>(true);
//   const [error, setError] = useState<string | null>(null);

//   useEffect(() => {
//     const fetchLogs = async () => {
//       setLoading(true);
//       setError(null);

//       try {
//         const token = localStorage.getItem("token");
//         if (!token) {
//           setError("No tienes acceso a los logs o no estás autenticado.");
//           setLoading(false);
//           return;
//         }

//         // Usando fetch en lugar de Axios
//         const res = await fetch(`${import.meta.env.VITE_API_URL}/logs`, {
//           method: "GET",
//           headers: {
//             Authorization: `Bearer ${token}`,
//             "Content-Type": "application/json",
//           },
//         });

//         if (!res.ok) {
//           // Si la respuesta no es exitosa, lanza un error
//           const errorData = await res.json();
//           throw new Error(errorData.message || "Error obteniendo logs.");
//         }

//         const data = await res.json();
//         setLogs(data);
//       } catch (error: unknown) {
//         if (error instanceof Error) {
//           // Manejamos el error como una instancia de Error
//           setError(error.message || "Error desconocido al obtener logs.");
//         } else {
//           // Si el error no es una instancia de Error
//           setError("Error desconocido al obtener logs.");
//         }
//       } finally {
//         setLoading(false);
//       }
//     };

//     fetchLogs();
//   }, []);

//   // ✅ Filtros optimizados con useMemo
//   const filteredLogs = useMemo(() => {
//     return logs.filter((log) => {
//       const matchesLevel = levelFilter ? log.level === levelFilter : true;
//       const matchesSearch = searchQuery ? log.message.toLowerCase().includes(searchQuery.toLowerCase()) : true;
//       return matchesLevel && matchesSearch;
//     });
//   }, [logs, levelFilter, searchQuery]);

//   return (
//     <TableContainer component={Paper} sx={{ padding: 2, maxWidth: "90%", margin: "auto", marginTop: 5 }}>
//       <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 2 }}>
//         📜 Monitoreo de Logs
//       </Typography>

//       {/* 🔍 Filtros */}
//       <div style={{ display: "flex", gap: "10px", marginBottom: "10px", justifyContent: "center" }}>
//         <FormControl variant="outlined" sx={{ minWidth: 120 }}>
//           <InputLabel>Nivel</InputLabel>
//           <Select
//             value={levelFilter}
//             onChange={(e) => setLevelFilter(e.target.value)}
//             label="Nivel"
//           >
//             <MenuItem value="">Todos</MenuItem>
//             <MenuItem value="info">Info</MenuItem>
//             <MenuItem value="warn">Warning</MenuItem>
//             <MenuItem value="error">Error</MenuItem>
//           </Select>
//         </FormControl>

//         <TextField
//           label="Buscar mensaje..."
//           variant="outlined"
//           onChange={(e) => setSearchQuery(e.target.value)}
//           sx={{ width: "300px" }}
//         />
//       </div>

//       {/* 📜 Estado de carga y errores */}
//       {loading ? (
//         <div style={{ display: "flex", justifyContent: "center", marginTop: 20 }}>
//           <CircularProgress />
//         </div>
//       ) : error ? (
//         <Typography color="error" sx={{ textAlign: "center" }}>
//           {error}
//         </Typography>
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
//             {filteredLogs.map((log) => (
//               <TableRow key={log.id}>
//                 <TableCell>{log.id}</TableCell>
//                 <TableCell>{log.level.toUpperCase()}</TableCell>
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

import { useEffect, useState, useMemo } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Typography,
  Select,
  MenuItem,
  TextField,
  FormControl,
  InputLabel,
  CircularProgress,
  Box,
} from "@mui/material";
import { useNavigate } from "react-router-dom";

// Interfaz para los logs
interface Log {
  id: number;
  level: string;
  message: string;
  timestamp: string;
}

// Componente principal
const Logs = () => {
  const [logs, setLogs] = useState<Log[]>([]);
  const [levelFilter, setLevelFilter] = useState<string>("");
  const [searchQuery, setSearchQuery] = useState<string>("");
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const navigate = useNavigate();

  useEffect(() => {
    const fetchLogs = async () => {
      setLoading(true);
      setError(null);

      try {
        const token = localStorage.getItem("token");
        if (!token) {
          setError("⚠️ No tienes acceso a los logs. Inicia sesión.");
          setTimeout(() => navigate("/login"), 2000); // Redirigir tras 2s
          setLoading(false);
          return;
        }

        const res = await fetch(`${import.meta.env.VITE_API_URL}/logs`, {
          method: "GET",
          headers: {
            Authorization: `Bearer ${token}`,
            "Content-Type": "application/json",
          },
        });

        if (!res.ok) {
          const errorData = await res.json();
          throw new Error(errorData.message || "Error obteniendo logs.");
        }

        const data = await res.json();
        setLogs(data);
      } catch (error: unknown) {
        setError(error instanceof Error ? error.message : "Error desconocido al obtener logs.");
      } finally {
        setLoading(false);
      }
    };

    fetchLogs();
  }, [navigate]);

  // ✅ Filtrado de logs optimizado con `useMemo`
  const filteredLogs = useMemo(() => {
    return logs.filter((log) => {
      const matchesLevel = levelFilter ? log.level === levelFilter : true;
      const matchesSearch = searchQuery ? log.message.toLowerCase().includes(searchQuery.toLowerCase()) : true;
      return matchesLevel && matchesSearch;
    });
  }, [logs, levelFilter, searchQuery]);

  return (
    <TableContainer component={Paper} sx={{ padding: 3, maxWidth: "90%", margin: "auto", marginTop: 5 }}>
      <Typography variant="h4" sx={{ textAlign: "center", marginBottom: 3 }}>
        📜 Monitoreo de Logs
      </Typography>

      {/* 🔍 Filtros */}
      <Box sx={{ display: "flex", gap: 2, justifyContent: "center", marginBottom: 2 }}>
        <FormControl variant="outlined" sx={{ minWidth: 120 }}>
          <InputLabel>Nivel</InputLabel>
          <Select
            value={levelFilter}
            onChange={(e) => setLevelFilter(e.target.value)}
            label="Nivel"
          >
            <MenuItem value="">Todos</MenuItem>
            <MenuItem value="info">Info</MenuItem>
            <MenuItem value="warn">Warning</MenuItem>
            <MenuItem value="error">Error</MenuItem>
          </Select>
        </FormControl>

        <TextField
          label="Buscar mensaje..."
          variant="outlined"
          onChange={(e) => setSearchQuery(e.target.value)}
          sx={{ width: "300px" }}
        />
      </Box>

      {/* 📜 Estado de carga y errores */}
      {loading ? (
        <Box sx={{ display: "flex", justifyContent: "center", marginTop: 5 }}>
          <CircularProgress />
        </Box>
      ) : error ? (
        <Typography color="error" sx={{ textAlign: "center", marginTop: 3 }}>
          {error}
        </Typography>
      ) : filteredLogs.length === 0 ? (
        <Typography sx={{ textAlign: "center", marginTop: 3 }}>
          ⚠️ No hay logs disponibles con los filtros aplicados.
        </Typography>
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
      )}
    </TableContainer>
  );
};

export default Logs;
