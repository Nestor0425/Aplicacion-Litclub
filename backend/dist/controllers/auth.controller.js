"use strict";
// import { Request, Response } from "express";
// import { loginSchema } from "../validators/auth.validator";
// import { authenticateUser, generateJWT } from "../services/auth.service";
// import logger from "../utils/logger";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getAuthenticatedUser = exports.login = void 0;
const auth_validator_1 = require("../validators/auth.validator");
const auth_service_1 = require("../services/auth.service");
const logger_1 = __importDefault(require("../utils/logger"));
const auth_service_2 = require("../services/auth.service"); // Función para verificar el token
const db_1 = __importDefault(require("../config/db"));
const login = async (req, res) => {
    try {
        // ✅ Validar los datos de entrada con Zod
        const validatedData = auth_validator_1.loginSchema.parse(req.body);
        // ✅ Autenticar usuario
        const result = await (0, auth_service_1.authenticateUser)(validatedData.email, validatedData.password);
        if (!result || !result.user) {
            logger_1.default.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
            res.status(401).json({ message: "Credenciales inválidas" });
            return;
        }
        const user = result.user;
        // ✅ Validar que el usuario tiene un `id` válido antes de generar el JWT
        if (typeof user.id !== "number") {
            logger_1.default.error(`❌ Error: El usuario ${user.email} no tiene un ID válido.`);
            res.status(500).json({ message: "Error interno en la autenticación." });
            return;
        }
        // ✅ Generar token JWT
        const token = (0, auth_service_1.generateJWT)({ id: user.id, rol: user.rol });
        logger_1.default.info(`✅ Usuario autenticado: ${user.email} (ID: ${user.id})`);
        res.json({ token, user });
    }
    catch (error) {
        logger_1.default.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
        res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
    }
};
exports.login = login;
const getAuthenticatedUser = async (req, res) => {
    try {
        const authHeader = req.headers.authorization;
        if (!authHeader || !authHeader.startsWith("Bearer ")) {
            res.status(401).json({ message: "No autorizado. Token no proporcionado." });
            return;
        }
        const token = authHeader.split(" ")[1];
        const decoded = (0, auth_service_2.verifyJWT)(token); // Verifica el token
        if (!decoded) {
            res.status(401).json({ message: "Token inválido o expirado." });
            return;
        }
        // ✅ Buscar el usuario en la base de datos
        const result = await db_1.default.query("SELECT id, nombre, email, rol FROM users WHERE id = $1", [decoded.id]);
        if (result.rows.length === 0) {
            res.status(404).json({ message: "Usuario no encontrado." });
            return;
        }
        res.json(result.rows[0]); // ✅ Corregido: No usar `return`
    }
    catch (error) {
        console.error("Error en autenticación:", error);
        res.status(500).json({ message: "Error interno del servidor." });
    }
};
exports.getAuthenticatedUser = getAuthenticatedUser;
