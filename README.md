# 📚 Aplicacion-LitClub

**LitClub** es un sistema de gestión de biblioteca que permite a los usuarios registrar, editar y administrar libros de forma sencilla.  
Incluye carga de libros mediante archivos CSV, edición, y autenticación de usuarios.

---

## 🚀 Características principales

- 🔑 **Autenticación de usuarios** (registro e inicio de sesión)
- 📂 **Dashboard** con acceso a las principales funciones
- ➕ **Agregar nuevos libros** mediante formulario
- 📝 **Editar y eliminar libros existentes**
- 📤 **Subir libros masivamente** desde un archivo CSV
- 🔒 **Cerrar sesión de manera segura**

---

## 🛠️ Instalación y configuración

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/Nestor0425/Aplicacion-Litclub.git
cd Aplicacion-Litclub

2.Instalar dependencias
npm install

3. Configurar variables de entorno
DATABASE_URL=postgresql://usuario:password@localhost:5432/litclub
JWT_SECRET=tu_clave_secreta

4.Iniciar el servidor
npm run dev

☁️ Despliegue
🔹 Vercel

Regístrate en Vercel
 con GitHub.

Importa el repositorio desde la opción New Project.

Configura:

Framework: React / Next.js (según corresponda)

Build Command: npm run build

Output Directory: build o .next

Añade variables de entorno en Settings > Environment Variables.

Vercel hará despliegues automáticos en cada push a main.

🔹 Render

Regístrate en Render
.

En el Dashboard, crea un New Web Service y selecciona el repo.

Configura:

Runtime: Node.js

Build Command: npm run build

Start Command: npm start

Root Directory: backend/ si aplica

Añade variables de entorno en Settings > Environment Variables.

Render desplegará automáticamente los cambios en main.

⚠️ Manejo y Gestión de Errores
Backend (Node.js + Express + PostgreSQL)

Middleware global de manejo de errores.

Uso de try...catch en funciones clave (login, getAuthenticatedUser, addBook, updateBook, etc.).

Respuestas JSON estructuradas con código de estado y mensaje.

Validación de autorización antes de consultas críticas.

Frontend (React + Axios)

Manejo de errores con catch.

Estado setError para mostrar errores claros en la UI.

Redirección a login si el usuario no está autenticado.

Páginas de error 404 y 500 personalizadas.

🧑‍💻 Manual de Usuario
🔑 Inicio de sesión

Dirígete a la página principal.

Ingresa correo y contraseña.

Si no tienes cuenta, regístrate primero.

Ejemplo admin:

📧 prueba4@gmail.com

🔑 Preuba1-

📝 Registro de usuario

Completa nombre, correo y contraseña.

Haz clic en Registrarse.

📂 Dashboard

Subir libros desde CSV.

Editar libros existentes.

Cerrar sesión.

➕ Agregar un nuevo libro

Completa los campos: título, autor, descripción, año, género, URL de portada y PDF.

Haz clic en Agregar Libro.

✏️ Editar libros

Selecciona el libro en el dashboard.

Modifica y guarda, o elimina el libro.

📤 Subir libros desde un archivo CSV

Selecciona el archivo CSV.

Haz clic en Subir CSV.

🔒 Cerrar sesión

Haz clic en Cerrar Sesión en el dashboard.

✅ Pruebas

Se realizaron pruebas de autenticación, manejo de errores y subida de libros.

Validación de seguridad siguiendo prácticas OWASP.
