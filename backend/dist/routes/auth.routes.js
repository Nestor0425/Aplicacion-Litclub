"use strict";
//  import { Router } from "express";
//  import { login } from "../controllers/auth.controller";
Object.defineProperty(exports, "__esModule", { value: true });
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
const express_1 = require("express");
const auth_controller_1 = require("../controllers/auth.controller");
const rateLimiter_1 = require("../middlewares/rateLimiter"); // 🔹 Importar middleware de rate limiting
const auth_controller_2 = require("../controllers/auth.controller");
const auth_middleware_1 = require("../middlewares/auth.middleware"); // Middleware de autenticación
const router = (0, express_1.Router)();
// 🛡️ Aplicar Rate Limiting solo en la ruta de login
router.post("/login", rateLimiter_1.loginLimiter, auth_controller_1.login);
router.get("/me", auth_middleware_1.authenticateToken, auth_controller_2.getAuthenticatedUser); // ✅ Nueva ruta para verificar sesión
exports.default = router;
