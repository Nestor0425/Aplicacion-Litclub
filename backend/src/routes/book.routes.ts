// import express from "express";
// import multer from "multer";

// import { authenticateToken } from "../middlewares/auth.middleware";
// import { addBook, getBooks, getLatestBooks, getBookFile, updateBook } from "../controllers/book.controller";
// import path from "path";
// const router = express.Router();

// // 📂 Configurar almacenamiento de archivos PDF
// const storage = multer.diskStorage({
//   destination: (req, file, cb) => {
//     cb(null, "uploads/"); // 📁 Guardar archivos en la carpeta 'uploads'
//   },
//   filename: (req, file, cb) => {
//     cb(null, Date.now() + "-" + file.originalname); // 🔖 Agregar timestamp al nombre del archivo
//   },
// });

// // 📌 Ruta para servir archivos PDF
// router.get("/file/:fileName", (req, res) => {
//   const filePath = path.join(__dirname, "..", "uploads", req.params.fileName);
  
//   res.setHeader("Content-Type", "application/pdf"); // ✅ Asegurar tipo MIME correcto
//   res.sendFile(filePath, (err) => {
//       if (err) {
//           console.error("❌ Error enviando archivo:", err);
//           res.status(500).send("Error al cargar el archivo.");
//       }
//   });
// });
// const upload = multer({ storage });

// // ✅ Ruta para obtener todos los libros
// router.get("/", getBooks);

// // ✅ Ruta para obtener los últimos libros agregados
// router.get("/latest", getLatestBooks);

// // ✅ Ruta para agregar un libro (con autenticación y subida de archivos)
// router.post("/", authenticateToken, upload.single("file"), addBook);

// // ✅ Ruta para obtener el archivo PDF de un libro
// router.get("/file/:id", getBookFile);

// // ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
// router.put("/:id", authenticateToken, upload.single("file"), updateBook);


// export default router;
import express, { Router, Request, Response } from "express";
import multer from "multer";
import fs from "fs";
import csv from "csv-parser";
import path from "path";
import { authenticateToken } from "../middlewares/auth.middleware";
import { addBook, getBooks, getLatestBooks, getBookFile, updateBook } from "../controllers/book.controller";
import pool from "../config/db";
import upload from "../config/multer";

// 📌 Definir un tipo de request extendido con `user`
interface AuthRequest extends Request {
  user?: { id: number; rol: string }; // Agregar propiedad `user`
}

const router = Router();

// 📂 Configurar almacenamiento de archivos PDF
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, "uploads/"); // 📁 Guardar archivos en la carpeta 'uploads'
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + "-" + file.originalname); // 🔖 Agregar timestamp al nombre del archivo
  },
});

// ✅ Middleware de Multer para subir archivos PDF y CSV


// ✅ Ruta para servir archivos PDF
router.get("/file/:fileName", (req, res) => {
  const filePath = path.join(__dirname, "..", "uploads", req.params.fileName);

  res.setHeader("Content-Type", "application/pdf"); // ✅ Asegurar tipo MIME correcto
  res.sendFile(filePath, (err) => {
    if (err) {
      console.error("❌ Error enviando archivo:", err);
      res.status(500).send("Error al cargar el archivo.");
    }
  });
});

// ✅ Ruta para obtener todos los libros
router.get("/", async (req: Request, res: Response) => {
  try {
    await getBooks(req, res);
  } catch (error) {
    console.error("Error en la ruta /books:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
});

router.post("/books", upload.single("file"), addBook);
router.put("/books/:id", upload.single("file"), updateBook);
router.get("/books", getBooks);
router.get("/books/latest", getLatestBooks);
router.get("/books/file/:id", getBookFile);


// ✅ Ruta para obtener los últimos libros agregados
router.get("/latest", getLatestBooks);

// ✅ Ruta para agregar un libro (con autenticación y subida de archivos PDF)
router.post("/", authenticateToken, upload.single("file"), addBook);

// ✅ Ruta para obtener el archivo PDF de un libro
router.get("/file/:id", getBookFile);

// ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
router.put("/:id", authenticateToken, upload.single("file"), updateBook);

// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// 📌 Ruta para subir un archivo CSV y agregar libros masivamente
router.post("/upload-csv", authenticateToken, upload.single("file"), async (req: AuthRequest, res: Response): Promise<void> => {
  try {
    if (!req.user || req.user.rol !== "admin") {
      res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
      return;
    }

    if (!req.file) {
      res.status(400).json({ message: "No se ha subido ningún archivo." });
      return;
    }

    const books: any[] = [];

    // 📌 Leer el archivo CSV
    fs.createReadStream(req.file.path)
      .pipe(csv())
      .on("data", (row) => {
        books.push(row);
      })
      .on("end", async () => {
        if (books.length === 0) {
          res.status(400).json({ message: "El archivo CSV está vacío." });
          return;
        }

        try {
          // 📌 Insertar múltiples libros en PostgreSQL con `unnest()`
          const query = `
            INSERT INTO books (title, author, genre, description, published_year, cover_image_url, available_file_url)
SELECT * FROM unnest(
  $1::text[], $2::text[], $3::text[], $4::text[], $5::integer[], $6::text[], $7::text[]

            )
          `;

          const values = [
            books.map(book => book.title || ""),
            books.map(book => book.author || ""),
            books.map(book => book.genre || ""),
            books.map(book => book.description || ""),
            books.map(book => parseInt(book.published_year, 10) || null),
            books.map(book => book.cover_image_url || ""),
            books.map(book => book.available_file_url || ""),
          ];

          await pool.query(query, values);

          res.json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });

        } catch (error) {
          console.error("❌ Error al insertar los libros:", error);
          res.status(500).json({ message: "Error al procesar los datos del CSV." });
        } finally {
          // ✅ Eliminar el archivo CSV después de procesarlo
          if (req.file) {
            fs.unlink(req.file.path, (err) => {
              if (err) console.error("❌ Error al eliminar el archivo CSV:", err);
            });
          }
        }
      });

  } catch (error) {
    console.error("❌ Error al subir y procesar el archivo CSV:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
});

export default router;
