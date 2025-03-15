// import cors from "cors";
// import express from "express";

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
import cors from "cors";
import express from "express";
import dotenv from "dotenv";

dotenv.config();

const app = express();

// Lista de orígenes permitidos para CORS
const allowedOrigins = [
  process.env.FRONTEND_URL || "https://aplicacion-lit-club-jx94w2f37-alexisrdz1219s-projects.vercel.app", // Dominio de Vercel
  "http://localhost:5173", // Frontend local en Vite
];

// Configuración de CORS
const corsOptions = {
  origin: (origin: string | undefined, callback: (error: Error | null, allow?: boolean) => void) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
    } else {
      callback(new Error("No permitido por CORS"));
    }
  },
  credentials: true, // Permite cookies y headers personalizados
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type", "Authorization"],
};

// Aplicar configuración de CORS
app.use(cors(corsOptions));

// Permitir JSON en las solicitudes
app.use(express.json());

export default corsOptions;
