"use strict";
// import cors from "cors";
// import express from "express";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// const app = express();
// const allowedOrigins = [
//   "https://aplicacion-lit-club-jx94w2f37-alexisrdz1219s-projects.vercel.app", // Dominio de Vercel
// ];
// app.use(
//   cors({
//     origin: allowedOrigins,
//     credentials: true, // Permitir envío de cookies y headers personalizados
//     methods: ["GET", "POST", "PUT", "DELETE"],
//     allowedHeaders: ["Content-Type", "Authorization"],
//   })
// );
// app.use(express.json());
const cors_1 = __importDefault(require("cors"));
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const app = (0, express_1.default)();
// Lista de orígenes permitidos para CORS
const allowedOrigins = [
    process.env.FRONTEND_URL || "https://aplicacion-lit-club-jx94w2f37-alexisrdz1219s-projects.vercel.app", // Dominio de Vercel
    "http://localhost:5173", // Frontend local en Vite
];
// Configuración de CORS
const corsOptions = {
    origin: (origin, callback) => {
        if (!origin || allowedOrigins.includes(origin)) {
            callback(null, true);
        }
        else {
            callback(new Error("No permitido por CORS"));
        }
    },
    credentials: true, // Permite cookies y headers personalizados
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
};
// Aplicar configuración de CORS
app.use((0, cors_1.default)(corsOptions));
// Permitir JSON en las solicitudes
app.use(express_1.default.json());
exports.default = corsOptions;
