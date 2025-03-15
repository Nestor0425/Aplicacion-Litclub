// export interface User {
//     id?: number;
//     nombre: string;
//     email: string;
//     rol: "admin" | "usuario";
//     password: string;
//   }
export interface User {
  id?: number;
  nombre: string;
  email: string;
  rol: "admin" | "usuario";
  password?: string; // 🔹 Hacemos la contraseña opcional para evitar exponerla
  createdAt?: Date;
  updatedAt?: Date;
}
