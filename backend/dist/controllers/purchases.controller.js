"use strict";
// import { Request, Response } from "express";
// import db from "../config/db";
// export const getPurchases = async (req: Request, res: Response) => {
//   const { userId } = req.query;
//   try {
//     const purchases = await db.query(
//       "SELECT books.id, books.title, books.author, books.cover_image_url FROM purchases JOIN books ON purchases.book_id = books.id WHERE purchases.user_id = $1",
//       [userId]
//     );
//     res.json(purchases.rows);
//   } catch (error) {
//     res.status(500).json({ message: "Error obteniendo compras" });
//   }
// };
