// import { Request, Response } from "express";
// import { loginSchema } from "../validators/auth.validator";
// import { authenticateUser, generateJWT } from "../services/auth.service";
// import logger from "../utils/logger";

// export const login = async (req: Request, res: Response): Promise<void> => {
//   try {
//     // ✅ Validar los datos de entrada con Zod
//     const validatedData = loginSchema.parse(req.body);

//     // ✅ Autenticar usuario
//     const result = await authenticateUser(validatedData.email, validatedData.password);

//     if (!result) {
//       logger.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
//       res.status(401).json({ message: "Credenciales inválidas" });
//       return;
//     }

//     // ✅ Generar token JWT
//     const token = generateJWT(result.user);
//     logger.info(`✅ Usuario autenticado: ${result.user.email} (ID: ${result.user.id})`);
    
//     res.json({ token, user: result.user });
//   } catch (error) {
//     logger.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
//     res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
//   }
// };
import { Request, Response } from "express";
import { loginSchema } from "../validators/auth.validator";
import { authenticateUser, generateJWT } from "../services/auth.service";
import logger from "../utils/logger";
import { User } from "../models/user.model";
import { verifyJWT } from "../services/auth.service"; // Función para verificar el token
import pool from "../config/db";


export const login = async (req: Request, res: Response): Promise<void> => {
  try {
    // ✅ Validar los datos de entrada con Zod
    const validatedData = loginSchema.parse(req.body);

    // ✅ Autenticar usuario
    const result = await authenticateUser(validatedData.email, validatedData.password);

    if (!result || !result.user) {
      logger.warn(`⚠ Intento de login fallido para ${validatedData.email}`);
      res.status(401).json({ message: "Credenciales inválidas" });
      return;
    }

    const user: User = result.user;

    // ✅ Validar que el usuario tiene un `id` válido antes de generar el JWT
    if (typeof user.id !== "number") {
      logger.error(`❌ Error: El usuario ${user.email} no tiene un ID válido.`);
      res.status(500).json({ message: "Error interno en la autenticación." });
      return;
    }

    // ✅ Generar token JWT
    const token = generateJWT({ id: user.id, rol: user.rol });

    logger.info(`✅ Usuario autenticado: ${user.email} (ID: ${user.id})`);
    res.json({ token, user });
  } catch (error) {
    logger.error(`❌ Error en login: ${error instanceof Error ? error.message : error}`);
    res.status(400).json({ message: "Datos inválidos", error: error instanceof Error ? error.message : error });
  }
};

export const getAuthenticatedUser = async (req: Request, res: Response): Promise<void> => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      res.status(401).json({ message: "No autorizado. Token no proporcionado." });
      return;
    }

    const token = authHeader.split(" ")[1];
    const decoded = verifyJWT(token); // Verifica el token

    if (!decoded) {
      res.status(401).json({ message: "Token inválido o expirado." });
      return;
    }

    // ✅ Buscar el usuario en la base de datos
    const result = await pool.query("SELECT id, nombre, email, rol FROM users WHERE id = $1", [decoded.id]);

    if (result.rows.length === 0) {
      res.status(404).json({ message: "Usuario no encontrado." });
      return;
    }

    res.json(result.rows[0]); // ✅ Corregido: No usar `return`
  } catch (error) {
    console.error("Error en autenticación:", error);
    res.status(500).json({ message: "Error interno del servidor." });
  }
};

