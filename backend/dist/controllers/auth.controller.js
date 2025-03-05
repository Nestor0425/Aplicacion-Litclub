"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.login = void 0;
const auth_validator_1 = require("../validators/auth.validator");
const auth_service_1 = require("../services/auth.service");
const logger_1 = __importDefault(require("../utils/logger"));
const login = async (req, res) => {
    try {
        // ✅ Validar los datos de entrada con Zod
        const validatedData = auth_validator_1.loginSchema.parse(req.body);
        // ✅ Autenticar usuario
        const result = await (0, auth_service_1.authenticateUser)(validatedData.email, validatedData.password);
        if (!result) {
            logger_1.default.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
            res.status(401).json({ message: "Credenciales inválidas" });
            return;
        }
        // ✅ Generar token JWT
        const token = (0, auth_service_1.generateJWT)(result.user);
        logger_1.default.info(`✅ Usuario autenticado: ${result.user.email} (ID: ${result.user.id})`);
        res.json({ token, user: result.user });
    }
    catch (error) {
        logger_1.default.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
        res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
    }
};
exports.login = login;
