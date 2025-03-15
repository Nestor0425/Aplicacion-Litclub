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
import { Button, Typography, Grid, Paper, CircularProgress, Alert } from "@mui/material";
import axios from "axios";

import { BookCard } from "../components/BookCard";
import { StatsSection } from "../components/StatsSection";
import { MotivationalQuote } from "../components/MotivationalQuote";
import { AuthorReview } from "../components/AuthorReview";

interface Book {
  id: number;
  title: string;
  author: string;
  cover_image_url: string;
}

const UserDashboard = () => {
  const { user, logout } = useContext(AuthContext) || { user: null, logout: () => {} };
  const navigate = useNavigate();
  const [latestBooks, setLatestBooks] = useState<Book[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!user) {
      navigate("/login");
      return;
    }

    const fetchLatestBooks = async () => {
      try {
        const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books/latest`);
        if (res.status === 200) {
          setLatestBooks(res.data);
        } else {
          throw new Error("No se pudieron cargar los libros.");
        }
      } catch (error) {
        console.error("Error obteniendo los últimos libros:", error);
        setError("No se pudieron cargar los libros. Intenta más tarde.");
      } finally {
        setLoading(false);
      }
    };

    fetchLatestBooks();
  }, [user, navigate]);

  return (
    <div style={{ maxWidth: "1200px", margin: "auto", padding: "20px" }}>
      <Typography variant="h3" sx={{ textAlign: "center", fontWeight: "bold", fontSize: "2.5rem" }}>
        Bienvenido {user?.nombre || "Usuario"} a tu Biblioteca 📚
      </Typography>
      <Typography variant="h6" sx={{ textAlign: "center", marginBottom: 2, color: "#777" }}>
        Que tengas un gran día, {user?.nombre || "Usuario"} 😊
      </Typography>

      {loading ? (
        <div style={{ display: "flex", justifyContent: "center", marginTop: "20px" }}>
          <CircularProgress color="primary" />
        </div>
      ) : error ? (
        <Alert severity="error" sx={{ textAlign: "center", marginBottom: 3 }}>
          {error}
        </Alert>
      ) : (
        <Grid container spacing={4}>
          {/* 📚 Sección de Libros */}
          <Grid item xs={12}>
            <Paper sx={{ padding: 3, borderRadius: "12px", boxShadow: 3 }}>
              <Typography variant="h5" sx={{ marginBottom: 2, fontWeight: "bold" }}>
                📈 Lo más popular
              </Typography>
              {latestBooks.length > 0 ? (
                <Grid container spacing={3}>
                  {latestBooks.map((book) => (
                    <Grid item xs={12} sm={6} md={4} key={book.id}>
                      <BookCard book={book} />
                    </Grid>
                  ))}
                </Grid>
              ) : (
                <Typography variant="body1" sx={{ textAlign: "center", color: "#777" }}>
                  No hay libros disponibles en este momento.
                </Typography>
              )}
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

          {/* 📊 Sección de Estadísticas */}
          {/* 📊 Sección de Estadísticas */}
<Grid item xs={12} md={4}>
  <StatsSection booksRead={12} readingHours={30} progress={60} />
</Grid>


          {/* ✨ Sección de Motivación */}
          <Grid item xs={12} md={4}>
            <MotivationalQuote />
          </Grid>

          {/* ✍ Sección de Reseñas de Autores */}
          <Grid item xs={12} md={4}>
            <AuthorReview />
          </Grid>
        </Grid>
      )}

      {/* 🚪 Botón de Cerrar Sesión */}
      <Button
        variant="contained"
        color="error"
        sx={{
          marginTop: 4,
          width: "200px",
          marginLeft: "auto",
          marginRight: "auto",
          display: "block",
          fontWeight: "bold",
        }}
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


