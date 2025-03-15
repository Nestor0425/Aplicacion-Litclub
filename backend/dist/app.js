"use strict";
// import express from "express";
// import cors from "cors";
// import helmet from "helmet";
// import authRoutes from "./routes/auth.routes";
// import userRoutes from "./routes/user.routes";
// import rateLimit from "express-rate-limit";
// import logger from "./utils/logger";
// import logsRoutes from "./routes/logs.routes";
// import cookieParser from "cookie-parser";
// import dashboardRoutes from "./routes/dashboard.routes";
// import bookRoutes from "./routes/book.routes";
// import path from "path";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// import morgan from "morgan";
// const app = express();
// app.use(cors());
// // Middleware para manejar JSON
// app.use(express.json());
// const allowedOrigins = [
//   "https://aplicacion-lit-club-jx94w2f37-alexisrdz1219s-projects.vercel.app"
// ];
// app.use(
//   cors({
//     origin: [
//       "https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app", // ✅ Permitir solo el frontend de Vercel
//       "http://localhost:5173" // (Opcional) Permitir en desarrollo local
//     ],
//     credentials: true, // ✅ Permite cookies y headers de autenticación
//     methods: ["GET", "POST", "PUT", "DELETE"], // ✅ Métodos permitidos
//     allowedHeaders: ["Content-Type", "Authorization"], // ✅ Permite headers importantes
//   })
// );
// app.use(helmet());
// // Aplicar Rate Limiting Global (Ejemplo: Máximo 100 peticiones por IP cada 15 min)
// const globalLimiter = rateLimit({
//     windowMs: 15 * 60 * 1000,
//     max: 100, // Límite de 100 peticiones por IP en 15 minutos
//     message: "Demasiadas solicitudes. Inténtalo más tarde.",
//   });
//   app.use(globalLimiter); // Aplica rate limiting globalmente
//   // Habilitar el uso de `X-Forwarded-For` para obtener la IP real
//   app.set("trust proxy", "loopback"); // 🔒 Solo confía en proxy en localhost
//   // Middleware para capturar errores no manejados
// app.use((err: any, req: any, res: any, next: any) => {
//   logger.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
//   res.status(500).json({ message: "Error interno del servidor" });
// });
// // 📌 Registrar todas las peticiones HTTP en logs
// app.use(morgan("combined", { stream: { write: (message) => logger.info(message.trim()) } }));
// app.use(cookieParser());
// app.use(express.json());
// // Montar las rutas
// app.use("/auth", authRoutes);
// app.use("/users", userRoutes);
// app.use("/logs", logsRoutes);
// app.use("/dashboard", dashboardRoutes);
// app.use("/books", bookRoutes);
// // Servir archivos estáticos desde la carpeta "uploads"
// // Servir archivos estáticos desde la carpeta "uploads"
// app.use("/uploads", express.static(path.join(__dirname, "..", "uploads")));
// app.get("/logs", (req, res) => {
//   res.json({ message: "Logs obtenidos correctamente" });
// });
// // 🔹 Evitar error "X-Frame-Options"
// // Configurar las cabeceras CSP manualmente
// app.use((req, res, next) => {
//   res.setHeader("Content-Security-Policy", "frame-ancestors 'self' https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app");
//   res.setHeader("X-Frame-Options", "ALLOW-FROM https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app"); // ❗ Algunos navegadores aún usan esto
//   next();
// });
// export default app;
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const helmet_1 = __importDefault(require("helmet"));
const express_rate_limit_1 = __importDefault(require("express-rate-limit"));
const cookie_parser_1 = __importDefault(require("cookie-parser"));
const morgan_1 = __importDefault(require("morgan"));
const path_1 = __importDefault(require("path"));
const logger_1 = __importDefault(require("./utils/logger"));
// 📌 Importar rutas
const auth_routes_1 = __importDefault(require("./routes/auth.routes"));
const user_routes_1 = __importDefault(require("./routes/user.routes"));
const logs_routes_1 = __importDefault(require("./routes/logs.routes"));
const dashboard_routes_1 = __importDefault(require("./routes/dashboard.routes"));
const book_routes_1 = __importDefault(require("./routes/book.routes"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
const app = (0, express_1.default)();
// 📌 Configuración dinámica de CORS
const allowedOrigins = [
    "http://localhost:5173", // Frontend local
    "https://aplicacionlitclub.onrender.com", // Enlace de producción en Render
];
app.use((0, cors_1.default)({
    origin: allowedOrigins,
    credentials: true,
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
}));
// 📌 Middleware de seguridad
app.use((0, helmet_1.default)({ contentSecurityPolicy: false })); // ❗ Evitar conflictos con CSP manual
// 📌 Aplicar Rate Limiting Global (100 peticiones por IP cada 15 min)
const globalLimiter = (0, express_rate_limit_1.default)({
    windowMs: 15 * 60 * 1000,
    max: process.env.NODE_ENV === "production" ? 100 : 1000, // 🔹 Ajustable según el entorno
    message: "Demasiadas solicitudes. Inténtalo más tarde.",
});
app.use(globalLimiter);
// 📌 Habilitar el uso de `X-Forwarded-For` en Render y Vercel
app.set("trust proxy", 1);
// 📌 Middleware de logs
app.use((0, morgan_1.default)("combined", { stream: { write: (message) => logger_1.default.info(message.trim()) } }));
// 📌 Middleware para manejo de cookies y JSON
app.use((0, cookie_parser_1.default)());
app.use(express_1.default.json());
// 📌 Montar rutas
app.use("/auth", auth_routes_1.default);
app.use("/users", user_routes_1.default);
app.use("/logs", logs_routes_1.default);
app.use("/dashboard", dashboard_routes_1.default);
app.use("/books", book_routes_1.default);
// 📌 Servir archivos estáticos desde "uploads"
app.use("/uploads", express_1.default.static(path_1.default.join(__dirname, "..", "uploads")));
// 📌 Ruta de prueba para logs
app.get("/logs", (req, res) => {
    res.json({ message: "Logs obtenidos correctamente" });
});
// 📌 Configuración de seguridad CSP (Content Security Policy)
app.use((req, res, next) => {
    res.setHeader("Content-Security-Policy", `frame-ancestors 'self' ${process.env.FRONTEND_URL || "http://localhost:5173"}`);
    res.setHeader("X-Frame-Options", `ALLOW-FROM ${process.env.FRONTEND_URL || "http://localhost:5173"}`);
    next();
});
// 📌 Middleware de manejo de errores
app.use((err, req, res, next) => {
    logger_1.default.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
    res.status(500).json({ message: "Error interno del servidor" });
});
app.use(express_1.default.json({ limit: "50mb" }));
app.use(express_1.default.urlencoded({ limit: "50mb", extended: true }));
exports.default = app;
