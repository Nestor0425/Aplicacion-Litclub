// import { useEffect, useState } from "react";
// import { Viewer } from "@react-pdf-viewer/core";
// import "@react-pdf-viewer/core/lib/styles/index.css";
// import { Typography, Grid, Card, CardContent, CardMedia, Container, TextField, MenuItem, Box, Button, Dialog, DialogActions, DialogContent, DialogTitle } from "@mui/material";
// import axios from "axios";
// import "../styles/BookPage.css";


// // 📌 Definir el tipo de datos de los libros
// interface Book {
//   id: number;
//   title: string;
//   author: string;
//   cover_image_url: string;
//   genre: string;
//   file_url?: string; // 📌 Puede ser opcional si algunos libros no tienen PDF
// }

// // 📌 Tipo de respuesta esperada de la API
// interface BooksApiResponse {
//   books: Book[];
// }

// const BooksPage = () => {
//   const [books, setBooks] = useState<Book[]>([]);
//   const [filteredBooks, setFilteredBooks] = useState<Book[]>([]);
//   const [searchQuery, setSearchQuery] = useState("");
//   const [genreFilter, setGenreFilter] = useState("");
//   const [authorFilter, setAuthorFilter] = useState("");
//   const [selectedBook, setSelectedBook] = useState<Book | null>(null);

//   // ✅ Cargar libros desde la API
//   useEffect(() => {
//     const fetchBooks = async () => {
//       try {
//         const res = await axios.get<BooksApiResponse | Book[]>(`${import.meta.env.VITE_API_URL}/books`);

//         console.log("📌 Respuesta de la API:", res.data);

//         if (Array.isArray(res.data)) {
//           setBooks(res.data);
//         } else if ("books" in res.data && Array.isArray(res.data.books)) {
//           setBooks(res.data.books);
//         } else {
//           console.error("❌ La respuesta de la API no contiene una lista de libros:", res.data);
//         }
//       } catch (error) {
//         console.error("Error obteniendo libros:", error);
//       }
//     };

//     fetchBooks();
//   }, []);

//   // 📌 Filtrar libros según búsqueda y filtros
//   useEffect(() => {
//     let filtered = books;

//     if (searchQuery) {
//       filtered = filtered.filter(
//         (book) =>
//           book.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
//           book.author.toLowerCase().includes(searchQuery.toLowerCase())
//       );
//     }

//     if (genreFilter) {
//       filtered = filtered.filter((book) => book.genre === genreFilter);
//     }

//     if (authorFilter) {
//       filtered = filtered.filter((book) => book.author === authorFilter);
//     }

//     setFilteredBooks(filtered);
//   }, [searchQuery, genreFilter, authorFilter, books]);

//   // ✅ Función para abrir el visor de PDF
//   const openBook = (fileUrl?: string) => {
//     if (!fileUrl) {
//       alert("Este libro no tiene un archivo PDF disponible.");
//       return;
//     }
  
//     const fullUrl = `${import.meta.env.VITE_API_URL}${fileUrl}`;
//     console.log("📁 URL del libro:", fullUrl);
    
//     // Abrir en nueva pestaña en lugar de usar iframe
//     window.open(fullUrl, "_blank");
//   };
  

//   // 📌 Obtener géneros y autores únicos
//   const uniqueGenres = Array.from(new Set(books.map((book) => book.genre)));
//   const uniqueAuthors = Array.from(new Set(books.map((book) => book.author)));

//   return (
//     <Container sx={{ marginTop: 5 }}>
//       <Typography variant="h3" align="center" className="page-title">
//         📚 Catálogo de Libros
//       </Typography>

//       {/* 📌 Barra de Búsqueda */}
//       <Box className="search-bar">
//         <TextField
//           label="🔍 Buscar por título o autor"
//           variant="outlined"
//           fullWidth
//           value={searchQuery}
//           onChange={(e) => setSearchQuery(e.target.value)}
//           className="search-input"
//         />

//         <TextField
//           select
//           label="📖 Filtrar por género"
//           variant="outlined"
//           value={genreFilter}
//           onChange={(e) => setGenreFilter(e.target.value)}
//           className="search-dropdown"
//         >
//           <MenuItem value="">Todos</MenuItem>
//           {uniqueGenres.map((genre) => (
//             <MenuItem key={genre} value={genre}>
//               {genre}
//             </MenuItem>
//           ))}
//         </TextField>

//         <TextField
//           select
//           label="✍ Filtrar por autor"
//           variant="outlined"
//           value={authorFilter}
//           onChange={(e) => setAuthorFilter(e.target.value)}
//           className="search-dropdown"
//         >
//           <MenuItem value="">Todos</MenuItem>
//           {uniqueAuthors.map((author) => (
//             <MenuItem key={author} value={author}>
//               {author}
//             </MenuItem>
//           ))}
//         </TextField>
//       </Box>

//       {/* 📌 Listado de Libros */}
//       <Grid container spacing={3} sx={{ marginTop: 3 }}>
//         {filteredBooks.length > 0 ? (
//           filteredBooks.map((book) => (
//             <Grid item xs={12} sm={6} md={4} lg={3} key={book.id}>
//               <Card>
//                 <CardMedia component="img" height="220" image={book.cover_image_url} alt={book.title} />
//                 <CardContent>
//                   <Typography variant="h6">{book.title}</Typography>
//                   <Typography variant="body2">Autor: {book.author}</Typography>
//                   <Typography variant="body2" color="textSecondary">Género: {book.genre}</Typography>
//                   <Button
//                     variant="contained"
//                     color="primary"
//                     onClick={() => openBook(book.file_url)}
//                   >
//                     📖 Leer Libro
//                   </Button>
//                 </CardContent>
//               </Card>
//             </Grid>
//           ))
//         ) : (
//           <Typography variant="h6" align="center" sx={{ width: "100%", marginTop: 3 }}>
//             ❌ No se encontraron libros con estos filtros.
//           </Typography>
//         )}
//       </Grid>

//       {/* 📌 Modal para Previsualización del Libro */}
//       <Dialog open={!!selectedBook} onClose={() => setSelectedBook(null)} fullWidth maxWidth="lg">
//         <DialogTitle>{selectedBook?.title}</DialogTitle>
//         <DialogContent>
//           {selectedBook?.file_url ? (
//             <Viewer fileUrl={`${import.meta.env.VITE_API_URL}${selectedBook.file_url}`} />
//           ) : (
//             <Typography color="error">Este libro no tiene un PDF disponible.</Typography>
//           )}
//         </DialogContent>
//         <DialogActions>
//           <Button onClick={() => setSelectedBook(null)} color="error">
//             Cerrar
//           </Button>
//         </DialogActions>
//       </Dialog>
//     </Container>
//   );
// };

// export default BooksPage;
import { useEffect, useState } from "react";
import { 
  Container, Typography, Grid, Card, CardContent, CardMedia, 
  TextField, MenuItem, Box, CircularProgress
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
  file_url?: string;
}

const BooksPage = () => {
  const [books, setBooks] = useState<Book[]>([]);
  const [filteredBooks, setFilteredBooks] = useState<Book[]>([]);
  const [searchQuery, setSearchQuery] = useState("");
  const [genreFilter, setGenreFilter] = useState("");
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchBooks = async () => {
      try {
        const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
        setBooks(res.data);
        setFilteredBooks(res.data);
      } catch (error) {
        console.error("Error obteniendo libros:", error);
      } finally {
        setLoading(false);
      }
    };
    fetchBooks();
  }, []);

  useEffect(() => {
    let filtered = books;
    if (searchQuery) {
      filtered = filtered.filter(
        (book) => book.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
          book.author.toLowerCase().includes(searchQuery.toLowerCase())
      );
    }
    if (genreFilter) {
      filtered = filtered.filter((book) => book.genre === genreFilter);
    }
    setFilteredBooks(filtered);
  }, [searchQuery, genreFilter, books]);

  // const openBook = (fileUrl?: string) => {
  //   if (!fileUrl) {
  //     alert("Este libro no tiene un archivo PDF disponible.");
  //     return;
  //   }
  //   window.open(`${import.meta.env.VITE_API_URL}${fileUrl}`, "_blank");
  // };

  return (
    <Container sx={{ marginTop: 5 }}>
      <Typography variant="h3" align="center">📚 Catálogo de Libros</Typography>
      {loading ? (
        <Box sx={{ display: "flex", justifyContent: "center", marginTop: 4 }}>
          <CircularProgress />
        </Box>
      ) : (
        <>
          <Box sx={{ display: "flex", gap: 2, marginBottom: 3 }}>
            <TextField
              label="🔍 Buscar por título o autor"
              variant="outlined"
              fullWidth
              value={searchQuery}
              onChange={(e) => setSearchQuery(e.target.value)}
            />
            <TextField
              select
              label="📖 Filtrar por género"
              variant="outlined"
              value={genreFilter}
              onChange={(e) => setGenreFilter(e.target.value)}
            >
              <MenuItem value="">Todos</MenuItem>
              {[...new Set(books.map((book) => book.genre))].map((genre) => (
                <MenuItem key={genre} value={genre}>{genre}</MenuItem>
              ))}
            </TextField>
          </Box>
          <Grid container spacing={3}>
            {filteredBooks.map((book) => (
              <Grid item xs={12} sm={6} md={4} key={book.id}>
                <Card>
                  <CardMedia component="img" height="220" image={book.cover_image_url} alt={book.title} />
                  <CardContent>
                    <Typography variant="h6">{book.title}</Typography>
                    <Typography variant="body2">Autor: {book.author}</Typography>
                    <Typography variant="body2">Género: {book.genre}</Typography>
                    <a href={book.file_url} target="_blank" rel="noopener noreferrer">
  📖 Ver Libro
</a>

                  </CardContent>
                </Card>
              </Grid>
            ))}
          </Grid>
        </>
      )}
    </Container>
  );
};

export default BooksPage;