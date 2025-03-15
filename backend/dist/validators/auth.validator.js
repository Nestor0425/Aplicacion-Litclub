"use strict";
// import { z } from "zod";
Object.defineProperty(exports, "__esModule", { value: true });
exports.loginSchema = void 0;
// export const loginSchema = z.object({
//   email: z.string().email({ message: "El email no es válido" }),
//   password: z.string().min(5, { message: "La contraseña debe tener al menos 5 caracteres" }),
// });
const zod_1 = require("zod");
exports.loginSchema = zod_1.z.object({
    email: zod_1.z.string()
        .trim()
        .email({ message: "El email no es válido" })
        .min(5, { message: "El email debe tener al menos 5 caracteres" }),
    password: zod_1.z.string()
        .trim()
        .min(8, { message: "La contraseña debe tener al menos 8 caracteres" })
        .regex(/[A-Z]/, { message: "La contraseña debe contener al menos una letra mayúscula" })
        .regex(/[0-9]/, { message: "La contraseña debe contener al menos un número" })
        .regex(/[^A-Za-z0-9]/, { message: "La contraseña debe contener al menos un carácter especial" }),
});
