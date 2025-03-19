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

// import express from "express";
// import cors from "cors";
// import helmet from "helmet";
// import rateLimit from "express-rate-limit";
// import cookieParser from "cookie-parser";
// import morgan from "morgan";
// import path from "path";
// import logger from "./utils/logger";

// // 📌 Importar rutas
// import authRoutes from "./routes/auth.routes";
// import userRoutes from "./routes/user.routes";
// import logsRoutes from "./routes/logs.routes";
// import dashboardRoutes from "./routes/dashboard.routes";
// import bookRoutes from "./routes/book.routes";

// import dotenv from "dotenv";
// dotenv.config();

// const app = express();

// // 📌 Configuración dinámica de CORS
// // const allowedOrigins = [
// //   "*"
// // // "http://localhost:5173",// Frontend local
// // // "https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app",
// // //   "https://aplicacionlitclub.onrender.com", // Enlace de producción en Render
// // ];

// const allowedOrigins = [
//   "http://localhost:5173",
//   "https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.appp", // 👈 Asegúrate de que es la URL correcta en Vercel
//   "https://aplicacionlitclub.onrender.com",
// ];


// app.use(
//   cors({
//     origin: (origin, callback) => {
//       if (!origin || allowedOrigins.includes(origin)) {
//         callback(null, true);
//       } else {
//         callback(new Error("❌ No permitido por CORS"));
//       }
//     },
//     credentials: true,
//     methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
//     allowedHeaders: ["Content-Type", "Authorization"],
//   })
// );


// // 📌 Middleware de seguridad
// app.use(helmet({ contentSecurityPolicy: false })); // ❗ Evitar conflictos con CSP manual

// // 📌 Aplicar Rate Limiting Global (100 peticiones por IP cada 15 min)
// const globalLimiter = rateLimit({
//   windowMs: 15 * 60 * 1000,
//   max: process.env.NODE_ENV === "production" ? 100 : 1000, // 🔹 Ajustable según el entorno
//   message: "Demasiadas solicitudes. Inténtalo más tarde.",
// });

// app.use(globalLimiter);

// // 📌 Habilitar el uso de `X-Forwarded-For` en Render y Vercel
// app.set("trust proxy", 1);

// // 📌 Middleware de logs
// app.use(morgan("combined", { stream: { write: (message) => logger.info(message.trim()) } }));

// // 📌 Middleware para manejo de cookies y JSON
// app.use(cookieParser());
// app.use(express.json());

// // 📌 Montar rutas
// app.use("/auth", authRoutes);
// app.use("/users", userRoutes);
// app.use("/logs", logsRoutes);
// app.use("/dashboard", dashboardRoutes);
// app.use("/books", bookRoutes);

// // 📌 Servir archivos estáticos desde "uploads"
// app.use("/uploads", express.static(path.join(__dirname, "..", "uploads")));

// // 📌 Ruta de prueba para logs
// app.get("/logs", (req, res) => {
//   res.json({ message: "Logs obtenidos correctamente" });
// });

// // 📌 Configuración de seguridad CSP (Content Security Policy)
// app.use((req, res, next) => {
//   res.setHeader(
//     "Content-Security-Policy",
//     `frame-ancestors 'self' ${process.env.FRONTEND_URL || "http://localhost:5173"}`
//   );
//   res.setHeader(
//     "X-Frame-Options",
//     `ALLOW-FROM ${process.env.FRONTEND_URL || "http://localhost:5173"}`
//   );
//   next();
// });

// // 📌 Middleware de manejo de errores
// app.use((err: any, req: any, res: any, next: any) => {
//   logger.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
//   res.status(500).json({ message: "Error interno del servidor" });
// });

// app.use(express.json({ limit: "50mb" }));
// app.use(express.urlencoded({ limit: "50mb", extended: true }));

// export default app;
import express from "express";
import cors from "cors";
import helmet from "helmet";
import rateLimit from "express-rate-limit";
import cookieParser from "cookie-parser";
import morgan from "morgan";
import path from "path";
import logger from "./utils/logger";

import authRoutes from "./routes/auth.routes";
import userRoutes from "./routes/user.routes";
import logsRoutes from "./routes/logs.routes";
import dashboardRoutes from "./routes/dashboard.routes";
import bookRoutes from "./routes/book.routes";
import statsRoutes from "./routes/stats.routes";

import dotenv from "dotenv";
dotenv.config();

const app = express();

// 📌 Middleware para parsear JSON antes que CORS
app.use(express.json({ limit: "50mb" }));
app.use(express.urlencoded({ limit: "50mb", extended: true }));

// 📌 Lista de dominios permitidos en producción
const allowedOrigins = [
  "http://localhost:5173", // Desarrollo
  "https://aplicacion-lit-club-ck8lmg4ky-alexisrdz1219s-projects.vercel.app", // Vercel
  "https://aplicacionlitclub.onrender.com", // Render
];

// 📌 Configuración de CORS
app.use(
  cors({
    origin: (origin, callback) => {
      const isAllowed =
        !origin ||
        allowedOrigins.includes(origin) ||
        origin.endsWith(".vercel.app"); // ✅ Permite todos los subdominios de Vercel

      if (isAllowed) {
        callback(null, true);
      } else {
        console.error(`❌ CORS bloqueado para origen: ${origin}`);
        callback(new Error("❌ No permitido por CORS"));
      }
    },
    credentials: true,
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);


// 📌 Middleware de seguridad
app.use(helmet({ contentSecurityPolicy: false }));

// 📌 Limitador de peticiones global
const globalLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: process.env.NODE_ENV === "production" ? 100 : 1000,
  message: "🚫 Demasiadas solicitudes. Intenta más tarde.",
});
app.use(globalLimiter);

// 📌 Configurar proxy para Render/Vercel
app.set("trust proxy", 1);

// 📌 Middleware de logs
app.use(morgan("combined", { stream: { write: (message) => logger.info(message.trim()) } }));

// 📌 Middleware de manejo de cookies
app.use(cookieParser());

// 📌 Montar rutas
app.use("/auth", authRoutes);
app.use("/users", userRoutes);
app.use("/logs", logsRoutes);
app.use("/dashboard", dashboardRoutes);
app.use("/stats", statsRoutes);
app.use("/books", bookRoutes);

// 📌 Servir archivos estáticos (PDFs, imágenes, etc.)
app.use("/uploads", express.static(path.join(__dirname, "..", "uploads")));

// 📌 Ruta de prueba para logs
app.get("/logs", (req, res) => {
  res.json({ message: "Logs obtenidos correctamente" });
});

// 📌 Configuración de seguridad CSP (Content Security Policy)
app.use((req, res, next) => {
  res.setHeader(
    "Content-Security-Policy",
    `frame-ancestors 'self' ${process.env.FRONTEND_URL || "http://localhost:5173"}`
  );
  res.setHeader(
    "X-Frame-Options",
    `ALLOW-FROM ${process.env.FRONTEND_URL || "http://localhost:5173"}`
  );
  next();
});

// 📌 Middleware de manejo de errores
app.use((err: any, req: any, res: any, next: any) => {
  logger.error(`❌ Error en ${req.method} ${req.url} - ${err.message}`);
  res.status(500).json({ message: "Error interno del servidor" });
});

export default app;
