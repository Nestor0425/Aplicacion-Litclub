import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";

const Register = () => {
  const navigate = useNavigate();
  const [nombre, setNombre] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await axios.post(`${import.meta.env.VITE_API_URL}/users/register`, {
        nombre,
        email,
        password,
        rol: "usuario",
      });
      navigate("/login");
    } catch (error) {
      console.error("Error en el registro:", error); // Agrega esta línea
      alert("Error en el registro");
    }
  };
  

  return (
    <div>
      <h2>Registro</h2>
      <form onSubmit={handleSubmit}>
        <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} placeholder="Nombre" />
        <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Correo electrónico" />
        <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Contraseña" />
        <button type="submit">Registrarse</button>
      </form>
    </div>
  );
};

export default Register;
