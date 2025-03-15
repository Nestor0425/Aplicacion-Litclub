"use strict";
// import { Request, Response } from "express";
// import db from "../config/db";
// import path from "path";
// import fs from "fs";
// import pool from "../config/db";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteBook = exports.updateBook = exports.getBookFile = exports.getLatestBooks = exports.getBooks = exports.addBook = void 0;
const db_1 = __importDefault(require("../config/db"));
const path_1 = __importDefault(require("path"));
const fs_1 = __importDefault(require("fs"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
// ➕ Agregar un libro (con archivo PDF)
// export const addBook = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const { title, author, genre, description, published_year, available } = req.body;
//     // ✅ Convertimos `req.files` al tipo correcto
//     const files = req.files as { [fieldname: string]: Express.Multer.File[] };
//     // ✅ Verificamos que los archivos existan antes de acceder a ellos
//     const coverImage = files?.cover_image?.[0] || null; // 📂 Imagen de portada
//     const file = files?.file?.[0] || null; // 📂 Archivo PDF
//     if (!coverImage) {
//       res.status(400).json({ message: "⚠️ Se requiere una imagen de portada." });
//       return;
//     }
//     if (!file) {
//       res.status(400).json({ message: "⚠️ Se requiere un archivo PDF." });
//       return;
//     }
//     // 📌 Validar año de publicación como número
//     const year = published_year && !isNaN(Number(published_year)) ? Number(published_year) : null;
//     // 📌 Insertar en la BD
//     const result = await pool.query(
//       `INSERT INTO books (title, author, genre, description, cover_image_url, published_year, available, file_url)
//        VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
//       [
//         title,
//         author,
//         genre,
//         description,
//         `/uploads/${coverImage.filename}`, // ✅ Imagen de portada
//         year,
//         available !== undefined ? available : true, // ✅ Establece `true` si no se proporciona
//         `/uploads/${file.filename}`, // ✅ Archivo PDF
//       ]
//     );
//     res.status(201).json({ message: "📚 Libro agregado correctamente", book: result.rows[0] });
//   } catch (error) {
//     console.error("❌ Error al agregar libro:", error);
//     res.status(500).json({ message: "Error interno del servidor" });
//   }
// };
const addBook = async (req, res) => {
    try {
        const { title, author, genre, description, published_year, available, cover_image_url, file_url } = req.body;
        // 📌 Validar año de publicación como número
        const year = published_year && !isNaN(Number(published_year)) ? Number(published_year) : null;
        // 📌 Insertar en la BD
        const result = await db_1.default.query(`INSERT INTO books (title, author, genre, description, cover_image_url, published_year, available, file_url)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`, [
            title,
            author,
            genre,
            description,
            cover_image_url || null, // ✅ Ahora la imagen es una URL
            year,
            available !== undefined ? available : true,
            file_url || null, // ✅ El archivo también es una URL
        ]);
        res.status(201).json({ message: "📚 Libro agregado correctamente", book: result.rows[0] });
    }
    catch (error) {
        console.error("❌ Error al agregar libro:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
};
exports.addBook = addBook;
// 📚 Obtener todos los libros
const getBooks = async (req, res) => {
    try {
        const result = await db_1.default.query("SELECT * FROM books ORDER BY created_at DESC");
        res.json(result.rows);
    }
    catch (error) {
        console.error("❌ Error al obtener libros:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
};
exports.getBooks = getBooks;
// 📚 Obtener solo los 3 libros más recientes
const getLatestBooks = async (req, res) => {
    try {
        const result = await db_1.default.query("SELECT * FROM books ORDER BY created_at DESC LIMIT 3");
        res.json(result.rows);
    }
    catch (error) {
        console.error("❌ Error al obtener los últimos libros:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
};
exports.getLatestBooks = getLatestBooks;
// 📂 Obtener archivo PDF de un libro
const getBookFile = async (req, res) => {
    try {
        const { id } = req.params;
        const result = await db_1.default.query("SELECT file_url FROM books WHERE id = $1", [id]);
        if (result.rows.length === 0) {
            res.status(404).json({ message: "Libro no encontrado." });
            return;
        }
        const fileUrl = result.rows[0].file_url;
        if (!fileUrl) {
            res.status(404).json({ message: "Este libro no tiene archivo adjunto." });
            return;
        }
        const fullPath = path_1.default.join(__dirname, "..", "..", fileUrl);
        if (!fs_1.default.existsSync(fullPath)) {
            res.status(404).json({ message: "Archivo no encontrado." });
            return;
        }
        res.sendFile(fullPath);
    }
    catch (error) {
        console.error("❌ Error al obtener archivo:", error);
        res.status(500).json({ message: "Error interno del servidor." });
    }
};
exports.getBookFile = getBookFile;
// 🔄 Actualizar un libro
// 📌 Función para actualizar un libro
const updateBook = async (req, res) => {
    try {
        const { title, author, genre, description, published_year, cover_image_url, file_url } = req.body;
        const { id } = req.params;
        // 📌 Validar año de publicación como número
        const year = published_year && !isNaN(Number(published_year)) ? Number(published_year) : null;
        const result = await db_1.default.query(`UPDATE books 
       SET title = $1, author = $2, genre = $3, description = $4, published_year = $5, 
           cover_image_url = COALESCE($6, cover_image_url), file_url = COALESCE($7, file_url) 
       WHERE id = $8 RETURNING *`, [title, author, genre, description, year, cover_image_url || null, file_url || null, id]);
        if (result.rowCount === 0) {
            res.status(404).json({ message: "❌ Libro no encontrado" });
            return;
        }
        res.json({ message: "📚 Libro actualizado correctamente", book: result.rows[0] });
    }
    catch (error) {
        console.error("❌ Error al actualizar el libro:", error);
        res.status(500).json({ message: "Error al actualizar el libro" });
    }
};
exports.updateBook = updateBook;
// 📌 Función para eliminar un libro
const deleteBook = async (req, res) => {
    try {
        const { id } = req.params;
        // 🔍 Verificar si el libro existe
        const bookExists = await db_1.default.query("SELECT * FROM books WHERE id = $1", [id]);
        if (bookExists.rows.length === 0) {
            res.status(404).json({ message: "📕 Libro no encontrado." });
            return;
        }
        // ❌ Eliminar el libro de la base de datos
        await db_1.default.query("DELETE FROM books WHERE id = $1", [id]);
        res.status(200).json({ message: "✅ Libro eliminado correctamente." });
    }
    catch (error) {
        console.error("❌ Error al eliminar el libro:", error);
        res.status(500).json({ message: "Error interno del servidor." });
    }
};
exports.deleteBook = deleteBook;
