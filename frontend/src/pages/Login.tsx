import { useContext, useState, useEffect } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";
import { TextField, Button, Typography, Box } from "@mui/material";
import "../styles/Login.css"; // ✅ Importar el CSS

const motivationalQuotes = [
  "La lectura es el gimnasio de la mente.",
  "Cada libro que lees te acerca más a tu mejor versión.",
  "Leer es plantar semillas de conocimiento en tu mente.",
  "Una mente bien leída es una mente bien armada.",
  "La lectura te lleva a lugares donde tus pies nunca han estado.",
];

const Login = () => {
  const auth = useContext(AuthContext);
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [code, setCode] = useState(""); // Código 2FA
  const [step, setStep] = useState(1); // Control de paso: 1 = Login, 2 = 2FA
  const [error, setError] = useState(""); // Manejo de errores
  const [quote, setQuote] = useState(""); // Frase motivacional

  const text = "Encuentra en la lectura tu mejor versión";

const [displayText, setDisplayText] = useState("");
const [index, setIndex] = useState(0);

  useEffect(() => {
    const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
    setQuote(randomQuote);
  }, []);

  useEffect(() => {
    if (index < text.length) {
      const timeout = setTimeout(() => {
        setDisplayText((prev) => prev + text[index]);
        setIndex(index + 1);
      }, 80); // Velocidad de escritura
      return () => clearTimeout(timeout);
    }
  }, [index]);
  

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(""); 
    const success = await auth?.login(email, password);
    if (success) {
      navigate("/dashboard");
    } else {
      setError("Se requiere autenticación de dos factores. Ingresa el código que recibiste.");
      setStep(2);
    }
  };

  const handleVerify2FA = async (e: React.FormEvent) => {
    e.preventDefault();
    setError("");
    const success = await auth?.verify2FA(code);
    if (success) {
      navigate("/dashboard");
    } else {
      setError("Código incorrecto. Inténtalo de nuevo.");
    }
  };

  return (
    <div className="login-container">
      {/* 📌 Sección Izquierda con Frase Motivacional */}
      <div className="login-left">
        <Typography variant="h4" className="typewriter-title">{displayText}</Typography>
        <Typography variant="body1"><em>{quote}</em></Typography>
      </div>

      {/* 📌 Sección Derecha con el Formulario */}
      <div className="login-right">
  <Box className="login-box">
    {/* 📌 Contenedor decorativo superior */}
    <div className="login-header">
      <Typography className="login-title">
        {step === 1 ? "Iniciar Sesion" : "Verificación 2FA 🔒"}
      </Typography>
      <Typography className="login-subtitle">
        {step === 1 ? "Ingresa tus credenciales para continuar." : "Introduce el código enviado a tu correo."}
      </Typography>
    </div>

    {error && <Typography className="login-error">{error}</Typography>}

    {/* 📌 Formulario */}
    <Box component="form" onSubmit={step === 1 ? handleLogin : handleVerify2FA} className="login-form">
      {step === 1 ? (
        <>
          <TextField
            label="Correo electrónico"
            variant="outlined"
            fullWidth
            className="login-input"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            sx={{ mb: 2 }} // Agrega margen inferior
          />
          <TextField
            label="Contraseña"
            type="password"
            variant="outlined"
            fullWidth
            className="login-input"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
            sx={{ mb: 2 }} // Agrega margen inferior
          />
          <Button type="submit" className="login-button">
            🚀 Iniciar sesión
          </Button>
        </>
      ) : (
        <>
          <TextField
            label="Código 2FA"
            variant="outlined"
            fullWidth
            className="login-input"
            value={code}
            onChange={(e) => setCode(e.target.value)}
            required
          />
          <Button type="submit" className="login-button">
            ✅ Verificar Código
          </Button>
        </>
      )}
    </Box>

    {/* 📌 Enlace de recuperación */}
    {/* <Typography className="login-footer">
      ¿Olvidaste tu contraseña? <a href="#">Recupérala aquí</a>
    </Typography> */}
  </Box>
</div>

    </div>
  );
};

export default Login;
