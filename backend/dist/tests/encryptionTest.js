"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const encryption_1 = require("../utils/encryption");
const originalText = "Datos Sensibles: Nombre Edson Alexis Rodriguez Ibarra";
console.log("Texto Original:", originalText);
const encrypted = (0, encryption_1.encryptData)(originalText);
console.log("🔐 Encriptado:", encrypted);
const decrypted = (0, encryption_1.decryptData)(encrypted);
console.log("🔓 Desencriptado:", decrypted);
