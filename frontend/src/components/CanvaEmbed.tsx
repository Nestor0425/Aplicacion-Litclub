import logo from "../assets/logo.png";
import ini from "../assets/inicio.jpg";

const CanvaEmbed = () => {
  return (
    <div className="">
      {/* Encabezado */}
      <header className="encabezado">
        <h1 className="">LITCLUB</h1>
        <div className="logo">
           <img src={logo} alt="Astronauta leyendo"  /> 
        </div>
      </header>
      
      {/* Contenido principal */}
      <div className="container">
  {/* Imagen */}
  <div className="image">
    <img src={ini} alt="Libros y jarrón" className="w-full rounded-lg shadow-lg" />
  </div>
  
  {/* Texto */}
  <div className="text">
    <h1 className="title">
      Encuentra en la lectura tu mejor versión
    </h1>
    <p className="description">
      La lectura te lleva a lugares donde tus pies nunca han estado.
    </p>
    <button className="btn">
      CONOCER MÁS
    </button>
  </div>
</div>

    </div>
  );
};

export default CanvaEmbed;
