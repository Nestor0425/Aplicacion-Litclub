import { Card, CardContent, CardMedia, Typography } from "@mui/material";
import { useState } from "react";

interface BookProps {
  book: {
    id: number;
    title: string;
    author: string;
    cover_image_url: string;
  };
}

export const BookCard = ({ book }: BookProps) => {
  const [hovered, setHovered] = useState(false);

  return (
    <Card
      sx={{
        position: "relative",
        borderRadius: "12px",
        boxShadow: hovered ? "0 12px 20px rgba(0, 0, 0, 0.1)" : "0 4px 12px rgba(0, 0, 0, 0.1)",
        transition: "box-shadow 0.3s ease, transform 0.3s ease",
        ":hover": {
          transform: "scale(1.05)",
          boxShadow: "0 12px 20px rgba(0, 0, 0, 0.15)"
        }
      }}
      onMouseEnter={() => setHovered(true)}
      onMouseLeave={() => setHovered(false)}
    >
      {/* Imagen del Libro */}
      <CardMedia
        component="img"
        height="300"
        image={book.cover_image_url}
        alt={book.title}
        sx={{
          borderRadius: "12px 12px 0 0",
          objectFit: "cover",
        }}
      />
      
      <CardContent sx={{ padding: "16px" }}>
        {/* Título y Autor */}
        <Typography variant="h6" sx={{ fontWeight: 600, color: "#333", marginBottom: "8px" }}>
          {book.title}
        </Typography>
        <Typography variant="body2" sx={{ color: "#777" }}>
          Autor: {book.author}
        </Typography>
        
      </CardContent>
    </Card>
  );
};
