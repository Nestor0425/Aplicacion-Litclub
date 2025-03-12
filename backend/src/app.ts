import express from "express";
import cors from "cors";
import helmet from "helmet";
import authRoutes from "./routes/auth.routes";
import userRoutes from "./routes/user.routes";
import rateLimit from "express-rate-limit";
import logger from "./utils/logger";
import logsRoutes from "./routes/logs.routes";
import cookieParser from "cookie-parser";
import dashboardRoutes from "./routes/dashboard.routes";
import bookRoutes from "./routes/book.routes";
import path from "path";


import morgan from "morgan";
const app = express();

app.use(cors());

// Middleware para manejar JSON
app.use(express.json());
app.use(
  cors({
    origin: [
      "https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app", // ✅ Permitir solo el frontend de Vercel
      "http://localhost:5173" // (Opcional) Permitir en desarrollo local
    ],
    credentials: true, // ✅ Permite cookies y headers de autenticación
    methods: ["GET", "POST", "PUT", "DELETE"], // ✅ Métodos permitidos
    allowedHeaders: ["Content-Type", "Authorization"], // ✅ Permite headers importantes
  })
);
app.use(helmet());

// Aplicar Rate Limiting Global (Ejemplo: Máximo 100 peticiones por IP cada 15 min)
const globalLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100, // Límite de 100 peticiones por IP en 15 minutos
    message: "Demasiadas solicitudes. Inténtalo más tarde.",
  });
  
  app.use(globalLimiter); // Aplica rate limiting globalmente

  // Habilitar el uso de `X-Forwarded-For` para obtener la IP real
  app.set("trust proxy", "loopback"); // 🔒 Solo confía en proxy en localhost

  // Middleware para capturar errores no manejados
app.use((err: any, req: any, res: any, next: any) => {
  logger.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
  res.status(500).json({ message: "Error interno del servidor" });
});

// 📌 Registrar todas las peticiones HTTP en logs
app.use(morgan("combined", { stream: { write: (message) => logger.info(message.trim()) } }));

app.use(cookieParser());

app.use(express.json());

// Montar las rutas
app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/logs", logsRoutes);
app.use("/dashboard", dashboardRoutes);
app.use("/books", bookRoutes);
// Servir archivos estáticos desde la carpeta "uploads"
// Servir archivos estáticos desde la carpeta "uploads"
app.use("/uploads", express.static(path.join(__dirname, "..", "uploads")));



app.get("/logs", (req, res) => {
  res.json({ message: "Logs obtenidos correctamente" });
});


// 🔹 Evitar error "X-Frame-Options"
// Configurar las cabeceras CSP manualmente
app.use((req, res, next) => {
  res.setHeader("Content-Security-Policy", "frame-ancestors 'self' https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app");
  res.setHeader("X-Frame-Options", "ALLOW-FROM https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app"); // ❗ Algunos navegadores aún usan esto
  next();
});





export default app;

