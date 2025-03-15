// import crypto from "crypto";
// import dotenv from "dotenv";

// dotenv.config();

// const ALGORITHM = "aes-256-gcm";
// const SECRET_KEY = crypto.scryptSync(process.env.ENCRYPTION_KEY!, "salt", 32); // 🔐 Derivar clave segura
// const IV_LENGTH = 12; // 🔄 Tamaño recomendado para GCM

// // 🔒 Función para encriptar datos
// export const encryptData = (text: string): string => {
//   const iv = crypto.randomBytes(IV_LENGTH); // Generar un IV aleatorio
//   const cipher = crypto.createCipheriv(ALGORITHM, SECRET_KEY, iv);

//   let encrypted = cipher.update(text, "utf8", "hex");
//   encrypted += cipher.final("hex");

//   const authTag = cipher.getAuthTag().toString("hex"); // 🔐 Protección de integridad

//   return `${iv.toString("hex")}:${authTag}:${encrypted}`; // Formato IV:AuthTag:CipherText
// };

// // 🔓 Función para desencriptar datos
// export const decryptData = (encryptedText: string): string => {
//   const [ivHex, authTagHex, encrypted] = encryptedText.split(":");

//   const iv = Buffer.from(ivHex, "hex");
//   const authTag = Buffer.from(authTagHex, "hex");

//   const decipher = crypto.createDecipheriv(ALGORITHM, SECRET_KEY, iv);
//   decipher.setAuthTag(authTag); // 🔐 Validar integridad del mensaje

//   let decrypted = decipher.update(encrypted, "hex", "utf8");
//   decrypted += decipher.final("utf8");

//   return decrypted;
// };

import crypto from "crypto";
import dotenv from "dotenv";

dotenv.config();

const ALGORITHM = "aes-256-gcm";
const IV_LENGTH = 12; // 🔄 Tamaño recomendado para GCM

// ✅ Verificar que la clave de encriptación está definida
if (!process.env.ENCRYPTION_KEY) {
  throw new Error("❌ ENCRYPTION_KEY no está definido en las variables de entorno.");
}

const SECRET_KEY = crypto.scryptSync(process.env.ENCRYPTION_KEY, "salt", 32); // 🔐 Derivar clave segura

// 🔒 Función para encriptar datos
export const encryptData = (text: string): string => {
  try {
    const iv = crypto.randomBytes(IV_LENGTH); // Generar un IV aleatorio
    const cipher = crypto.createCipheriv(ALGORITHM, SECRET_KEY, iv);

    let encrypted = cipher.update(text, "utf8", "hex");
    encrypted += cipher.final("hex");

    const authTag = cipher.getAuthTag().toString("hex"); // 🔐 Protección de integridad

    return `${iv.toString("hex")}:${authTag}:${encrypted}`; // Formato IV:AuthTag:CipherText
  } catch (error) {
    console.error("❌ Error al encriptar datos:", error);
    throw new Error("Error al encriptar los datos.");
  }
};

// 🔓 Función para desencriptar datos
export const decryptData = (encryptedText: string): string => {
  try {
    const parts = encryptedText.split(":");
    if (parts.length !== 3) {
      throw new Error("Formato de datos encriptados incorrecto.");
    }

    const [ivHex, authTagHex, encrypted] = parts;

    const iv = Buffer.from(ivHex, "hex");
    const authTag = Buffer.from(authTagHex, "hex");

    const decipher = crypto.createDecipheriv(ALGORITHM, SECRET_KEY, iv);
    decipher.setAuthTag(authTag); // 🔐 Validar integridad del mensaje

    let decrypted = decipher.update(encrypted, "hex", "utf8");
    decrypted += decipher.final("utf8");

    return decrypted;
  } catch (error) {
    console.error("❌ Error al desencriptar datos:", error);
    throw new Error("No se pudo desencriptar la información.");
  }
};
