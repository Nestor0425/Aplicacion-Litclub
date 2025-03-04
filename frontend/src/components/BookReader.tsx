import { useState } from "react";
import { Document, Page } from "react-pdf";
import EPUBJS from "epubjs";
import { Box, Button, Typography } from "@mui/material";
import "react-pdf/dist/esm/Page/AnnotationLayer.css";
import "react-pdf/dist/esm/Page/TextLayer.css";

interface BookReaderProps {
  fileUrl: string; // URL del libro (PDF o EPUB)
  fileType: "pdf" | "epub"; // Tipo de archivo
}

const BookReader: React.FC<BookReaderProps> = ({ fileUrl, fileType }) => {
  const [numPages, setNumPages] = useState<number | null>(null);
  const [pageNumber, setPageNumber] = useState(1);
  const [epubContent, setEpubContent] = useState<string | null>(null);

  // Función para cargar EPUB
  const loadEpub = () => {
    const book = EPUBJS(fileUrl);
    book.renderTo("epub-viewer", { width: "100%", height: "600px" });
    setEpubContent("Cargando EPUB...");
  };

  return (
    <Box sx={{ textAlign: "center", padding: 3 }}>
      <Typography variant="h5">📖 Visor de Libros</Typography>

      {fileType === "pdf" ? (
        <>
          <Document file={fileUrl} onLoadSuccess={({ numPages }) => setNumPages(numPages)}>
            <Page pageNumber={pageNumber} width={600} />
          </Document>
          <Box sx={{ marginTop: 2 }}>
            <Button onClick={() => setPageNumber(pageNumber - 1)} disabled={pageNumber <= 1}>
              ◀ Anterior
            </Button>
            <Typography display="inline" sx={{ margin: "0 10px" }}>
              Página {pageNumber} de {numPages}
            </Typography>
            <Button onClick={() => setPageNumber(pageNumber + 1)} disabled={pageNumber >= (numPages || 1)}>
              Siguiente ▶
            </Button>
          </Box>
        </>
      ) : (
        <Box sx={{ marginTop: 3 }}>
          <Button onClick={loadEpub} variant="contained" color="primary">
            📖 Cargar EPUB
          </Button>
          <Box id="epub-viewer" sx={{ width: "100%", height: "600px", marginTop: 2 }}></Box>
          {epubContent && <Typography>{epubContent}</Typography>}
        </Box>
      )}
    </Box>
  );
};

export default BookReader;
