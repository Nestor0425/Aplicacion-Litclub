"use strict";
// import { Pool } from "pg";
// import dotenv from "dotenv";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// dotenv.config();
// const pool = new Pool({
//   connectionString: process.env.DATABASE_URL,
//   ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false, // Necesario en Render
// });
// const testDbConnection = async () => {
//   try {
//     const result = await pool.query("SELECT NOW()");
//     console.log("✅ Conexión exitosa a la base de datos:", result.rows);
//   } catch (error) {
//     console.error("❌ Error en la conexión a la base de datos:", error);
//   }
// };
// testDbConnection();
// export default pool;
const pg_1 = require("pg");
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
// Verificar si estamos en entorno de producción
const isProduction = process.env.NODE_ENV === "production";
// Crear la conexión al pool
const pool = new pg_1.Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: isProduction ? { rejectUnauthorized: false } : false, // SSL solo en producción
});
// Función para probar la conexión
const testDbConnection = async () => {
    try {
        const client = await pool.connect();
        const result = await client.query("SELECT NOW()");
        console.log("✅ Conexión exitosa a la base de datos:", result.rows[0]);
        client.release();
    }
    catch (error) {
        console.error("❌ Error en la conexión a la base de datos:", error);
    }
};
// Ejecutar la prueba de conexión solo en entorno local (desarrollo)
if (process.env.NODE_ENV !== "production") {
    testDbConnection();
}
exports.default = pool;
