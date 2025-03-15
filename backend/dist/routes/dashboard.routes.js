"use strict";
// import { Router } from "express";
// import { getDashboardStats } from "../controllers/dashboard.controller";
// import { authenticateToken, authorizeRole } from "../middlewares/auth.middleware";
Object.defineProperty(exports, "__esModule", { value: true });
// const router = Router();
// // ✅ Asegurar que la ruta correcta está definida
// router.get("/", authenticateToken, authorizeRole("admin"), getDashboardStats);
// export default router;
const express_1 = require("express");
const dashboard_controller_1 = require("../controllers/dashboard.controller");
const auth_middleware_1 = require("../middlewares/auth.middleware");
const router = (0, express_1.Router)();
// ✅ Asegurar que la ruta correcta está definida
router.get("/", auth_middleware_1.authenticateToken, (0, auth_middleware_1.authorizeRole)("admin"), dashboard_controller_1.getDashboardStats);
exports.default = router;
