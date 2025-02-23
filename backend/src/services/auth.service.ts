// import jwt from "jsonwebtoken";
// import bcrypt from "bcryptjs";
// import { findUserByEmail } from "./user.service";
// import dotenv from "dotenv";

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

import jwt, { SignOptions} from "jsonwebtoken";
import bcrypt from "bcryptjs";
import { findUserByEmail } from "./user.service";
import dotenv from "dotenv";
import speakeasy from "speakeasy";
import nodemailer from "nodemailer";

dotenv.config();

// 📌 Función para autenticar usuario con email y contraseña
export const authenticateUser = async (email: string, password: string) => {
  const user = await findUserByEmail(email);
  if (!user) return null;

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return null;

  return { user };
};

// 📌 Función para generar el código 2FA
export const generate2FACode = (): string => {
  return speakeasy.totp({
    secret: process.env.TWO_FA_SECRET || "my_secret_2fa",
    encoding: "base32",
    step: 60, // Código válido por 60 segundos
  });
};

// 📌 Función para enviar el código 2FA por email
export const send2FACode = async (email: string, code: string) => {
  console.log(`✅ Código 2FA generado: ${code} para ${email}`); // 🔍 Verificación en consola

  const transporter = nodemailer.createTransport({
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

    console.log(`✅ Correo enviado a: ${email}`); // 🔍 Confirmación en consola
  } catch (error) {
    console.error(`❌ Error enviando correo: ${error}`); // 🔍 Si hay error, se muestra en consola
  }
};


// 📌 Función para generar el token JWT después de la verificación 2FA
export const generateJWT = (user: { id: number; rol: string }) => {
  if (!process.env.JWT_SECRET) {
    throw new Error("JWT_SECRET no está definido en las variables de entorno");
  }

  // ✅ Asegurar que `expiresIn` sea del tipo correcto para `jwt.sign`
  const expiresIn: SignOptions["expiresIn"] =
    process.env.JWT_EXPIRES_IN && !isNaN(Number(process.env.JWT_EXPIRES_IN))
      ? (Number(process.env.JWT_EXPIRES_IN) as SignOptions["expiresIn"])
      : (process.env.JWT_EXPIRES_IN as SignOptions["expiresIn"]) || "1h";

  return jwt.sign(
    { id: user.id, rol: user.rol },
    process.env.JWT_SECRET as string,
    { expiresIn }
  );
};

