// import { Request } from "express";

// export interface AuthenticatedRequest extends Request {
//   user?: { id: number; rol: string };
// }
import { Request } from "express";

// 📌 Definir la estructura completa del usuario autenticado
interface AuthUser {
  id: number;
  nombre: string;
  email: string;
  rol: "admin" | "usuario"; // 🔹 Opcionalmente, restringir los valores del rol
}

// 📌 Extender Express para incluir `user` en `req`
export interface AuthenticatedRequest extends Request {
  user?: AuthUser;
}
