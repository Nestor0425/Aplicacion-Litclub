import { Router } from "express";
import { getTotalBooks } from "../controllers/stats.controller";

const router = Router();

router.get("/total-books", getTotalBooks);

export default router;
