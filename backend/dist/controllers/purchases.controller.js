"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getPurchases = void 0;
const db_1 = __importDefault(require("../config/db"));
const getPurchases = async (req, res) => {
    const { userId } = req.query;
    try {
        const purchases = await db_1.default.query("SELECT books.id, books.title, books.author, books.cover_image_url FROM purchases JOIN books ON purchases.book_id = books.id WHERE purchases.user_id = $1", [userId]);
        res.json(purchases.rows);
    }
    catch (error) {
        res.status(500).json({ message: "Error obteniendo compras" });
    }
};
exports.getPurchases = getPurchases;
