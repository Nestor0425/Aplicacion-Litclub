// // import { createContext, useState, ReactNode } from "react";

// // interface NavbarContextType {
// //   showNavbar: boolean;
// //   setShowNavbar: (show: boolean) => void;
// // }

// // export const NavbarContext = createContext<NavbarContextType>({
// //   showNavbar: true,
// //   setShowNavbar: () => {},
// // });

// // export const NavbarProvider = ({ children }: { children: ReactNode }) => {
// //   const [showNavbar, setShowNavbar] = useState(true);

// //   return (
// //     <NavbarContext.Provider value={{ showNavbar, setShowNavbar }}>
// //       {children}
// //     </NavbarContext.Provider>
// //   );
// // };
// import { createContext, useState, useEffect, useContext, ReactNode } from "react";
// import Navbar from "../components/Navbar";

// interface NavbarContextType {
//   showNavbar: boolean;
//   setShowNavbar: (show: boolean) => void;
// }

// export const NavbarContext = createContext<NavbarContextType | null>(null);

// export const NavbarProvider = ({ children }: { children: ReactNode }) => {
//   const [showNavbar, setShowNavbar] = useState<boolean>(() => {
//     // ✅ Recuperar el estado desde localStorage al cargar
//     const storedValue = localStorage.getItem("showNavbar");
//     return storedValue ? JSON.parse(storedValue) : true;
//   });

//   // ✅ Guardar cambios en `localStorage`
//   useEffect(() => {
//     localStorage.setItem("showNavbar", JSON.stringify(showNavbar));
//   }, [showNavbar]);

//   return (
//     <NavbarContext.Provider value={{ showNavbar, setShowNavbar }}>
//       {children}
//     </NavbarContext.Provider>
//   );
// };

// // ✅ Hook personalizado para usar el contexto de Navbar
// export const useNavbar = (): NavbarContextType => {
//   const context = useContext(NavbarContext);
//   if (!context) {
//     throw new Error("useNavbar debe usarse dentro de un NavbarProvider");
//   }
//   return context;
// };

// export const NavbarWrapper = () => {
//   const navbarContext = useContext(NavbarContext);

//   if (!navbarContext) return null; // Evita acceder a propiedades de un contexto nulo

//   return navbarContext.showNavbar ? <Navbar /> : null;
// };

import { createContext, useState, useEffect, useContext, ReactNode } from "react";
import Navbar from "../components/Navbar";

interface NavbarContextType {
  showNavbar: boolean;
  setShowNavbar: (show: boolean) => void;
}

// ✅ Crear el contexto con `undefined` en lugar de `null`
export const NavbarContext = createContext<NavbarContextType | undefined>(undefined);

export const NavbarProvider = ({ children }: { children: ReactNode }) => {
  const [showNavbar, setShowNavbar] = useState<boolean>(() => {
    try {
      const storedValue = localStorage.getItem("showNavbar");
      return storedValue ? JSON.parse(storedValue) : true;
    } catch {
      return true; // Valor por defecto
    }
  });

  useEffect(() => {
    if (typeof window !== "undefined") {
      localStorage.setItem("showNavbar", JSON.stringify(showNavbar));
    }
  }, [showNavbar]);

  return (
    <NavbarContext.Provider value={{ showNavbar, setShowNavbar }}>
      {children}
    </NavbarContext.Provider>
  );
};

// ✅ Hook para acceder de manera segura al contexto
export const useNavbar = (): NavbarContextType => {
  const context = useContext(NavbarContext);
  if (!context) {
    return { showNavbar: true, setShowNavbar: () => {} }; // Valor por defecto para evitar errores
  }
  return context;
};

// ✅ Componente que maneja la visibilidad del Navbar
export const NavbarWrapper = () => {
  const { showNavbar } = useNavbar();
  return showNavbar ? <Navbar /> : null;
};
