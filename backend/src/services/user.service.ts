import pool from "../config/db";
import bcrypt from "bcryptjs";
import { encryptData, decryptData } from "../utils/encryption";
import { User } from "../models/user.model";

export const createUser = async (user: User) => {
  const hashedPassword = await bcrypt.hash(user.password, 12);
  const result = await pool.query(
    "INSERT INTO users (nombre, email, rol, password) VALUES ($1, $2, $3, $4) RETURNING *",
    [user.nombre, user.email, user.rol, hashedPassword]
  );
  return result.rows[0];
};
// Ya esta protegida ante una inyeccion
export const findUserByEmail = async (email: string) => {
  const result = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
  return result.rows[0];
};

// 🔐 Guardar datos encriptados en la BD
export const saveSensitiveData = async (userId: number, sensitiveInfo: string) => {
  const encryptedInfo = encryptData(sensitiveInfo);
  await pool.query("UPDATE users SET sensitive_info = $1 WHERE id = $2", [encryptedInfo, userId]);
};

// 🔓 Leer y desencriptar datos de la BD
export const getSensitiveData = async (userId: number): Promise<string | null> => {
  const result = await pool.query("SELECT sensitive_info FROM users WHERE id = $1", [userId]);
  if (result.rows.length === 0) return null;

  return decryptData(result.rows[0].sensitive_info);
};
