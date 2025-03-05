"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const marketplace_controller_1 = require("../controllers/marketplace.controller");
const auth_middleware_1 = require("../middlewares/auth.middleware");
const router = express_1.default.Router();
router.get("/books", marketplace_controller_1.getBooksForSale); // 📚 Listar libros en venta
router.post("/cart", auth_middleware_1.authenticateToken, marketplace_controller_1.addToCart); // 🛒 Agregar libro al carrito
router.post("/purchase", auth_middleware_1.authenticateToken, marketplace_controller_1.completePurchase); // 💳 Finalizar compra
exports.default = router;
