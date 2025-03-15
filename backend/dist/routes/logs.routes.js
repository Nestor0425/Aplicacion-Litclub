"use strict";
// import { Router, Response } from "express";
// import { authenticateToken, AuthenticatedRequest } from "../middlewares/auth.middleware";
// import db from "../config/db";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// const router = Router();
// // 📌 Obtener logs (Solo Admins)
// router.get("/", authenticateToken, async (req: AuthenticatedRequest, res: Response): Promise<void> => {
//   try {
//     // ✅ Verificar si el usuario es admin
//     if (!req.user || req.user.rol !== "admin") {
//       res.status(403).json({ message: "Acceso denegado" });
//       return;
//     }
//     // 📌 Obtener logs desde PostgreSQL
//     const result = await db.query("SELECT * FROM logs ORDER BY timestamp DESC LIMIT 100");
//     res.json(result.rows);
//   } catch (error) {
//     console.error("❌ Error obteniendo logs:", error);
//     res.status(500).json({ message: "Error obteniendo logs" });
//   }
// });
// export default router;
const express_1 = require("express");
const auth_middleware_1 = require("../middlewares/auth.middleware");
const db_1 = __importDefault(require("../config/db"));
const router = (0, express_1.Router)();
// 📌 Obtener logs (Solo Admins)
router.get("/", auth_middleware_1.authenticateToken, (0, auth_middleware_1.authorizeRole)("admin"), async (req, res) => {
    try {
        // 📌 Obtener logs desde PostgreSQL
        const result = await db_1.default.query("SELECT * FROM logs ORDER BY timestamp DESC LIMIT 100");
        res.json(result.rows);
    }
    catch (error) {
        console.error("❌ Error obteniendo logs:", error);
        res.status(500).json({ message: "Error obteniendo logs" });
    }
});
exports.default = router;
