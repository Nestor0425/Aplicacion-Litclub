import { Container, Box, Text, VStack, Input, Textarea, Button, HStack, Icon } from "@chakra-ui/react";
import { motion } from "framer-motion";
import { useState } from "react";
import { useNavigate } from "react-router-dom";
import { FaEnvelope, FaPhone, FaMapMarkerAlt, FaPaperPlane } from "react-icons/fa";

const MotionBox = motion(Box);
const MotionButton = motion(Button);

const ContactPage = () => {
  const navigate = useNavigate();
  const [form, setForm] = useState({ name: "", email: "", message: "" });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("📨 Enviando mensaje:", form);
    alert("Mensaje enviado con éxito!");
  };

  return (
    <Container maxW="container.lg" textAlign="center" py={20}>
      
      {/* 🌟 Encabezado */}
      <MotionBox initial={{ opacity: 0, y: -30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1 }}>
        <Text fontSize="6xl" fontWeight="bold" color="black">
          Contáctanos 📩
        </Text>
        <Text fontSize="2xl" color="gray.600" mt={4} maxW="600px" mx="auto">
          ¿Tienes preguntas o sugerencias? Escríbenos y te responderemos lo antes posible.
        </Text>
      </MotionBox>

      {/* 📌 Imagen Representativa */}
      <MotionBox initial={{ opacity: 0, y: 30 }} animate={{ opacity: 1, y: 0 }} transition={{ duration: 1, delay: 0.5 }} mt={10}>
        
      </MotionBox>

      {/* 📌 Formulario de Contacto */}
      <VStack as="form" mt={12} gap={6} maxW="600px" mx="auto" onSubmit={handleSubmit}>
        <Input
          placeholder="Tu Nombre"
          name="name"
          value={form.name}
          onChange={handleChange}
          size="lg"
          borderColor="blue.400"
          required
        />
        <Input
          placeholder="Tu Correo Electrónico"
          name="email"
          type="email"
          value={form.email}
          onChange={handleChange}
          size="lg"
          borderColor="blue.400"
          required
        />
        <Textarea
          placeholder="Escribe tu mensaje..."
          name="message"
          value={form.message}
          onChange={handleChange}
          size="lg"
          rows={5}
          borderColor="blue.400"
          required
        />
        <MotionButton
  type="submit"
  mt={4}
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
>
  <HStack gap={3}>
    <FaPaperPlane />
    <Text>Enviar Mensaje</Text>
  </HStack>
</MotionButton>


      </VStack>

      {/* 🏢 Información de Contacto */}
      <VStack mt={16} gap={6} align="center">
        <Text fontSize="4xl" fontWeight="bold">
          📍 Nuestra Ubicación
        </Text>
        <HStack gap={8}>
          <MotionBox
            p={6}
            bg="gray.100"
            borderRadius="xl"
            boxShadow="lg"
            textAlign="center"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <Icon as={FaMapMarkerAlt} boxSize={10} color="black" />
            <Text fontSize="xl" fontWeight="semibold" mt={2}>
              Montemorelos
            </Text>
            <Text fontSize="md" color="gray.600">
              Universidad Tecnologica de Santa Catarina
            </Text>
          </MotionBox>

          <MotionBox
            p={6}
            bg="gray.100"
            borderRadius="xl"
            boxShadow="lg"
            textAlign="center"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <Icon as={FaPhone} boxSize={10} color="black" />
            <Text fontSize="xl" fontWeight="semibold" mt={2}>
              Teléfono
            </Text>
            <Text fontSize="md" color="gray.600">
              911
            </Text>
          </MotionBox>

          <MotionBox
            p={6}
            bg="gray.100"
            borderRadius="xl"
            boxShadow="lg"
            textAlign="center"
            whileHover={{ scale: 1.05 }}
            whileTap={{ scale: 0.95 }}
          >
            <Icon as={FaEnvelope} boxSize={10} color="black" />
            <Text fontSize="xl" fontWeight="semibold" mt={2}>
              Correo Electrónico
            </Text>
            <Text fontSize="md" color="gray.600">
              contacto@litclub.com
            </Text>
          </MotionBox>
        </HStack>
      </VStack>

      {/* 📌 CTA Final */}
      <Box mt={16}>
        <Text fontSize="2xl" fontWeight="bold" color="black">
          También puedes seguirnos en nuestras redes sociales 📲
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
          onClick={() => navigate("/")}
        >
          🌍 Volver al Inicio
        </MotionButton>
      </Box>

    </Container>
  );
};

export default ContactPage;
