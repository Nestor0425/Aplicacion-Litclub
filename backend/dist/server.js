"use strict";
// import app from "./app";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// const PORT = process.env.PORT || 5001;
// app.listen(PORT, () => {
//   console.log(`Servidor corriendo en http://localhost:${PORT}`);
// });
const app_1 = __importDefault(require("./app"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config(); // ✅ Cargar variables de entorno
const PORT = process.env.PORT || 5001;
// 📌 Iniciar servidor con manejo de errores
app_1.default.listen(PORT, () => {
    console.log(`✅ Servidor corriendo en ${process.env.NODE_ENV === "production" ? "Render/Vercel" : `http://localhost:${PORT}`}`);
}).on("error", (err) => {
    console.error("❌ Error al iniciar el servidor:", err);
});
