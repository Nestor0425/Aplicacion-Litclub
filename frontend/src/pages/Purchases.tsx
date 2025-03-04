import { useEffect, useState } from "react";
import { Typography, Grid, Card, CardContent, CardMedia, Container } from "@mui/material";
import axios from "axios";

interface Purchase {
    id: number;
    bookId: number;
    userId: number;
    title: string;
    author: string;
    cover_image_url: string;
    price: number;
    date: string;
  }

const Purchases = () => {
  const [purchases, setPurchases] = useState<Purchase[]>([]);

  useEffect(() => {
    const fetchPurchases = async () => {
        try {
          const res = await axios.get<Purchase[]>(`${import.meta.env.VITE_API_URL}/purchases`, { 
            params: { userId: 1 } 
          });
          setPurchases(res.data); // ✅ Ahora TypeScript reconoce el tipo correctamente
        } catch (error) {
          console.error("Error obteniendo compras:", error);
        }
      };

    fetchPurchases();
  }, []);

  return (
    <Container sx={{ marginTop: 5 }}>
      <Typography variant="h3" align="center">📚 Tus Libros Comprados</Typography>
      <Grid container spacing={3} sx={{ marginTop: 3 }}>
        {purchases.map((book) => (
          <Grid item xs={12} sm={4} md={3} key={book.id}>
            <Card>
              <CardMedia component="img" height="220" image={book.cover_image_url} alt={book.title} />
              <CardContent>
                <Typography variant="h6">{book.title}</Typography>
                <Typography variant="body2">Autor: {book.author}</Typography>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </Container>
  );
};

export default Purchases;
