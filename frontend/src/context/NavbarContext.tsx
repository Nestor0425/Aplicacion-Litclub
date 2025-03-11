import { createContext, useState, ReactNode } from "react";

interface NavbarContextType {
  showNavbar: boolean;
  setShowNavbar: (show: boolean) => void;
}

export const NavbarContext = createContext<NavbarContextType>({
  showNavbar: true,
  setShowNavbar: () => {},
});

export const NavbarProvider = ({ children }: { children: ReactNode }) => {
  const [showNavbar, setShowNavbar] = useState(true);

  return (
    <NavbarContext.Provider value={{ showNavbar, setShowNavbar }}>
      {children}
    </NavbarContext.Provider>
  );
};
