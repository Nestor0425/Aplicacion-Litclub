import { Request, Response } from "express";
import db from "../config/db";

export const getDashboardStats = async (req: Request, res: Response) => {
  try {
    const usersCount = await db.query("SELECT COUNT(*) FROM users");
    const loginsCount = await db.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Usuario autenticado%'");
    const failedLoginsCount = await db.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Intento de login fallido%'");
    const twoFAAttempts = await db.query("SELECT COUNT(*) FROM logs WHERE message LIKE '%Código 2FA enviado%'");

    res.json({
      users: Number(usersCount.rows[0].count),
      logins: Number(loginsCount.rows[0].count),
      failedLogins: Number(failedLoginsCount.rows[0].count),
      twoFA: Number(twoFAAttempts.rows[0].count),
    });
  } catch (error) {
    console.error("Error obteniendo estadísticas:", error);
    res.status(500).json({ message: "Error obteniendo estadísticas" });
  }
};
