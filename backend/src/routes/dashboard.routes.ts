// import { Router } from "express";
// import { getDashboardStats } from "../controllers/dashboard.controller";
// import { authenticateToken, authorizeRole } from "../middlewares/auth.middleware";

// const router = Router();

// // ✅ Asegurar que la ruta correcta está definida
// router.get("/", authenticateToken, authorizeRole("admin"), getDashboardStats);

// export default router;
import { Router } from "express";
import { getDashboardStats } from "../controllers/dashboard.controller";
import { authenticateToken, authorizeRole } from "../middlewares/auth.middleware";

const router = Router();

// ✅ Asegurar que la ruta correcta está definida
router.get("/", authenticateToken, authorizeRole("admin"), getDashboardStats);

export default router;

