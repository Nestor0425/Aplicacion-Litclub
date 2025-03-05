"use strict";
// import { Response, NextFunction } from "express";
// import jwt, { JwtPayload, VerifyErrors } from "jsonwebtoken";
// import dotenv from "dotenv";
// import { AuthenticatedRequest } from "../types/express"; // Importar la interfaz personalizada
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.authorizeRole = exports.authenticateToken = void 0;
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const authenticateToken = (req, res, next) => {
    try {
        // ✅ Obtener el token desde el header Authorization
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            res.status(403).json({ message: "Acceso denegado, token no proporcionado" });
            return;
        }
        const token = authHeader.split(" ")[1];
        jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET, (err, decoded) => {
            if (err) {
                res.status(403).json({ message: "Token inválido o expirado" });
                return;
            }
            if (!decoded || typeof decoded === "string") {
                res.status(403).json({ message: "Token inválido" });
                return;
            }
            req.user = decoded;
            next(); // ✅ Continuar con la siguiente función
        });
    }
    catch (error) {
        console.error("❌ Error en autenticación:", error);
        res.status(500).json({ message: "Error interno en la autenticación" });
    }
};
exports.authenticateToken = authenticateToken;
const authorizeRole = (role) => {
    return (req, res, next) => {
        if (!req.user) {
            res.status(403).json({ message: "Acceso denegado, usuario no autenticado" });
            return;
        }
        if (req.user.rol !== role) {
            res.status(403).json({ message: `Acceso denegado, se requiere rol: ${role}` });
            return;
        }
        next(); // ✅ Continuar con la siguiente función
    };
};
exports.authorizeRole = authorizeRole;
