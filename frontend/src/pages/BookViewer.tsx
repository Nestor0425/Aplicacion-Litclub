// import { useParams, useNavigate } from "react-router-dom";
// import { useEffect, useState } from "react";
// import { Button } from "@mui/material";

// const BookViewer = () => {
//   const { fileUrl } = useParams(); 
//   const navigate = useNavigate();
//   const [pdfUrl, setPdfUrl] = useState<string | null>(null);

//   useEffect(() => {
//     if (fileUrl) {
//       const decodedUrl = decodeURIComponent(fileUrl);

//       // Verifica si la URL es absoluta o relativa
//       const isAbsolute = decodedUrl.startsWith("http") || decodedUrl.startsWith("/");
//       const fullUrl = isAbsolute ? decodedUrl : `${import.meta.env.VITE_API_URL}/uploads/${decodedUrl}`;

//       setPdfUrl(fullUrl);
//     } else {
//       console.error("📁 Error: No se recibió una URL válida para el PDF.");
//     }
//   }, [fileUrl]);

//   if (!pdfUrl) {
//     return <div style={{ textAlign: "center", marginTop: "20px", color: "red" }}>⚠ No se encontró el archivo PDF.</div>;
//   }

//   return (
//     <div style={{ width: "100%", height: "100vh", display: "flex", flexDirection: "column" }}>
//       <Button 
//         variant="contained" 
//         color="primary" 
//         onClick={() => navigate(-1)} 
//         sx={{ margin: "10px", alignSelf: "flex-start" }}
//       >
//         🔙 Volver
//       </Button>

//       {/* 📌 Visor de PDF */}
//       <iframe
//         src={pdfUrl}
//         width="100%"
//         height="100%"
//         style={{ border: "none", flexGrow: 1 }}
//         title="Visor de PDF"
//         onError={() => console.error(`❌ Error al cargar el PDF: ${pdfUrl}`)}
//       ></iframe>
//     </div>
//   );
// };

// export default BookViewer;
import { useParams, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { Button } from "@mui/material";

const BookViewer = () => {
  const { fileUrl } = useParams();
  const navigate = useNavigate();
  const [pdfUrl, setPdfUrl] = useState<string | null>(null);
  const [error, setError] = useState<boolean>(false);

  useEffect(() => {
    if (fileUrl) {
      try {
        const decodedUrl = decodeURIComponent(fileUrl);
        let fullUrl = "";

        if (decodedUrl.startsWith("http") || decodedUrl.startsWith("/")) {
          fullUrl = decodedUrl;
        } else {
          fullUrl = `${import.meta.env.VITE_API_URL}/uploads/${decodedUrl}`;
        }

        setPdfUrl(fullUrl);
      } catch (error) {
        console.error("📁 Error al decodificar la URL:", error);
        setError(true);
      }
    } else {
      console.error("📁 Error: No se recibió una URL válida para el PDF.");
      setError(true);
    }
  }, [fileUrl]);

  if (error || !pdfUrl) {
    return (
      <div style={{ textAlign: "center", marginTop: "20px", color: "red" }}>
        ⚠ No se encontró el archivo PDF.
      </div>
    );
  }

  return (
    <div style={{ width: "100%", height: "100vh", display: "flex", flexDirection: "column" }}>
      <Button 
        variant="contained" 
        color="primary" 
        onClick={() => navigate(-1)} 
        sx={{ margin: "10px", alignSelf: "flex-start" }}
        aria-label="Volver a la página anterior"
      >
        🔙 Volver
      </Button>

      {/* 📌 Visor de PDF con manejo de errores */}
      <iframe
        src={pdfUrl}
        width="100%"
        height="100%"
        style={{ border: "none", flexGrow: 1 }}
        title="Visor de PDF"
        onError={() => {
          console.error(`❌ Error al cargar el PDF: ${pdfUrl}`);
          setError(true);
        }}
      ></iframe>
    </div>
  );
};

export default BookViewer;
