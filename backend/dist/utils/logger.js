"use strict";
// import winston, { format, transports } from "winston";
// import TransportStream from "winston-transport";
// import { Pool } from "pg";
// import dotenv from "dotenv";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
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
const winston_1 = __importStar(require("winston"));
const winston_transport_1 = __importDefault(require("winston-transport"));
const pg_1 = require("pg");
const dotenv_1 = __importDefault(require("dotenv"));
dotenv_1.default.config();
// 📌 Verificar si la base de datos está configurada
const isDatabaseLoggingEnabled = !!process.env.DATABASE_URL;
// 📌 Configurar conexión a PostgreSQL si está habilitada
const pool = isDatabaseLoggingEnabled
    ? new pg_1.Pool({ connectionString: process.env.DATABASE_URL })
    : null;
// 📌 Transporte personalizado para guardar logs en PostgreSQL
class PostgresTransport extends winston_transport_1.default {
    constructor(opts) {
        super(opts);
    }
    async log(info, callback) {
        setImmediate(() => this.emit("logged", info));
        if (!pool) {
            console.warn("⚠ PostgreSQL logging está deshabilitado.");
            callback();
            return;
        }
        try {
            await pool.query("INSERT INTO logs (level, message, timestamp) VALUES ($1, $2, NOW())", [info.level, info.message]);
        }
        catch (error) {
            console.error("❌ Error guardando log en la base de datos:", error);
        }
        callback();
    }
}
// 📌 Configuración del Logger
const logger = winston_1.default.createLogger({
    level: "info",
    format: winston_1.format.combine(winston_1.format.timestamp(), winston_1.format.json()),
    transports: [
        new winston_1.transports.File({ filename: "logs/errors.log", level: "error" }),
        new winston_1.transports.File({ filename: "logs/combined.log" }),
        new winston_1.transports.Console(),
    ],
});
// 📌 Agregar transporte PostgreSQL solo si está habilitado
if (isDatabaseLoggingEnabled) {
    logger.add(new PostgresTransport());
}
exports.default = logger;
