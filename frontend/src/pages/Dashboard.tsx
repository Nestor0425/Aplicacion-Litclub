import { useContext, useEffect, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { Button, Container, Typography, Paper, CircularProgress, Box, TextField, MenuItem, Snackbar, Alert } from "@mui/material";
import axios from "axios";
import { Chart as ChartJS, CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement } from "chart.js";

// ✅ Registrar componentes necesarios de Chart.js
ChartJS.register(CategoryScale, LinearScale, BarElement, Title, Tooltip, Legend, ArcElement);

interface DashboardStats {
  users: number;
  logins: number;
  failedLogins: number;
  twoFA: number;
}

interface BookForm {
  title: string;
  author: string;
  genre: string;
  description: string;
  published_year: string;
  file: File | null; // 📌 Añadir el campo "file" para almacenar el PDF
}

interface Book {
  id: number;
  title: string;
  author: string;
  cover_image_url: string;
  genre: string;
}


const Dashboard = () => {
  const { user, logout } = useContext(AuthContext) || { user: null, logout: () => {} };
  const navigate = useNavigate();
  const [, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [books, setBooks] = useState<Book[]>([]);
  const [form, setForm] = useState<BookForm>({
    title: "",
    author: "",
    genre: "",
    description: "",
    published_year: "",
    file: null, // Inicializamos el archivo en "null"
  });
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [snackbarSeverity, setSnackbarSeverity] = useState<"success" | "error">("success");

  useEffect(() => {
    if (!user) {
      navigate("/login");
      return;
    }

    if (user.rol !== "admin") {
      navigate("/user-dashboard");
      return;
    }

    const fetchBooks = async () => {
      try {
        const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
        setBooks(res.data);
      } catch (error) {
        console.error("Error obteniendo libros:", error);
      }
    };

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

    fetchBooks();
    fetchStats();
  }, [navigate, user?.rol]);

  // 📌 Función para manejar cambios en inputs de texto
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  // 📌 Función para manejar el cambio de archivo
  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    if (e.target.files && e.target.files.length > 0) {
      setForm({ ...form, file: e.target.files[0] });
    }
  };

  // 📌 Función para agregar un libro con un archivo PDF
  const handleAddBook = async (event: React.FormEvent<HTMLFormElement>) => {
    event.preventDefault();
  
    try {
      const token = localStorage.getItem("token");
      if (!token) throw new Error("No hay token de autenticación");
  
      const formData = new FormData();
      formData.append("title", form.title);
      formData.append("author", form.author);
      formData.append("genre", form.genre);
      formData.append("description", form.description);
      formData.append("published_year", form.published_year);
      if (form.file) formData.append("file", form.file);
  
      const res = await fetch(`${import.meta.env.VITE_API_URL}/books`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
        credentials: "include",
      });
  
      if (!res.ok) {
        const errorData = await res.json();
        throw new Error(errorData.message || "Error al agregar el libro");
      }
  
      const data = await res.json();
      console.log("✅ Libro agregado:", data);
  
      setSnackbarMessage(data.message);
      setSnackbarSeverity("success");
      setSnackbarOpen(true);
  
      // Limpiar el formulario
      setForm({
        title: "",
        author: "",
        genre: "",
        description: "",
        published_year: "",
        file: null,
      });
    } catch (error) {
      console.error("❌ Error al agregar libro:", error);
      setSnackbarMessage(error instanceof Error ? error.message : "Error desconocido");
      setSnackbarSeverity("error");
      setSnackbarOpen(true);
    }
  };
  
  

  const hadleViewLogs = () => {
    navigate("/logs");
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
        <Box sx={{ marginTop: 3 }}>
        <Button
  variant="contained"
  color="secondary"
  sx={{ marginTop: 3, marginRight: 2 }}
  onClick={() => navigate("/upload-books")}
>
  📂 Subir Libros CSV
</Button>

        {/* 📌 Botón para ir a la página de edición de libros */}
        <Button variant="contained" color="primary" onClick={() => navigate("/edit-books")}>
          ✏️ Editar Libros
        </Button>
      </Box>
        {/* 📌 Botón para ver logs (Solo para administradores) */}
        {user?.rol === "admin" && (
            <Button
              variant="contained"
              color="secondary"
              sx={{ marginTop: 3 }}
              onClick={hadleViewLogs}
            >
              📜 Ver Logs
            </Button>
          )}
          <Button variant="contained" color="error" sx={{ marginTop: 3 }} onClick={() => { logout(); navigate("/login"); }}>
            🚪 Cerrar Sesión
          </Button>

        
          {/* 📌 Formulario para Agregar Libros */}
          <Paper sx={{ padding: 3, marginTop: 4 }}>
            <Typography variant="h5">➕ Agregar Nuevo Libro</Typography>
            <form onSubmit={handleAddBook} style={{ display: "flex", flexDirection: "column", gap: "15px", marginTop: "10px" }}>
              <TextField label="Título" name="title" value={form.title} onChange={handleInputChange} required />
              <TextField label="Autor" name="author" value={form.author} onChange={handleInputChange} required />
              <TextField label="Descripción" name="description" value={form.description} onChange={handleInputChange} required />
              <TextField label="Año de Publicación" name="published_year" value={form.published_year} onChange={handleInputChange} required />
              <TextField select label="Género" name="genre" value={form.genre} onChange={handleInputChange} required>
                {["Ficción", "No Ficción", "Misterio", "Fantasía", "Ciencia Ficción"].map((genre) => (
                  <MenuItem key={genre} value={genre}>{genre}</MenuItem>
                ))}
              </TextField>

              {/* 📌 Input para seleccionar archivo PDF */}
              <input type="file" accept="application/pdf" onChange={handleFileChange} />

              <Button variant="contained" color="primary" type="submit">📖 Agregar Libro</Button>
            </form>
          </Paper>

          {/* 📌 Notificaciones Snackbar */}
          <Snackbar open={snackbarOpen} autoHideDuration={4000} onClose={() => setSnackbarOpen(false)}>
            <Alert onClose={() => setSnackbarOpen(false)} severity={snackbarSeverity}>
              {snackbarMessage}
            </Alert>
          </Snackbar>

          <Paper sx={{ marginTop: 5, padding: 3 }}>
  <Typography variant="h5">📚 Libros en la Biblioteca</Typography>
  <Box sx={{ display: "flex", flexWrap: "wrap", gap: 2, justifyContent: "center", marginTop: 3 }}>
    {books.map((book) => (
      <Paper key={book.id} sx={{ padding: 2, width: "300px" }}>
        <Typography variant="h6">{book.title}</Typography>
        <Typography variant="body2">Autor: {book.author}</Typography>
        <Typography variant="body2">Género: {book.genre}</Typography>
      </Paper>
    ))}
  </Box>
</Paper>

        </>
      )}
    </Container>
  );
};

export default Dashboard;
