// import app from "./app";

// const PORT = process.env.PORT || 5001;

// app.listen(PORT, () => {
//   console.log(`Servidor corriendo en http://localhost:${PORT}`);
// });
import app from "./app";
import dotenv from "dotenv";

dotenv.config(); // ✅ Cargar variables de entorno

const PORT = process.env.PORT || 5001;

// 📌 Iniciar servidor con manejo de errores
app.listen(PORT, () => {
  console.log(`✅ Servidor corriendo en ${process.env.NODE_ENV === "production" ? "Render/Vercel" : `http://localhost:${PORT}`}`);
}).on("error", (err) => {
  console.error("❌ Error al iniciar el servidor:", err);
});
