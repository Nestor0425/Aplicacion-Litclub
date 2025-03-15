// import { LinearProgress, Paper, Typography } from "@mui/material";
// import { useState } from "react";

// export const StatsSection = () => {
//   // eslint-disable-next-line @typescript-eslint/no-unused-vars
//   const [progress] = useState(60); // Ejemplo de progreso al 60%

//   return (
//     <Paper className="dashboard-section">
//       <Typography variant="h5" sx={{ fontWeight: 'bold', marginBottom: 2 }}>📊 Tu progreso</Typography>
//       <Typography variant="body1">📖 Libros leídos: <strong>12</strong></Typography>
//       <Typography variant="body1">⏳ Tiempo de lectura: <strong>30 horas</strong></Typography>
//       <LinearProgress variant="determinate" value={progress} sx={{ marginTop: 2 }} />
//       <Typography variant="body2" sx={{ marginTop: 1 }}>Progreso: {progress}%</Typography>
//     </Paper>
//   );
// };
import { LinearProgress, Paper, Typography } from "@mui/material";

interface StatsSectionProps {
  booksRead: number;
  readingHours: number;
  progress: number; // Porcentaje de progreso
}

export const StatsSection = ({ booksRead, readingHours, progress }: StatsSectionProps) => {
  return (
    <Paper
      sx={{
        padding: 3,
        borderRadius: 2,
        boxShadow: 3,
        backgroundColor: "#f9f9f9",
        textAlign: "center",
      }}
    >
      <Typography variant="h5" sx={{ fontWeight: "bold", marginBottom: 2 }}>
        📊 Tu progreso
      </Typography>
      <Typography variant="body1">
        📖 Libros leídos: <strong>{booksRead}</strong>
      </Typography>
      <Typography variant="body1">
        ⏳ Tiempo de lectura: <strong>{readingHours} horas</strong>
      </Typography>
      <LinearProgress
        variant="determinate"
        value={progress}
        sx={{ marginTop: 2, height: 10, borderRadius: 5 }}
      />
      <Typography variant="body2" sx={{ marginTop: 1 }}>
        Progreso: {progress}%
      </Typography>
    </Paper>
  );
};
