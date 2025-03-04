import { useLocation } from "react-router-dom";
import BookReader from "../components/BookReader";
import { Container, Typography } from "@mui/material";

const ReadBook = () => {
  const location = useLocation();
  const { fileUrl, fileType } = location.state || {};

  if (!fileUrl || !fileType) {
    return <Typography variant="h6" align="center">❌ No se ha seleccionado un libro.</Typography>;
  }

  return (
    <Container>
      <BookReader fileUrl={fileUrl} fileType={fileType} />
    </Container>
  );
};

export default ReadBook;
