import { useEffect, useContext } from "react";
import { NavbarContext } from "../context/NavbarContext";
import CanvaEmbed from "../components/CanvaEmbed";
import "../styles/Inicio.css";

const Inicio = () => {
  const navbarContext = useContext(NavbarContext);

  useEffect(() => {
    if (navbarContext) {
      navbarContext.setShowNavbar(false); // Oculta el Navbar al entrar
    }

    return () => {
      if (navbarContext) {
        navbarContext.setShowNavbar(true); // Lo vuelve a mostrar al salir
      }
    };
  }, [navbarContext]);

  return <CanvaEmbed />;
};

export default Inicio;
