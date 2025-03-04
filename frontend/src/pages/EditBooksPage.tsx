import { useEffect, useState } from "react";
import { 
  Container, Typography, Table, TableBody, TableCell, TableContainer, 
  TableHead, TableRow, Paper, TextField, Button 
} from "@mui/material";
import axios from "axios";

interface Book {
  id: number;
  title: string;
  author: string;
  genre: string;
  description: string;
  published_year: string;
  cover_image_url: string;
  available_file_url: string;
}

const EditBooksPage = () => {
  const [books, setBooks] = useState<Book[]>([]);

  useEffect(() => {
    fetchBooks();
  }, []);

  const fetchBooks = async () => {
    try {
      const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
      setBooks(res.data);
    } catch (error) {
      console.error("Error obteniendo libros:", error);
    }
  };

  const handleInputChange = (id: number, field: string, value: string) => {
    setBooks((prevBooks) =>
      prevBooks.map((book) =>
        book.id === id ? { ...book, [field]: value ?? "" } : book // 🔥 Evita valores `null`
      )
    );
  };

  const handleUpdateBook = async (book: Book) => {
    try {
      const token = localStorage.getItem("token"); 
      if (!token) {
        alert("⚠️ Debes iniciar sesión para actualizar libros.");
        return;
      }

      const updatedBook = {
        title: book.title,
        author: book.author,
        genre: book.genre,
        description: book.description,
        published_year: book.published_year,
        cover_image_url: book.cover_image_url,
        available_file_url: book.available_file_url,
      };

      await axios.put(
        `${import.meta.env.VITE_API_URL}/books/${book.id}`,
        updatedBook,
        {
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        }
      );

      alert("📚 Libro actualizado correctamente.");
      fetchBooks(); // ✅ Refrescar la lista
    } catch (error) {
      console.error("❌ Error al actualizar el libro:", error);
      alert("Hubo un error al actualizar el libro.");
    }
  };

  return (
    <Container sx={{ marginTop: 5 }}>
      <Typography variant="h3" align="center">
        ✏️ Editar Libros
      </Typography>

      <TableContainer component={Paper} sx={{ marginTop: 3 }}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Título</TableCell>
              <TableCell>Autor</TableCell>
              <TableCell>Género</TableCell>
              <TableCell>Descripción</TableCell>
              <TableCell>Año Publicación</TableCell>
              <TableCell>URL Imagen</TableCell>
              <TableCell>Archivo PDF</TableCell>
              <TableCell>Acciones</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {books.map((book) => (
              <TableRow key={book.id}>
                <TableCell>
                  <TextField 
                    value={book.title || ""} 
                    onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.author || ""} 
                    onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.genre || ""} 
                    onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.description || ""} 
                    onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.published_year || ""} 
                    onChange={(e) => handleInputChange(book.id, "published_year", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.cover_image_url || ""} 
                    onChange={(e) => handleInputChange(book.id, "cover_image_url", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.available_file_url || ""} 
                    onChange={(e) => handleInputChange(book.id, "available_file_url", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <Button 
                    variant="contained" 
                    color="success" 
                    onClick={() => handleUpdateBook(book)}
                  >
                    💾 Guardar
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>
    </Container>
  );
};

export default EditBooksPage;
