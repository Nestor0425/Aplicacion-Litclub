// import { Request, Response } from "express";
// import db from "../config/db";
// import path from "path";
// import fs from "fs";
// import pool from "../config/db";

// interface MulterRequest extends Request {
//   file?: Express.Multer.File; // Permite acceder a req.file
// }

// // Obtener todos los libros ordenados por fecha de creación (más recientes primero)
// export const getBooks = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const books = await pool.query("SELECT * FROM books");
//     res.json(books.rows); // ✅ Express espera que manejes la respuesta aquí
//   } catch (error) {
//     console.error("Error al obtener libros:", error);
//     res.status(500).json({ message: "Error interno del servidor" });
//   }
// };




// // Obtener solo los 3 libros más recientes
// export const getLatestBooks = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const result = await db.query("SELECT * FROM books ORDER BY created_at DESC LIMIT 3");
//     res.json(result.rows); // ✅ Solo enviar la respuesta, sin return explícito
//   } catch (error) {
//     console.error("Error obteniendo los últimos libros:", error);
//     res.status(500).json({ message: "Error al obtener los últimos libros" });
//   }
// };

// // 📌 Agregar un Libro con PDF
// // ✅ Controlador para agregar un libro
// export const addBook = async (req: Request, res: Response): Promise<void> => {
//   try {
//       const { title, author, genre, description, published_year } = req.body;
//       const fileUrl = req.file ? `/uploads/${req.file.filename}` : null; // ✅ Asegurar la URL correcta

//       if (!fileUrl) {
//           res.status(400).json({ message: "❌ Debes subir un archivo PDF." });
//           return;
//       }

//       const query = "INSERT INTO books (title, author, genre, description, published_year, file_url) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *";
//       const values = [title, author, genre, description, published_year, fileUrl];

//       const result = await pool.query(query, values);
//       res.status(201).json({ message: "✅ Libro agregado con éxito.", book: result.rows[0] });
//   } catch (error) {
//       console.error("❌ Error al agregar libro:", error);
//       res.status(500).json({ message: "❌ Error interno del servidor." });
//   }
// };

// // 📌 Obtener archivo PDF de un libro
// export const getBookFile = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const { id } = req.params;

//     // 🔍 Buscar el libro en la base de datos
//     const result = await db.query("SELECT file_url FROM books WHERE id = $1", [id]);

//     if (result.rows.length === 0) {
//       res.status(404).json({ message: "Libro no encontrado." });
//       return;
//     }

//     const filePath = result.rows[0].file_url;

//     if (!filePath) {
//       res.status(404).json({ message: "Este libro no tiene archivo adjunto." });
//       return;
//     }

//     // 📂 Ruta completa del archivo
//     const fullPath = path.join(__dirname, "..", filePath);

//     // 📌 Verificar si el archivo existe antes de enviarlo
//     if (!fs.existsSync(fullPath)) {
//       res.status(404).json({ message: "Archivo no encontrado en el servidor." });
//       return;
//     }

//     // 📤 Enviar el archivo como respuesta
//     res.sendFile(fullPath);
//   } catch (error) {
//     console.error("❌ Error al obtener el archivo del libro:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// };


// export const updateBook = async (req: MulterRequest, res: Response): Promise<void> => {
//   try {
//     const { id } = req.params;
//     const { title, author, genre, description, published_year } = req.body;

//     // 📌 Verificar si el libro existe
//     const bookExists = await db.query("SELECT file_url FROM books WHERE id = $1", [id]);

//     if (bookExists.rows.length === 0) {
//       res.status(404).json({ message: "Libro no encontrado." });
//       return;
//     }

//     let filePath = bookExists.rows[0].file_url;

//     // 📌 Si se sube un nuevo archivo, eliminar el anterior y actualizar la ruta
//     if (req.file) {
//       // Eliminar archivo anterior si existe
//       if (filePath) {
//         const oldFilePath = path.join(__dirname, "..", filePath);
//         if (fs.existsSync(oldFilePath)) {
//           fs.unlinkSync(oldFilePath); // Eliminar el archivo viejo
//         }
//       }
//       filePath = `/uploads/${req.file.filename}`;
//     }

//     // 📌 Actualizar libro en la base de datos
//     await db.query(
//       `UPDATE books SET title = $1, author = $2, genre = $3, description = $4, published_year = $5, file_url = $6 WHERE id = $7`,
//       [title, author, genre, description, published_year, filePath, id]
//     );

//     res.status(200).json({ message: "Libro actualizado con éxito." });
//   } catch (error) {
//     console.error("❌ Error al actualizar el libro:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// };

// import { Request, Response } from "express";
// import path from "path";
// import fs from "fs";
// import pool from "../config/db"; // ✅ Unifica la conexión a la BD

// // ✅ Interface para MulterRequest
// interface MulterRequest extends Request {
//   file?: Express.Multer.File;
// }

// // 📚 Obtener todos los libros
// export const getBooks = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const result = await pool.query("SELECT * FROM books ORDER BY created_at DESC");
//     res.json(result.rows);
//   } catch (error) {
//     console.error("Error al obtener libros:", error);
//     res.status(500).json({ message: "Error interno del servidor" });
//   }
// };

// // 📚 Obtener solo los 3 libros más recientes
// export const getLatestBooks = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const result = await pool.query("SELECT * FROM books ORDER BY created_at DESC LIMIT 3");
//     res.json(result.rows);
//   } catch (error) {
//     console.error("Error al obtener los últimos libros:", error);
//     res.status(500).json({ message: "Error interno del servidor" });
//   }
// };

// // ➕ Agregar un libro (con archivo PDF)
// export const addBook = async (req: MulterRequest, res: Response): Promise<void> => {
//   try {
//     const { title, author, genre, description, published_year } = req.body;
//     const fileUrl = req.file ? `/uploads/${req.file.filename}` : null;

//     if (!fileUrl) {
//       res.status(400).json({ message: "Debes subir un archivo PDF." });
//       return;
//     }

//     const query = `
//       INSERT INTO books (title, author, genre, description, published_year, file_url)
//       VALUES ($1, $2, $3, $4, $5, $6) RETURNING *
//     `;
//     const values = [title, author, genre, description, published_year, fileUrl];

//     const result = await pool.query(query, values);
//     res.status(201).json({ message: "Libro agregado correctamente", book: result.rows[0] });
//   } catch (error) {
//     console.error("❌ Error al agregar libro:", error);
//     res.status(500).json({ message: "Error interno del servidor" });
//   }
// };


// // 📂 Obtener archivo PDF de un libro
// export const getBookFile = async (req: Request, res: Response): Promise<void> => {
//   try {
//     const { id } = req.params;
//     const result = await pool.query("SELECT file_url FROM books WHERE id = $1", [id]);

//     if (result.rows.length === 0) {
//       res.status(404).json({ message: "Libro no encontrado." });
//       return;
//     }

//     const filePath = result.rows[0].file_url;
//     if (!filePath) {
//       res.status(404).json({ message: "Este libro no tiene archivo adjunto." });
//       return;
//     }

//     const fullPath = path.join(__dirname, "..", "..", filePath);
//     if (!fs.existsSync(fullPath)) {
//       res.status(404).json({ message: "Archivo no encontrado." });
//       return;
//     }

//     res.sendFile(fullPath);
//   } catch (error) {
//     console.error("Error al obtener archivo:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// };

// // 🔄 Actualizar un libro
// export const updateBook = async (req: MulterRequest, res: Response): Promise<void> => {
//   try {
//     const { id } = req.params;
//     const { title, author, genre, description, published_year } = req.body;

//     const existingBook = await pool.query("SELECT file_url FROM books WHERE id = $1", [id]);
//     if (existingBook.rows.length === 0) {
//       res.status(404).json({ message: "Libro no encontrado." });
//       return;
//     }

//     let filePath = existingBook.rows[0].file_url;

//     if (req.file) {
//       if (filePath) {
//         const oldPath = path.join(__dirname, "..", "..", filePath);
//         if (fs.existsSync(oldPath)) {
//           fs.unlinkSync(oldPath);
//         }
//       }
//       filePath = `/uploads/${req.file.filename}`;
//     }

//     const query = `
//       UPDATE books 
//       SET title = $1, author = $2, genre = $3, description = $4, published_year = $5, file_url = $6 
//       WHERE id = $7
//     `;
//     const values = [title, author, genre, description, published_year, filePath, id];

//     await pool.query(query, values);

//     res.status(200).json({ message: "Libro actualizado correctamente." });
//   } catch (error) {
//     console.error("Error al actualizar libro:", error);
//     res.status(500).json({ message: "Error interno del servidor." });
//   }
// };

import { Request, Response } from "express";
import pool from "../config/db";
import path from "path";
import fs from "fs";
import dotenv from "dotenv";

dotenv.config();



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
export const addBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const { title, author, genre, description, published_year, available, cover_image_url, file_url } = req.body;

    // 📌 Validar año de publicación como número
    const year = published_year && !isNaN(Number(published_year)) ? Number(published_year) : null;

    // 📌 Insertar en la BD
    const result = await pool.query(
      `INSERT INTO books (title, author, genre, description, cover_image_url, published_year, available, file_url)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING *`,
      [
        title,
        author,
        genre,
        description,
        cover_image_url || null, // ✅ Ahora la imagen es una URL
        year,
        available !== undefined ? available : true, 
        file_url || null, // ✅ El archivo también es una URL
      ]
    );

    res.status(201).json({ message: "📚 Libro agregado correctamente", book: result.rows[0] });
  } catch (error) {
    console.error("❌ Error al agregar libro:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
};






// Interface para MulterRequest
interface MulterRequest extends Request {
  file?: Express.Multer.File;
}

// 📚 Obtener todos los libros
export const getBooks = async (req: Request, res: Response): Promise<void> => {
  try {
    const result = await pool.query("SELECT * FROM books ORDER BY created_at DESC");
    res.json(result.rows);
  } catch (error) {
    console.error("❌ Error al obtener libros:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
};


// 📚 Obtener solo los 3 libros más recientes
export const getLatestBooks = async (req: Request, res: Response): Promise<void> => {
  try {
    const result = await pool.query("SELECT * FROM books ORDER BY created_at DESC LIMIT 3");
    res.json(result.rows);
  } catch (error) {
    console.error("❌ Error al obtener los últimos libros:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
};


// 📂 Obtener archivo PDF de un libro
export const getBookFile = async (req: Request, res: Response): Promise<void> => {
  try {
    const { id } = req.params;
    const result = await pool.query("SELECT file_url FROM books WHERE id = $1", [id]);

    if (result.rows.length === 0) {
      res.status(404).json({ message: "Libro no encontrado." });
      return;
    }

    const fileUrl: string | null = result.rows[0].file_url;
    if (!fileUrl) {
      res.status(404).json({ message: "Este libro no tiene archivo adjunto." });
      return;
    }

    const fullPath = path.join(__dirname, "..", "..", fileUrl);
    
    if (!fs.existsSync(fullPath)) {
      res.status(404).json({ message: "Archivo no encontrado." });
      return;
    }

    res.sendFile(fullPath);
  } catch (error) {
    console.error("❌ Error al obtener archivo:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
};




// 🔄 Actualizar un libro
// 📌 Función para actualizar un libro
export const updateBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const { title, author, genre, description, published_year, cover_image_url, file_url } = req.body;
    const { id } = req.params;

    // 📌 Validar año de publicación como número
    const year = published_year && !isNaN(Number(published_year)) ? Number(published_year) : null;

    const result = await pool.query(
      `UPDATE books 
       SET title = $1, author = $2, genre = $3, description = $4, published_year = $5, 
           cover_image_url = COALESCE($6, cover_image_url), file_url = COALESCE($7, file_url) 
       WHERE id = $8 RETURNING *`,
      [title, author, genre, description, year, cover_image_url || null, file_url || null, id]
    );

    if (result.rowCount === 0) {
      res.status(404).json({ message: "❌ Libro no encontrado" });
      return;
    }

    res.json({ message: "📚 Libro actualizado correctamente", book: result.rows[0] });
  } catch (error) {
    console.error("❌ Error al actualizar el libro:", error);
    res.status(500).json({ message: "Error al actualizar el libro" });
  }
};



// 📌 Función para eliminar un libro
export const deleteBook = async (req: Request, res: Response): Promise<void> => {
  try {
    const { id } = req.params;

    // 🔍 Verificar si el libro existe
    const bookExists = await pool.query("SELECT * FROM books WHERE id = $1", [id]);
    if (bookExists.rows.length === 0) {
      res.status(404).json({ message: "📕 Libro no encontrado." });
      return;
    }

    // ❌ Eliminar el libro de la base de datos
    await pool.query("DELETE FROM books WHERE id = $1", [id]);

    res.status(200).json({ message: "✅ Libro eliminado correctamente." });
  } catch (error) {
    console.error("❌ Error al eliminar el libro:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
};
