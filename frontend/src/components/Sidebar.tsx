import { Link } from "react-router-dom";
import { useContext } from "react";
import { AuthContext } from "../context/AuthContext";

const Sidebar = () => {
  const { user } = useContext(AuthContext) || { user: null };

  return (
    <nav>
      <ul>
        <li><Link to="/dashboard">Dashboard</Link></li>
        {user?.rol === "admin" && <li><Link to="/logs">📜 Ver Logs</Link></li>}
      </ul>
    </nav>
  );
};

export default Sidebar;
