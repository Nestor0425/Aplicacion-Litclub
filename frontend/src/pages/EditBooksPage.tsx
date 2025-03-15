// // import { useEffect, useState } from "react";
// // import { 
// //   Container, Typography, Table, TableBody, TableCell, TableContainer, 
// //   TableHead, TableRow, Paper, TextField, Button 
// // } from "@mui/material";
// // import axios from "axios";

// // interface Book {
// //   id: number;
// //   title: string;
// //   author: string;
// //   genre: string;
// //   description: string;
// //   published_year: string;
// //   cover_image_url: string;
// //   available_file_url: string;
// // }

// // const EditBooksPage = () => {
// //   const [books, setBooks] = useState<Book[]>([]);

// //   useEffect(() => {
// //     fetchBooks();
// //   }, []);

// //   const fetchBooks = async () => {
// //     try {
// //       const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
// //       setBooks(res.data);
// //     } catch (error) {
// //       console.error("Error obteniendo libros:", error);
// //     }
// //   };

// //   const handleInputChange = (id: number, field: string, value: string) => {
// //     setBooks((prevBooks) =>
// //       prevBooks.map((book) =>
// //         book.id === id ? { ...book, [field]: value ?? "" } : book // 🔥 Evita valores `null`
// //       )
// //     );
// //   };

// //   const handleUpdateBook = async (book: Book) => {
// //     try {
// //       const token = localStorage.getItem("token"); 
// //       if (!token) {
// //         alert("⚠️ Debes iniciar sesión para actualizar libros.");
// //         return;
// //       }

// //       const updatedBook = {
// //         title: book.title,
// //         author: book.author,
// //         genre: book.genre,
// //         description: book.description,
// //         published_year: book.published_year,
// //         cover_image_url: book.cover_image_url,
// //         available_file_url: book.available_file_url,
// //       };

// //       await axios.put(
// //         `${import.meta.env.VITE_API_URL}/books/${book.id}`,
// //         updatedBook,
// //         {
// //           headers: {
// //             "Content-Type": "application/json",
// //             Authorization: `Bearer ${token}`,
// //           },
// //         }
// //       );

// //       alert("📚 Libro actualizado correctamente.");
// //       fetchBooks(); // ✅ Refrescar la lista
// //     } catch (error) {
// //       console.error("❌ Error al actualizar el libro:", error);
// //       alert("Hubo un error al actualizar el libro.");
// //     }
// //   };

// //   return (
// //     <Container sx={{ marginTop: 5 }}>
// //       <Typography variant="h3" align="center">
// //         ✏️ Editar Libros
// //       </Typography>

// //       <TableContainer component={Paper} sx={{ marginTop: 3 }}>
// //         <Table>
// //           <TableHead>
// //             <TableRow>
// //               <TableCell>Título</TableCell>
// //               <TableCell>Autor</TableCell>
// //               <TableCell>Género</TableCell>
// //               <TableCell>Descripción</TableCell>
// //               <TableCell>Año Publicación</TableCell>
// //               <TableCell>URL Imagen</TableCell>
// //               <TableCell>Archivo PDF</TableCell>
// //               <TableCell>Acciones</TableCell>
// //             </TableRow>
// //           </TableHead>
// //           <TableBody>
// //             {books.map((book) => (
// //               <TableRow key={book.id}>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.title || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.author || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.genre || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.description || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.published_year || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "published_year", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.cover_image_url || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "cover_image_url", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <TextField 
// //                     value={book.available_file_url || ""} 
// //                     onChange={(e) => handleInputChange(book.id, "available_file_url", e.target.value)} 
// //                     fullWidth 
// //                   />
// //                 </TableCell>
// //                 <TableCell>
// //                   <Button 
// //                     variant="contained" 
// //                     color="success" 
// //                     onClick={() => handleUpdateBook(book)}
// //                   >
// //                     💾 Guardar
// //                   </Button>
// //                 </TableCell>
// //               </TableRow>
// //             ))}
// //           </TableBody>
// //         </Table>
// //       </TableContainer>
// //     </Container>
// //   );
// // };

// // export default EditBooksPage;

// import { useEffect, useState, useMemo } from "react";
// import { 
//   Container, Typography, Table, TableBody, TableCell, TableContainer, 
//   TableHead, TableRow, Paper, TextField, Button, Snackbar, Alert
// } from "@mui/material";
// import axios from "axios";
// import { useNavigate } from "react-router-dom";

// interface Book {
//   id: number;
//   title: string;
//   author: string;
//   genre: string;
//   description: string;
//   published_year: string;
//   cover_image_url: string;
//   available_file_url: string;
// }

// const EditBooksPage = () => {
//   const [books, setBooks] = useState<Book[]>([]);
//   const [snackbarOpen, setSnackbarOpen] = useState(false);
//   const [snackbarMessage, setSnackbarMessage] = useState("");
//   const [snackbarSeverity, setSnackbarSeverity] = useState<"success" | "error">("success");
//   const navigate = useNavigate();

//   useEffect(() => {
//     fetchBooks();
//   }, []);

//   // 📌 Obtener libros de la API con `sessionStorage` para evitar recargas innecesarias
//   const fetchBooks = async () => {
//     const storedBooks = sessionStorage.getItem("books");
//     if (storedBooks) {
//       setBooks(JSON.parse(storedBooks));
//       return;
//     }

//     try {
//       const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
//       setBooks(res.data);
//       sessionStorage.setItem("books", JSON.stringify(res.data));
//     } catch (error) {
//       console.error("❌ Error obteniendo libros:", error);
//       setSnackbarMessage("No se pudieron cargar los libros.");
//       setSnackbarSeverity("error");
//       setSnackbarOpen(true);
//     }
//   };

//   // 📌 Optimización para evitar renders innecesarios
//   const bookList = useMemo(() => books, [books]);

//   const handleInputChange = (id: number, field: string, value: string) => {
//     setBooks((prevBooks) =>
//       prevBooks.map((book) =>
//         book.id === id ? { ...book, [field]: value ?? "" } : book
//       )
//     );
//   };

//   const handleUpdateBook = async (book: Book) => {
//     try {
//       const token = localStorage.getItem("token");
//       if (!token) {
//         navigate("/login");
//         return;
//       }

//       const updatedBook = {
//         title: book.title,
//         author: book.author,
//         genre: book.genre,
//         description: book.description,
//         published_year: book.published_year,
//         cover_image_url: book.cover_image_url,
//         available_file_url: book.available_file_url,
//       };

//       await axios.put(
//         `${import.meta.env.VITE_API_URL}/books/${book.id}`,
//         updatedBook,
//         {
//           headers: {
//             "Content-Type": "application/json",
//             Authorization: `Bearer ${token}`,
//           },
//         }
//       );

//       setSnackbarMessage("📚 Libro actualizado correctamente.");
//       setSnackbarSeverity("success");
//       setSnackbarOpen(true);

//       sessionStorage.removeItem("books"); // 🗑️ Se elimina para forzar la recarga
//       fetchBooks(); // 🔄 Recargar libros actualizados
//     } catch (error) {
//       console.error("❌ Error al actualizar el libro:", error);
//       setSnackbarMessage("Hubo un error al actualizar el libro.");
//       setSnackbarSeverity("error");
//       setSnackbarOpen(true);
//     }
//   };

//   return (
//     <Container sx={{ marginTop: 5 }}>
//       <Typography variant="h3" align="center">
//         ✏️ Editar Libros
//       </Typography>

//       <TableContainer component={Paper} sx={{ marginTop: 3 }}>
//         <Table>
//           <TableHead>
//             <TableRow>
//               <TableCell>Título</TableCell>
//               <TableCell>Autor</TableCell>
//               <TableCell>Género</TableCell>
//               <TableCell>Descripción</TableCell>
//               <TableCell>Año Publicación</TableCell>
//               <TableCell>URL Imagen</TableCell>
//               <TableCell>Archivo PDF</TableCell>
//               <TableCell>Acciones</TableCell>
//             </TableRow>
//           </TableHead>
//           <TableBody>
//             {bookList.map((book) => (
//               <TableRow key={book.id}>
//                 <TableCell>
//                   <TextField 
//                     value={book.title || ""} 
//                     onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.author || ""} 
//                     onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.genre || ""} 
//                     onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.description || ""} 
//                     onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.published_year || ""} 
//                     onChange={(e) => handleInputChange(book.id, "published_year", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.cover_image_url || ""} 
//                     onChange={(e) => handleInputChange(book.id, "cover_image_url", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.available_file_url || ""} 
//                     onChange={(e) => handleInputChange(book.id, "available_file_url", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <Button 
//                     variant="contained" 
//                     color="success" 
//                     onClick={() => handleUpdateBook(book)}
//                   >
//                     💾 Guardar
//                   </Button>
//                 </TableCell>
//               </TableRow>
//             ))}
//           </TableBody>
//         </Table>
//       </TableContainer>

//       {/* 📌 Snackbar para mostrar mensajes */}
//       <Snackbar open={snackbarOpen} autoHideDuration={4000} onClose={() => setSnackbarOpen(false)}>
//         <Alert onClose={() => setSnackbarOpen(false)} severity={snackbarSeverity}>
//           {snackbarMessage}
//         </Alert>
//       </Snackbar>
//     </Container>
//   );
// };

// export default EditBooksPage;
// import { useEffect, useState, useMemo } from "react";
// import { 
//   Container, Typography, Table, TableBody, TableCell, TableContainer, 
//   TableHead, TableRow, Paper, TextField, Button, Snackbar, Alert
// } from "@mui/material";
// import axios from "axios";
// import { useNavigate } from "react-router-dom";

// interface Book {
//   id: number;
//   title: string;
//   author: string;
//   genre: string;
//   description: string;
//   published_year: string;
//   cover_image_url?: string;
//   available_file_url?: string;
// }

// const EditBooksPage = () => {
//   const [books, setBooks] = useState<Book[]>([]);
//   const [snackbarOpen, setSnackbarOpen] = useState(false);
//   const [snackbarMessage, setSnackbarMessage] = useState("");
//   const [snackbarSeverity, setSnackbarSeverity] = useState<"success" | "error">("success");
//   const navigate = useNavigate();

//   useEffect(() => {
//     fetchBooks();
//   }, []);

//   // 📌 Obtener libros de la API con `sessionStorage` para evitar recargas innecesarias
//   const fetchBooks = async () => {
//     const storedBooks = sessionStorage.getItem("books");
//     if (storedBooks) {
//       setBooks(JSON.parse(storedBooks));
//       return;
//     }

//     try {
//       const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
//       setBooks(res.data);
//       sessionStorage.setItem("books", JSON.stringify(res.data));
//     } catch (error) {
//       console.error("❌ Error obteniendo libros:", error);
//       setSnackbarMessage("No se pudieron cargar los libros.");
//       setSnackbarSeverity("error");
//       setSnackbarOpen(true);
//     }
//   };

//   // 📌 Optimización para evitar renders innecesarios
//   const bookList = useMemo(() => books, [books]);

//   const handleInputChange = (id: number, field: keyof Book, value: string) => {
//     setBooks((prevBooks) =>
//       prevBooks.map((book) =>
//         book.id === id ? { ...book, [field]: value } : book
//       )
//     );
//   };

//   const handleUpdateBook = async (book: Book) => {
//     try {
//       const token = localStorage.getItem("token");
//       if (!token) {
//         navigate("/login");
//         return;
//       }

//       const updatedBook = {
//         title: book.title,
//         author: book.author,
//         genre: book.genre,
//         description: book.description,
//         published_year: book.published_year,
//         cover_image_url: book.cover_image_url || "",
//         available_file_url: book.available_file_url || "",
//       };

//       await axios.put(
//         `${import.meta.env.VITE_API_URL}/books/${book.id}`,
//         updatedBook,
//         {
//           headers: {
//             "Content-Type": "application/json",
//             Authorization: `Bearer ${token}`,
//           },
//         }
//       );

//       setSnackbarMessage("📚 Libro actualizado correctamente.");
//       setSnackbarSeverity("success");
//       setSnackbarOpen(true);

//       sessionStorage.removeItem("books"); // 🗑️ Se elimina para forzar la recarga
//       fetchBooks(); // 🔄 Recargar libros actualizados
//     } catch (error) {
//       console.error("❌ Error al actualizar el libro:", error);
//       setSnackbarMessage("Hubo un error al actualizar el libro.");
//       setSnackbarSeverity("error");
//       setSnackbarOpen(true);
//     }
//   };

//   return (
//     <Container sx={{ marginTop: 5 }}>
//       <Typography variant="h3" align="center">
//         ✏️ Editar Libros
//       </Typography>

//       <TableContainer component={Paper} sx={{ marginTop: 3 }}>
//         <Table>
//           <TableHead>
//             <TableRow>
//               <TableCell>Título</TableCell>
//               <TableCell>Autor</TableCell>
//               <TableCell>Género</TableCell>
//               <TableCell>Descripción</TableCell>
//               <TableCell>Año Publicación</TableCell>
//               <TableCell>URL Imagen</TableCell>
//               <TableCell>Archivo PDF</TableCell>
//               <TableCell>Acciones</TableCell>
//             </TableRow>
//           </TableHead>
//           <TableBody>
//             {bookList.map((book) => (
//               <TableRow key={book.id}>
//                 <TableCell>
//                   <TextField 
//                     value={book.title || ""} 
//                     onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
//                     fullWidth 
//                     required
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.author || ""} 
//                     onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
//                     fullWidth 
//                     required
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.genre || ""} 
//                     onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
//                     fullWidth 
//                     required
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.description || ""} 
//                     onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
//                     fullWidth 
//                     required
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     type="number"
//                     value={book.published_year || ""}
//                     onChange={(e) => handleInputChange(book.id, "published_year", e.target.value)}
//                     fullWidth 
//                     required
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.cover_image_url || ""} 
//                     onChange={(e) => handleInputChange(book.id, "cover_image_url", e.target.value)} 
//                     fullWidth 
//                     placeholder="https://ejemplo.com/imagen.jpg"
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.available_file_url || ""} 
//                     onChange={(e) => handleInputChange(book.id, "available_file_url", e.target.value)} 
//                     fullWidth 
//                     placeholder="https://ejemplo.com/libro.pdf"
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <Button 
//                     variant="contained" 
//                     color="success" 
//                     onClick={() => handleUpdateBook(book)}
//                   >
//                     💾 Guardar
//                   </Button>
//                 </TableCell>
//               </TableRow>
//             ))}
//           </TableBody>
//         </Table>
//       </TableContainer>

//       {/* 📌 Snackbar para mostrar mensajes */}
//       <Snackbar open={snackbarOpen} autoHideDuration={4000} onClose={() => setSnackbarOpen(false)}>
//         <Alert onClose={() => setSnackbarOpen(false)} severity={snackbarSeverity}>
//           {snackbarMessage}
//         </Alert>
//       </Snackbar>
//     </Container>
//   );
// };

// export default EditBooksPage;

// import { useEffect, useState } from "react";
// import { 
//   Container, Typography, Table, TableBody, TableCell, TableContainer, 
//   TableHead, TableRow, Paper, TextField, Button, Snackbar, Alert, AlertColor 
// } from "@mui/material";
// import axios from "axios";

// interface Book {
//   id: number;
//   title: string;
//   author: string;
//   genre: string;
//   description: string;
//   published_year: string;
//   cover_image_url: string;
//   file_url: string;
// }

// interface SnackbarState {
//   open: boolean;
//   message: string;
//   severity: AlertColor;
// }

// const EditBooksPage = () => {
//   const [books, setBooks] = useState<Book[]>([]);
//   const [snackbar, setSnackbar] = useState<SnackbarState>({
//     open: false,
//     message: "",
//     severity: "success",
//   });

//   useEffect(() => {
//     fetchBooks();
//   }, []);

//   const fetchBooks = async () => {
//     try {
//       const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
//       setBooks(res.data);
//     } catch (error) {
//       console.error("❌ Error obteniendo libros:", error);
//       setSnackbar({ open: true, message: "No se pudieron cargar los libros.", severity: "error" });
//     }
//   };

//   const handleInputChange = (id: number, field: keyof Book, value: string) => {
//     setBooks((prevBooks) =>
//       prevBooks.map((book) =>
//         book.id === id ? { ...book, [field]: value } : book
//       )
//     );
//   };
  

//   const handleUpdateBook = async (book: Book) => {
//     try {
//       const token = localStorage.getItem("token");
//       if (!token) {
//         alert("⚠️ Debes iniciar sesión para actualizar libros.");
//         return;
//       }

//       const updatedBook = {
//         title: book.title,
//         author: book.author,
//         genre: book.genre,
//         description: book.description,
//         published_year: book.published_year,
//         cover_image_url: book.cover_image_url || "", // ✅ Asegura que siempre se envíe un string
//       file_url: book.file_url || "", 
//       };

//       await axios.put(`${import.meta.env.VITE_API_URL}/books/${book.id}`, updatedBook, {
//         headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
//       });

//       setSnackbar({ open: true, message: "📚 Libro actualizado correctamente.", severity: "success" });
//     } catch (error) {
//       console.error("❌ Error al actualizar el libro:", error);
//       setSnackbar({ open: true, message: "Error al actualizar el libro.", severity: "error" });
//     }
//   };

//   return (
//     <Container sx={{ marginTop: 5 }}>
//       <Typography variant="h3" align="center">✏️ Editar Libros</Typography>
//       <TableContainer component={Paper} sx={{ marginTop: 3 }}>
//         <Table>
//           <TableHead>
//             <TableRow>
//               <TableCell>Título</TableCell>
//               <TableCell>Autor</TableCell>
//               <TableCell>Género</TableCell>
//               <TableCell>Descripción</TableCell>
//               <TableCell>Año Publicación</TableCell>
//               <TableCell>Portada (URL)</TableCell>
//               <TableCell>Archivo (URL)</TableCell>
//               <TableCell>Acciones</TableCell>
//             </TableRow>
//           </TableHead>
//           <TableBody>
//             {books.map((book) => (
//               <TableRow key={book.id}>
//                 <TableCell>
//                   <TextField 
//                     value={book.title} 
//                     onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.author} 
//                     onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.genre} 
//                     onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.description} 
//                     onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//                   <TextField 
//                     value={book.published_year} 
//                     onChange={(e) => handleInputChange(book.id, "published_year", e.target.value)} 
//                     fullWidth 
//                   />
//                 </TableCell>
//                 <TableCell>
//   <TextField 
//     value={book.cover_image_url || ""} 
//     onChange={(e) => handleInputChange(book.id, "cover_image_url", e.target.value)} 
//     fullWidth 
//   />
// </TableCell>
// <TableCell>
//   <TextField 
//     value={book.file_url || ""} 
//     onChange={(e) => handleInputChange(book.id, "file_url", e.target.value)} 
//     fullWidth 
//   />
// </TableCell>


//                 <TableCell>
//                   <Button 
//                     variant="contained" 
//                     color="success" 
//                     onClick={() => handleUpdateBook(book)}
//                   >
//                     💾 Guardar
//                   </Button>
//                 </TableCell>
//               </TableRow>
//             ))}
//           </TableBody>
//         </Table>
//       </TableContainer>

//       {/* 📌 Snackbar para mostrar mensajes */}
//       <Snackbar 
//         open={snackbar.open} 
//         autoHideDuration={4000} 
//         onClose={() => setSnackbar({ ...snackbar, open: false })}
//       >
//         <Alert severity={snackbar.severity}>{snackbar.message}</Alert>
//       </Snackbar>
//     </Container>
//   );
// };

// export default EditBooksPage;

import { useEffect, useState } from "react";
import { 
  Container, Typography, Table, TableBody, TableCell, TableContainer, 
  TableHead, TableRow, Paper, TextField, Button, Snackbar, Alert, AlertColor 
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
  file_url: string;
}

interface SnackbarState {
  open: boolean;
  message: string;
  severity: AlertColor;
}

const EditBooksPage = () => {
  const [books, setBooks] = useState<Book[]>([]);
  const [snackbar, setSnackbar] = useState<SnackbarState>({
    open: false,
    message: "",
    severity: "success",
  });

  useEffect(() => {
    fetchBooks();
  }, []);

  const fetchBooks = async () => {
    try {
      const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/books`);
      setBooks(res.data);
    } catch (error) {
      console.error("❌ Error obteniendo libros:", error);
      setSnackbar({ open: true, message: "No se pudieron cargar los libros.", severity: "error" });
    }
  };

  const handleInputChange = (id: number, field: keyof Book, value: string) => {
    setBooks((prevBooks) =>
      prevBooks.map((book) =>
        book.id === id ? { ...book, [field]: value } : book
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
        cover_image_url: book.cover_image_url || "", // ✅ Asegura que siempre se envíe un string
        file_url: book.file_url || "", 
      };

      await axios.put(`${import.meta.env.VITE_API_URL}/books/${book.id}`, updatedBook, {
        headers: { "Content-Type": "application/json", Authorization: `Bearer ${token}` },
      });

      setSnackbar({ open: true, message: "📚 Libro actualizado correctamente.", severity: "success" });
    } catch (error) {
      console.error("❌ Error al actualizar el libro:", error);
      setSnackbar({ open: true, message: "Error al actualizar el libro.", severity: "error" });
    }
  };

  // ✅ Función para eliminar un libro
  const handleDeleteBook = async (bookId: number) => {
    try {
      const token = localStorage.getItem("token");
      if (!token) {
        alert("⚠️ Debes iniciar sesión para eliminar libros.");
        return;
      }

      if (!window.confirm("¿Estás seguro de que deseas eliminar este libro?")) {
        return; // Cancelar la acción si el usuario no confirma
      }

      await axios.delete(`${import.meta.env.VITE_API_URL}/books/${bookId}`, {
        headers: { Authorization: `Bearer ${token}` },
      });

      // 🗑️ Filtrar los libros para remover el eliminado
      setBooks((prevBooks) => prevBooks.filter((book) => book.id !== bookId));

      setSnackbar({ open: true, message: "📚 Libro eliminado correctamente.", severity: "success" });
    } catch (error) {
      console.error("❌ Error al eliminar el libro:", error);
      setSnackbar({ open: true, message: "Error al eliminar el libro.", severity: "error" });
    }
  };

  return (
    <Container sx={{ marginTop: 5 }}>
      <Typography variant="h3" align="center">✏️ Editar Libros</Typography>
      <TableContainer component={Paper} sx={{ marginTop: 3 }}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>Título</TableCell>
              <TableCell>Autor</TableCell>
              <TableCell>Género</TableCell>
              <TableCell>Descripción</TableCell>
              <TableCell>Año Publicación</TableCell>
              <TableCell>Portada (URL)</TableCell>
              <TableCell>Archivo (URL)</TableCell>
              <TableCell>Acciones</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {books.map((book) => (
              <TableRow key={book.id}>
                <TableCell>
                  <TextField 
                    value={book.title} 
                    onChange={(e) => handleInputChange(book.id, "title", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.author} 
                    onChange={(e) => handleInputChange(book.id, "author", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.genre} 
                    onChange={(e) => handleInputChange(book.id, "genre", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.description} 
                    onChange={(e) => handleInputChange(book.id, "description", e.target.value)} 
                    fullWidth 
                  />
                </TableCell>
                <TableCell>
                  <TextField 
                    value={book.published_year} 
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
                    value={book.file_url || ""} 
                    onChange={(e) => handleInputChange(book.id, "file_url", e.target.value)} 
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
                  <Button 
                    variant="contained" 
                    color="error" 
                    sx={{ marginLeft: 1 }}
                    onClick={() => handleDeleteBook(book.id)}
                  >
                    🗑️ Eliminar
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {/* 📌 Snackbar para mostrar mensajes */}
      <Snackbar 
        open={snackbar.open} 
        autoHideDuration={4000} 
        onClose={() => setSnackbar({ ...snackbar, open: false })}
      >
        <Alert severity={snackbar.severity}>{snackbar.message}</Alert>
      </Snackbar>
    </Container>
  );
};

export default EditBooksPage;
