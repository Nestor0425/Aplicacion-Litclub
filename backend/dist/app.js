"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const helmet_1 = __importDefault(require("helmet"));
const auth_routes_1 = __importDefault(require("./routes/auth.routes"));
const user_routes_1 = __importDefault(require("./routes/user.routes"));
const express_rate_limit_1 = __importDefault(require("express-rate-limit"));
const logger_1 = __importDefault(require("./utils/logger"));
const logs_routes_1 = __importDefault(require("./routes/logs.routes"));
const cookie_parser_1 = __importDefault(require("cookie-parser"));
const dashboard_routes_1 = __importDefault(require("./routes/dashboard.routes"));
const book_routes_1 = __importDefault(require("./routes/book.routes"));
const morgan_1 = __importDefault(require("morgan"));
const app = (0, express_1.default)();
// Middleware para manejar JSON
app.use(express_1.default.json());
app.use((0, cors_1.default)({
    origin: "http://localhost:5173", // ✅ Permite solo el frontend
    credentials: true, // ✅ Permite cookies y headers de autenticación
    methods: ["GET", "POST", "PUT", "DELETE"], // ✅ Métodos permitidos
    allowedHeaders: ["Content-Type", "Authorization"], // ✅ Permite headers importantes
}));
app.use((0, helmet_1.default)());
// Aplicar Rate Limiting Global (Ejemplo: Máximo 100 peticiones por IP cada 15 min)
const globalLimiter = (0, express_rate_limit_1.default)({
    windowMs: 15 * 60 * 1000,
    max: 100, // Límite de 100 peticiones por IP en 15 minutos
    message: "Demasiadas solicitudes. Inténtalo más tarde.",
});
app.use(globalLimiter); // Aplica rate limiting globalmente
// Habilitar el uso de `X-Forwarded-For` para obtener la IP real
app.set("trust proxy", "loopback"); // 🔒 Solo confía en proxy en localhost
// Middleware para capturar errores no manejados
app.use((err, req, res, next) => {
    logger_1.default.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
    res.status(500).json({ message: "Error interno del servidor" });
});
// 📌 Registrar todas las peticiones HTTP en logs
app.use((0, morgan_1.default)("combined", { stream: { write: (message) => logger_1.default.info(message.trim()) } }));
app.use((0, cookie_parser_1.default)());
app.use(express_1.default.json());
// Montar las rutas
app.use("/auth", auth_routes_1.default);
app.use("/users", user_routes_1.default);
app.use("/logs", logs_routes_1.default);
app.use("/dashboard", dashboard_routes_1.default);
app.use("/books", book_routes_1.default);
// Servir archivos estáticos desde la carpeta "uploads"
// Servir archivos estáticos desde la carpeta "uploads"
app.use("/uploads", express_1.default.static("uploads"));
// 🔹 Evitar error "X-Frame-Options"
// Configurar las cabeceras CSP manualmente
app.use((req, res, next) => {
    res.setHeader("Content-Security-Policy", "frame-ancestors 'self' http://localhost:5173");
    res.setHeader("X-Frame-Options", "ALLOW-FROM http://localhost:5173"); // ❗ Algunos navegadores aún usan esto
    next();
});
exports.default = app;
