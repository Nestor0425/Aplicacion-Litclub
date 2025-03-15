"use strict";
// import { Request, Response } from "express";
// import { createUser } from "../services/user.service";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const user_service_1 = require("../services/user.service");
const register = async (req, res) => {
    try {
        const user = await (0, user_service_1.createUser)(req.body);
        res.status(201).json({
            message: "Usuario registrado exitosamente",
            user: {
                id: user.id,
                nombre: user.nombre,
                email: user.email,
                rol: user.rol, // 🔹 No exponemos la contraseña
            },
        });
    }
    catch (error) {
        console.error("❌ Error en el registro de usuario:", error);
        res.status(500).json({ message: "Error interno del servidor" });
    }
};
exports.register = register;
