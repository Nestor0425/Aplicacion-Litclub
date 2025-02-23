 
//  import { Router } from "express";
//  import { login } from "../controllers/auth.controller";

//  const router = Router();

// //   Definir correctamente la ruta POST para /login
//  router.post("/login", login);

//  export default router;

import { Router } from "express";
import { login } from "../controllers/auth.controller";
import { loginLimiter } from "../middlewares/rateLimiter"; // Importar middleware

const router = Router();

// Aplicar Rate Limiting solo en la ruta de login
router.post("/login", loginLimiter, login);


export default router;
