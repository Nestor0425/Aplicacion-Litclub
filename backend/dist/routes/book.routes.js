"use strict";
// import express from "express";
// import multer from "multer";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
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
const express_1 = require("express");
const multer_1 = __importDefault(require("multer"));
const fs_1 = __importDefault(require("fs"));
const csv_parser_1 = __importDefault(require("csv-parser"));
const path_1 = __importDefault(require("path"));
const auth_middleware_1 = require("../middlewares/auth.middleware");
const book_controller_1 = require("../controllers/book.controller");
const db_1 = __importDefault(require("../config/db"));
const router = (0, express_1.Router)();
// 📂 Configurar almacenamiento de archivos PDF
const storage = multer_1.default.diskStorage({
    destination: (req, file, cb) => {
        cb(null, "uploads/"); // 📁 Guardar archivos en la carpeta 'uploads'
    },
    filename: (req, file, cb) => {
        cb(null, Date.now() + "-" + file.originalname); // 🔖 Agregar timestamp al nombre del archivo
    },
});
// ✅ Middleware de Multer para subir archivos PDF y CSV
const upload = (0, multer_1.default)({ storage });
// ✅ Ruta para servir archivos PDF
router.get("/file/:fileName", (req, res) => {
    const filePath = path_1.default.join(__dirname, "..", "uploads", req.params.fileName);
    res.setHeader("Content-Type", "application/pdf"); // ✅ Asegurar tipo MIME correcto
    res.sendFile(filePath, (err) => {
        if (err) {
            console.error("❌ Error enviando archivo:", err);
            res.status(500).send("Error al cargar el archivo.");
        }
    });
});
// ✅ Ruta para obtener todos los libros
router.get("/", async (req, res) => {
    try {
        await (0, book_controller_1.getBooks)(req, res);
    }
    catch (error) {
        console.error("Error en la ruta /books:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
});
// ✅ Ruta para obtener los últimos libros agregados
router.get("/latest", book_controller_1.getLatestBooks);
// ✅ Ruta para agregar un libro (con autenticación y subida de archivos PDF)
router.post("/", auth_middleware_1.authenticateToken, upload.single("file"), book_controller_1.addBook);
// ✅ Ruta para obtener el archivo PDF de un libro
router.get("/file/:id", book_controller_1.getBookFile);
// ✅ Ruta para actualizar un libro (incluyendo actualización de archivo PDF)
router.put("/:id", auth_middleware_1.authenticateToken, upload.single("file"), book_controller_1.updateBook);
// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// ✅ Ruta para subir y procesar un archivo CSV
// 📌 Ruta para subir un archivo CSV y agregar libros masivamente
// 📌 Ruta para subir un archivo CSV y agregar libros masivamente
router.post("/upload-csv", auth_middleware_1.authenticateToken, upload.single("file"), async (req, res) => {
    try {
        if (!req.user || req.user.rol !== "admin") {
            res.status(403).json({ message: "No tienes permisos para subir libros en masa." });
            return;
        }
        if (!req.file) {
            res.status(400).json({ message: "No se ha subido ningún archivo." });
            return;
        }
        const books = [];
        // 📌 Leer el archivo CSV
        fs_1.default.createReadStream(req.file.path)
            .pipe((0, csv_parser_1.default)())
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
                await db_1.default.query(query, values);
                res.json({ message: `📚 Se han agregado ${books.length} libros correctamente.` });
            }
            catch (error) {
                console.error("❌ Error al insertar los libros:", error);
                res.status(500).json({ message: "Error al procesar los datos del CSV." });
            }
            finally {
                // ✅ Eliminar el archivo CSV después de procesarlo
                if (req.file) {
                    fs_1.default.unlink(req.file.path, (err) => {
                        if (err)
                            console.error("❌ Error al eliminar el archivo CSV:", err);
                    });
                }
            }
        });
    }
    catch (error) {
        console.error("❌ Error al subir y procesar el archivo CSV:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
});
exports.default = router;
