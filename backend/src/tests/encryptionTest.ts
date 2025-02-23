import { encryptData, decryptData } from "../utils/encryption";

const originalText = "Datos Sensibles: Nombre Edson Alexis Rodriguez Ibarra";

console.log("Texto Original:", originalText);

const encrypted = encryptData(originalText);
console.log("🔐 Encriptado:", encrypted);

const decrypted = decryptData(encrypted);
console.log("🔓 Desencriptado:", decrypted);
