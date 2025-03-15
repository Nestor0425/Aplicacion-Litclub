// import pool from "../config/db";
// import bcrypt from "bcryptjs";
// import { encryptData, decryptData } from "../utils/encryption";
// import { User } from "../models/user.model";

// export const createUser = async (user: User) => {
//   const hashedPassword = await bcrypt.hash(user.password, 12);
//   const result = await pool.query(
//     "INSERT INTO users (nombre, email, rol, password) VALUES ($1, $2, $3, $4) RETURNING *",
//     [user.nombre, user.email, user.rol, hashedPassword]
//   );
//   return result.rows[0];
// };
// // Ya esta protegida ante una inyeccion
// export const findUserByEmail = async (email: string) => {
//   const result = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
//   return result.rows[0];
// };

// // 🔐 Guardar datos encriptados en la BD
// export const saveSensitiveData = async (userId: number, sensitiveInfo: string) => {
//   const encryptedInfo = encryptData(sensitiveInfo);
//   await pool.query("UPDATE users SET sensitive_info = $1 WHERE id = $2", [encryptedInfo, userId]);
// };

// // 🔓 Leer y desencriptar datos de la BD
// export const getSensitiveData = async (userId: number): Promise<string | null> => {
//   const result = await pool.query("SELECT sensitive_info FROM users WHERE id = $1", [userId]);
//   if (result.rows.length === 0) return null;

//   return decryptData(result.rows[0].sensitive_info);
// };

import pool from "../config/db";
import bcrypt from "bcryptjs";
import { encryptData, decryptData } from "../utils/encryption";
import { User } from "../models/user.model";

// 📌 Función para crear usuario con contraseña encriptada
export const createUser = async (user: User) => {
  try {
    if (!user.password) {
      throw new Error("❌ Error: Se requiere una contraseña para crear un usuario.");
    }

    const hashedPassword = await bcrypt.hash(user.password, 12);
    const result = await pool.query(
      "INSERT INTO users (nombre, email, rol, password) VALUES ($1, $2, $3, $4) RETURNING id, nombre, email, rol",
      [user.nombre, user.email, user.rol, hashedPassword]
    );

    return result.rows[0]; // 🔹 Retorna solo datos seguros (sin contraseña)
  } catch (error) {
    console.error("❌ Error al crear usuario:", error);
    throw new Error("Error en la creación del usuario.");
  }
};

// 📌 Buscar usuario por email (retorna `null` si no existe)
export const findUserByEmail = async (email: string): Promise<User | null> => {
  try {
    const result = await pool.query("SELECT * FROM users WHERE email = $1", [email]);

    return result.rows.length > 0 ? result.rows[0] : null;
  } catch (error) {
    console.error("❌ Error buscando usuario por email:", error);
    return null;
  }
};

// 🔐 Guardar datos sensibles encriptados en la BD
export const saveSensitiveData = async (userId: number, sensitiveInfo: string): Promise<void> => {
  try {
    const encryptedInfo = encryptData(sensitiveInfo);
    await pool.query("UPDATE users SET sensitive_info = $1 WHERE id = $2", [encryptedInfo, userId]);
  } catch (error) {
    console.error("❌ Error guardando datos sensibles:", error);
    throw new Error("No se pudo guardar la información.");
  }
};

// 🔓 Leer y desencriptar datos de la BD
export const getSensitiveData = async (userId: number): Promise<string | null> => {
  try {
    const result = await pool.query("SELECT sensitive_info FROM users WHERE id = $1", [userId]);
    if (result.rows.length === 0 || !result.rows[0].sensitive_info) return null;

    return decryptData(result.rows[0].sensitive_info);
  } catch (error) {
    console.error("❌ Error obteniendo datos sensibles:", error);
    return null;
  }
};

