"use strict";
// // import multer from "multer";
// // import path from "path";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// // const storage = multer.diskStorage({
// //   destination: path.join(__dirname, "..", "..", "uploads"), // ✅ Ruta directa a la carpeta 'uploads'
// //   filename: (_req, file, cb) => {
// //     cb(null, `${Date.now()}_${file.originalname}`);
// //   },
// // });
// // const upload = multer({
// //   storage,
// //   limits: {
// //     fileSize: 5 * 1024 * 1024, // ✅ Limite de tamaño 5 MB
// //   },
// //   fileFilter: (_req, file, cb) => {
// //     if (file.mimetype === "application/pdf") {
// //       cb(null, true);
// //     } else {
// //       cb(new Error("Solo se permiten archivos PDF"));
// //     }
// //   },
// // });
// // export default upload;
// import multer from "multer";
// import path from "path";
// import dotenv from "dotenv";
// dotenv.config();
// // Determinar si se está en producción
// const isProduction = process.env.NODE_ENV === "production";
// // Configuración de almacenamiento según el entorno
// const storage = isProduction
//   ? multer.memoryStorage() // ⚡ En producción usa almacenamiento en memoria (para S3, Cloudinary, etc.)
//   : multer.diskStorage({
//       destination: path.join(__dirname, "..", "..", "uploads"), // 📂 Guarda en 'uploads' en local
//       filename: (_req, file, cb) => {
//         cb(null, `${Date.now()}_${file.originalname}`);
//       },
//     });
//     const upload = multer({
//       limits: {
//         fileSize: 50 * 1024 * 1024, // 📌 Aumenta el límite a 50MB
//       },
//       storage: multer.diskStorage({
//         destination: (req, file, cb) => {
//           cb(null, "uploads/"); // 📂 Directorio donde se guardan los archivos
//         },
//         filename: (req, file, cb) => {
//           cb(null, Date.now() + "-" + file.originalname);
//         },
//       }),
//     });
// export default upload;
const multer_1 = __importDefault(require("multer"));
const path_1 = __importDefault(require("path"));
const fs_1 = __importDefault(require("fs"));
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
// 📌 Definir el directorio de subida
const uploadDir = path_1.default.resolve(__dirname, "..", "uploads");
// ✅ Verificar si la carpeta `uploads/` existe, si no, crearla automáticamente
if (!fs_1.default.existsSync(uploadDir)) {
    fs_1.default.mkdirSync(uploadDir, { recursive: true });
    console.log("📂 Carpeta 'uploads/' creada exitosamente.");
}
// 📌 Determinar si se está en producción
const isProduction = process.env.NODE_ENV === "production";
// 📌 Configuración del almacenamiento
const storage = isProduction
    ? multer_1.default.memoryStorage() // 🚀 En producción usa almacenamiento en memoria (para S3, Cloudinary, etc.)
    : multer_1.default.diskStorage({
        destination: (_req, _file, cb) => {
            cb(null, uploadDir); // 📂 Guarda en 'uploads' en local
        },
        filename: (_req, file, cb) => {
            cb(null, `${Date.now()}-${file.originalname.replace(/\s/g, "_")}`); // 🔹 Evita espacios en los nombres
        },
    });
// 📌 Configurar el middleware de Multer
const upload = (0, multer_1.default)({
    storage,
    limits: { fileSize: 50 * 1024 * 1024 }, // 📌 Límite de 50MB
    fileFilter: (_req, file, cb) => {
        const allowedMimeTypes = ["application/pdf", "image/jpeg", "image/png", "text/csv", "application/vnd.ms-excel"];
        if (allowedMimeTypes.includes(file.mimetype)) {
            cb(null, true);
        }
        else {
            cb(new Error("❌ Solo se permiten archivos PDF, JPG y PNG"));
        }
    },
}).fields([
    { name: "cover_image", maxCount: 1 }, // ✅ Imagen de portada (máximo 1 archivo)
    { name: "file", maxCount: 1 }, // ✅ Archivo PDF del libro (máximo 1 archivo)
]);
exports.default = upload;
