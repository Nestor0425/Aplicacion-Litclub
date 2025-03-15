// import { useState } from "react";
// import axios from "axios";
// import { useNavigate } from "react-router-dom";

// const Register = () => {
//   const navigate = useNavigate();
//   const [nombre, setNombre] = useState("");
//   const [email, setEmail] = useState("");
//   const [password, setPassword] = useState("");

//   const handleSubmit = async (e: React.FormEvent) => {
//     e.preventDefault();
//     try {
//       await axios.post(`${import.meta.env.VITE_API_URL}/users/register`, {
//         nombre,
//         email,
//         password,
//         rol: "usuario",
//       });
//       navigate("/login");
//     } catch (error) {
//       console.error("Error en el registro:", error); // Agrega esta línea
//       alert("Error en el registro");
//     }
//   };
  

//   return (
//     <div>
//       <h2>Registro</h2>
//       <form onSubmit={handleSubmit}>
//         <input type="text" value={nombre} onChange={(e) => setNombre(e.target.value)} placeholder="Nombre" />
//         <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Correo electrónico" />
//         <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Contraseña" />
//         <button type="submit">Registrarse</button>
//       </form>
//     </div>
//   );
// };

// export default Register;
import { useState } from "react";
import axios from "axios";
import { useNavigate } from "react-router-dom";
import { TextField, Button, Typography, Box, CircularProgress, Snackbar, Alert } from "@mui/material";

const Register = () => {
  const navigate = useNavigate();
  const [nombre, setNombre] = useState("");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<boolean>(false);

  const validateEmail = (email: string) => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    
    if (!nombre || !email || !password) {
      setError("⚠️ Todos los campos son obligatorios.");
      return;
    }
    if (!validateEmail(email)) {
      setError("⚠️ Ingresa un correo electrónico válido.");
      return;
    }
    if (password.length < 5) {
      setError("⚠️ La contraseña debe tener al menos 5 caracteres.");
      return;
    }

    setLoading(true);
    try {
      const res = await axios.post(`${import.meta.env.VITE_API_URL}/users/register`, {
        nombre,
        email,
        password,
        rol: "usuario",
      });

      if (res.status === 201) {
        setSuccess(true);
        setTimeout(() => navigate("/login"), 2000); // Redirigir tras 2s
      } else {
        throw new Error("Registro fallido.");
      }
   
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    } catch (error: any) {
      console.error("Error en el registro:", error);
      setError(error.response?.data?.message || "Error en el registro. Inténtalo nuevamente.");
    } finally {
      setLoading(false);
    }
  };

  return (
    <Box sx={{ maxWidth: 400, mx: "auto", mt: 5, textAlign: "center" }}>
      <Typography variant="h4" gutterBottom>
        📝 Registro
      </Typography>
      <form onSubmit={handleSubmit} style={{ display: "flex", flexDirection: "column", gap: "15px" }}>
        <TextField 
          label="Nombre" 
          variant="outlined" 
          fullWidth 
          value={nombre} 
          onChange={(e) => setNombre(e.target.value)} 
        />
        <TextField 
          label="Correo electrónico" 
          variant="outlined" 
          type="email" 
          fullWidth 
          value={email} 
          onChange={(e) => setEmail(e.target.value)} 
        />
        <TextField 
          label="Contraseña" 
          variant="outlined" 
          type="password" 
          fullWidth 
          value={password} 
          onChange={(e) => setPassword(e.target.value)} 
        />
        
        <Button type="submit" variant="contained" color="primary" disabled={loading}>
          {loading ? <CircularProgress size={24} /> : "Registrarse"}
        </Button>
      </form>

      {error && (
        <Snackbar open={!!error} autoHideDuration={4000} onClose={() => setError(null)}>
          <Alert severity="error" onClose={() => setError(null)}>
            {error}
          </Alert>
        </Snackbar>
      )}

      {success && (
        <Snackbar open={success} autoHideDuration={4000} onClose={() => setSuccess(false)}>
          <Alert severity="success" onClose={() => setSuccess(false)}>
            ✅ Registro exitoso. Redirigiendo a inicio de sesión...
          </Alert>
        </Snackbar>
      )}

      <Button sx={{ marginTop: 2 }} onClick={() => navigate("/login")}>
        ¿Ya tienes una cuenta? Iniciar sesión
      </Button>
    </Box>
  );
};

export default Register;
