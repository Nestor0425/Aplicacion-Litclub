import { Router } from "express";
import { register } from "../controllers/user.controller";

const router = Router();
router.post("/register", register, (req, res) => {
    res.json({ message: "Ruta de registro funcionando" });
  });
  

export default router;
