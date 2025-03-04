import { Paper, Typography, Box, Button, IconButton } from "@mui/material";
import { useState } from "react";
import ThumbUpIcon from "@mui/icons-material/ThumbUp";
import ShareIcon from "@mui/icons-material/Share";

export const MotivationalQuote = () => {
  const quotes = [
    "“Un libro es un sueño que tienes en tus manos.” - Neil Gaiman",
    "“Un libro puede ser una puerta hacia un mundo nuevo.” - C.S. Lewis",
    "“La lectura es a la mente lo que el ejercicio es al cuerpo.” - Joseph Addison",
    "“Hay no mejores amigos que los libros.” - Charles W. Eliot",
  ];

  const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];

  const [likes, setLikes] = useState(0);
  const [shared, setShared] = useState(false);

  const handleLike = () => setLikes(likes + 1);
  const handleShare = () => setShared(true);

  return (
    <Paper className="dashboard-section" sx={{ position: "relative", padding: 3, backgroundColor: "#f9f9f9", borderRadius: "10px", boxShadow: "0px 8px 15px rgba(0, 0, 0, 0.1)" }}>
      {/* Motivational Quote Text */}
      <Typography variant="h5" sx={{ fontWeight: "bold", color: "#333", marginBottom: 2 }}>
        ✨ Historia Motivadora
      </Typography>
      <Typography variant="h6" sx={{ fontStyle: "italic", color: "#4caf50", marginBottom: 3 }}>
        {randomQuote}
      </Typography>

      {/* Like and Share buttons */}
      <Box sx={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <Box sx={{ display: "flex", alignItems: "center" }}>
          <IconButton color="primary" onClick={handleLike}>
            <ThumbUpIcon />
          </IconButton>
          <Typography variant="body2" sx={{ marginLeft: 1 }}>
            {likes} {likes === 1 ? "Me gusta" : "Me gustan"}
          </Typography>
        </Box>
        <Button variant="contained" color="secondary" onClick={handleShare} sx={{ display: "flex", alignItems: "center" }}>
          <ShareIcon sx={{ marginRight: 1 }} />
          {shared ? "¡Compartido!" : "Compartir"}
        </Button>
      </Box>

      {/* Background Decoration */}
      <Box sx={{
        position: "absolute",
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        backgroundImage: "url('https://via.placeholder.com/300')",
        backgroundSize: "cover",
        backgroundPosition: "center",
        opacity: 0.1,
        borderRadius: "10px",
        zIndex: -1
      }} />
    </Paper>
  );
};
