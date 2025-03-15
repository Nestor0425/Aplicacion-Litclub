"use strict";
// import { Router } from "express";
// import { register } from "../controllers/user.controller";
Object.defineProperty(exports, "__esModule", { value: true });
// const router = Router();
// router.post("/register", register, (req, res) => {
//     res.json({ message: "Ruta de registro funcionando" });
//   });
// export default router;
const express_1 = require("express");
const user_controller_1 = require("../controllers/user.controller");
const router = (0, express_1.Router)();
// 📌 Ruta de registro de usuarios
router.post("/register", user_controller_1.register);
exports.default = router;
