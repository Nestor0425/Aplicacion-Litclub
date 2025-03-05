"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.getSensitiveData = exports.saveSensitiveData = exports.findUserByEmail = exports.createUser = void 0;
const db_1 = __importDefault(require("../config/db"));
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const encryption_1 = require("../utils/encryption");
const createUser = async (user) => {
    const hashedPassword = await bcryptjs_1.default.hash(user.password, 12);
    const result = await db_1.default.query("INSERT INTO users (nombre, email, rol, password) VALUES ($1, $2, $3, $4) RETURNING *", [user.nombre, user.email, user.rol, hashedPassword]);
    return result.rows[0];
};
exports.createUser = createUser;
// Ya esta protegida ante una inyeccion
const findUserByEmail = async (email) => {
    const result = await db_1.default.query("SELECT * FROM users WHERE email = $1", [email]);
    return result.rows[0];
};
exports.findUserByEmail = findUserByEmail;
// 🔐 Guardar datos encriptados en la BD
const saveSensitiveData = async (userId, sensitiveInfo) => {
    const encryptedInfo = (0, encryption_1.encryptData)(sensitiveInfo);
    await db_1.default.query("UPDATE users SET sensitive_info = $1 WHERE id = $2", [encryptedInfo, userId]);
};
exports.saveSensitiveData = saveSensitiveData;
// 🔓 Leer y desencriptar datos de la BD
const getSensitiveData = async (userId) => {
    const result = await db_1.default.query("SELECT sensitive_info FROM users WHERE id = $1", [userId]);
    if (result.rows.length === 0)
        return null;
    return (0, encryption_1.decryptData)(result.rows[0].sensitive_info);
};
exports.getSensitiveData = getSensitiveData;
