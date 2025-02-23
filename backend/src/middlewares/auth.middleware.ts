// import { Response, NextFunction } from "express";
// import jwt, { JwtPayload, VerifyErrors } from "jsonwebtoken";
// import dotenv from "dotenv";
// import { AuthenticatedRequest } from "../types/express"; // Importar la interfaz personalizada

// dotenv.config();


// export const authenticateToken = (req: AuthenticatedRequest, res: Response, next: NextFunction): void => {
//   try {
//     const authHeader = req.headers.authorization;
//     if (!authHeader) {
//       res.status(403).json({ message: "Acceso denegado, token no proporcionado" });
//       return;
//     }

//     const token = authHeader.split(" ")[1];
//     if (!token) {
//       res.status(403).json({ message: "Formato de autorización incorrecto" });
//       return;
//     }

//     jwt.verify(token, process.env.JWT_SECRET as string, {} as jwt.VerifyOptions, (err: VerifyErrors | null, decoded: JwtPayload | string | undefined) => {
//       if (err) {
//         res.status(403).json({ message: "Token inválido o expirado" });
//         return;
//       }

//       if (!decoded || typeof decoded === "string") {
//         res.status(403).json({ message: "Token inválido" });
//         return;
//       }

//       req.user = decoded as { id: number; rol: string };
//       next(); // ✅ Continuar con la siguiente función
//     });
//   } catch (error) {
//     console.error("❌ Error en autenticación:", error);
//     res.status(500).json({ message: "Error interno en la autenticación" });
//   }
// };


// export const authorizeRole = (role: string) => {
//   return (req: AuthenticatedRequest, res: Response, next: NextFunction): void => {
//     if (!req.user) {
//       res.status(403).json({ message: "Acceso denegado, usuario no autenticado" });
//       return;
//     }

//     if (req.user.rol !== role) {
//       res.status(403).json({ message: `Acceso denegado, se requiere rol: ${role}` });
//       return;
//     }

//     next(); // ✅ Continuar con la siguiente función
//   };
// };
import { Request, Response, NextFunction } from "express";
import jwt, { JwtPayload, VerifyErrors } from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

export interface AuthenticatedRequest extends Request {
  user?: { id: number; nombre: string; email: string; rol: string };
}

export const authenticateToken = (req: AuthenticatedRequest, res: Response, next: NextFunction): void => {
  try {
    // ✅ Obtener el token desde el header Authorization
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      res.status(403).json({ message: "Acceso denegado, token no proporcionado" });
      return;
    }

    const token = authHeader.split(" ")[1];

    jwt.verify(token, process.env.JWT_SECRET as string, (err: VerifyErrors | null, decoded: JwtPayload | string | undefined) => {
      if (err) {
        res.status(403).json({ message: "Token inválido o expirado" });
        return;
      }

      if (!decoded || typeof decoded === "string") {
        res.status(403).json({ message: "Token inválido" });
        return;
      }

      req.user = decoded as { id: number; nombre: string; email: string; rol: string };
      next(); // ✅ Continuar con la siguiente función
    });
  } catch (error) {
    console.error("❌ Error en autenticación:", error);
    res.status(500).json({ message: "Error interno en la autenticación" });
  }
};


export const authorizeRole = (role: string) => {
     return (req: AuthenticatedRequest, res: Response, next: NextFunction): void => {
       if (!req.user) {
         res.status(403).json({ message: "Acceso denegado, usuario no autenticado" });
         return;
       }
  
       if (req.user.rol !== role) {
         res.status(403).json({ message: `Acceso denegado, se requiere rol: ${role}` });
         return;
       }
  
       next(); // ✅ Continuar con la siguiente función
     };
   };