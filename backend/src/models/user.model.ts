export interface User {
    id?: number;
    nombre: string;
    email: string;
    rol: "admin" | "usuario";
    password: string;
  }
  