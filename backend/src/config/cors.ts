import cors from "cors";

const corsOptions = {
  origin: ["https://aplicacion-lit-club-ka8t0c03r-alexisrdz1219s-projects.vercel.app"], // ✅ Cambia por el dominio de tu frontend en Vercel
  methods: ["GET", "POST", "PUT", "DELETE"],
  credentials: true, // ✅ Importante para cookies y headers de autorización
};

export default cors(corsOptions);
