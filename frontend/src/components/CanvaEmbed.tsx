// import logo from "../assets/logo.png";
// import ini from "../assets/inicio.jpg";

// const CanvaEmbed = () => {
//   return (
//     <div className="">
//       {/* Encabezado */}
//       <header className="encabezado">
//         <h1 className="">LITCLUB</h1>
//         <div className="logo">
//            <img src={logo} alt="Astronauta leyendo"  /> 
//         </div>
//       </header>
      
//       {/* Contenido principal */}
//       <div className="container">
//   {/* Imagen */}
//   <div className="image">
//     <img src={ini} alt="Libros y jarrón" className="w-full rounded-lg shadow-lg" />
//   </div>
  
//   {/* Texto */}
//   <div className="text">
//     <h1 className="title">
//       Encuentra en la lectura tu mejor versión
//     </h1>
//     <p className="description">
//       La lectura te lleva a lugares donde tus pies nunca han estado.
//     </p>
//     <button className="btn">
//       CONOCER MÁS
//     </button>
//   </div>
// </div>

//     </div>
//   );
// };

// export default CanvaEmbed;

const CanvaEmbed = () => {
  return (
    <div className="flex flex-col items-center">
      {/* Encabezado */}
      <header className="encabezado flex items-center justify-between w-full px-6 py-4 bg-gray-900 text-white">
        <h1 className="text-3xl font-bold">LITCLUB</h1>
        <div className="logo">
          <img src="/logo.png" alt="Astronauta leyendo" className="h-16 w-auto" /> 
        </div>
      </header>
      
      {/* Contenido principal */}
      <div className="container flex flex-col md:flex-row items-center justify-center gap-6 p-6">
        {/* Imagen */}
        <div className="image">
          <img src="/inicio.jpg" alt="Libros y jarrón" className="w-full rounded-lg shadow-lg" />
        </div>
        
        {/* Texto */}
        <div className="text text-center md:text-left">
          <h1 className="text-3xl font-bold mb-4">
            Encuentra en la lectura tu mejor versión
          </h1>
          <p className="text-lg text-gray-600 mb-4">
            La lectura te lleva a lugares donde tus pies nunca han estado.
          </p>
          <button className="btn bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700 transition-all">
            CONOCER MÁS
          </button>
        </div>
      </div>
    </div>
  );
};

export default CanvaEmbed;
