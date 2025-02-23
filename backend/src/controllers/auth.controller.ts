// import { Request, Response } from "express";
// import { loginSchema } from "../validators/auth.validator";
// import { authenticateUser } from "../services/auth.service";
// import logger from "../utils/logger";
// // agregue esto
// import { generate2FACode, send2FACode } from "../services/auth.service";

// const twoFACodes = new Map<string, string>(); // Guardar códigos temporales

// export const login = async (req: Request, res: Response): Promise<void> => {
//   try {
//     // ✅ Validar datos con Zod
//     const validatedData = loginSchema.parse(req.body);

//     // ✅ Autenticar usuario
//     const result = await authenticateUser(validatedData.email, validatedData.password);
    
//     if (!result) {
//       logger.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
//       res.status(401).json({ message: "Credenciales inválidas" });
//       return;
//     }

//     logger.info(`✅ Usuario autenticado: ${result.user.email} (ID: ${result.user.id})`);
//     res.json(result);
//   } catch (error) {
//     logger.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
//     res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
//   }
// };

import { Request, Response } from "express";
import { loginSchema } from "../validators/auth.validator";
import { authenticateUser, generateJWT } from "../services/auth.service";
import logger from "../utils/logger";
import { generate2FACode, send2FACode } from "../services/auth.service";
import jwt from "jsonwebtoken";

const twoFACodes = new Map<string, string>(); // Guardar códigos temporales

export const login = async (req: Request, res: Response): Promise<void> => {
  try {
    const validatedData = loginSchema.parse(req.body);
    const result = await authenticateUser(validatedData.email, validatedData.password);

    if (!result) {
      logger.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
      res.status(401).json({ message: "Credenciales inválidas" });
      return;
    }

    // ✅ Desactivar 2FA si ENABLE_2FA está en "false"
    if (process.env.ENABLE_2FA === "true" && result.user.rol === "admin") {
      const twoFACode = generate2FACode();
      twoFACodes.set(validatedData.email, twoFACode);
      await send2FACode(validatedData.email, twoFACode);

      logger.info(`🔒 Código 2FA enviado a ${validatedData.email}`);
      res.json({ requires2FA: true });
      return;
    }

    // ✅ Si 2FA está desactivado, autenticar directamente
    const token = generateJWT(result.user);
    logger.info(`✅ Usuario autenticado sin 2FA: ${result.user.email} (ID: ${result.user.id})`);
    res.json({ token, user: result.user });
  } catch (error) {
    logger.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
    res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
  }
};


// 📌 Verificación del Código 2FA
export const verify2FA = (req: Request, res: Response): void => {
  const { email, code } = req.body;

  if (!twoFACodes.has(email) || twoFACodes.get(email) !== code) {
    logger.warn(`❌ Código 2FA incorrecto para ${email}`);
    res.status(403).json({ message: "Código 2FA incorrecto o expirado" });
    return;
  }

  twoFACodes.delete(email); // Eliminar código usado

  // ✅ Generar token JWT
  const token = jwt.sign({ id: email }, process.env.JWT_SECRET as string, { expiresIn: "1h" });

  logger.info(`✅ 2FA verificado exitosamente para ${email}`);
  res.json({ message: "Autenticación exitosa", token });
};
