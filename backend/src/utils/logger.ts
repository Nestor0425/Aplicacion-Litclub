// import winston, { format, transports } from "winston";
// import TransportStream from "winston-transport";
// import { Pool } from "pg";
// import dotenv from "dotenv";

// dotenv.config();

// // 📌 Configurar conexión a PostgreSQL
// const pool = new Pool({
//   connectionString: process.env.DATABASE_URL,
// });

// // 📌 Transporte personalizado para guardar logs en PostgreSQL
// class PostgresTransport extends TransportStream {
//   constructor(opts?: TransportStream.TransportStreamOptions) {
//     super(opts);
//   }

//   async log(info: any, callback: () => void) {
//     setImmediate(() => this.emit("logged", info));

//     try {
//       await pool.query("INSERT INTO logs (level, message, timestamp) VALUES ($1, $2, NOW())", [
//         info.level,
//         info.message,
//       ]);
//     } catch (error) {
//       console.error("❌ Error guardando log en la base de datos:", error);
//     }

//     callback();
//   }
// }

// // 📌 Configuración del Logger
// const logger = winston.createLogger({
//   level: "info",
//   format: format.combine(
//     format.timestamp(),
//     format.json()
//   ),
//   transports: [
//     new transports.File({ filename: "logs/errors.log", level: "error" }),
//     new transports.File({ filename: "logs/combined.log" }),
//     new transports.Console(),
//     new PostgresTransport(), // ✅ Agregar el transporte personalizado para PostgreSQL
//   ],
// });

// export default logger;

import winston, { format, transports } from "winston";
import TransportStream from "winston-transport";
import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

// 📌 Verificar si la base de datos está configurada
const isDatabaseLoggingEnabled = !!process.env.DATABASE_URL;

// 📌 Configurar conexión a PostgreSQL si está habilitada
const pool = isDatabaseLoggingEnabled
  ? new Pool({ connectionString: process.env.DATABASE_URL })
  : null;

// 📌 Transporte personalizado para guardar logs en PostgreSQL
class PostgresTransport extends TransportStream {
  constructor(opts?: TransportStream.TransportStreamOptions) {
    super(opts);
  }

  async log(info: any, callback: () => void) {
    setImmediate(() => this.emit("logged", info));

    if (!pool) {
      console.warn("⚠ PostgreSQL logging está deshabilitado.");
      callback();
      return;
    }

    try {
      await pool.query(
        "INSERT INTO logs (level, message, timestamp) VALUES ($1, $2, NOW())",
        [info.level, info.message]
      );
    } catch (error) {
      console.error("❌ Error guardando log en la base de datos:", error);
    }

    callback();
  }
}

// 📌 Configuración del Logger
const logger = winston.createLogger({
  level: "info",
  format: format.combine(format.timestamp(), format.json()),
  transports: [
    new transports.File({ filename: "logs/errors.log", level: "error" }),
    new transports.File({ filename: "logs/combined.log" }),
    new transports.Console(),
  ],
});

// 📌 Agregar transporte PostgreSQL solo si está habilitado
if (isDatabaseLoggingEnabled) {
  logger.add(new PostgresTransport());
}

export default logger;
