"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.completePurchase = exports.addToCart = exports.getBooksForSale = void 0;
const db_1 = __importDefault(require("../config/db"));
const getBooksForSale = async (req, res) => {
    try {
        const books = await db_1.default.query("SELECT * FROM books WHERE available = true");
        res.json(books.rows);
    }
    catch (error) {
        res.status(500).json({ message: "Error obteniendo libros en venta" });
    }
};
exports.getBooksForSale = getBooksForSale;
const addToCart = async (req, res) => {
    const { userId, bookId } = req.body;
    try {
        await db_1.default.query("INSERT INTO cart (user_id, book_id) VALUES ($1, $2)", [userId, bookId]);
        res.json({ message: "Libro agregado al carrito" });
    }
    catch (error) {
        res.status(500).json({ message: "Error agregando al carrito" });
    }
};
exports.addToCart = addToCart;
const completePurchase = async (req, res) => {
    const { userId } = req.body;
    try {
        const cartItems = await db_1.default.query("SELECT book_id FROM cart WHERE user_id = $1", [userId]);
        for (const item of cartItems.rows) {
            await db_1.default.query("UPDATE books SET available = false WHERE id = $1", [item.book_id]);
            await db_1.default.query("INSERT INTO purchases (user_id, book_id) VALUES ($1, $2)", [userId, item.book_id]);
        }
        await db_1.default.query("DELETE FROM cart WHERE user_id = $1", [userId]);
        res.json({ message: "Compra completada" });
    }
    catch (error) {
        res.status(500).json({ message: "Error al completar la compra" });
    }
};
exports.completePurchase = completePurchase;
