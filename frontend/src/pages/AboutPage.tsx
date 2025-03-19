import { Container, Box, Text, VStack, Image, Button, Icon, Flex } from "@chakra-ui/react";
import { motion } from "framer-motion";
import { useNavigate } from "react-router-dom";
import { FaBullseye, FaEye, FaHeart } from "react-icons/fa"; // ✅ Iconos representativos

const MotionBox = motion(Box);
const MotionButton = motion(Button);

const missionVisionValues = [
  {
    icon: FaBullseye,
    title: "Nuestra Misión",
    description:
      "Crear una plataforma intuitiva y accesible para fomentar la lectura digital y conectar a los lectores con historias increíbles.",
  },
  {
    icon: FaEye,
    title: "Nuestra Visión",
    description:
      "Ser la biblioteca digital de referencia, ofreciendo una experiencia de usuario fluida y elegante para todos.",
  },
  {
    icon: FaHeart,
    title: "Nuestros Valores",
    description: "Accesibilidad, Innovación, Comunidad y Pasión por la lectura.",
  },
];

const AboutPage = () => {
  const navigate = useNavigate();

  return (
    <Container maxW="container.lg" textAlign="center" py={20}>
      {/* 🌟 Encabezado */}
      <MotionBox initial={{ opacity: 0, y: -30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1 }}>
        <Text fontSize="6xl" fontWeight="bold" color="black">
          Sobre <span style={{ color: "#2b87a9" }}>LitClub</span>
        </Text>
        <Text fontSize="2xl" color="gray.600" mt={4} maxW="600px" mx="auto">
          Una biblioteca digital moderna creada para los amantes de la lectura. 📚✨
        </Text>
      </MotionBox>

      {/* 📌 Imagen Representativa */}
      <MotionBox
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1, delay: 0.5 }}
        display="flex"
        justifyContent="center"
        mt={10}
      >
        <Image
          src="https://images.unsplash.com/photo-1524995997946-a1c2e315a42f"
          alt="Biblioteca digital elegante"
          width="600px"
          borderRadius="20px"
          shadow="xl"
        />
      </MotionBox>

      {/* 📝 Descripción del Proyecto */}
      <VStack gap={6} mt={12} maxW="800px" mx="auto" textAlign="left">
        <Text fontSize="xl" color="gray.700">
          LitClub nació con la visión de ofrecer una experiencia de lectura digital única, accesible y moderna.
          Buscamos conectar a lectores de todo el mundo, brindando un espacio donde puedan compartir, descubrir y
          disfrutar de miles de títulos con facilidad.
        </Text>
        <Text fontSize="xl" color="gray.700">
          Creemos que la lectura es una puerta al conocimiento y la imaginación, y queremos hacerla más accesible para
          todos.
        </Text>
      </VStack>

      {/* 🚀 Misión, Visión y Valores */}
      <VStack mt={16} gap={10} align="center">
        {missionVisionValues.map((item, index) => (
          <Flex
            key={index}
            align="center"
            justify="center"
            flexDirection={index % 2 === 0 ? "row" : "row-reverse"} // Alternar lado
            gap={10}
            maxW="800px"
            w="full"
          >
            {/* Ícono grande a la izquierda/derecha */}
            <MotionBox
              bg="gray.100"
              borderRadius="full"
              p={6}
              boxShadow="lg"
              whileHover={{ scale: 1.1 }}
              whileTap={{ scale: 0.95 }}
            >
              <Icon as={item.icon} boxSize={14} color="#2b87a9" />
            </MotionBox>

            {/* Texto al lado del icono */}
            <MotionBox
              p={6}
              bg="gray.50"
              borderRadius="xl"
              boxShadow="lg"
              maxW="500px"
              textAlign="left"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Text fontSize="2xl" fontWeight="bold" color="#2b87a9">
                {item.title}
              </Text>
              <Text fontSize="md" color="gray.600" mt={2}>
                {item.description}
              </Text>
            </MotionBox>
          </Flex>
        ))}
      </VStack>

      {/* 📌 CTA Final */}
      <Box mt={16}>
        <Text fontSize="2xl" fontWeight="bold" color="black">
          ¿Listo para unirte a la comunidad?
        </Text>
        <MotionButton
          mt={6}
          size="lg"
          bg="black"
          color="white"
          px={8}
          py={6}
          borderRadius="full"
          fontSize="lg"
          _hover={{ bg: "gray.800" }}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          onClick={() => navigate("/register")}
        >
          🌍 Explorar LitClub
        </MotionButton>
      </Box>
    </Container>
  );
};

export default AboutPage;
