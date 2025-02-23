const axios = require("axios");

const testLogin = async () => {
  for (let i = 1; i <= 6; i++) {
    try {
      const response = await axios.post("http://localhost:5001/auth/login", {
        email: "usuario_invalido@example.com",
        password: "contraseña_incorrecta",
      });
      console.log(`Intento ${i}:`, response.data);
    } catch (error) {
      console.error(`Intento ${i}:`, error.response.data);
    }
  }
};

testLogin();
