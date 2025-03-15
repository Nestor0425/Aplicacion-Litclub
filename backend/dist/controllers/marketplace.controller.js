"use strict";
// import { Request, Response } from "express";
// import db from "../config/db";
// export const getBooksForSale = async (req: Request, res: Response) => {
//   try {
//     const books = await db.query("SELECT * FROM books WHERE available = true");
//     res.json(books.rows);
//   } catch (error) {
//     res.status(500).json({ message: "Error obteniendo libros en venta" });
//   }
// };
// export const addToCart = async (req: Request, res: Response) => {
//   const { userId, bookId } = req.body;
//   try {
//     await db.query("INSERT INTO cart (user_id, book_id) VALUES ($1, $2)", [userId, bookId]);
//     res.json({ message: "Libro agregado al carrito" });
//   } catch (error) {
//     res.status(500).json({ message: "Error agregando al carrito" });
//   }
// };
// export const completePurchase = async (req: Request, res: Response) => {
//   const { userId } = req.body;
//   try {
//     const cartItems = await db.query("SELECT book_id FROM cart WHERE user_id = $1", [userId]);
//     for (const item of cartItems.rows) {
//       await db.query("UPDATE books SET available = false WHERE id = $1", [item.book_id]);
//       await db.query("INSERT INTO purchases (user_id, book_id) VALUES ($1, $2)", [userId, item.book_id]);
//     }
//     await db.query("DELETE FROM cart WHERE user_id = $1", [userId]);
//     res.json({ message: "Compra completada" });
//   } catch (error) {
//     res.status(500).json({ message: "Error al completar la compra" });
//   }
// };
