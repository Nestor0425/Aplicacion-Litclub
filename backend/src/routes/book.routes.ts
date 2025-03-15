// // import express from "express";
// // import multer from "multer";

// // import { authenticateToken } from "../middlewares/auth.middleware";
// // import { addBook, getBooks, getLatestBooks, getBookFile, updateBook } from "../controllers/book.controller";
// // import path from "path";
// // const router = express.Router();

// // // 📂 Configurar almacenamiento de archivos PDF
// // const storage = multer.diskStorage({
// //   destination: (req, file, cb) => {
// //     cb(null, "uploads/"); // 📁 Guardar archivos en la carpeta 'uploads'
// //   },
// //   filename: (req, file, cb) => {
// //     cb(null, Date.now() + "-" + file.originalname); // 🔖 Agregar timestamp al nombre del archivo
// //   },
// // });

// // // 📌 Ruta para servir archivos PDF
// // router.get("/file/:fileName", (req, res) => {
// //   const filePath = path.join(__dirname, "..", "uploads", req.params.fileName);
  
// //   res.setHeader("Content-Type", "application/pdf"); // ✅ Asegurar tipo MIME correcto
// //   res.sendFile(filePath, (err) => {
// //       if (err) {
// //           console.error("❌ Error enviando archivo:", err);
// //           res.status(500).send("Error al cargar el archivo.");
// //       }
// //   });
// // });
// // const upload = multer({ storage });

// // // ✅ Ruta para obtener todos los libros
// // router.get("/", getBooks);

// // // ✅ Ruta para obtener los últimos libros agregados
// // router.get("/latest", getLatestBooks);

// // // ✅ Ruta para agregar un libro (con autenticación y subida de archivos)
// // router.post("/", authenticateToken, upload.single("file"), addBook);

// // // ✅ Ruta para obtener el archivo PDF de un libro
// // router.get("/file/:id", getBookFile);

// // // ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
// // router.put("/:id", authenticateToken, upload.single("file"), updateBook);


// // export default router;


// // import express, { Router, Request, Response } from "express";
// // import multer from "multer";
// // import fs from "fs";
// // import csv from "csv-parser";
// // import path from "path";
// // import { authenticateToken } from "../middlewares/auth.middleware";
// // import { addBook, getBooks, getLatestBooks, getBookFile, updateBook } from "../controllers/book.controller";
// // import pool from "../config/db";
// // import upload from "../config/multer";

// // // 📌 Definir un tipo de request extendido con `user`
// // interface AuthRequest extends Request {
// //   user?: { id: number; rol: string }; // Agregar propiedad `user`
// // }

// // const router = Router();

// // // 📂 Configurar almacenamiento de archivos PDF
// // const storage = multer.diskStorage({
// //   destination: (req, file, cb) => {
// //     cb(null, "uploads/"); // 📁 Guardar archivos en la carpeta 'uploads'
// //   },
// //   filename: (req, file, cb) => {
// //     cb(null, Date.now() + "-" + file.originalname); // 🔖 Agregar timestamp al nombre del archivo
// //   },
// // });

// // // ✅ Middleware de Multer para subir archivos PDF y CSV


// // // ✅ Ruta para servir archivos PDF
// // router.get("/file/:fileName", (req, res) => {
// //   const filePath = path.join(__dirname, "..", "uploads", req.params.fileName);

// //   res.setHeader("Content-Type", "application/pdf"); // ✅ Asegurar tipo MIME correcto
// //   res.sendFile(filePath, (err) => {
// //     if (err) {
// //       console.error("❌ Error enviando archivo:", err);
// //       res.status(500).send("Error al cargar el archivo.");
// //     }
// //   });
// // });

// // // ✅ Ruta para obtener todos los libros
// // router.get("/", async (req: Request, res: Response) => {
// //   try {
// //     await getBooks(req, res);
// //   } catch (error) {
// //     console.error("Error en la ruta /books:", error);
// //     res.status(500).json({ message: "Error interno del servidor" });
// //   }
// // });

// // router.post("/books", upload.single("file"), addBook);
// // router.put("/books/:id", upload.single("file"), updateBook);
// // router.get("/books", getBooks);
// // router.get("/books/latest", getLatestBooks);
// // router.get("/books/file/:id", getBookFile);


// // // ✅ Ruta para obtener los últimos libros agregados
// // router.get("/latest", getLatestBooks);

// // // ✅ Ruta para agregar un libro (con autenticación y subida de archivos PDF)
// // router.post("/", authenticateToken, upload.single("file"), addBook);

// // // ✅ Ruta para obtener el archivo PDF de un libro
// // router.get("/file/:id", getBookFile);

// // // ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
// // router.put("/:id", authenticateToken, upload.single("file"), updateBook);

// // // ✅ Ruta para subir y procesar un archivo CSV
// // // ✅ Ruta para subir y procesar un archivo CSV
// // // ✅ Ruta para subir y procesar un archivo CSV
// // // ✅ Ruta para subir y procesar un archivo CSV
// // // 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// // // 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// // router.post("/upload-csv", authenticateToken, upload.single("file"), async (req: AuthRequest, res: Response): Promise<void> => {
// //   try {
// //     if (!req.user || req.user.rol !== "admin") {
// //       res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
// //       return;
// //     }

// //     if (!req.file) {
// //       res.status(400).json({ message: "No se ha subido ningún archivo." });
// //       return;
// //     }

// //     const books: any[] = [];

// //     // 📌 Leer el archivo CSV
// //     fs.createReadStream(req.file.path)
// //       .pipe(csv())
// //       .on("data", (row) => {
// //         books.push(row);
// //       })
// //       .on("end", async () => {
// //         if (books.length === 0) {
// //           res.status(400).json({ message: "El archivo CSV está vacío." });
// //           return;
// //         }

// //         try {
// //           // 📌 Insertar múltiples libros en PostgreSQL con `unnest()`
// //           const query = `
// //             INSERT INTO books (title, author, genre, description, published_year, cover_image_url, available_file_url)
// // SELECT * FROM unnest(
// //   $1::text[], $2::text[], $3::text[], $4::text[], $5::integer[], $6::text[], $7::text[]

// //             )
// //           `;

// //           const values = [
// //             books.map(book => book.title || ""),
// //             books.map(book => book.author || ""),
// //             books.map(book => book.genre || ""),
// //             books.map(book => book.description || ""),
// //             books.map(book => parseInt(book.published_year, 10) || null),
// //             books.map(book => book.cover_image_url || ""),
// //             books.map(book => book.available_file_url || ""),
// //           ];

// //           await pool.query(query, values);

// //           res.json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });

// //         } catch (error) {
// //           console.error("❌ Error al insertar los libros:", error);
// //           res.status(500).json({ message: "Error al procesar los datos del CSV." });
// //         } finally {
// //           // ✅ Eliminar el archivo CSV después de procesarlo
// //           if (req.file) {
// //             fs.unlink(req.file.path, (err) => {
// //               if (err) console.error("❌ Error al eliminar el archivo CSV:", err);
// //             });
// //           }
// //         }
// //       });

// //   } catch (error) {
// //     console.error("❌ Error al subir y procesar el archivo CSV:", error);
// //     res.status(500).json({ message: "Error interno del servidor" });
// //   }
// // });

// // export default router;

// // import express, { Router, Request, Response } from "express";
// // import multer from "multer";
// // import fs from "fs";
// // import csv from "csv-parser";
// // import path from "path";
// // import { authenticateToken } from "../middlewares/auth.middleware";
// // import { addBook, getBooks, getLatestBooks, getBookFile, updateBook, deleteBook } from "../controllers/book.controller";
// // import pool from "../config/db";
// // import upload from "../config/multer";

// // // 📌 Definir un tipo de request extendido con `user`
// // interface AuthRequest extends Request {
// //   user?: { id: number; rol: string }; // Agregar propiedad `user`
// //   file?: Express.Multer.File;
// // }



// // const router = Router();

// // // ✅ Ruta para obtener todos los libros
// // router.get("/", getBooks);

// // // ✅ Ruta para obtener los últimos libros agregados
// // router.get("/latest", getLatestBooks);

// // // ✅ Ruta para agregar un libro (con autenticación y subida de archivos PDF)
// // router.post("/", authenticateToken, upload.single("file"), addBook);

// // // ✅ Ruta para obtener el archivo PDF de un libro
// // router.get("/file/:id", getBookFile);

// // // ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
// // router.put("/:id", authenticateToken, upload.single("file"), updateBook);



// // // 📌 Ruta para servir archivos PDF correctamente tipada
// // router.get("/file/:fileName", async (req: Request<{ fileName: string }>, res: Response): Promise<void> => {
// //   try {
// //     const { fileName } = req.params;
// //     const filePath = path.join(__dirname, "..", "uploads", fileName);

// //     if (!fs.existsSync(filePath)) {
// //       res.status(404).json({ message: "Archivo no encontrado." });
// //       return;
// //     }

// //     res.setHeader("Content-Type", "application/pdf");
// //     res.sendFile(filePath, (err) => {
// //       if (err) {
// //         console.error("❌ Error enviando archivo:", err);
// //         res.status(500).send("Error al cargar el archivo.");
// //       }
// //     });
// //   } catch (error) {
// //     console.error("❌ Error en la descarga del archivo:", error);
// //     res.status(500).json({ message: "Error interno del servidor." });
// //   }
// // });


// // // 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// // // 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// // router.post("/upload-csv", authenticateToken, upload.single("file"), async (req: AuthRequest, res: Response): Promise<void> => {
// //   try {
// //     if (!req.user || req.user.rol !== "admin") {
// //       res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
// //       return;
// //     }

// //     if (!req.file) {
// //       res.status(400).json({ message: "No se ha subido ningún archivo." });
// //       return;
// //     }

// //     const books: any[] = [];

// //     // 📌 Leer el archivo CSV
// //     fs.createReadStream(req.file.path)
// //       .pipe(csv())
// //       .on("data", (row) => {
// //         books.push(row);
// //       })
// //       .on("end", async () => {
// //         if (books.length === 0) {
// //           res.status(400).json({ message: "El archivo CSV está vacío." });
// //           return;
// //         }

// //         try {
// //           // 📌 Insertar múltiples libros en PostgreSQL con parámetros dinámicos
// //           const query = `
// //             INSERT INTO books (title, author, genre, description, published_year, cover_image_url, available_file_url)
// //             VALUES ${books.map((_, i) => `($${i * 7 + 1}, $${i * 7 + 2}, $${i * 7 + 3}, $${i * 7 + 4}, $${i * 7 + 5}, $${i * 7 + 6}, $${i * 7 + 7})`).join(", ")}
// //           `;

// //           const values = books.flatMap(book => [
// //             book.title || "",
// //             book.author || "",
// //             book.genre || "",
// //             book.description || "",
// //             parseInt(book.published_year, 10) || null,
// //             book.cover_image_url || "",
// //             book.available_file_url || "",
// //           ]);

// //           await pool.query(query, values);

// //           res.json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });
// //         } catch (error) {
// //           console.error("❌ Error al insertar los libros:", error);
// //           res.status(500).json({ message: "Error al procesar los datos del CSV." });
// //         } finally {
// //           // ✅ Eliminar el archivo CSV después de procesarlo si existe
// //           if (req.file?.path) {
// //             fs.unlink(req.file.path, (err) => {
// //               if (err) console.error("❌ Error al eliminar el archivo CSV:", err);
// //             });
// //           }
// //         }
// //       });

// //   } catch (error) {
// //     console.error("❌ Error al subir y procesar el archivo CSV:", error);
// //     res.status(500).json({ message: "Error interno del servidor." });
// //   }
// // });


// // export default router;
// import express, { Router, Request, Response } from "express";
// import multer from "multer";
// import fs from "fs";
// import csv from "csv-parser";
// import path from "path";
// import format from "pg-format";
// import { authenticateToken } from "../middlewares/auth.middleware";
// import { addBook, getBooks, getLatestBooks, getBookFile, updateBook, deleteBook } from "../controllers/book.controller";
// import pool from "../config/db";
// import upload from "../config/multer";

// // 📌 Definir un tipo de request extendido con `user`
// interface AuthRequest extends Request {
//   user?: { id: number; rol: string };
//   file?: Express.Multer.File;
// }

// const router = Router();

// // ✅ Obtener todos los libros
// router.get("/", getBooks);

// // ✅ Obtener los últimos libros agregados
// router.get("/latest", getLatestBooks);

// // ✅ Agregar un libro con autenticación y subida de archivos PDF
// router.post("/", authenticateToken, upload.fields("file"), addBook);

// // ✅ Obtener el archivo PDF de un libro
// router.get("/file/:id", getBookFile);

// // ✅ Actualizar un libro (incluye actualización de archivo PDF)
// router.put("/:id", authenticateToken, upload.fields([
//   { name: "cover_image", maxCount: 1 }, 
//   { name: "file", maxCount: 1 }
// ]), updateBook);


// // ✅ Eliminar un libro
// router.delete("/:id", authenticateToken, deleteBook);

// // 📌 Servir archivos PDF de manera segura
// router.get("/file/download/:fileName", async (req: Request, res: Response) => {
//   try {
//     const { fileName } = req.params;
//     const filePath = path.join(__dirname, "..", "uploads", fileName);

//     if (!fs.existsSync(filePath)) {
//       res.status(404).json({ message: "Archivo no encontrado." });
//       return;
//     }

//     res.setHeader("Content-Type", "application/pdf");
//     res.sendFile(filePath, (err) => {
//       if (err) {
//         console.error("❌ Error enviando archivo:", err);
//         res.status(500).send("Error al cargar el archivo.");
//       }
//     });
//   } catch (error) {
//     console.error("❌ Error en la descarga del archivo:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// });

// // 📌 Subir un archivo CSV y agregar libros masivamente
// router.post("/upload-csv", authenticateToken, upload.fields([{ name: "file", maxCount: 1 }]), async (req: AuthRequest, res: Response): Promise<void> => {
//   try {
//     if (!req.user || req.user.rol !== "admin") {
//       res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
//       return;
//     }

//     if (!req.files?.file?.[0]) {
//       res.status(400).json({ message: "No se ha subido ningún archivo." });
//       return;
//     }

//     const filePath = req.files.file[0].path;
//     const books: any[] = [];

//     // 📌 Leer el archivo CSV
//     fs.createReadStream(filePath)
//       .pipe(csv())
//       .on("data", (row) => {
//         books.push(row);
//       })
//       .on("end", async () => {
//         if (books.length === 0) {
//           res.status(400).json({ message: "El archivo CSV está vacío." });
//           return;
//         }

//         try {
//           // 📌 Construir la consulta de inserción masiva
//           const values = books.map(book => [
//             book.title || "",
//             book.author || "",
//             book.genre || "",
//             book.description || "",
//             parseInt(book.published_year, 10) || null,
//             book.cover_image_url || "",
//             book.file_url || "",
//           ]);

//           const query = format(`
//             INSERT INTO books (title, author, genre, description, published_year, cover_image_url, file_url)
//             VALUES %L RETURNING id
//           `, values);

//           await pool.query(query);

//           res.status(201).json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });
//         } catch (error) {
//           console.error("❌ Error al insertar los libros:", error);
//           res.status(500).json({ message: "Error al procesar los datos del CSV." });
//         } finally {
//           // ✅ Eliminar el archivo CSV después de procesarlo
//           fs.unlink(filePath, (err) => {
//             if (err) console.error("❌ Error al eliminar el archivo CSV:", err);
//           });
//         }
//       });

//   } catch (error) {
//     console.error("❌ Error al subir y procesar el archivo CSV:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// });



// export default router;
import express, { Router, Request, Response, NextFunction } from "express";
import multer from "multer";
import fs from "fs";
import csv from "csv-parser";
import path from "path";
import format from "pg-format";
import { authenticateToken } from "../middlewares/auth.middleware";
import { addBook, getBooks, getLatestBooks, getBookFile, updateBook, deleteBook } from "../controllers/book.controller";
import pool from "../config/db";
import upload from "../config/multer"; // ✅ Importar correctamente el middleware de `multer`

// 📌 Definir un tipo de request extendido con `user` y `files`
interface AuthRequest extends Request {
  user?: { id: number; rol: string };
  files?: { [fieldname: string]: Express.Multer.File[] } | Express.Multer.File[] | undefined;
}


const router = Router();

// ✅ Middleware de manejo de `multer`
const handleUpload = (req: Request, res: Response, next: NextFunction) => {
  upload(req, res, (err: any) => {
    if (err instanceof multer.MulterError) {
      return res.status(400).json({ message: "Error al subir el archivo: " + err.message });
    } else if (err) {
      return res.status(500).json({ message: "Error de servidor al subir archivos" });
    }
    next();
  });
};

// ✅ Obtener todos los libros
router.get("/", getBooks);

// ✅ Obtener los últimos libros agregados
router.get("/latest", getLatestBooks);

// ✅ Agregar un libro con autenticación y subida de archivos
router.post("/", authenticateToken, handleUpload, addBook);

// ✅ Obtener el archivo PDF de un libro
router.get("/file/:id", getBookFile);

// ✅ Actualizar un libro (incluye actualización de portada y archivo PDF)
router.put("/:id", authenticateToken, handleUpload, updateBook);

// ✅ Eliminar un libro
router.delete("/:id", authenticateToken, deleteBook);

// 📌 Servir archivos PDF de manera segura
router.get("/file/download/:fileName", async (req: Request, res: Response) => {
  try {
    const { fileName } = req.params;
    const filePath = path.join(__dirname, "..", "uploads", fileName);

    if (!fs.existsSync(filePath)) {
      res.status(404).json({ message: "Archivo no encontrado." });
      return;
    }

    res.setHeader("Content-Type", "application/pdf");
    res.sendFile(filePath, (err) => {
      if (err) {
        console.error("❌ Error enviando archivo:", err);
        res.status(500).send("Error al cargar el archivo.");
      }
    });
  } catch (error) {
    console.error("❌ Error en la descarga del archivo:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
});

// 📌 Subir un archivo CSV y agregar libros masivamente
router.post(
  "/upload-csv",
  authenticateToken,
  handleUpload,
  async (req: AuthRequest, res: Response) => {
    try {
      if (!req.user || req.user.rol !== "admin") {
        res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
        return;
      }

      const uploadedFiles = req.files as { [fieldname: string]: Express.Multer.File[] };
      if (!uploadedFiles?.file?.[0]) {
        res.status(400).json({ message: "No se ha subido ningún archivo." });
        return;
      }

      console.log("✅ Archivo recibido:", req.file);


      const filePath = uploadedFiles.file[0].path;
      const books: any[] = [];

      // 📌 Leer el archivo CSV
      fs.createReadStream(filePath)
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
            // 📌 Construir la consulta de inserción masiva
            const values = books.map((book) => [
              book.title || "",
              book.author || "",
              book.genre || "",
              book.description || "",
              parseInt(book.published_year, 10) || null,
              book.cover_image_url || "",
              book.file_url || "",
            ]);

            const query = format(
              `
            INSERT INTO books (title, author, genre, description, published_year, cover_image_url, file_url)
            VALUES %L RETURNING id
          `,
              values
            );

            await pool.query(query);

            res.status(201).json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });
          } catch (error) {
            console.error("❌ Error al insertar los libros:", error);
            res.status(500).json({ message: "Error al procesar los datos del CSV." });
          } finally {
            // ✅ Eliminar el archivo CSV después de procesarlo
            fs.unlink(filePath, (err) => {
              if (err) console.error("❌ Error al eliminar el archivo CSV:", err);
            });
          }
        });
    } catch (error) {
      console.error("❌ Error al subir y procesar el archivo CSV:", error);
      res.status(500).json({ message: "Error interno del servidor." });
    }
  }
);


export default router;

