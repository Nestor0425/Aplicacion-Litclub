import { Router, Response } from "express";
import { authenticateToken, AuthenticatedRequest } from "../middlewares/auth.middleware";
import db from "../config/db";

const router = Router();

// 📌 Obtener logs (Solo Admins)
router.get("/", authenticateToken, async (req: AuthenticatedRequest, res: Response): Promise<void> => {
  try {
    // ✅ Verificar si el usuario es admin
    if (!req.user || req.user.rol !== "admin") {
      res.status(403).json({ message: "Acceso denegado" });
      return;
    }

    // 📌 Obtener logs desde PostgreSQL
    const result = await db.query("SELECT * FROM logs ORDER BY timestamp DESC LIMIT 100");

    res.json(result.rows);
  } catch (error) {
    console.error("❌ Error obteniendo logs:", error);
    res.status(500).json({ message: "Error obteniendo logs" });
  }
});

export default router;
