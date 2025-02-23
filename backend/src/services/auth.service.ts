import jwt from "jsonwebtoken";
import bcrypt from "bcryptjs";
import { findUserByEmail } from "./user.service";
import dotenv from "dotenv";

dotenv.config();

export const authenticateUser = async (email: string, password: string) => {
  const user = await findUserByEmail(email);
  if (!user) return null;

  const isMatch = await bcrypt.compare(password, user.password);
  if (!isMatch) return null;

  // Verificar que JWT_SECRET está definido
  if (!process.env.JWT_SECRET) {
    throw new Error("JWT_SECRET no está definido en las variables de entorno");
  }

  const expiresIn = process.env.JWT_EXPIRES_IN || "1h"; // Se asegura de que sea un string válido

  const token = jwt.sign(
    { id: user.id, rol: user.rol },
    process.env.JWT_SECRET as string, // Asegurar que es una string válida
    {
      expiresIn: expiresIn as jwt.SignOptions["expiresIn"], // Corrección en el tipado
    }
  );

  return { token, user };
};

