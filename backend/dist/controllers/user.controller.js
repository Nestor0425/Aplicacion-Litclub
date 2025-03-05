"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.register = void 0;
const user_service_1 = require("../services/user.service");
const register = async (req, res) => {
    const user = await (0, user_service_1.createUser)(req.body);
    res.status(201).json(user);
};
exports.register = register;
