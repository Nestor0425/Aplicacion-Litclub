 
//  import { Router } from "express";
//  import { login } from "../controllers/auth.controller";

//  const router = Router();

// //   Definir correctamente la ruta POST para /login
//  router.post("/login", login);

//  export default router;

// import { Router } from "express";
// import { login } from "../controllers/auth.controller";
// import { loginLimiter } from "../middlewares/rateLimiter"; // Importar middleware

// const router = Router();

// // Aplicar Rate Limiting solo en la ruta de login
// router.post("/login", loginLimiter, login);


// export default router;
import express from "express";

import { Router } from "express";
import { login } from "../controllers/auth.controller";
import { loginLimiter } from "../middlewares/rateLimiter"; // 🔹 Importar middleware de rate limiting
import { getAuthenticatedUser } from "../controllers/auth.controller";
import { authenticateToken } from "../middlewares/auth.middleware"; // Middleware de autenticación

const router = express.Router();

// 🛡️ Aplicar Rate Limiting solo en la ruta de login
router.post("/login", loginLimiter, login);
router.post("/me", authenticateToken, getAuthenticatedUser); // ✅ Nueva ruta para verificar sesión



export default router;
