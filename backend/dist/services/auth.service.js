"use strict";
// import jwt from "jsonwebtoken";
// import bcrypt from "bcryptjs";
// import { findUserByEmail } from "./user.service";
// import dotenv from "dotenv";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.verifyJWT = exports.generateJWT = exports.send2FACode = exports.generate2FACode = exports.authenticateUser = void 0;
// dotenv.config();
// export const authenticateUser = async (email: string, password: string) => {
//   const user = await findUserByEmail(email);
//   if (!user) return null;
//   const isMatch = await bcrypt.compare(password, user.password);
//   if (!isMatch) return null;
//   // Verificar que JWT_SECRET está definido
//   if (!process.env.JWT_SECRET) {
//     throw new Error("JWT_SECRET no está definido en las variables de entorno");
//   }
//   const expiresIn = process.env.JWT_EXPIRES_IN || "1h"; // Se asegura de que sea un string válido
//   const token = jwt.sign(
//     { id: user.id, rol: user.rol },
//     process.env.JWT_SECRET as string, // Asegurar que es una string válida
//     {
//       expiresIn: expiresIn as jwt.SignOptions["expiresIn"], // Corrección en el tipado
//     }
//   );
//   return { token, user };
// };
// import jwt, { SignOptions} from "jsonwebtoken";
// import bcrypt from "bcryptjs";
// import { findUserByEmail } from "./user.service";
// import dotenv from "dotenv";
// import speakeasy from "speakeasy";
// import nodemailer from "nodemailer";
// dotenv.config();
// // 📌 Función para autenticar usuario con email y contraseña
// export const authenticateUser = async (email: string, password: string) => {
//   const user = await findUserByEmail(email);
//   if (!user) return null;
//   const isMatch = await bcrypt.compare(password, user.password);
//   if (!isMatch) return null;
//   return { user };
// };
// // 📌 Función para generar el código 2FA
// export const generate2FACode = (): string => {
//   return speakeasy.totp({
//     secret: process.env.TWO_FA_SECRET || "my_secret_2fa",
//     encoding: "base32",
//     step: 60, // Código válido por 60 segundos
//   });
// };
// // 📌 Función para enviar el código 2FA por email
// export const send2FACode = async (email: string, code: string) => {
//   console.log(`✅ Código 2FA generado: ${code} para ${email}`); // 🔍 Verificación en consola
//   const transporter = nodemailer.createTransport({
//     service: "gmail",
//     auth: {
//       user: process.env.EMAIL_USER,
//       pass: process.env.EMAIL_PASS,
//     },
//   });
//   try {
//     await transporter.sendMail({
//       from: process.env.EMAIL_USER,
//       to: email,
//       subject: "Código de Autenticación 2FA",
//       text: `Tu código de autenticación es: ${code}. Tiene una validez de 60 segundos.`,
//     });
//     console.log(`✅ Correo enviado a: ${email}`); // 🔍 Confirmación en consola
//   } catch (error) {
//     console.error(`❌ Error enviando correo: ${error}`); // 🔍 Si hay error, se muestra en consola
//   }
// };
// // 📌 Función para generar el token JWT después de la verificación 2FA
// export const generateJWT = (user: { id: number; rol: string }) => {
//   if (!process.env.JWT_SECRET) {
//     throw new Error("JWT_SECRET no está definido en las variables de entorno");
//   }
//   // ✅ Asegurar que `expiresIn` sea del tipo correcto para `jwt.sign`
//   const expiresIn: SignOptions["expiresIn"] =
//     process.env.JWT_EXPIRES_IN && !isNaN(Number(process.env.JWT_EXPIRES_IN))
//       ? (Number(process.env.JWT_EXPIRES_IN) as SignOptions["expiresIn"])
//       : (process.env.JWT_EXPIRES_IN as SignOptions["expiresIn"]) || "1h";
//   return jwt.sign(
//     { id: user.id, rol: user.rol },
//     process.env.JWT_SECRET as string,
//     { expiresIn }
//   );
// };
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const user_service_1 = require("./user.service");
const dotenv_1 = __importDefault(require("dotenv"));
const speakeasy_1 = __importDefault(require("speakeasy"));
const nodemailer_1 = __importDefault(require("nodemailer"));
dotenv_1.default.config();
// 📌 Función para autenticar usuario con email y contraseña
const authenticateUser = async (email, password) => {
    const user = await (0, user_service_1.findUserByEmail)(email);
    if (!user || !user.password)
        return null; // 🔹 Evitar error si no tiene password
    const isMatch = await bcryptjs_1.default.compare(password, user.password);
    if (!isMatch)
        return null;
    return { user };
};
exports.authenticateUser = authenticateUser;
// 📌 Función para generar el código 2FA
const generate2FACode = () => {
    return speakeasy_1.default.totp({
        secret: process.env.TWO_FA_SECRET || "my_secret_2fa",
        encoding: "base32",
        step: 60, // Código válido por 60 segundos
    });
};
exports.generate2FACode = generate2FACode;
// 📌 Función para enviar el código 2FA por email
const send2FACode = async (email, code) => {
    console.log(`✅ Código 2FA generado: ${code} para ${email}`);
    if (!process.env.EMAIL_USER || !process.env.EMAIL_PASS) {
        console.error("❌ Error: Configuración de email no establecida en .env");
        return;
    }
    const transporter = nodemailer_1.default.createTransport({
        service: "gmail",
        auth: {
            user: process.env.EMAIL_USER,
            pass: process.env.EMAIL_PASS,
        },
    });
    try {
        await transporter.sendMail({
            from: process.env.EMAIL_USER,
            to: email,
            subject: "Código de Autenticación 2FA",
            text: `Tu código de autenticación es: ${code}. Tiene una validez de 60 segundos.`,
        });
        console.log(`✅ Correo enviado a: ${email}`);
    }
    catch (error) {
        console.error(`❌ Error enviando correo: ${error}`);
    }
};
exports.send2FACode = send2FACode;
// 📌 Función para generar el token JWT después de la verificación 2FA
const generateJWT = (user) => {
    if (!process.env.JWT_SECRET) {
        throw new Error("❌ JWT_SECRET no está definido en las variables de entorno");
    }
    let expiresIn = "1h"; // Valor por defecto
    if (process.env.JWT_EXPIRES_IN) {
        const parsedExpire = Number(process.env.JWT_EXPIRES_IN);
        if (!isNaN(parsedExpire) && parsedExpire > 0) {
            expiresIn = `${parsedExpire}s`; // Convertimos a string con "s" para segundos
        }
    }
    return jsonwebtoken_1.default.sign({ id: user.id, rol: user.rol }, process.env.JWT_SECRET, { expiresIn });
};
exports.generateJWT = generateJWT;
const verifyJWT = (token) => {
    try {
        const decoded = jsonwebtoken_1.default.verify(token, process.env.JWT_SECRET);
        return decoded;
    }
    catch (error) {
        console.error("Error verificando el token:", error);
        return null;
    }
};
exports.verifyJWT = verifyJWT;
