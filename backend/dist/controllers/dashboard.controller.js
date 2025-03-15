"use strict";
// import { Response } from "express";
// import db from "../config/db";
// import { AuthenticatedRequest } from "../types/express"; // Importar el tipo de request autenticado
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getDashboardStats = void 0;
const db_1 = __importDefault(require("../config/db"));
const getDashboardStats = async (req, res) => {
    try {
        if (!req.user) {
            res.status(401).json({ message: "No autorizado" });
            return;
        }
        if (req.user.rol !== "admin") {
            res.status(403).json({ message: "Acceso denegado" });
            return;
        }
        const usersCount = await db_1.default.query("SELECT COUNT(*) FROM users");
        const loginsCount = await db_1.default.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Usuario autenticado%'");
        const failedLoginsCount = await db_1.default.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Intento de login fallido%'");
        const twoFAAttempts = await db_1.default.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Código 2FA enviado%'");
        res.json({
            users: Number(usersCount.rows[0].count),
            logins: Number(loginsCount.rows[0].count),
            failedLogins: Number(failedLoginsCount.rows[0].count),
            twoFA: Number(twoFAAttempts.rows[0].count),
        });
    }
    catch (error) {
        console.error("❌ Error obteniendo estadísticas:", error);
        res.status(500).json({ message: "Error obteniendo estadísticas" });
    }
};
exports.getDashboardStats = getDashboardStats;
