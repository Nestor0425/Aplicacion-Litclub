// import { useContext, useState, useEffect } from "react";
// import { AuthContext } from "../context/AuthContext";
// import { useNavigate } from "react-router-dom";
// import { TextField, Button, Typography, Box } from "@mui/material";
// import "../styles/Login.css"; // ✅ Importar el CSS

// const motivationalQuotes = [
//   "La lectura es el gimnasio de la mente.",
//   "Cada libro que lees te acerca más a tu mejor versión.",
//   "Leer es plantar semillas de conocimiento en tu mente.",
//   "Una mente bien leída es una mente bien armada.",
//   "La lectura te lleva a lugares donde tus pies nunca han estado.",
// ];

// const Login = () => {
//   const auth = useContext(AuthContext);
//   const navigate = useNavigate();
//   const [email, setEmail] = useState("");
//   const [password, setPassword] = useState("");
//   const [error, setError] = useState(""); // Manejo de errores
//   const [quote, setQuote] = useState(""); // Frase motivacional
//   const [isLoading, setIsLoading] = useState(false); // Estado para controlar el spinner
//   const text = "Encuentra en la lectura tu mejor versión";
//   const [displayText, setDisplayText] = useState("");
//   const [index, setIndex] = useState(0);

//   useEffect(() => {
//     const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
//     setQuote(randomQuote);
//   }, []);

//   useEffect(() => {
//     if (index < text.length) {
//       const timeout = setTimeout(() => {
//         setDisplayText((prev) => prev + text[index]);
//         setIndex(index + 1);
//       }, 80); // Velocidad de escritura
//       return () => clearTimeout(timeout);
//     }
//   }, [index]);

//   const handleLogin = async (e: React.FormEvent) => {
//     e.preventDefault();
//     setError(""); // Limpiar mensajes de error previos
//     setIsLoading(true); // Activar el spinner
  
//     try {
//       const success = await auth?.login(email, password); // Intentar hacer login
//       setIsLoading(false); // Desactivar el spinner después de la validación
  
//       if (success) {
//         navigate("/dashboard"); // Redirigir al dashboard si el login es exitoso
//       } else {
//         setError("Credenciales incorrectas. Inténtalo de nuevo.");
//       }
//     // eslint-disable-next-line @typescript-eslint/no-unused-vars
//     } catch (error) {
//       setIsLoading(false); // Desactivar el spinner si ocurre un error inesperado
//       setError("Ocurrió un error. Intenta nuevamente.");
//     }
//   };
  

//   return (
//     <div className="login-container">
//       {/* 📌 Sección Izquierda con Frase Motivacional */}
//       <div className="login-left">
//         <Typography variant="h4" className="typewriter-title">{displayText}</Typography>
//         <Typography variant="body1"><em>{quote}</em></Typography>
//       </div>

//       {/* 📌 Sección Derecha con el Formulario */}
//       <div className="login-right">
//         <Box className="login-box">
//           {/* 📌 Contenedor decorativo superior */}
//           <div className="login-header">
//             <Typography className="login-title">
//               Iniciar Sesión
//             </Typography>
//             <Typography className="login-subtitle">
//               Ingresa tus credenciales para continuar.
//             </Typography>
//           </div>


//           {/* 📌 Formulario */}
//           <Box component="form" onSubmit={handleLogin} className="login-form">
//             <TextField
//               label="Correo electrónico"
//               variant="outlined"
//               fullWidth
//               className="login-input"
//               value={email}
//               onChange={(e) => setEmail(e.target.value)}
//               required
//               sx={{ mb: 2 }} // Agrega margen inferior
//             />
//             <TextField
//               label="Contraseña"
//               type="password"
//               variant="outlined"
//               fullWidth
//               className="login-input"
//               value={password}
//               onChange={(e) => setPassword(e.target.value)}
//               required
//               sx={{ mb: 2 }} // Agrega margen inferior
//             />
//             {/* <Button type="submit" className="login-button">
//               🚀 Iniciar sesión
//             </Button> */}
//             <Button type="submit" disabled={isLoading} className="login-button">
//   {isLoading ? 'Cargando...' : '🚀 Iniciar sesión'}
// </Button>

//           </Box>
//           {isLoading && (
//   <div className="spinner-container">
//     <div className="spinner"></div>
//   </div>
// )} {/* Mostrar el spinner mientras carga */}

// {error && <p className="error-message">{error}</p>} {/* Mostrar error si lo hay */}

// <Button type="submit" className="login-button" onClick={() => navigate("/register")}>
//   Registro
// </Button>
//         </Box>
//       </div>
//     </div>
//   );
// };

// export default Login;
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
  const [error, setError] = useState(""); // Manejo de errores
  const [quote, setQuote] = useState(""); // Frase motivacional
  const [isLoading, setIsLoading] = useState(false); // Estado de carga del botón
  const text = "Encuentra en la lectura tu mejor versión";
  const [displayText, setDisplayText] = useState("");
  const [index, setIndex] = useState(0);

  useEffect(() => {
    const storedQuote = sessionStorage.getItem("motivationalQuote");
    if (storedQuote) {
      setQuote(storedQuote);
    } else {
      const randomQuote = motivationalQuotes[Math.floor(Math.random() * motivationalQuotes.length)];
      setQuote(randomQuote);
      sessionStorage.setItem("motivationalQuote", randomQuote);
    }
  }, []);

  useEffect(() => {
    if (index < text.length) {
      const timeout = setTimeout(() => {
        setDisplayText((prev) => prev + text[index]);
        setIndex(index + 1);
      }, 80);
      return () => clearTimeout(timeout);
    }
  }, [index]);

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(""); // Limpiar errores previos
    if (!email.trim() || !password.trim()) {
      setError("⚠️ Todos los campos son obligatorios.");
      return;
    }

    setIsLoading(true); // Activar spinner

    try {
      const success = await auth?.login(email, password);
      setIsLoading(false);

      if (success) {
        navigate("/dashboard");
      } else {
        setError("❌ Credenciales incorrectas. Inténtalo de nuevo.");
      }
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    } catch (error) {
      setIsLoading(false);
      setError("❌ Ocurrió un error. Intenta nuevamente.");
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
            <Typography className="login-title">Iniciar Sesión</Typography>
            <Typography className="login-subtitle">Ingresa tus credenciales para continuar.</Typography>
          </div>

          {/* 📌 Formulario */}
          <Box component="form" onSubmit={handleLogin} className="login-form">
            <TextField
              label="Correo electrónico"
              variant="outlined"
              fullWidth
              className="login-input"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              required
              sx={{ mb: 2 }}
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
              sx={{ mb: 2 }}
            />

            <Button 
              type="submit" 
              disabled={isLoading} 
              className="login-button"
              aria-label="Iniciar sesión"
            >
              {isLoading ? "🔄 Cargando..." : "🚀 Iniciar sesión"}
            </Button>
          </Box>

          {/* 📌 Spinner de carga */}
          {isLoading && (
            <div className="spinner-container">
              <div className="spinner"></div>
            </div>
          )}

          {/* 📌 Mensaje de error */}
          {error && <Typography color="error" sx={{ mt: 2 }}>{error}</Typography>}

          {/* 📌 Botón de Registro */}
          <Button 
            className="login-button" 
            onClick={() => navigate("/register")}
            sx={{ marginTop: 2 }}
          >
            📝 Registrarse
          </Button>
        </Box>
      </div>
    </div>
  );
};

export default Login;
