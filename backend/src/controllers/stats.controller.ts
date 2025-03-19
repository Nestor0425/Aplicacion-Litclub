import { Request, Response } from "express";
import pool from "../config/db"; // Asegúrate de importar tu conexión a la BD

export const getTotalBooks = async (_req: Request, res: Response) => {
  try {
    const result = await pool.query("SELECT COUNT(*) FROM books;");
    res.json({ totalLibros: result.rows[0].count });
  } catch (error) {
    console.error("❌ Error obteniendo el total de libros:", error);
    res.status(500).json({ message: "Error al obtener el total de libros" });
  }
};
