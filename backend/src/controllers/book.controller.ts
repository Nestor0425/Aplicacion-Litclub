import { Request, Response } from "express";
import db from "../config/db";
import path from "path";
import fs from "fs";
import pool from "../config/db";

interface MulterRequest extends Request {
  file?: Express.Multer.File; // Permite acceder a req.file
}

// Obtener todos los libros ordenados por fecha de creación (más recientes primero)
export const getBooks = async (req: Request, res: Response): Promise<void> => {
  try {
    const books = await pool.query("SELECT * FROM books");
    res.json(books.rows); // ✅ Express espera que manejes la respuesta aquí
  } catch (error) {
    console.error("Error al obtener libros:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
};




// Obtener solo los 3 libros más recientes
export const getLatestBooks = async (req: Request, res: Response): Promise<void> => {
  try {
    const result = await db.query("SELECT * FROM books ORDER BY created_at DESC LIMIT 3");
    res.json(result.rows); // ✅ Solo enviar la respuesta, sin return explícito
  } catch (error) {
    console.error("Error obteniendo los últimos libros:", error);
    res.status(500).json({ message: "Error al obtener los últimos libros" });
  }
};

// 📌 Agregar un Libro con PDF
// ✅ Controlador para agregar un libro
export const addBook = async (req: Request, res: Response): Promise<void> => {
  try {
      const { title, author, genre, description, published_year } = req.body;
      const fileUrl = req.file ? `/uploads/${req.file.filename}` : null; // ✅ Asegurar la URL correcta

      if (!fileUrl) {
          res.status(400).json({ message: "❌ Debes subir un archivo PDF." });
          return;
      }

      const query = "INSERT INTO books (title, author, genre, description, published_year, file_url) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *";
      const values = [title, author, genre, description, published_year, fileUrl];

      const result = await pool.query(query, values);
      res.status(201).json({ message: "✅ Libro agregado con éxito.", book: result.rows[0] });
  } catch (error) {
      console.error("❌ Error al agregar libro:", error);
      res.status(500).json({ message: "❌ Error interno del servidor." });
  }
};





// 📌 Obtener archivo PDF de un libro
export const getBookFile = async (req: Request, res: Response): Promise<void> => {
  try {
    const { id } = req.params;

    // 🔍 Buscar el libro en la base de datos
    const result = await db.query("SELECT file_url FROM books WHERE id = $1", [id]);

    if (result.rows.length === 0) {
      res.status(404).json({ message: "Libro no encontrado." });
      return;
    }

    const filePath = result.rows[0].file_url;

    if (!filePath) {
      res.status(404).json({ message: "Este libro no tiene archivo adjunto." });
      return;
    }

    // 📂 Ruta completa del archivo
    const fullPath = path.join(__dirname, "..", filePath);

    // 📌 Verificar si el archivo existe antes de enviarlo
    if (!fs.existsSync(fullPath)) {
      res.status(404).json({ message: "Archivo no encontrado en el servidor." });
      return;
    }

    // 📤 Enviar el archivo como respuesta
    res.sendFile(fullPath);
  } catch (error) {
    console.error("❌ Error al obtener el archivo del libro:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
};


export const updateBook = async (req: MulterRequest, res: Response): Promise<void> => {
  try {
    const { id } = req.params;
    const { title, author, genre, description, published_year } = req.body;

    // 📌 Verificar si el libro existe
    const bookExists = await db.query("SELECT file_url FROM books WHERE id = $1", [id]);

    if (bookExists.rows.length === 0) {
      res.status(404).json({ message: "Libro no encontrado." });
      return;
    }

    let filePath = bookExists.rows[0].file_url;

    // 📌 Si se sube un nuevo archivo, eliminar el anterior y actualizar la ruta
    if (req.file) {
      // Eliminar archivo anterior si existe
      if (filePath) {
        const oldFilePath = path.join(__dirname, "..", filePath);
        if (fs.existsSync(oldFilePath)) {
          fs.unlinkSync(oldFilePath); // Eliminar el archivo viejo
        }
      }
      filePath = `/uploads/${req.file.filename}`;
    }

    // 📌 Actualizar libro en la base de datos
    await db.query(
      `UPDATE books SET title = $1, author = $2, genre = $3, description = $4, published_year = $5, file_url = $6 WHERE id = $7`,
      [title, author, genre, description, published_year, filePath, id]
    );

    res.status(200).json({ message: "Libro actualizado con éxito." });
  } catch (error) {
    console.error("❌ Error al actualizar el libro:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
};

