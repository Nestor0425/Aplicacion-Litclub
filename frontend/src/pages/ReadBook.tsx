// import { useLocation } from "react-router-dom";
// import BookReader from "../components/BookReader";
// import { Container, Typography } from "@mui/material";

// const ReadBook = () => {
//   const location = useLocation();
//   const { fileUrl, fileType } = location.state || {};

//   if (!fileUrl || !fileType) {
//     return <Typography variant="h6" align="center">❌ No se ha seleccionado un libro.</Typography>;
//   }

//   return (
//     <Container>
//       <BookReader fileUrl={fileUrl} fileType={fileType} />
//     </Container>
//   );
// };

// export default ReadBook;

import { useLocation, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import BookReader from "../components/BookReader";
import { Container, Typography, CircularProgress, Box } from "@mui/material";

const ReadBook = () => {
  const location = useLocation();
  const navigate = useNavigate();
  const [fileUrl, setFileUrl] = useState<string | null>(null);
  const [fileType, setFileType] = useState<"pdf" | "epub" | null>(null); // ✅ Solo acepta "pdf" o "epub"
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (location.state?.fileUrl && location.state?.fileType) {
      const type = location.state.fileType.toLowerCase(); // ✅ Normaliza el tipo a minúsculas
      if (type === "pdf" || type === "epub") {
        setFileUrl(location.state.fileUrl);
        setFileType(type); // ✅ Se asegura de que el tipo sea válido
        setLoading(false);
      } else {
        navigate("/books"); // Redirigir si el tipo de archivo no es válido
      }
    } else {
      setTimeout(() => {
        navigate("/books"); // Redirigir si no hay datos válidos
      }, 2000);
    }
  }, [location.state, navigate]);

  if (loading) {
    return (
      <Box sx={{ display: "flex", justifyContent: "center", alignItems: "center", height: "80vh" }}>
        <CircularProgress />
      </Box>
    );
  }

  if (!fileUrl || !fileType) {
    return (
      <Typography variant="h6" align="center" color="error" sx={{ marginTop: 5 }}>
        ❌ No se ha seleccionado un libro. Redirigiendo...
      </Typography>
    );
  }

  return (
    <Container>
      <BookReader fileUrl={fileUrl} fileType={fileType} /> {/* ✅ Ahora `fileType` siempre será "pdf" o "epub" */}
    </Container>
  );
};

export default ReadBook;
