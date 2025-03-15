// // import { Card, CardContent, CardMedia, Typography } from "@mui/material";
// // import { useState } from "react";

// // interface BookProps {
// //   book: {
// //     id: number;
// //     title: string;
// //     author: string;
// //     cover_image_url: string;
// //   };
// // }

// // export const BookCard = ({ book }: BookProps) => {
// //   const [hovered, setHovered] = useState(false);

// //   return (
// //     <Card
// //       sx={{
// //         position: "relative",
// //         borderRadius: "12px",
// //         boxShadow: hovered ? "0 12px 20px rgba(0, 0, 0, 0.1)" : "0 4px 12px rgba(0, 0, 0, 0.1)",
// //         transition: "box-shadow 0.3s ease, transform 0.3s ease",
// //         ":hover": {
// //           transform: "scale(1.05)",
// //           boxShadow: "0 12px 20px rgba(0, 0, 0, 0.15)"
// //         }
// //       }}
// //       onMouseEnter={() => setHovered(true)}
// //       onMouseLeave={() => setHovered(false)}
// //     >
// //       {/* Imagen del Libro */}
// //       <CardMedia
// //         component="img"
// //         height="300"
// //         image={book.cover_image_url}
// //         alt={book.title}
// //         sx={{
// //           borderRadius: "12px 12px 0 0",
// //           objectFit: "cover",
// //         }}
// //       />
      
// //       <CardContent sx={{ padding: "16px" }}>
// //         {/* Título y Autor */}
// //         <Typography variant="h6" sx={{ fontWeight: 600, color: "#333", marginBottom: "8px" }}>
// //           {book.title}
// //         </Typography>
// //         <Typography variant="body2" sx={{ color: "#777" }}>
// //           Autor: {book.author}
// //         </Typography>
        
// //       </CardContent>
// //     </Card>
// //   );
// // };

// import { Card, CardContent, CardMedia, Typography } from "@mui/material";

// interface BookProps {
//   book: {
//     id: number;
//     title: string;
//     author: string;
//     cover_image_url?: string; // ✅ Opcional para evitar errores si la imagen no está disponible
//   };
// }

// export const BookCard = ({ book }: BookProps) => {
//   return (
//     <Card
//       sx={{
//         position: "relative",
//         borderRadius: 2,
//         boxShadow: "0 4px 12px rgba(0, 0, 0, 0.1)",
//         transition: "all 0.3s ease",
//         ":hover": {
//           transform: "scale(1.05)",
//           boxShadow: "0 12px 20px rgba(0, 0, 0, 0.15)",
//         },
//       }}
//     >
//       {/* Imagen del Libro */}
//       <CardMedia
//         component="img"
//         height="300"
//         image={book.cover_image_url || "/placeholder-image.jpg"} // ✅ Imagen por defecto si no hay URL
//         alt={book.title || "Imagen no disponible"}
//         sx={{
//           borderRadius: "12px 12px 0 0",
//           objectFit: "cover",
//           backgroundColor: "#f0f0f0",
//         }}
//       />

//       <CardContent sx={{ padding: 2 }}>
//         {/* Título y Autor */}
//         <Typography variant="h6" sx={{ fontWeight: 600, color: "#333", marginBottom: 1 }}>
//           {book.title || "Título no disponible"} {/* ✅ Previene errores si `title` es `null` */}
//         </Typography>
//         <Typography variant="body2" sx={{ color: "#777" }}>
//           Autor: {book.author || "Autor desconocido"} {/* ✅ Previene errores si `author` es `null` */}
//         </Typography>
//       </CardContent>
//     </Card>
//   );
// };
import { Card, CardContent, CardMedia, Typography } from "@mui/material";

interface BookProps {
  book: {
    id: number;
    title: string;
    author: string;
    cover_image_url?: string;
  };
}

export const BookCard = ({ book }: BookProps) => {
  return (
    <Card
      sx={{
        position: "relative",
        borderRadius: 2,
        boxShadow: "0 4px 12px rgba(0, 0, 0, 0.1)",
        transition: "all 0.3s ease",
        ":hover": {
          transform: "scale(1.05)",
          boxShadow: "0 12px 20px rgba(0, 0, 0, 0.15)",
        },
      }}
    >
      {/* 📌 Imagen del Libro con Respaldo */}
      <CardMedia
  component="img"
  height="300"
  image={book.cover_image_url || "/placeholder-image.jpg"} // ✅ Usa la URL en lugar de archivos locales
  alt={book.title || "Imagen no disponible"}
  sx={{
    borderRadius: "12px 12px 0 0",
    objectFit: "cover",
    backgroundColor: "#f0f0f0",
  }}
/>


      {/* 📌 Contenido del Libro */}
      <CardContent sx={{ padding: 2 }}>
        <Typography variant="h6" sx={{ fontWeight: 600, color: "#333", marginBottom: 1 }}>
          {book.title?.trim() || "Título no disponible"}
        </Typography>
        <Typography variant="body2" sx={{ color: "#777" }}>
          Autor: {book.author?.trim() || "Autor desconocido"}
        </Typography>
      </CardContent>
    </Card>
  );
};
