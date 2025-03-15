// import { Paper, Typography, Box, Button, Divider, TextField, Rating } from "@mui/material";
// import { useState } from "react";
// import "../styles/AuthorReview.css";

// export const AuthorReview = () => {
//   const [rating, setRating] = useState(0);
//   const [comment, setComment] = useState("");

//   const handleCommentChange = (e: React.ChangeEvent<HTMLInputElement>) => {
//     setComment(e.target.value);
//   };

//   return (
//     <Paper className="dashboard-section">
//       <Typography variant="h5" className="section-title">✍ Reseñas de Autores</Typography>

//       {/* Sección de Autor */}
//       <Box sx={{ marginBottom: 3 }}>
//         <Typography variant="body1">
//           Gabriel García Márquez: Maestro del realismo mágico.
//         </Typography>
//         <Typography variant="body2" sx={{ fontStyle: "italic", marginTop: 1 }}>
//           "El realismo mágico convierte la literatura en una experiencia sensorialmente poderosa, tejiendo lo fantástico con lo cotidiano."
//         </Typography>
//       </Box>

//       <Divider sx={{ marginBottom: 2 }} />

//       {/* Calificación de Libro */}
//       <Box sx={{ marginBottom: 3 }}>
//         <Typography variant="h5" sx={{ marginBottom: 1 }}>
//           ⭐ Calificación
//         </Typography>
//         <Rating
//           name="book-rating"
//           value={rating}
//           onChange={(_, newValue) => setRating(newValue || 0)}
//           precision={0.5}
//         />
//       </Box>

//       {/* Comentarios */}
//       <Box sx={{ marginBottom: 3 }}>
//         <Typography variant="h5" sx={{ marginBottom: 1 }}>
//           📝 Escribe tu comentario
//         </Typography>
//         <TextField
//           multiline
//           rows={4}
//           fullWidth
//           variant="outlined"
//           value={comment}
//           onChange={handleCommentChange}
//           placeholder="Escribe aquí tu reseña sobre el autor..."
//         />
//       </Box>

//       {/* Libros Relacionados */}
//       <Box sx={{ marginBottom: 3 }}>
//         <Typography variant="h5" sx={{ marginBottom: 2 }}>
//           📚 Libros Relacionados
//         </Typography>
//         <Box sx={{ display: "flex", flexDirection: "column", gap: 1 }}>
//           <Button
//             variant="outlined"
//             color="primary"
//             onClick={() => alert("Ver detalles de Cien años de soledad")}
//           >
//             Cien Años de Soledad
//           </Button>
//           <Button
//             variant="outlined"
//             color="primary"
//             onClick={() => alert("Ver detalles de El amor en los tiempos del cólera")}
//           >
//             El amor en los tiempos del cólera
//           </Button>
//           <Button
//             variant="outlined"
//             color="primary"
//             onClick={() => alert("Ver detalles de Crónica de una muerte anunciada")}
//           >
//             Crónica de una muerte anunciada
//           </Button>
//         </Box>
//       </Box>

//       {/* Botón de Enviar Comentario */}
//       <Button
//         variant="contained"
//         color="primary"
//         sx={{ width: "100%", padding: "12px 0" }}
//         onClick={() => alert("Comentario enviado")}
//       >
//         Enviar Comentario
//       </Button>
//     </Paper>
//   );
// };
import { Paper, Typography, Box, Button, Divider, TextField, Rating } from "@mui/material";
import { useState } from "react";

export const AuthorReview = () => {
  const [rating, setRating] = useState<number | null>(0);
  const [comment, setComment] = useState<string>("");

  const handleCommentChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setComment(e.target.value);
  };

  const handleSubmit = () => {
    if (!comment.trim() || rating === 0) {
      alert("Por favor, completa la calificación y el comentario.");
      return;
    }

    // Aquí puedes enviar la reseña al backend con una API request (ej. fetch o axios)
    console.log("Comentario enviado:", { rating, comment });

    // Limpiar campos después de enviar
    setRating(0);
    setComment("");
  };

  const books = [
    { title: "Cien Años de Soledad", details: "Ver detalles de Cien años de soledad" },
    { title: "El amor en los tiempos del cólera", details: "Ver detalles de El amor en los tiempos del cólera" },
    { title: "Crónica de una muerte anunciada", details: "Ver detalles de Crónica de una muerte anunciada" },
  ];

  return (
    <Paper sx={{ padding: 3, borderRadius: 2, boxShadow: 3 }}>
      <Typography variant="h5" sx={{ marginBottom: 2 }}>✍ Reseñas de Autores</Typography>

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
        <Typography variant="h5" sx={{ marginBottom: 1 }}>⭐ Calificación</Typography>
        <Rating
          name="book-rating"
          value={rating}
          onChange={(_, newValue) => setRating(newValue)}
          precision={0.5}
        />
      </Box>

      {/* Comentarios */}
      <Box sx={{ marginBottom: 3 }}>
        <Typography variant="h5" sx={{ marginBottom: 1 }}>📝 Escribe tu comentario</Typography>
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
        <Typography variant="h5" sx={{ marginBottom: 2 }}>📚 Libros Relacionados</Typography>
        <Box sx={{ display: "flex", flexDirection: "column", gap: 1 }}>
          {books.map((book, index) => (
            <Button
              key={index}
              variant="outlined"
              color="primary"
              onClick={() => console.log(book.details)}
            >
              {book.title}
            </Button>
          ))}
        </Box>
      </Box>

      {/* Botón de Enviar Comentario */}
      <Button
        variant="contained"
        color="primary"
        sx={{ width: "100%", padding: "12px 0" }}
        onClick={handleSubmit}
      >
        Enviar Comentario
      </Button>
    </Paper>
  );
};

