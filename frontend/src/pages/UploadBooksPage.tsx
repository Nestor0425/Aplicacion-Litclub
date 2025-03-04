import { useState } from "react";
import { Container, Typography, Button, Box, Snackbar, Alert } from "@mui/material";
import axios from "axios";

interface ApiResponse {
    message: string;
  }
  
const UploadBooksPage = () => {
  const [selectedFile, setSelectedFile] = useState<File | null>(null);
  const [snackbarOpen, setSnackbarOpen] = useState(false);
  const [snackbarMessage, setSnackbarMessage] = useState("");
  const [snackbarSeverity, setSnackbarSeverity] = useState<"success" | "error">("success");

  const handleFileChange = (event: React.ChangeEvent<HTMLInputElement>) => {
    if (event.target.files && event.target.files.length > 0) {
      setSelectedFile(event.target.files[0]);
    }
  };

  const handleUpload = async () => {
    if (!selectedFile) {
      alert("⚠️ Selecciona un archivo CSV antes de subirlo.");
      return;
    }

    try {
      const token = localStorage.getItem("token");
      if (!token) {
        alert("⚠️ Debes iniciar sesión para subir libros.");
        return;
      }

      const formData = new FormData();
      formData.append("file", selectedFile);

      const res = await axios.post<ApiResponse>(`${import.meta.env.VITE_API_URL}/books/upload-csv`, formData, {
        headers: {
          "Content-Type": "multipart/form-data",
          Authorization: `Bearer ${token}`,
        },
      });

      setSnackbarMessage(res.data.message);
      setSnackbarSeverity("success");
      setSnackbarOpen(true);
      setSelectedFile(null);
    } catch (error) {
      console.error("❌ Error al subir el archivo CSV:", error);
      setSnackbarMessage("Error al subir el archivo CSV. Inténtalo de nuevo.");
      setSnackbarSeverity("error");
      setSnackbarOpen(true);
    }
  };

  return (
    <Container sx={{ textAlign: "center", marginTop: 5 }}>
      <Typography variant="h4">📂 Subir Libros desde CSV</Typography>

      <Box sx={{ marginTop: 3 }}>
        <input type="file" accept=".csv" onChange={handleFileChange} />
      </Box>

      <Button
        variant="contained"
        color="primary"
        sx={{ marginTop: 3 }}
        onClick={handleUpload}
        disabled={!selectedFile}
      >
        📤 Subir CSV
      </Button>

      {/* 📌 Notificaciones Snackbar */}
      <Snackbar open={snackbarOpen} autoHideDuration={4000} onClose={() => setSnackbarOpen(false)}>
        <Alert onClose={() => setSnackbarOpen(false)} severity={snackbarSeverity}>
          {snackbarMessage}
        </Alert>
      </Snackbar>
    </Container>
  );
};

export default UploadBooksPage;
