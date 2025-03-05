"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginLimiter = void 0;
const express_rate_limit_1 = __importDefault(require("express-rate-limit"));
exports.loginLimiter = (0, express_rate_limit_1.default)({
    windowMs: 15 * 60 * 1000, // 15 minutos
    max: 5, // Máximo de 5 intentos por IP
    message: "Demasiados intentos de inicio de sesión. Intenta de nuevo en 15 minutos.",
    standardHeaders: true,
    legacyHeaders: false,
    // 🔹 Usar keyGenerator para obtener la IP real y convertir IPv6 a IPv4 si es necesario
    keyGenerator: (req) => {
        let ip = req.headers["x-forwarded-for"] || req.socket.remoteAddress || "unknown";
        if (ip === "::1") {
            ip = "127.0.0.1"; // 🔄 Convertir IPv6 a IPv4
        }
        return ip;
    },
    handler: (req, res) => {
        let ip = req.headers["x-forwarded-for"] || req.socket.remoteAddress || "unknown";
        if (ip === "::1") {
            ip = "127.0.0.1"; // 🔄 Convertir IPv6 a IPv4
        }
        console.warn(`🔴 BLOQUEO: Demasiados intentos de login desde IP: ${ip}`);
        res.status(429).json({ message: "Demasiados intentos de inicio de sesión. Intenta de nuevo en 15 minutos." });
    },
});
