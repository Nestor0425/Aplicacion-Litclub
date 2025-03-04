// import { useContext, useEffect, useState } from "react";
// import { AuthContext } from "../context/AuthContext";
// import { useNavigate } from "react-router-dom";
// import { Button, Typography, Grid, Card, CardContent, CardMedia, Paper, Box } from "@mui/material";
// import "../styles/UserDashboard.css"; // Importar CSS personalizado
// import axios from "axios";  


// interface Book {
//   id: number;
//   title: string;
//   author: string;
//   cover_image_url: string;
// }

// const UserDashboard = () => {
//   const { user, logout } = useContext(AuthContext) || { user: null, logout: () => {} };
//   const navigate = useNavigate();
//   const [latestBooks, setLatestBooks] = useState<Book[]>([]);

//   useEffect(() => {
//     const fetchLatestBooks = async () => {
//       try {
//         const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books/latest`);
//         setLatestBooks(res.data);
//       } catch (error) {
//         console.error("Error obteniendo los últimos libros:", error);
//       }
//     };

//     fetchLatestBooks();
//   }, []);



//   return (
//     <Box sx={{ width: "100vw", minHeight: "100vh", textAlign: "center", backgroundColor: "#f5f5f5", padding: 3 }}>
//       <Typography variant="h3">📖 Bienvenido a tu Biblioteca</Typography>
//       <Typography variant="h6">Hola, {user?.nombre || "Usuario"}! 📚</Typography>
//       <Typography sx={{ marginTop: 2 }}>
//         Explora nuestra colección de libros, administra tus préstamos y sigue tu progreso de lectura.
//       </Typography>

//       <Grid container spacing={4} className="dashboard-grid">
//         {/* Sección de Libros */}
//         <Paper>
//         <Typography variant="h5">📚 Últimos Libros Agregados</Typography>
//         <Grid container spacing={3}>
//           {latestBooks.map((book) => (
//             <Grid item xs={12} sm={4} key={book.id}>
//               <Card>
//                 <CardMedia component="img" height="200" image={book.cover_image_url} alt={book.title} />
//                 <CardContent>
//                   <Typography variant="h6">{book.title}</Typography>
//                   <Typography variant="body2">Autor: {book.author}</Typography>
//                 </CardContent>
//               </Card>
//             </Grid>
//           ))}
//         </Grid>
//         <Button
//           variant="contained"
//           color="primary"
//           sx={{ marginTop: 3 }}
//           onClick={() => navigate("/books")}
//         >
//           📖 Ver Todos los Libros
//         </Button>
//       </Paper>

//         </Grid>

//         {/* Sección de Estadísticas */}
//         <Grid item xs={12} md={4}>
//           <Paper className="dashboard-section">
//             <Typography variant="h5" className="section-title">📊 Tu progreso</Typography>
//             <Typography variant="body1">📖 Libros leídos: <strong>12</strong></Typography>
//             <Typography variant="body1">⏳ Tiempo de lectura: <strong>30 horas</strong></Typography>
//           </Paper>
//         </Grid>
      

//       {/* Sección de Historias Motivadoras */}
//       <Paper className="dashboard-section">
//         <Typography variant="h5" className="section-title">✨ Historia Motivadora</Typography>
//         <Typography variant="body1" className="motivational-text">
//           “Un libro es un sueño que tienes en tus manos.” - Neil Gaiman
//         </Typography>
//       </Paper>

//       {/* Sección de Reseñas de Autores */}
//       <Paper className="dashboard-section">
//         <Typography variant="h5" className="section-title">✍ Reseñas de Autores</Typography>
//         <Typography variant="body1">Gabriel García Márquez: Maestro del realismo mágico.</Typography>
//       </Paper>

//       {/* Botón de Cerrar Sesión */}
//       <Button
//         variant="contained"
//         color="error"
//         className="logout-button"
//         onClick={() => {
//           logout();
//           navigate("/login");
//         }}
//       >
//         🚪 Cerrar Sesión
//       </Button>
//     </Box>
//   );
// };

// export default UserDashboard;
import { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button, Typography, Grid, Paper } from "@mui/material";
import "../styles/UserDashboard.css"; // Importar CSS personalizado
import axios from "axios";

import { BookCard } from "../components/BookCard"; // Componente de tarjeta de libro
import { StatsSection } from "../components/StatsSection"; // Componente de estadísticas
import { MotivationalQuote } from "../components/MotivationalQuote"; // Componente de cita motivacional
import { AuthorReview } from "../components/AuthorReview"; // Componente de reseña de autor

interface Book {
  id: number;
  title: string;
  author: string;
  cover_image_url: string;
}

import { CircularProgress } from "@mui/material";

const UserDashboard = () => {
  const { user, logout } = useContext(AuthContext) || { user: null, logout: () => {} };
  const navigate = useNavigate();
  const [latestBooks, setLatestBooks] = useState<Book[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchLatestBooks = async () => {
      try {
        const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books/latest`);
        setLatestBooks(res.data);
        setLoading(false);
      } catch (error) {
        console.error("Error obteniendo los últimos libros:", error);
        setLoading(false);
      }
    };

    fetchLatestBooks();
  }, []);

  return (
    <div className="dashboard-container">
      <Typography variant="h3" sx={{ textAlign: "center", fontWeight: 'bold', fontSize: '2.5rem' }}>
        Bienvenido {user?.nombre || "Usuario"} a tu Biblioteca
      </Typography>
      <Typography variant="h6" sx={{ textAlign: "center", marginBottom: 2, color: '#777' }}>
        Que pases un lindo dia {user?.nombre || "Usuario"}!, gracias por tu visita
      </Typography>

      {loading ? (
        <div className="loading-spinner">
          <CircularProgress color="primary" />
        </div>
      ) : (
        <Grid container spacing={4}>
          {/* Sección de Libros */}
          <Grid item xs={12}>
            <Paper className="books-section">
              <Typography variant="h5" sx={{ marginBottom: 2, fontWeight: 'bold' }}>Lo mas Top 📈</Typography>
              <Grid container spacing={3}>
                {latestBooks.map((book) => (
                  <Grid item xs={12} sm={6} md={4} key={book.id}>
                    <BookCard book={book} />
                  </Grid>
                ))}
              </Grid>
              <Button
                variant="contained"
                color="primary"
                sx={{ marginTop: 3 }}
                onClick={() => navigate("/books")}
              >
                📖 Ver Todos los Libros
              </Button>
            </Paper>
          </Grid>

          {/* Sección de Estadísticas */}
          <Grid item xs={12} md={4}>
            <StatsSection />
          </Grid>

          {/* Sección de Historia Motivacional */}
          <Grid item xs={12} md={4}>
            <MotivationalQuote />
          </Grid>

          {/* Sección de Reseñas de Autores */}
          <Grid item xs={12} md={4}>
            <AuthorReview />
          </Grid>
        </Grid>
      )}

      {/* Botón de Cerrar Sesión */}
      <Button
        variant="contained"
        color="error"
        sx={{ marginTop: 4, width: "200px", marginLeft: "auto", marginRight: "auto", display: "block" }}
        onClick={() => {
          logout();
          navigate("/login");
        }}
      >
        🚪 Cerrar Sesión
      </Button>
    </div>
  );
};

export default UserDashboard;

