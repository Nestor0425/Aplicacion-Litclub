import { useEffect, useState } from "react";
import { Typography, Grid, Card, CardContent, CardMedia, Button, Container } from "@mui/material";
import axios from "axios";

interface Book {
  id: number;
  title: string;
  author: string;
  cover_image_url: string;
  price: number;
}

const Marketplace = () => {
  const [books, setBooks] = useState<Book[]>([]);
  const [cart, setCart] = useState<number[]>([]);

  useEffect(() => {
    const fetchBooks = async () => {
        try {
          const res = await axios.get<Book[]>(`${import.meta.env.VITE_API_URL}/marketplace/books`);
          setBooks(res.data); // ✅ Ahora TypeScript sabe que res.data es un array de libros
        } catch (error) {
          console.error("Error obteniendo libros:", error);
        }
      };
      

    fetchBooks();
  }, []);

  const addToCart = async (bookId: number) => {
    try {
      await axios.post(`${import.meta.env.VITE_API_URL}/marketplace/cart`, { userId: 1, bookId });
      setCart([...cart, bookId]);
    } catch (error) {
      console.error("Error al agregar al carrito:", error);
    }
  };

  return (
    <Container sx={{ marginTop: 5 }}>
      <Typography variant="h3" align="center">🛒 Marketplace de Libros</Typography>
      <Grid container spacing={3} sx={{ marginTop: 3 }}>
        {books.map((book) => (
          <Grid item xs={12} sm={4} md={3} key={book.id}>
            <Card>
              <CardMedia component="img" height="220" image={book.cover_image_url} alt={book.title} />
              <CardContent>
                <Typography variant="h6">{book.title}</Typography>
                <Typography variant="body2">Autor: {book.author}</Typography>
                <Typography variant="body2" color="textSecondary">💰 ${book.price}</Typography>
                <Button variant="contained" color="primary" onClick={() => addToCart(book.id)}>
                  🛍 Agregar al carrito
                </Button>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </Container>
  );
};

export default Marketplace;
