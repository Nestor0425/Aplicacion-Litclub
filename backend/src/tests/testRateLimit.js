// const axios = require("axios");

// const testLogin = async () => {
//   for (let i = 1; i <= 6; i++) {
//     try {
//       const response = await axios.post("http://localhost:5001/auth/login", {
//         email: "usuario_invalido@example.com",
//         password: "contraseña_incorrecta",
//       });
//       console.log(`Intento ${i}:`, response.data);
//     } catch (error) {
//       console.error(`Intento ${i}:`, error.response.data);
//     }
//   }
// };

// testLogin();
const axios = require("axios");
require("dotenv").config();

// 🔹 Configuración de la URL del backend
const BASE_URL = process.env.API_URL || "http://localhost:5001"; // Usa variable de entorno o localhost

const testLogin = async () => {
  console.log(`🔍 Iniciando pruebas de rate limit en: ${BASE_URL}/auth/login\n`);

  for (let i = 1; i <= 6; i++) {
    try {
      const response = await axios.post(`${BASE_URL}/auth/login`, {
        email: "usuario_invalido@example.com",
        password: "contraseña_incorrecta",
      });

      console.log(`✅ Intento ${i}:`, response.data);
    } catch (error) {
      if (error.response) {
        console.error(`⛔ Intento ${i}:`, error.response.data);
      } else {
        console.error(`⚠ Error en intento ${i}: No se pudo conectar al servidor.`);
      }
    }

    // ⏳ Esperar 1 segundo entre intentos para simular tráfico real
    await new Promise((resolve) => setTimeout(resolve, 1000));
  }

  console.log("\n🛑 Pruebas finalizadas. Verifica si el rate limit bloqueó los intentos correctamente.");
};

testLogin();
