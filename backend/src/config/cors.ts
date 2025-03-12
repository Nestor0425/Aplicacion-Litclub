import cors from "cors";
import express from "express";

const app = express();

const allowedOrigins = [
  "https://aplicacion-lit-club-jx94w2f37-alexisrdz1219s-projects.vercel.app", // Dominio de Vercel
];

app.use(
  cors({
    origin: allowedOrigins,
    credentials: true, // Permitir envío de cookies y headers personalizados
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Content-Type", "Authorization"],
  })
);

app.use(express.json());
