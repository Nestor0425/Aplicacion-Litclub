import { useEffect, useContext } from "react";
import { NavbarContext } from "../context/NavbarContext";
import CanvaEmbed from "../components/CanvaEmbed";
import "../styles/Inicio.css";


const Inicio = () => {
  const { setShowNavbar } = useContext(NavbarContext);

  useEffect(() => {
    setShowNavbar(false); // Oculta el Navbar al entrar
    return () => setShowNavbar(true); // Lo vuelve a mostrar al salir
  }, [setShowNavbar]);

  return (
      <><CanvaEmbed /></>
  );
};

export default Inicio;
