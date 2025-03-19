import { 
  Box, Text, Button, Image, Icon, SimpleGrid, Flex,
  Container
} from "@chakra-ui/react";
import { motion } from "framer-motion";
import { useNavigate } from "react-router-dom";
import { FaBook, FaUsers, FaChartLine, FaArrowRight } from "react-icons/fa";

const MotionBox = motion(Box);
const MotionButton = motion(Button);

const HomePage = () => {
  const navigate = useNavigate();

  return (
    <Box maxW="full" overflow="hidden">
      
      <Container maxW="container.lg" textAlign="center" py={20} bg="purple.200">

      

      {/* 📌 Texto y Botón */}
      <MotionBox
        initial={{ opacity: 0, y: 30 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1, delay: 0.5 }}
        mt={10}
        
      >
        <Text fontSize="6xl" fontWeight="bold" color="black" letterSpacing="tight">
          LitClub
        </Text>
        <Text fontSize="2xl" color="gray.600" mt={4} maxW="600px" mx="auto">
          Descubre la mejor experiencia de lectura digital. Explora miles de títulos, comparte libros y sumérgete en nuevas historias.
        </Text>
        <MotionButton
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
          mt={6}
          onClick={() => navigate("/register")}
        >
          Únete Ahora <Icon as={FaArrowRight} ml={2} />
        </MotionButton>
      </MotionBox>

    </Container>

      {/* 🌟 SECCIÓN DE BENEFICIOS */}
      <Box bg="white" py={20} px={{ base: 6, md: 12 }}>
        <Text fontSize="5xl" fontWeight="bold" textAlign="center">
          ¿Por qué elegir LitClub?
        </Text>

        <SimpleGrid columns={{ base: 1, md: 3 }} gap={10} mt={12} >
          {[
            { icon: FaBook, title: "Sube tus libros", desc: "Comparte con miles de lectores." },
            { icon: FaUsers, title: "Comunidad Exclusiva", desc: "Conéctate con otros apasionados." },
            { icon: FaChartLine, title: "Estadísticas de Lectura", desc: "Monitorea tu progreso." },
          ].map((item, index) => (
            <MotionBox
              key={index}
              p={6}
              bg="purple.200"
              borderRadius="xl"
              boxShadow="lg"
              textAlign="center"
              whileHover={{ scale: 1.05 }}
              whileTap={{ scale: 0.95 }}
            >
              <Icon as={item.icon} boxSize={10} color="black" mb={4} />
              <Text fontSize="xl" fontWeight="semibold">{item.title}</Text>
              <Text fontSize="md" color="gray.500" mt={2}>{item.desc}</Text>
            </MotionBox>
          ))}
        </SimpleGrid>
      </Box>

      {/* 🌟 SECCIÓN EXCLUSIVA */}
      <Flex 
        align="center" 
        justify="space-between"
        flexWrap="wrap"
        px={{ base: 6, md: 12 }} 
        py={20} 
        bg="black" 
        color="white"
      >
        {/* 📌 Imagen */}
        <MotionBox
          flex="1"
          display="flex"
          justifyContent="center"
          initial={{ opacity: 0, x: -50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 1, delay: 0.5 }}
        >
          <Image 
            src="https://images.unsplash.com/photo-1568667256549-094345857637" 
            alt="Persona leyendo"
            width="480px" 
            borderRadius="20px"
            shadow="xl"
          />
        </MotionBox>

        {/* 📌 Texto */}
        <MotionBox
          flex="1"
          textAlign="left"
          maxW="600px"
          initial={{ opacity: 0, x: 50 }}
          animate={{ opacity: 1, x: 0 }}
          transition={{ duration: 1 }}
        >
          <Text fontSize="5xl" fontWeight="bold">
            La Revolución de la Lectura
          </Text>
          <Text fontSize="2xl" mt={4} >
            Explora nuevas historias, descubre autores independientes y lleva tu lectura al siguiente nivel.
          </Text>
          <MotionButton
            mt={6}
            size="lg"
            bg="purple.200"
            color="black"
            px={8}
            py={6}
            borderRadius="full"
            fontSize="lg"
            _hover={{ bg: "gray.300" }}
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
            onClick={() => navigate("/books")}
          >
            Explorar Biblioteca
          </MotionButton>
        </MotionBox>
      </Flex>

      {/* 🌟 CTA FINAL */}
      <Box py={20} textAlign="center" bg="gray.100">
        <Text fontSize="5xl" fontWeight="bold">Únete a LitClub Ahora</Text>
        <Text fontSize="lg" mt={3}>
          La mejor plataforma para descubrir, leer y compartir libros digitales.
        </Text>
        <MotionButton
          mt={6}
          size="lg"
          bg="black"
          color="purple.200"
          px={8}
          py={6}
          borderRadius="full"
          fontSize="lg"
          _hover={{ bg: "gray.800" }}
          whileHover={{ scale: 1.05 }}
          whileTap={{ scale: 0.95 }}
          onClick={() => navigate("/register")}
        >
          Crear Cuenta Gratis <Icon as={FaArrowRight} ml={2} />
        </MotionButton>
      </Box>

    </Box>
  );
};

export default HomePage;
