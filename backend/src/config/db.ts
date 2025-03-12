import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: process.env.NODE_ENV === "production" ? { rejectUnauthorized: false } : false, // Necesario en Render
});

const testDbConnection = async () => {
  try {
    const result = await pool.query("SELECT NOW()");
    console.log("✅ Conexión exitosa a la base de datos:", result.rows);
  } catch (error) {
    console.error("❌ Error en la conexión a la base de datos:", error);
  }
};

testDbConnection();

export default pool;
