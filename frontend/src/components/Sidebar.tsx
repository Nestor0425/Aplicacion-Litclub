// import { Link } from "react-router-dom";
// import { useContext } from "react";
// import { AuthContext } from "../context/AuthContext";

// const Sidebar = () => {
//   const { user } = useContext(AuthContext) || { user: null };

//   return (
//     <nav>
//       <ul>
//         <li><Link to="/dashboard">Dashboard</Link></li>
//         {user?.rol === "admin" && <li><Link to="/logs">📜 Ver Logs</Link></li>}
//       </ul>
//     </nav>
//   );
// };

// export default Sidebar;
import { Link } from "react-router-dom";
import { useContext } from "react";
import { AuthContext } from "../context/AuthContext";

const Sidebar = () => {
  const authContext = useContext(AuthContext);

  if (!authContext || !authContext.user) {
    return null; // ✅ Si no hay usuario, no renderizar el Sidebar
  }

  const { user } = authContext;

  return (
    <nav className="sidebar" aria-label="Menú lateral">
      <ul className="sidebar-menu">
        <li>
          <Link to="/dashboard" className="sidebar-link">📊 Dashboard</Link>
        </li>
        {user.rol === "admin" && (
          <li>
            <Link to="/logs" className="sidebar-link">📜 Ver Logs</Link>
          </li>
        )}
      </ul>
    </nav>
  );
};

export default Sidebar;
