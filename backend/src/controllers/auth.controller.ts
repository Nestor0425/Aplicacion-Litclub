import { Request, Response } from "express";
import { loginSchema } from "../validators/auth.validator";
import { authenticateUser } from "../services/auth.service";
import logger from "../utils/logger";

export const login = async (req: Request, res: Response): Promise<void> => {
  try {
    // ✅ Validar datos con Zod
    const validatedData = loginSchema.parse(req.body);

    // ✅ Autenticar usuario
    const result = await authenticateUser(validatedData.email, validatedData.password);
    
    if (!result) {
      logger.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
      res.status(401).json({ message: "Credenciales inválidas" });
      return;
    }

    logger.info(`✅ Usuario autenticado: ${result.user.email} (ID: ${result.user.id})`);
    res.json(result);
  } catch (error) {
    logger.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
    res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
  }
};
