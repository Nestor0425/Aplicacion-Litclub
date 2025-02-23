// import { useContext, useState } from "react";
// import { AuthContext } from "../context/AuthContext";
// import { useNavigate } from "react-router-dom";

// const Login = () => {
//   const auth = useContext(AuthContext);
//   const navigate = useNavigate();
//   const [email, setEmail] = useState("");
//   const [password, setPassword] = useState("");

//   const handleSubmit = async (e: React.FormEvent) => {
//     e.preventDefault();
//     const success = await auth?.login(email, password);
//     if (success) {
//       navigate("/dashboard");
//     } else {
//       alert("Error en el inicio de sesión");
//     }
//   };

//   return (
//     <div>
//       <h2>Iniciar Sesión</h2>
//       <form onSubmit={handleSubmit}>
//         <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Correo electrónico" />
//         <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Contraseña" />
//         <button type="submit">Iniciar sesión</button>
//       </form>
//     </div>
//   );
// };

// export default Login;

import { useContext, useState } from "react";
import { AuthContext } from "../context/AuthContext";
import { useNavigate } from "react-router-dom";

const Login = () => {
  const auth = useContext(AuthContext);
  const navigate = useNavigate();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [code, setCode] = useState(""); // Código 2FA
  const [step, setStep] = useState(1); // Control de paso: 1 = Login, 2 = 2FA

  const handleLogin = async (e: React.FormEvent) => {
    e.preventDefault();
    const success = await auth?.login(email, password);
    if (success) {
      navigate("/dashboard");
    } else {
      alert("Se requiere autenticación de dos factores. Ingresa el código que recibiste.");
      setStep(2); // Pasar a la verificación 2FA
    }
  };

  const handleVerify2FA = async (e: React.FormEvent) => {
    e.preventDefault();
    const success = await auth?.verify2FA(code);
    if (success) {
      navigate("/dashboard");
    } else {
      alert("Código incorrecto. Inténtalo de nuevo.");
    }
  };

  return (
    <div>
      {step === 1 ? (
        <>
          <h2>Iniciar Sesión</h2>
          <form onSubmit={handleLogin}>
            <input type="email" value={email} onChange={(e) => setEmail(e.target.value)} placeholder="Correo electrónico" required />
            <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Contraseña" required />
            <button type="submit">Iniciar sesión</button>
          </form>
        </>
      ) : (
        <>
          <h2>Verificación 2FA</h2>
          <form onSubmit={handleVerify2FA}>
            <input type="text" value={code} onChange={(e) => setCode(e.target.value)} placeholder="Código 2FA" required />
            <button type="submit">Verificar Código</button>
          </form>
        </>
      )}
    </div>
  );
};

export default Login;
