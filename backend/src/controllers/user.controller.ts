// import { Request, Response } from "express";
// import { createUser } from "../services/user.service";

// export const register = async (req: Request, res: Response) => {
//   const user = await createUser(req.body);
//   res.status(201).json(user);
// };
import { Request, Response } from "express";
import { createUser } from "../services/user.service";

export const register = async (req: Request, res: Response): Promise<void> => {
  try {
    const user = await createUser(req.body);

    res.status(201).json({
      message: "Usuario registrado exitosamente",
      user: {
        id: user.id,
        nombre: user.nombre,
        email: user.email,
        rol: user.rol, // 🔹 No exponemos la contraseña
      },
    });
  } catch (error) {
    console.error("❌ Error en el registro de usuario:", error);
    res.status(500).json({ message: "Error interno del servidor" });
  }
};

