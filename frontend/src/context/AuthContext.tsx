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

//   const login = async (email: string, password: string) => {
//     try {
//       const res = await axios.post<AuthResponse>(`${import.meta.env.VITE_API_URL}/auth/login`, {
//         email,
//         password,
//       });

//       setUser(res.data.user);
//       localStorage.setItem("user", JSON.stringify(res.data.user));
//       localStorage.setItem("token", res.data.token);
//       return true;
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

interface TwoFAResponse {
  requires2FA: boolean;
  user?: User;
  token?: string;
}

interface AuthContextType {
  user: User | null;
  login: (email: string, password: string) => Promise<boolean>;
  verify2FA: (code: string) => Promise<boolean>;
  logout: () => void;
}

export const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children }: { children: React.ReactNode }) => {
  const [user, setUser] = useState<User | null>(null);
  const [emailFor2FA, setEmailFor2FA] = useState<string | null>(null);

  useEffect(() => {
    const storedUser = localStorage.getItem("user");
    if (storedUser) {
      setUser(JSON.parse(storedUser));
    }
  }, []);

  const login = async (email: string, password: string): Promise<boolean> => {
    try {
      const res = await axios.post<TwoFAResponse>(`${import.meta.env.VITE_API_URL}/auth/login`, {
        email,
        password,
      });

      if (res.data.requires2FA) {
        setEmailFor2FA(email); // ✅ Guardar el email temporalmente para la verificación 2FA
        return false; // ✅ Indicar que falta verificar 2FA
      }

      if (res.data.user && res.data.token) {
        setUser(res.data.user);
        localStorage.setItem("user", JSON.stringify(res.data.user));
        localStorage.setItem("token", res.data.token);
        return true;
      }

      return false;
    } catch (error) {
      console.error("Error en login:", error);
      return false;
    }
  };

  const verify2FA = async (code: string): Promise<boolean> => {
    try {
      if (!emailFor2FA) {
        console.error("Error: No hay email para verificar 2FA");
        return false;
      }

      const res = await axios.post<AuthResponse>(`${import.meta.env.VITE_API_URL}/auth/verify-2fa`, {
        email: emailFor2FA,
        code,
      });

      if (res.data.user && res.data.token) {
        setUser(res.data.user);
        localStorage.setItem("user", JSON.stringify(res.data.user));
        localStorage.setItem("token", res.data.token);
        setEmailFor2FA(null); // ✅ Limpiar el email de la memoria
        return true;
      }

      return false;
    } catch (error) {
      console.error("Error en verificación 2FA:", error);
      return false;
    }
  };

  const logout = () => {
    setUser(null);
    localStorage.removeItem("user");
    localStorage.removeItem("token");
  };

  return (
    <AuthContext.Provider value={{ user, login, verify2FA, logout }}>
      {children}
    </AuthContext.Provider>
  );
};
