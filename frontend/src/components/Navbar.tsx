import { Link } from "react-router-dom";

const Navbar = () => {
  return (
    <nav>
      <ul>
        <li><Link to="/dashboard">📊 Dashboard</Link></li>
        <li><Link to="/logs">📜 Logs</Link></li>
      </ul>
    </nav>
  );
};

export default Navbar;
