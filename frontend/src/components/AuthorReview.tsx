import { Paper, Typography, Box, Button, Divider, TextField, Rating } from "@mui/material";
import { useState } from "react";
import "../styles/AuthorReview.css";

export const AuthorReview = () => {
  const [rating, setRating] = useState(0);
  const [comment, setComment] = useState("");

  const handleCommentChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setComment(e.target.value);
  };

  return (
    <Paper className="dashboard-section">
      <Typography variant="h5" className="section-title">✍ Reseñas de Autores</Typography>

      {/* Sección de Autor */}
      <Box sx={{ marginBottom: 3 }}>
        <Typography variant="body1">
          Gabriel García Márquez: Maestro del realismo mágico.
        </Typography>
        <Typography variant="body2" sx={{ fontStyle: "italic", marginTop: 1 }}>
          "El realismo mágico convierte la literatura en una experiencia sensorialmente poderosa, tejiendo lo fantástico con lo cotidiano."
        </Typography>
      </Box>

      <Divider sx={{ marginBottom: 2 }} />

      {/* Calificación de Libro */}
      <Box sx={{ marginBottom: 3 }}>
        <Typography variant="h5" sx={{ marginBottom: 1 }}>
          ⭐ Calificación
        </Typography>
        <Rating
          name="book-rating"
          value={rating}
          onChange={(_, newValue) => setRating(newValue || 0)}
          precision={0.5}
        />
      </Box>

      {/* Comentarios */}
      <Box sx={{ marginBottom: 3 }}>
        <Typography variant="h5" sx={{ marginBottom: 1 }}>
          📝 Escribe tu comentario
        </Typography>
        <TextField
          multiline
          rows={4}
          fullWidth
          variant="outlined"
          value={comment}
          onChange={handleCommentChange}
          placeholder="Escribe aquí tu reseña sobre el autor..."
        />
      </Box>

      {/* Libros Relacionados */}
      <Box sx={{ marginBottom: 3 }}>
        <Typography variant="h5" sx={{ marginBottom: 2 }}>
          📚 Libros Relacionados
        </Typography>
        <Box sx={{ display: "flex", flexDirection: "column", gap: 1 }}>
          <Button
            variant="outlined"
            color="primary"
            onClick={() => alert("Ver detalles de Cien años de soledad")}
          >
            Cien Años de Soledad
          </Button>
          <Button
            variant="outlined"
            color="primary"
            onClick={() => alert("Ver detalles de El amor en los tiempos del cólera")}
          >
            El amor en los tiempos del cólera
          </Button>
          <Button
            variant="outlined"
            color="primary"
            onClick={() => alert("Ver detalles de Crónica de una muerte anunciada")}
          >
            Crónica de una muerte anunciada
          </Button>
        </Box>
      </Box>

      {/* Botón de Enviar Comentario */}
      <Button
        variant="contained"
        color="primary"
        sx={{ width: "100%", padding: "12px 0" }}
        onClick={() => alert("Comentario enviado")}
      >
        Enviar Comentario
      </Button>
    </Paper>
  );
};
