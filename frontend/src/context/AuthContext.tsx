// import { createContext, useState, useEffect } from "react";
// import axios from "axios";

// interface User {
//   id: number;
//   nombre: string;
//   email: string;
//   rol: "admin" | "usuario";
// }

// interface AuthResponse {
//   token: string;
//   user: User;
// }

// interface AuthContextType {
//   user: User | null;
//   login: (email: string, password: string) => Promise<boolean>;
//   logout: () => void;
// }

// export const AuthContext = createContext<AuthContextType | null>(null);

// export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
//   const [user, setUser] = useState<User | null>(null);

//   useEffect(() => {
//     const storedUser = localStorage.getItem("user");
//     if (storedUser) {
//       setUser(JSON.parse(storedUser));
//     }
//   }, []);

//   const login = async (email: string, password: string): Promise<boolean> => {
//     try {
//       const res = await axios.post<AuthResponse>(`${import.meta.env.VITE_API_URL}/auth/login`, {
//         email,
//         password,
//       });

//       if (res.data.user && res.data.token) {
//         setUser(res.data.user);
//         localStorage.setItem("user", JSON.stringify(res.data.user));
//         localStorage.setItem("token", res.data.token);
//         return true;
//       }

//       return false;
//     } catch (error) {
//       console.error("Error en login:", error);
//       return false;
//     }
//   };

//   const logout = () => {
//     setUser(null);
//     localStorage.removeItem("user");
//     localStorage.removeItem("token");
//   };

//   return (
//     <AuthContext.Provider value={{ user, login, logout }}>
//       {children}
//     </AuthContext.Provider>
//   );
// };

import { createContext, useState, useEffect } from "react";
import axios from "axios";

interface User {
  id: number;
  nombre: string;
  email: string;
  rol: "admin" | "usuario";
}

interface AuthResponse {
  token: string;
  user: User;
}

interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<boolean>;
  logout: () => void;
}

export const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);

  // ✅ Verifica si el token es válido al recargar la app
  useEffect(() => {
    const verifyToken = async () => {
      const token = localStorage.getItem("token");
      if (token) {
        try {
          const res = await axios.get<User>(`${import.meta.env.VITE_API_URL}/auth/me`, {
            headers: { Authorization: `Bearer ${token}` },
          });
          setUser(res.data);
          axios.defaults.headers.common["Authorization"] = `Bearer ${token}`;
        } catch (error) {
          console.error("Token inválido o expirado:", error);
          logout();
        }
      }
    };
    verifyToken();
  }, []);

  // ✅ Función de login con manejo de errores mejorado
  const login = async (email: string, password: string): Promise<boolean> => {
    try {
      const res = await axios.post<AuthResponse>(`${import.meta.env.VITE_API_URL}/auth/login`, {
        email,
        password,
      });

      if (res.data.user && res.data.token) {
        setUser(res.data.user);
        localStorage.setItem("user", JSON.stringify(res.data.user));
        localStorage.setItem("token", res.data.token);
        axios.defaults.headers.common["Authorization"] = `Bearer ${res.data.token}`;
        return true;
      }
      return false;
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    } catch (error: any) {
      console.error("Error en login:", error);
      alert(error.response?.data?.message || "Error al iniciar sesión.");
      return false;
    }
  };

  // ✅ Función de logout
  const logout = () => {
    setUser(null);
    localStorage.removeItem("user");
    localStorage.removeItem("token");
    delete axios.defaults.headers.common["Authorization"];
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
