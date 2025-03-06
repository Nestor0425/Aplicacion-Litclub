--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Homebrew)
-- Dumped by pg_dump version 17.2 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: books; Type: TABLE; Schema: public; Owner: alexisrodriguez
--

CREATE TABLE public.books (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    genre character varying(100),
    description text,
    cover_image_url text,
    published_year integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    available boolean DEFAULT true,
    file_url character varying(255),
    available_file_url text
);


ALTER TABLE public.books OWNER TO alexisrodriguez;

--
-- Name: books_id_seq; Type: SEQUENCE; Schema: public; Owner: alexisrodriguez
--

CREATE SEQUENCE public.books_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.books_id_seq OWNER TO alexisrodriguez;

--
-- Name: books_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexisrodriguez
--

ALTER SEQUENCE public.books_id_seq OWNED BY public.books.id;


--
-- Name: loans; Type: TABLE; Schema: public; Owner: alexisrodriguez
--

CREATE TABLE public.loans (
    id integer NOT NULL,
    user_id integer,
    book_id integer,
    loan_date timestamp without time zone DEFAULT now(),
    return_date timestamp without time zone,
    due_date timestamp without time zone NOT NULL,
    returned boolean DEFAULT false,
    borrowed_at timestamp without time zone DEFAULT now(),
    returned_at timestamp without time zone
);


ALTER TABLE public.loans OWNER TO alexisrodriguez;

--
-- Name: loans_id_seq; Type: SEQUENCE; Schema: public; Owner: alexisrodriguez
--

CREATE SEQUENCE public.loans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.loans_id_seq OWNER TO alexisrodriguez;

--
-- Name: loans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexisrodriguez
--

ALTER SEQUENCE public.loans_id_seq OWNED BY public.loans.id;


--
-- Name: logs; Type: TABLE; Schema: public; Owner: alexisrodriguez
--

CREATE TABLE public.logs (
    id integer NOT NULL,
    level character varying(10),
    message text,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.logs OWNER TO alexisrodriguez;

--
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: alexisrodriguez
--

CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.logs_id_seq OWNER TO alexisrodriguez;

--
-- Name: logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexisrodriguez
--

ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: alexisrodriguez
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(255) NOT NULL,
    rol character varying(20) DEFAULT 'usuario'::character varying
);


ALTER TABLE public.users OWNER TO alexisrodriguez;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: alexisrodriguez
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO alexisrodriguez;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: alexisrodriguez
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: books id; Type: DEFAULT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.books ALTER COLUMN id SET DEFAULT nextval('public.books_id_seq'::regclass);


--
-- Name: loans id; Type: DEFAULT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.loans ALTER COLUMN id SET DEFAULT nextval('public.loans_id_seq'::regclass);


--
-- Name: logs id; Type: DEFAULT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: books; Type: TABLE DATA; Schema: public; Owner: alexisrodriguez
--

COPY public.books (id, title, author, genre, description, cover_image_url, published_year, created_at, available, file_url, available_file_url) FROM stdin;
564	Hamlet	William Shakespeare	Ficción	La obra se centra en el príncipe Hamlet de Dinamarca, quien lleva a cabo una venganza contra su tío Claudio, quien asesinó a su padre y usurpó el trono.56 La obra explora temas como la venganza, la locura, el incesto y la corrupción moral.	https://imgs.search.brave.com/4juIe_ioungmNnaXwWi2JSedYBib9kUXb7rc-22_m_w/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9vY2Vh/bm8ubXgvaW1nL29i/cmEvbWVkaWEvMTk5/MDMuanBn	1601	2025-03-01 21:01:19.355536	t	\N	/uploads/hamlet.pdf
565	Los juegos del hambre	Suzanne Collins	Ficción	La historia sigue a la protagonista Katniss Everdeen, quien se presenta voluntaria para participar en los Juegos del Hambre, un combate a muerte televisado en el que dos representantes de cada uno de los 12 distritos deben luchar hasta que quede un solo sobreviviente	https://imgs.search.brave.com/EW4VZxcwzlCAhtLlsBYrX1GJd05of4iLhUZsx0ymA9M/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMtbmEuc3NsLWlt/YWdlcy1hbWF6b24u/Y29tL2ltYWdlcy9J/LzcxZTRrakNzdUFM/LmpwZw	1949	2025-03-01 21:01:19.355536	t	\N	/uploads/losjuegosdelhambre.pdf
566	It	Stephen King	Terror	La historia gira en torno a un grupo de siete amigos que investigan y enfrentan a una entidad sobrenatural que se alimenta del terror que produce en sus víctimas, principalmente niños, en la ficticia ciudad de Derry, Maine.	https://imgs.search.brave.com/aDxXePa0AK1fGyiXzYfgBCj2f8zcV4gI-WZ1FDRwa2E/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL00v/TVY1Qk16UXlNREUz/TVRrdE1HWTJOUzAw/TnpsaUxXSXdNMll0/TVRsaU1UQXhNV1Ux/TnpsbFhrRXlYa0Zx/Y0djQC5qcGc	1986	2025-03-01 21:01:19.355536	t	\N	/uploads/it.pdf
567	El código Da Vinci	Dan Brown	Novela	La historia sigue a Robert Langdon, un experto en simbología, quien recibe una llamada en medio de la noche informándole sobre el asesinato del conservador del museo del Louvre y un mensaje cifrado junto al cuerpo. Langdon descubre que las pistas conducen a las obras de Leonardo Da Vinci y que están a la vista de todos, ocultas por el ingenio del pintor. Langdon se une a la criptóloga francesa Sophie Neveu y descubren que el conservador del museo pertenecía al Priorato de Sión, una sociedad que ha velado por mantener en secreto una sorprendente verdad histórica.	https://imgs.search.brave.com/A_qfz1Gn7hQ5f_GU69Cskf-eDjauJC0NWKPNKmw0VzY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly91cGxv/YWQud2lraW1lZGlh/Lm9yZy93aWtpcGVk/aWEvY29tbW9ucy8y/LzIyL0RhX1ZpbmNp/X1ZpdHJ1dmVfTHVj/X1ZpYXRvdXIuanBn	2003	2025-03-01 21:01:19.355536	t	\N	/uploads/cienañosdesoledad.pdf
568	El señor de los anillos	J. R. R. Tolkien	Fantasia	un hobbit de la Comarca, para destruir el Anillo Único y evitar que Sauron, el señor oscuro, lo use para dominar la Tierra Media.	https://imgs.search.brave.com/4xsj4iJ6P5jsfYNqkIM57w2AGdav6xaCQl7nFEPFhXM/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pMC53/cC5jb20vZ2xvcmlh/ZGVnb25kb3IuY29t/L3dwLWNvbnRlbnQv/dXBsb2Fkcy8yMDI0/LzAxLzkxQ1pPTlRG/TmdMLl9TTDE1MDBf/LmpwZz9yZXNpemU9/NjgwLDEwMjQmc3Ns/PTE	1937	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
569	 Orgullo y prejuicio	Jane Austen	Novela	La historia narra cómo Elizabeth Bennet y Fitzwilliam Darcy se enfrentan a sus prejuicios movidos por el amor que surge entre ellos	https://imgs.search.brave.com/GO9l0Dn2pHAMcm_oSec-a2obEVNJLemuXBBL7RRJ1jU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/YWxiYWVkaXRvcmlh/bC5lcy93cC1jb250/ZW50L3VwbG9hZHMv/MjAyMC8xMC85Nzg4/NDg0Mjg0ODg4LW9y/Z3VsbG8teS1wcmVq/dWljaW8tYWxiYS1l/ZGl0b3JpYWwuanBn	1813	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
570	 Matar a un ruiseño	Harper Lee	Humor	La novela explora temas polémicos como la violación sexual y la desigualdad racial, pero también se destaca por su calidez y humor.	https://imgs.search.brave.com/wYxwlIR9u9NLNF06tlsSzyzCzObtBZmDThLq-vUb-nM/rs:fit:500:0:0:0/g:ce/aHR0cHM6Ly90cmFi/YWxpYnJvcy5jb20v/cnMvMTQ5NTMvNDg4/NmQ1MjMtMTk3Ny00/ZmExLWFiMjQtZGYx/YjYwOWM4OTdjLzU2/YS9maWxlbmFtZS9t/YXRhci1hLXVuLXJ1/aXNlbm9yLWhhcnBl/ci1sZWUtdHJhYmFs/aWJyb3MuanBn	1930	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
571	Rayuela	Julio Cortázar	Novela	Un alma dada, primero, por su autor que la escribió enamorado de su historia, de la literatura y del juego y, segundo.	https://imgs.search.brave.com/koP0yZE-33kd2bF0Zbc-VxoCOA2vSVXRXy3SbDg0EcA/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9lcy5i/YWJlbGlvLmNvbS9j/b3V2L0NWVF9SYXl1/ZWxhXzQ4LmpwZw	1963	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
572	Los miserables 	Victor Hugo	Novela	La historia se desarrolla en el período de la restauración de la monarquía en Francia y aborda temas como el bien y el mal, la política, la ley, la ética y la religión	https://imgs.search.brave.com/qW-r-HoT-IW_UDLgvgz7PcUhS_uGUmJyZaCzetty2uU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/ZWxlamFuZHJpYS5j/b20vY292ZXJzL0xv/c19NaXNlcmFibGVz/LUh1Z29fVmljdG9y/LW1kLnBuZw	1862	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
573	Fahrenheit 451	Ray Bradbury	Novela	La obra presenta una sociedad futurista donde los libros están prohibidos y los bomberos se encargan de quemarlos junto con las casas de sus dueños.	https://imgs.search.brave.com/K9XaCNAumS6OIeKcfNeeS4LQMwPLHWdZteHPj4bvAls/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9xdWVs/aWJyb2xlby5jb20v/aW1hZ2VzL2xpYnJv/cy9saWJyby0xNTk2/MDIyMDc5LmpwZw	1953	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
574	La gran nevada	Joan Carreras	Novela	Esta novela se centra en un protagonista que se da cuenta de que su vida estable ha caído en un abismo angustiante en solo seis meses, desde el solsticio de verano hasta el de invierno.	https://imgs.search.brave.com/aKRMsWCJt5OkMbI6h62q_193EEkNuDweCoGfwanTeI4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZS5jZG4xLmJ1c2Nh/bGlicmUuY29tLzYw/ZTM5NTg5ODQ2M2I1/ZjMxNThiY2RkZi5f/X1JTMzYweDM2MF9f/LmpwZw	1979	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
575	La sombra del viento	Carlos Ruiz Zafón	Novela	Ambientada en la Barcelona de la primera mitad del siglo XX, desde los últimos esplendores del Modernismo hasta las tinieblas de la posguerra, la historia sigue a Daniel Sempere, quien es llevado por su padre a un misterioso lugar conocido como El Cementerio de los Libros Olvidados, donde encuentra un libro maldito que cambiará el rumbo de su vida y le arrastrará a un laberinto de intrigas y secretos.	https://imgs.search.brave.com/m4dUtGosz6eH_rMOcIEEsZ7YtOi3V1c31w-SnGCB_Bo/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9xdWVs/aWJyb2xlby5jb20v/aW1hZ2VzL2xpYnJv/cy9saWJyby0xNTk1/ODM3NTM1LmpwZw	2001	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
576	El nombre de la rosa 	Umberto Eco	Novela	La historia se desarrolla en el turbulento ambiente religioso del siglo XIV y narra las investigaciones que realiza el fraile franciscano Guillermo de Baskerville junto con su pupilo Adso de Melk, quienes intentan esclarecer una serie de misteriosos crímenes ocurridos en una abadía del norte de Italia.	https://imgs.search.brave.com/9pVYbTtONP-rcRXIK77_ES4Lj3oJf0UrPl6QqJ7hoY4/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9tLm1l/ZGlhLWFtYXpvbi5j/b20vaW1hZ2VzL0kv/NTF6aGEzSEJpcEwu/anBn	1980	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
577	Drácula	Bram Stoker	Fantasia	El personaje principal, el conde Drácula, es el arquetipo de vampiro occidental por antonomasia, siendo considerado el más famoso de la cultura popular.	https://imgs.search.brave.com/fUFPus_PMT9X7NJwNIzFxHaQvD2aH80yPOv144V-JNU/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/aW5mb2JhZS5jb20v/cmVzaXplci92Mi9H/WExETk5VSkhOR0RW/SlM0VEZPTDdETEVI/QS5qcGVnP2F1dGg9/NmEzMGNhYWQ3NWZj/ZDMxNmRlNDQ2NGI0/ZTcwOTI0NTAzMmVl/ZjNmY2Y5YmI4Y2Nj/MDdlMWEyZDc1ZGJh/OWMxYyZzbWFydD10/cnVlJndpZHRoPTM1/MCZoZWlnaHQ9NTI1/JnF1YWxpdHk9ODU	1897	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
578	Moby-Dick	Moby-Dick	Novela	La historia narra la travesía del barco ballenero Pequod, comandado por el capitán Ahab, junto a Ismael y el arponero Queequeg en una obsesiva y autodestructiva persecución de una gran ballena blanca llamada Moby Dick	https://imgs.search.brave.com/5M78_25so1DRbc5e0EDP2SApq5jpGpsc57gEBDq1qAc/rs:fit:860:0:0:0/g:ce/aHR0cDovL3d3dy5s/aWJyZXJpYWxlb24u/Y29tLm14L2ltYWdl/bmVzLzk3ODk3MDYv/OTc4OTcwNjI3MjIz/LkdJRg.gif	1851	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
579	El gran Gatsby	F. Scott Fitzgerald	Novela	La historia gira en torno al misterioso millonario Jay Gatsby y su obsesión por la hermosa ex debutante Daisy Buchanan. Gatsby organiza grandes fiestas en su fabulosa mansión de Long Island para reconquistar a Daisy, quien una vez lo amó.	https://imgs.search.brave.com/SKI-fq6bvaETd9lSM_3236S8m_ZyZTb9jVoIKWPLWTY/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9jZG4u/cHJvZC53ZWJzaXRl/LWZpbGVzLmNvbS82/MDM0ZDdkMWYzZTBm/NTJjNTBiMmFkZWUv/NjI1NDI4ZWMyNjFh/YzM4NDYwM2ViYWIz/XzYwOWFiNTdmMmY3/NmU4M2I1NmRhYWY1/Y185Nzg4NDE4Mzk1/MTg1X3dlYi5hdmlm	1925	2025-03-01 21:01:19.355536	t	\N	/uploads/cronica.pdf
\.


--
-- Data for Name: loans; Type: TABLE DATA; Schema: public; Owner: alexisrodriguez
--

COPY public.loans (id, user_id, book_id, loan_date, return_date, due_date, returned, borrowed_at, returned_at) FROM stdin;
\.


--
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: alexisrodriguez
--

COPY public.logs (id, level, message, "timestamp") FROM stdin;
1	info	🔹 Log de prueba INFO en PostgreSQL	2025-02-21 22:11:20.254565
2	warn	⚠ Log de prueba WARN en PostgreSQL	2025-02-21 22:11:20.259875
3	error	❌ Log de prueba ERROR en PostgreSQL	2025-02-21 22:11:20.265341
4	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-21 22:12:07.532614
5	info	::1 - - [22/Feb/2025:04:12:07 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:12:07.552218
6	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-21 22:32:21.055421
7	info	::1 - - [22/Feb/2025:04:32:21 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:21.075136
8	info	::1 - - [22/Feb/2025:04:32:41 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:41.575724
9	info	::1 - - [22/Feb/2025:04:32:41 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:41.57806
10	info	::1 - - [22/Feb/2025:04:32:46 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:46.774712
11	info	::1 - - [22/Feb/2025:04:32:46 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:46.778429
12	info	::1 - - [22/Feb/2025:04:32:51 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:51.290053
13	info	::1 - - [22/Feb/2025:04:32:51 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:51.292125
14	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-21 22:32:59.000657
15	info	::1 - - [22/Feb/2025:04:32:59 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:32:59.002859
16	info	::1 - - [22/Feb/2025:04:33:54 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:33:54.362592
17	info	::1 - - [22/Feb/2025:04:33:54 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:33:54.366277
18	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-21 22:40:24.451279
19	info	::1 - - [22/Feb/2025:04:40:24 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:40:24.453505
20	info	::1 - - [22/Feb/2025:04:40:27 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:40:27.218502
21	info	::1 - - [22/Feb/2025:04:40:27 +0000] "GET /logs HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:40:27.220183
22	info	::1 - - [22/Feb/2025:04:40:51 +0000] "GET /logs HTTP/1.1" 403 53 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:40:51.363742
23	info	::1 - - [22/Feb/2025:04:40:51 +0000] "GET /favicon.ico HTTP/1.1" 404 150 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:40:51.437429
24	info	::1 - - [22/Feb/2025:04:43:18 +0000] "GET /logs HTTP/1.1" 403 53 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:43:18.086711
25	error	❌ Error en login: [\n  {\n    "validation": "email",\n    "code": "invalid_string",\n    "message": "El email no es válido",\n    "path": [\n      "email"\n    ]\n  },\n  {\n    "code": "too_small",\n    "minimum": 5,\n    "type": "string",\n    "inclusive": true,\n    "exact": false,\n    "message": "La contraseña debe tener al menos 5 caracteres",\n    "path": [\n      "password"\n    ]\n  }\n]	2025-02-21 22:43:45.44584
26	info	::1 - - [22/Feb/2025:04:43:45 +0000] "POST /auth/login HTTP/1.1" 400 462 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:43:45.448005
27	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-21 22:43:55.919688
28	info	::1 - - [22/Feb/2025:04:43:55 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:43:55.923335
29	info	::1 - - [22/Feb/2025:04:46:04 +0000] "GET /logs HTTP/1.1" 200 7024 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:04.48205
30	info	::1 - - [22/Feb/2025:04:46:04 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:04.483859
31	info	::1 - - [22/Feb/2025:04:46:22 +0000] "GET /logs HTTP/1.1" 200 7609 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:22.647559
32	info	::1 - - [22/Feb/2025:04:46:22 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:22.64955
33	info	::1 - - [22/Feb/2025:04:46:48 +0000] "GET /logs HTTP/1.1" 200 8194 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:48.26367
34	info	::1 - - [22/Feb/2025:04:46:48 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:46:48.264729
35	info	::1 - - [22/Feb/2025:04:47:04 +0000] "GET /logs HTTP/1.1" 200 8779 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:47:04.964788
36	info	::1 - - [22/Feb/2025:04:47:04 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-21 22:47:04.980323
37	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-22 21:09:30.808953
38	info	::1 - - [23/Feb/2025:03:09:30 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-22 21:09:30.826273
39	info	::1 - - [23/Feb/2025:03:09:32 +0000] "GET /logs HTTP/1.1" 200 9790 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-22 21:09:32.297348
40	info	::1 - - [23/Feb/2025:03:09:32 +0000] "GET /logs HTTP/1.1" 200 10084 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-22 21:09:32.301609
41	info	::1 - - [23/Feb/2025:03:10:30 +0000] "GET /logs HTTP/1.1" 200 10379 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-22 21:10:30.440779
42	info	::1 - - [23/Feb/2025:03:10:30 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-22 21:10:30.442952
43	info	::1 - - [23/Feb/2025:16:59:06 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 10:59:06.258778
44	info	::1 - - [23/Feb/2025:16:59:06 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 10:59:06.266098
45	info	::1 - - [23/Feb/2025:17:14:51 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:14:51.650401
46	info	::1 - - [23/Feb/2025:17:14:51 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:14:51.670627
47	info	::1 - - [23/Feb/2025:17:27:23 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:27:23.179538
48	info	::1 - - [23/Feb/2025:17:27:23 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:27:23.205513
49	info	::1 - - [23/Feb/2025:17:49:39 +0000] "GET /logs HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:49:39.404779
50	info	✅ Usuario autenticado: alexis@gmail.com (ID: 1)	2025-02-23 11:49:57.603034
51	info	::1 - - [23/Feb/2025:17:49:57 +0000] "POST /auth/login HTTP/1.1" 200 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:49:57.605494
52	info	::1 - - [23/Feb/2025:17:49:58 +0000] "GET /logs HTTP/1.1" 200 13435 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:49:58.692776
53	info	::1 - - [23/Feb/2025:17:49:58 +0000] "GET /logs HTTP/1.1" 200 13730 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 11:49:58.696532
54	info	::1 - - [23/Feb/2025:18:00:19 +0000] "GET /logs HTTP/1.1" 200 14025 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:00:19.78014
55	info	::1 - - [23/Feb/2025:18:00:19 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:00:19.786559
56	info	::1 - - [23/Feb/2025:18:00:19 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:00:19.79309
57	info	::1 - - [23/Feb/2025:18:00:19 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:00:19.794166
58	info	::1 - - [23/Feb/2025:18:23:37 +0000] "POST /users/register HTTP/1.1" 201 147 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:23:37.97998
59	info	✅ Usuario autenticado: alexisrdz19@gmail.com (ID: 4)	2025-02-23 12:23:47.037658
60	info	::1 - - [23/Feb/2025:18:23:47 +0000] "POST /auth/login HTTP/1.1" 200 326 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:23:47.042783
61	info	::1 - - [23/Feb/2025:18:26:33 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:26:33.220517
62	info	::1 - - [23/Feb/2025:18:26:33 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:26:33.222422
63	warn	⚠ Intento de login fallido para usuario@example.com	2025-02-23 12:58:27.402198
64	info	::1 - - [23/Feb/2025:18:58:27 +0000] "POST /auth/login HTTP/1.1" 401 37 "-" "curl/8.7.1"	2025-02-23 12:58:27.405031
65	info	✅ Usuario autenticado: alexisrdz19@gmail.com (ID: 4)	2025-02-23 12:58:57.667159
66	info	::1 - - [23/Feb/2025:18:58:57 +0000] "POST /auth/login HTTP/1.1" 200 326 "-" "curl/8.7.1"	2025-02-23 12:58:57.668957
67	error	❌ Error en login: Missing credentials for "PLAIN"	2025-02-23 12:59:40.741152
68	info	::1 - - [23/Feb/2025:18:59:40 +0000] "POST /auth/login HTTP/1.1" 400 74 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 12:59:40.748035
69	info	✅ Usuario autenticado: alexisrdz19@gmail.com (ID: 4)	2025-02-23 13:00:01.428012
70	info	::1 - - [23/Feb/2025:19:00:01 +0000] "POST /auth/login HTTP/1.1" 200 326 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:00:01.429533
71	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-23 13:01:40.578181
1270	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-28 21:43:20.165511
72	info	::1 - - [23/Feb/2025:19:01:40 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:01:40.580037
73	info	::1 - - [23/Feb/2025:19:01:45 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:01:45.232205
74	info	::1 - - [23/Feb/2025:19:08:40 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:08:40.142213
75	info	::1 - - [23/Feb/2025:19:08:40 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:08:40.144984
76	info	::1 - - [23/Feb/2025:19:08:40 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:08:40.74782
77	info	::1 - - [23/Feb/2025:19:08:40 +0000] "GET /logs HTTP/1.1" 403 29 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:08:40.75444
78	warn	⚠ Intento de login fallido para alexisrdz19@gmail.come	2025-02-23 13:08:51.255145
79	info	::1 - - [23/Feb/2025:19:08:51 +0000] "POST /auth/login HTTP/1.1" 401 37 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:08:51.257245
80	error	❌ Error en login: Invalid login: 535-5.7.8 Username and Password not accepted. For more information, go to\n535 5.7.8  https://support.google.com/mail/?p=BadCredentials 5614622812f47-3f3f8f500a7sm3800164b6e.37 - gsmtp	2025-02-23 13:11:55.820204
81	info	::1 - - [23/Feb/2025:19:11:55 +0000] "POST /auth/login HTTP/1.1" 400 240 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:11:55.824606
82	warn	⚠ Intento de login fallido para alexisrdz19@gmail.come	2025-02-23 13:13:25.142804
83	info	::1 - - [23/Feb/2025:19:13:25 +0000] "POST /auth/login HTTP/1.1" 401 37 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:13:25.14557
84	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-23 13:14:31.929077
85	info	::1 - - [23/Feb/2025:19:14:31 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:14:31.930969
86	warn	⚠ Intento de login fallido para alexisrdz19@gmail.come	2025-02-23 13:14:39.554689
87	info	::1 - - [23/Feb/2025:19:14:39 +0000] "POST /auth/login HTTP/1.1" 401 37 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:14:39.557151
88	info	🔒 Código 2FA enviado a ealexisrdz19@gmail.com	2025-02-23 13:15:01.538386
89	info	::1 - - [23/Feb/2025:19:15:01 +0000] "POST /auth/login HTTP/1.1" 200 20 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:15:01.540493
90	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-23 13:31:06.94252
91	info	::1 - - [23/Feb/2025:19:31:06 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:31:06.966061
92	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 13:31:22.108199
93	info	::1 - - [23/Feb/2025:19:31:22 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:31:22.121839
94	info	::1 - - [23/Feb/2025:19:31:28 +0000] "GET /logs HTTP/1.1" 200 23491 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:31:28.984955
95	info	::1 - - [23/Feb/2025:19:31:28 +0000] "GET /logs HTTP/1.1" 200 23786 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:31:28.991669
96	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 13:50:52.986737
97	info	::1 - - [23/Feb/2025:19:50:52 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:50:52.999214
98	info	::1 - - [23/Feb/2025:19:50:53 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:50:53.025853
99	info	::1 - - [23/Feb/2025:19:50:53 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:50:53.027693
100	info	::1 - - [23/Feb/2025:19:52:52 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:52.542013
101	info	::1 - - [23/Feb/2025:19:52:52 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:52.547288
102	info	::1 - - [23/Feb/2025:19:52:55 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:55.471959
103	info	::1 - - [23/Feb/2025:19:52:55 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:55.476778
104	info	::1 - - [23/Feb/2025:19:52:55 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:55.805528
105	info	::1 - - [23/Feb/2025:19:52:55 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:52:55.821887
106	info	::1 - - [23/Feb/2025:19:53:08 +0000] "GET /logs HTTP/1.1" 200 26148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:08.352087
107	info	::1 - - [23/Feb/2025:19:53:08 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:08.353372
108	info	::1 - - [23/Feb/2025:19:53:09 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:09.706397
109	info	::1 - - [23/Feb/2025:19:53:09 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:09.710038
110	info	::1 - - [23/Feb/2025:19:53:19 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:19.393181
111	info	::1 - - [23/Feb/2025:19:53:19 +0000] "GET /dashboard HTTP/1.1" 404 148 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:53:19.40908
112	info	::1 - - [23/Feb/2025:19:55:06 +0000] "GET /dashboard HTTP/1.1" 403 53 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:06.674954
113	info	::1 - - [23/Feb/2025:19:55:13 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:13.847565
114	info	::1 - - [23/Feb/2025:19:55:13 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:13.87291
115	info	::1 - - [23/Feb/2025:19:55:21 +0000] "GET /logs HTTP/1.1" 200 26504 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:21.680275
116	info	::1 - - [23/Feb/2025:19:55:21 +0000] "GET /logs HTTP/1.1" 200 26500 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:21.687665
117	info	::1 - - [23/Feb/2025:19:55:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:23.124346
118	info	::1 - - [23/Feb/2025:19:55:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 13:55:23.128239
119	info	::1 - - [23/Feb/2025:20:11:17 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:11:17.463982
120	info	::1 - - [23/Feb/2025:20:11:17 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:11:17.494716
121	info	::1 - - [23/Feb/2025:20:29:27 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:29:27.773014
122	info	::1 - - [23/Feb/2025:20:29:27 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:29:27.780702
123	info	::1 - - [23/Feb/2025:20:55:53 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:55:53.771388
124	info	::1 - - [23/Feb/2025:20:55:53 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:55:53.787013
125	info	::1 - - [23/Feb/2025:20:55:56 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:55:56.119541
126	info	::1 - - [23/Feb/2025:20:55:56 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:55:56.136898
127	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 14:56:09.423981
128	info	::1 - - [23/Feb/2025:20:56:09 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:56:09.425158
129	info	::1 - - [23/Feb/2025:20:56:09 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:56:09.460612
130	info	::1 - - [23/Feb/2025:20:56:09 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:56:09.462558
131	info	::1 - - [23/Feb/2025:20:57:04 +0000] "GET /dashboard HTTP/1.1" - - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:57:05.025009
132	info	::1 - - [23/Feb/2025:20:57:05 +0000] "GET /dashboard HTTP/1.1" - - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:57:05.0281
133	info	::1 - - [23/Feb/2025:20:57:05 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:57:05.450952
134	info	::1 - - [23/Feb/2025:20:57:05 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 14:57:05.463047
135	info	::1 - - [23/Feb/2025:21:00:08 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:08.940332
136	info	::1 - - [23/Feb/2025:21:00:08 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:08.942577
137	info	::1 - - [23/Feb/2025:21:00:22 +0000] "GET /logs HTTP/1.1" 200 26586 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:22.884618
138	info	::1 - - [23/Feb/2025:21:00:22 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:22.887472
139	info	::1 - - [23/Feb/2025:21:00:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:36.726463
140	info	::1 - - [23/Feb/2025:21:00:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:00:36.727933
141	info	::1 - - [23/Feb/2025:21:12:04 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:12:04.032494
142	info	::1 - - [23/Feb/2025:21:12:04 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:12:04.051013
143	info	::1 - - [23/Feb/2025:21:12:04 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:12:04.054321
144	info	::1 - - [23/Feb/2025:21:12:04 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:12:04.054239
145	info	::1 - - [23/Feb/2025:21:13:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:13:31.089108
146	info	::1 - - [23/Feb/2025:21:13:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:13:31.109575
147	info	::1 - - [23/Feb/2025:21:13:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:13:31.206292
148	info	::1 - - [23/Feb/2025:21:13:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:13:31.212248
149	info	::1 - - [23/Feb/2025:21:18:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:18:50.358027
150	info	::1 - - [23/Feb/2025:21:18:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:18:50.360209
151	info	::1 - - [23/Feb/2025:21:18:54 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:18:54.915762
152	info	::1 - - [23/Feb/2025:21:18:54 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:18:54.922644
153	info	::1 - - [23/Feb/2025:21:19:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:02.661724
154	info	::1 - - [23/Feb/2025:21:19:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:02.66526
155	info	::1 - - [23/Feb/2025:21:19:06 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:06.173532
156	info	::1 - - [23/Feb/2025:21:19:06 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:06.178236
157	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 15:19:21.796569
158	info	::1 - - [23/Feb/2025:21:19:21 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:21.80184
159	info	::1 - - [23/Feb/2025:21:19:21 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:21.811866
160	info	::1 - - [23/Feb/2025:21:19:21 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:21.814306
161	info	::1 - - [23/Feb/2025:21:19:27 +0000] "GET /logs HTTP/1.1" 200 26993 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:27.533856
162	info	::1 - - [23/Feb/2025:21:19:27 +0000] "GET /logs HTTP/1.1" 200 26997 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:27.53899
163	info	::1 - - [23/Feb/2025:21:19:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:36.197669
164	info	::1 - - [23/Feb/2025:21:19:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:19:36.201402
165	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 15:26:58.027637
166	info	::1 - - [23/Feb/2025:21:26:58 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:26:58.029959
167	info	::1 - - [23/Feb/2025:21:26:58 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:26:58.043915
168	info	::1 - - [23/Feb/2025:21:26:58 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:26:58.046643
169	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-23 15:29:31.321061
170	info	::1 - - [23/Feb/2025:21:29:31 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:31.322968
171	info	::1 - - [23/Feb/2025:21:29:31 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:31.327527
172	info	::1 - - [23/Feb/2025:21:29:31 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:31.331215
173	info	::1 - - [23/Feb/2025:21:29:38 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:38.013544
174	info	::1 - - [23/Feb/2025:21:29:38 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:38.016177
175	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 15:29:45.789303
176	info	::1 - - [23/Feb/2025:21:29:45 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:45.790227
177	info	::1 - - [23/Feb/2025:21:29:45 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:45.810058
178	info	::1 - - [23/Feb/2025:21:29:45 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:29:45.812984
179	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 15:35:25.628717
180	info	::1 - - [23/Feb/2025:21:35:25 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:35:25.63274
181	info	::1 - - [23/Feb/2025:21:35:25 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:35:25.646443
182	info	::1 - - [23/Feb/2025:21:35:25 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 15:35:25.64904
183	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 17:35:24.711477
184	info	::1 - - [23/Feb/2025:23:35:24 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:35:24.732097
185	info	::1 - - [23/Feb/2025:23:35:24 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:35:24.736503
186	info	::1 - - [23/Feb/2025:23:35:24 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:35:24.737648
187	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 17:49:37.939425
188	info	::1 - - [23/Feb/2025:23:49:37 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:49:37.966325
189	info	::1 - - [23/Feb/2025:23:49:37 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:49:37.968187
190	info	::1 - - [23/Feb/2025:23:49:37 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:49:37.971537
191	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 17:51:10.105082
192	info	::1 - - [23/Feb/2025:23:51:10 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:51:10.107964
193	info	::1 - - [23/Feb/2025:23:51:10 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:51:10.114143
194	info	::1 - - [23/Feb/2025:23:51:10 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 17:51:10.116531
195	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 21:08:56.422965
196	info	::1 - - [24/Feb/2025:03:08:56 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:08:56.460967
197	info	::1 - - [24/Feb/2025:03:08:56 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:08:56.461553
198	info	::1 - - [24/Feb/2025:03:08:56 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:08:56.469355
199	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 21:22:41.306686
200	info	::1 - - [24/Feb/2025:03:22:41 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:22:41.311934
201	info	::1 - - [24/Feb/2025:03:22:41 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:22:41.328663
202	info	::1 - - [24/Feb/2025:03:22:41 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:22:41.333035
203	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-23 21:24:32.81419
342	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 20:21:36.901868
1309	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-03-01 17:09:44.117391
204	info	::1 - - [24/Feb/2025:03:24:32 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:32.816209
205	info	::1 - - [24/Feb/2025:03:24:32 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:32.821665
206	info	::1 - - [24/Feb/2025:03:24:32 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:32.823028
207	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 21:24:50.015165
208	info	::1 - - [24/Feb/2025:03:24:50 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:50.036958
209	info	::1 - - [24/Feb/2025:03:24:50 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:50.042835
210	info	::1 - - [24/Feb/2025:03:24:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:24:50.042775
211	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 21:56:03.193192
212	info	::1 - - [24/Feb/2025:03:56:03 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:56:03.209244
213	info	::1 - - [24/Feb/2025:03:56:03 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:56:03.212893
214	info	::1 - - [24/Feb/2025:03:56:03 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:56:03.213049
215	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 21:57:02.920169
216	info	::1 - - [24/Feb/2025:03:57:02 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:57:02.926995
217	info	::1 - - [24/Feb/2025:03:57:02 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:57:02.935153
218	info	::1 - - [24/Feb/2025:03:57:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 21:57:02.93732
219	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-23 22:05:05.582698
220	info	::1 - - [24/Feb/2025:04:05:05 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:05.58558
221	info	::1 - - [24/Feb/2025:04:05:05 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:05.597085
222	info	::1 - - [24/Feb/2025:04:05:05 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:05.599422
223	info	::1 - - [24/Feb/2025:04:05:08 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:08.856751
224	info	::1 - - [24/Feb/2025:04:05:08 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:08.860891
225	info	::1 - - [24/Feb/2025:04:05:27 +0000] "GET /logs HTTP/1.1" 200 27270 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:27.997176
226	info	::1 - - [24/Feb/2025:04:05:27 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:05:27.998433
227	info	::1 - - [24/Feb/2025:04:06:44 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:06:44.790462
228	info	::1 - - [24/Feb/2025:04:06:44 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-23 22:06:44.792062
229	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 17:33:47.126996
230	info	::1 - - [24/Feb/2025:23:33:47 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:33:47.159262
231	info	::1 - - [24/Feb/2025:23:33:47 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:33:47.167608
232	info	::1 - - [24/Feb/2025:23:33:47 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:33:47.167737
233	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 17:34:10.606715
234	info	::1 - - [24/Feb/2025:23:34:10 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:34:10.608179
235	info	::1 - - [24/Feb/2025:23:34:10 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:34:10.63325
236	info	::1 - - [24/Feb/2025:23:34:10 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:34:10.636077
237	info	✅ Usuario autenticado sin 2FA: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 17:53:57.752751
238	info	::1 - - [24/Feb/2025:23:53:57 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:53:57.765949
239	info	::1 - - [24/Feb/2025:23:53:57 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:53:57.779082
240	info	::1 - - [24/Feb/2025:23:53:57 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:53:57.782129
241	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 17:54:04.735544
242	info	::1 - - [24/Feb/2025:23:54:04 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:54:04.736543
243	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 17:54:45.066516
244	info	::1 - - [24/Feb/2025:23:54:45 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:54:45.069051
245	info	::1 - - [24/Feb/2025:23:59:11 +0000] "GET /dashboard/user HTTP/1.1" 404 153 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 17:59:11.289798
246	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:03:54.052379
247	info	::1 - - [25/Feb/2025:00:03:54 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:03:54.066079
248	info	::1 - - [25/Feb/2025:00:03:54 +0000] "GET /dashboard/user HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:03:54.075639
249	info	::1 - - [25/Feb/2025:00:03:54 +0000] "GET /dashboard/user HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:03:54.079725
250	info	::1 - - [25/Feb/2025:00:04:22 +0000] "GET /dashboard/user HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:22.458603
251	info	::1 - - [25/Feb/2025:00:04:22 +0000] "GET /dashboard/user HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:22.460328
252	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:04:25.775591
253	info	::1 - - [25/Feb/2025:00:04:25 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:25.779767
254	info	::1 - - [25/Feb/2025:00:04:25 +0000] "GET /dashboard/user HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:25.794285
255	info	::1 - - [25/Feb/2025:00:04:25 +0000] "GET /dashboard/user HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:25.79923
256	info	::1 - - [25/Feb/2025:00:04:33 +0000] "GET /dashboard/user HTTP/1.1" 404 153 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:33.397413
257	info	::1 - - [25/Feb/2025:00:04:33 +0000] "GET /dashboard/user HTTP/1.1" 404 153 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:33.399316
258	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:04:36.066464
259	info	::1 - - [25/Feb/2025:00:04:36 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:36.069455
260	info	::1 - - [25/Feb/2025:00:04:36 +0000] "GET /dashboard/user HTTP/1.1" 404 153 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:36.082083
261	info	::1 - - [25/Feb/2025:00:04:36 +0000] "GET /dashboard/user HTTP/1.1" 404 153 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:04:36.086015
262	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:05:29.663342
263	info	::1 - - [25/Feb/2025:00:05:29 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:29.669071
264	info	::1 - - [25/Feb/2025:00:05:29 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:29.674533
265	info	::1 - - [25/Feb/2025:00:05:29 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:29.676022
266	info	::1 - - [25/Feb/2025:00:05:44 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:44.148638
267	info	::1 - - [25/Feb/2025:00:05:44 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:44.150279
268	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:05:47.663352
269	info	::1 - - [25/Feb/2025:00:05:47 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:05:47.666354
270	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:06:56.941661
271	info	::1 - - [25/Feb/2025:00:06:56 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:06:56.94375
272	info	✅ Usuario autenticado sin 2FA: usuario@gmail.com (ID: 2)	2025-02-24 18:07:10.424473
273	info	::1 - - [25/Feb/2025:00:07:10 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:07:10.428833
274	info	::1 - - [25/Feb/2025:00:07:16 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:07:16.407837
275	info	::1 - - [25/Feb/2025:00:07:18 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:07:18.342002
276	info	::1 - - [25/Feb/2025:00:08:29 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:08:29.249977
277	info	::1 - - [25/Feb/2025:00:09:18 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:09:18.710007
278	info	::1 - - [25/Feb/2025:00:09:42 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:09:42.213283
279	info	::1 - - [25/Feb/2025:00:11:18 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:11:18.815099
280	info	::1 - - [25/Feb/2025:00:12:40 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:12:40.236922
281	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 18:14:53.24028
282	info	::1 - - [25/Feb/2025:00:14:53 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:14:53.267262
283	info	::1 - - [25/Feb/2025:00:14:53 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:14:53.26959
284	info	::1 - - [25/Feb/2025:00:14:53 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:14:53.274129
285	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:15:00.416304
286	info	::1 - - [25/Feb/2025:00:15:00 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:15:00.417551
287	info	::1 - - [25/Feb/2025:00:15:00 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:15:00.431383
288	info	::1 - - [25/Feb/2025:00:15:00 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:15:00.434555
289	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:22:41.702833
290	info	::1 - - [25/Feb/2025:00:22:41 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:41.726433
291	info	::1 - - [25/Feb/2025:00:22:41 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:41.730374
292	info	::1 - - [25/Feb/2025:00:22:41 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:41.730267
293	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 18:22:54.313364
294	info	::1 - - [25/Feb/2025:00:22:54 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:54.314886
295	info	::1 - - [25/Feb/2025:00:22:54 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:54.344565
296	info	::1 - - [25/Feb/2025:00:22:54 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:22:54.347845
297	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:23:01.185337
298	info	::1 - - [25/Feb/2025:00:23:01 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:23:01.186972
299	info	::1 - - [25/Feb/2025:00:23:01 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:23:01.201923
300	info	::1 - - [25/Feb/2025:00:23:01 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:23:01.204073
301	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:32:11.356811
302	info	::1 - - [25/Feb/2025:00:32:11 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:11.369393
303	info	::1 - - [25/Feb/2025:00:32:11 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:11.373446
304	info	::1 - - [25/Feb/2025:00:32:11 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:11.37565
305	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 18:32:24.6041
306	info	::1 - - [25/Feb/2025:00:32:24 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:24.622904
996	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:13:51.378942
307	info	::1 - - [25/Feb/2025:00:32:24 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:24.656178
308	info	::1 - - [25/Feb/2025:00:32:24 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:24.669314
309	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:32:35.419353
310	info	::1 - - [25/Feb/2025:00:32:35 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:35.422946
311	info	::1 - - [25/Feb/2025:00:32:35 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:35.43673
312	info	::1 - - [25/Feb/2025:00:32:35 +0000] "GET /dashboard HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:32:35.439518
313	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:36:02.660692
314	info	::1 - - [25/Feb/2025:00:36:02 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:36:02.69418
315	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 18:36:10.752298
316	info	::1 - - [25/Feb/2025:00:36:10 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:36:10.753769
317	info	::1 - - [25/Feb/2025:00:36:10 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:36:10.791086
318	info	::1 - - [25/Feb/2025:00:36:10 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:36:10.794731
319	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 18:49:44.449614
320	info	::1 - - [25/Feb/2025:00:49:44 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:49:44.494185
321	info	::1 - - [25/Feb/2025:00:49:44 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:49:44.497704
322	info	::1 - - [25/Feb/2025:00:49:44 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:49:44.499267
323	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:49:47.999828
324	info	::1 - - [25/Feb/2025:00:49:47 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:49:48.000954
325	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 18:50:02.764737
326	info	::1 - - [25/Feb/2025:00:50:02 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 18:50:02.767509
327	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 19:42:44.706009
328	info	::1 - - [25/Feb/2025:01:42:44 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 19:42:44.744329
329	info	::1 - - [25/Feb/2025:01:57:41 +0000] "GET /books HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 19:57:41.742822
330	info	::1 - - [25/Feb/2025:01:57:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 19:57:41.747763
331	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 20:20:49.379363
332	info	::1 - - [25/Feb/2025:02:20:49 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:20:49.394318
333	info	::1 - - [25/Feb/2025:02:20:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:20:49.398958
334	info	::1 - - [25/Feb/2025:02:20:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:20:49.399419
335	info	::1 - - [25/Feb/2025:02:20:49 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:20:49.403166
336	info	::1 - - [25/Feb/2025:02:20:49 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:20:49.40615
337	info	::1 - - [25/Feb/2025:02:21:28 +0000] "POST /books HTTP/1.1" 201 42 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:28.392048
338	info	::1 - - [25/Feb/2025:02:21:33 +0000] "GET /books HTTP/1.1" 200 443 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:33.864364
339	info	::1 - - [25/Feb/2025:02:21:33 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:33.872273
340	info	::1 - - [25/Feb/2025:02:21:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:33.87802
341	info	::1 - - [25/Feb/2025:02:21:33 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:33.879416
343	info	::1 - - [25/Feb/2025:02:21:36 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:36.905151
344	info	::1 - - [25/Feb/2025:02:21:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:36.919042
345	info	::1 - - [25/Feb/2025:02:21:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:36.920464
346	info	::1 - - [25/Feb/2025:02:21:36 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:36.922641
347	info	::1 - - [25/Feb/2025:02:21:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:21:36.92529
348	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 20:22:00.253761
349	info	::1 - - [25/Feb/2025:02:22:00 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:00.255523
350	info	::1 - - [25/Feb/2025:02:22:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:02.425673
351	info	::1 - - [25/Feb/2025:02:22:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:02.427498
352	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 20:22:43.516569
353	info	::1 - - [25/Feb/2025:02:22:43 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:43.519102
354	info	::1 - - [25/Feb/2025:02:22:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:43.532156
355	info	::1 - - [25/Feb/2025:02:22:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:43.553651
356	info	::1 - - [25/Feb/2025:02:22:43 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:43.560187
357	info	::1 - - [25/Feb/2025:02:22:43 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:22:43.565011
358	info	::1 - - [25/Feb/2025:02:23:26 +0000] "POST /books HTTP/1.1" 201 42 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:23:26.258875
359	info	::1 - - [25/Feb/2025:02:24:15 +0000] "POST /books HTTP/1.1" 201 42 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:15.871567
360	info	::1 - - [25/Feb/2025:02:24:20 +0000] "GET /books HTTP/1.1" 200 1342 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:20.628238
361	info	::1 - - [25/Feb/2025:02:24:20 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:20.642488
362	info	::1 - - [25/Feb/2025:02:24:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:20.648582
363	info	::1 - - [25/Feb/2025:02:24:20 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:20.650288
364	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 20:24:25.605392
365	info	::1 - - [25/Feb/2025:02:24:25 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:25.609487
366	info	::1 - - [25/Feb/2025:02:24:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:28.255171
367	info	::1 - - [25/Feb/2025:02:24:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:24:28.256781
368	info	::1 - - [25/Feb/2025:02:25:18 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:18.57928
369	info	::1 - - [25/Feb/2025:02:25:18 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:18.581293
370	info	::1 - - [25/Feb/2025:02:25:19 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:19.826672
371	info	::1 - - [25/Feb/2025:02:25:19 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:19.828166
372	info	::1 - - [25/Feb/2025:02:25:24 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:24.032834
373	info	::1 - - [25/Feb/2025:02:25:24 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:24.043729
374	info	::1 - - [25/Feb/2025:02:25:29 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:29.54922
375	info	::1 - - [25/Feb/2025:02:25:29 +0000] "GET /books/latest HTTP/1.1" 404 151 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:25:29.561025
376	info	::1 - - [25/Feb/2025:02:37:50 +0000] "GET /books/latest HTTP/1.1" 200 1342 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:37:50.945238
377	info	::1 - - [25/Feb/2025:02:37:50 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:37:50.948444
378	info	::1 - - [25/Feb/2025:02:37:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:37:55.797527
379	info	::1 - - [25/Feb/2025:02:37:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:37:55.805438
380	info	::1 - - [25/Feb/2025:02:38:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:00.439186
381	info	::1 - - [25/Feb/2025:02:38:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:00.441539
382	info	::1 - - [25/Feb/2025:02:38:02 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:02.382524
383	info	::1 - - [25/Feb/2025:02:38:02 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:02.384514
384	info	::1 - - [25/Feb/2025:02:38:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:28.155434
385	info	::1 - - [25/Feb/2025:02:38:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:28.157593
386	info	::1 - - [25/Feb/2025:02:38:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:30.324946
387	info	::1 - - [25/Feb/2025:02:38:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:30.333484
388	info	::1 - - [25/Feb/2025:02:38:34 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:34.266983
389	info	::1 - - [25/Feb/2025:02:38:34 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:38:34.269289
390	info	::1 - - [25/Feb/2025:02:41:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:41:45.578814
391	info	::1 - - [25/Feb/2025:02:41:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:41:47.371829
392	info	::1 - - [25/Feb/2025:02:41:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:41:47.390598
393	info	::1 - - [25/Feb/2025:02:45:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:45:17.446349
394	info	::1 - - [25/Feb/2025:02:45:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:45:17.448811
395	info	::1 - - [25/Feb/2025:02:45:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:45:17.552336
396	info	::1 - - [25/Feb/2025:02:53:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:53:01.096236
397	info	::1 - - [25/Feb/2025:02:53:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:53:01.104086
399	info	::1 - - [25/Feb/2025:02:53:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:53:01.114221
398	info	::1 - - [25/Feb/2025:02:53:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 20:53:01.114541
400	info	::1 - - [25/Feb/2025:03:14:23 +0000] "GET /loans HTTP/1.1" 404 144 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:14:23.162488
401	info	::1 - - [25/Feb/2025:03:19:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:32.604774
402	info	::1 - - [25/Feb/2025:03:19:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:32.608084
403	info	::1 - - [25/Feb/2025:03:19:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:32.613729
404	info	::1 - - [25/Feb/2025:03:19:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:32.614356
1182	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-28 18:32:15.633509
405	info	::1 - - [25/Feb/2025:03:19:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:36.549519
406	info	::1 - - [25/Feb/2025:03:19:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:36.551614
407	info	::1 - - [25/Feb/2025:03:19:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:36.552973
408	info	::1 - - [25/Feb/2025:03:19:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:36.556691
409	info	::1 - - [25/Feb/2025:03:19:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:42.549757
410	info	::1 - - [25/Feb/2025:03:19:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:42.551887
411	info	::1 - - [25/Feb/2025:03:19:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:42.55328
412	info	::1 - - [25/Feb/2025:03:19:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:42.554878
413	info	::1 - - [25/Feb/2025:03:19:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:45.553116
414	info	::1 - - [25/Feb/2025:03:19:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:45.555294
415	info	::1 - - [25/Feb/2025:03:19:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:45.556669
416	info	::1 - - [25/Feb/2025:03:19:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:45.558076
417	info	::1 - - [25/Feb/2025:03:19:48 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:48.550676
418	info	::1 - - [25/Feb/2025:03:19:48 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:48.554203
419	info	::1 - - [25/Feb/2025:03:19:48 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:48.555585
420	info	::1 - - [25/Feb/2025:03:19:48 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:19:48.556881
421	info	::1 - - [25/Feb/2025:03:20:43 +0000] "GET /loans HTTP/1.1" 404 144 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:43.991212
422	info	::1 - - [25/Feb/2025:03:20:43 +0000] "GET /loans HTTP/1.1" 404 144 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:43.993293
423	info	::1 - - [25/Feb/2025:03:20:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:45.642347
424	info	::1 - - [25/Feb/2025:03:20:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:45.644823
425	info	::1 - - [25/Feb/2025:03:20:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:46.881188
426	info	::1 - - [25/Feb/2025:03:20:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:46.882923
427	info	::1 - - [25/Feb/2025:03:20:48 +0000] "POST /loans/borrow HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:48.070885
428	info	::1 - - [25/Feb/2025:03:20:49 +0000] "GET /loans HTTP/1.1" 404 144 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:49.842428
429	info	::1 - - [25/Feb/2025:03:20:49 +0000] "GET /loans HTTP/1.1" 404 144 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:49.84483
430	info	::1 - - [25/Feb/2025:03:20:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:51.13276
431	info	::1 - - [25/Feb/2025:03:20:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:51.135678
432	info	::1 - - [25/Feb/2025:03:20:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:52.24206
433	info	::1 - - [25/Feb/2025:03:20:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:52.243648
434	info	::1 - - [25/Feb/2025:03:20:53 +0000] "POST /loans/borrow HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:53.48497
1328	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-03-01 17:12:01.710285
435	info	::1 - - [25/Feb/2025:03:20:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:58.542445
436	info	::1 - - [25/Feb/2025:03:20:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:20:58.545121
437	info	::1 - - [25/Feb/2025:03:21:00 +0000] "POST /loans/borrow HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:21:00.244279
438	info	::1 - - [25/Feb/2025:03:34:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:32.217144
439	info	::1 - - [25/Feb/2025:03:34:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:32.22081
440	info	::1 - - [25/Feb/2025:03:34:35 +0000] "POST /loans/borrow HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:35.333007
441	info	::1 - - [25/Feb/2025:03:34:38 +0000] "GET /loans HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:38.040031
442	info	::1 - - [25/Feb/2025:03:34:38 +0000] "GET /loans HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:38.044082
443	info	::1 - - [25/Feb/2025:03:34:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:39.338757
444	info	::1 - - [25/Feb/2025:03:34:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:39.342
445	info	::1 - - [25/Feb/2025:03:34:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:45.684148
446	info	::1 - - [25/Feb/2025:03:34:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:45.690042
447	info	::1 - - [25/Feb/2025:03:34:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:47.60742
448	info	::1 - - [25/Feb/2025:03:34:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:47.61049
449	info	::1 - - [25/Feb/2025:03:34:48 +0000] "POST /loans/borrow HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:34:48.972895
450	info	::1 - - [25/Feb/2025:03:39:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:31.118439
451	info	::1 - - [25/Feb/2025:03:39:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:31.12412
452	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 21:39:37.685543
453	info	::1 - - [25/Feb/2025:03:39:37 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:37.686822
454	info	::1 - - [25/Feb/2025:03:39:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:37.708761
455	info	::1 - - [25/Feb/2025:03:39:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:37.713183
456	info	::1 - - [25/Feb/2025:03:39:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:38.969723
457	info	::1 - - [25/Feb/2025:03:39:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:38.973502
458	info	::1 - - [25/Feb/2025:03:39:40 +0000] "POST /loans/borrow HTTP/1.1" 500 41 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:40.191749
459	info	::1 - - [25/Feb/2025:03:39:53 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:53.120758
460	info	::1 - - [25/Feb/2025:03:39:53 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:53.122786
461	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 21:39:58.5974
462	info	::1 - - [25/Feb/2025:03:39:58 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:58.598252
463	info	::1 - - [25/Feb/2025:03:39:58 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:58.613425
464	info	::1 - - [25/Feb/2025:03:39:58 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:39:58.615575
465	info	::1 - - [25/Feb/2025:03:40:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:00.948592
1241	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-28 21:26:10.138994
466	info	::1 - - [25/Feb/2025:03:40:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:00.950382
467	info	::1 - - [25/Feb/2025:03:40:02 +0000] "POST /loans/borrow HTTP/1.1" 500 41 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:02.461246
468	info	::1 - - [25/Feb/2025:03:40:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:07.602715
469	info	::1 - - [25/Feb/2025:03:40:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:07.607884
470	info	::1 - - [25/Feb/2025:03:40:09 +0000] "POST /loans/borrow HTTP/1.1" 500 41 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:40:09.141579
471	info	::1 - - [25/Feb/2025:03:45:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:27.372972
472	info	::1 - - [25/Feb/2025:03:45:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:27.374804
473	info	::1 - - [25/Feb/2025:03:45:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:29.034936
474	info	::1 - - [25/Feb/2025:03:45:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:29.044406
475	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 21:45:35.202516
476	info	::1 - - [25/Feb/2025:03:45:35 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:35.203569
477	info	::1 - - [25/Feb/2025:03:45:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:35.219452
478	info	::1 - - [25/Feb/2025:03:45:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:35.22697
479	info	::1 - - [25/Feb/2025:03:45:35 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:35.228307
480	info	::1 - - [25/Feb/2025:03:45:35 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:35.232583
481	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-24 21:45:44.309855
482	info	::1 - - [25/Feb/2025:03:45:44 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:44.310472
483	info	::1 - - [25/Feb/2025:03:45:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:44.330034
484	info	::1 - - [25/Feb/2025:03:45:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:44.33157
485	info	::1 - - [25/Feb/2025:03:45:44 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:44.332677
486	info	::1 - - [25/Feb/2025:03:45:44 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:44.336967
487	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 21:45:49.402061
488	info	::1 - - [25/Feb/2025:03:45:49 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:49.402607
489	info	::1 - - [25/Feb/2025:03:45:49 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:49.416828
490	info	::1 - - [25/Feb/2025:03:45:49 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:49.418345
491	info	::1 - - [25/Feb/2025:03:45:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:51.747097
492	info	::1 - - [25/Feb/2025:03:45:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:51.749432
493	info	::1 - - [25/Feb/2025:03:45:53 +0000] "POST /loans/borrow HTTP/1.1" 500 41 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:45:53.766916
494	info	::1 - - [25/Feb/2025:03:51:27 +0000] "GET /books HTTP/1.1" 200 1393 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:51:27.270381
495	info	::1 - - [25/Feb/2025:03:51:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:51:27.277758
496	info	::1 - - [25/Feb/2025:03:51:29 +0000] "POST /loans/borrow HTTP/1.1" 500 41 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:51:29.215432
497	info	::1 - - [25/Feb/2025:03:53:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:16.742345
498	info	::1 - - [25/Feb/2025:03:53:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:16.743827
499	info	::1 - - [25/Feb/2025:03:53:18 +0000] "POST /loans/borrow HTTP/1.1" 201 48 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:18.777247
500	info	::1 - - [25/Feb/2025:03:53:23 +0000] "GET /loans HTTP/1.1" 200 485 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:23.530708
501	info	::1 - - [25/Feb/2025:03:53:23 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:23.534408
502	info	::1 - - [25/Feb/2025:03:53:25 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:25.548445
503	info	::1 - - [25/Feb/2025:03:53:27 +0000] "GET /books/latest HTTP/1.1" 200 1394 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:27.929637
504	info	::1 - - [25/Feb/2025:03:53:27 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:27.933252
505	info	::1 - - [25/Feb/2025:03:53:29 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:29.131454
506	info	::1 - - [25/Feb/2025:03:53:29 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:29.134475
507	info	::1 - - [25/Feb/2025:03:53:31 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:31.632356
508	info	::1 - - [25/Feb/2025:03:53:33 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:33.683279
509	info	::1 - - [25/Feb/2025:03:53:33 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:33.685189
510	info	::1 - - [25/Feb/2025:03:53:35 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:35.53593
511	info	::1 - - [25/Feb/2025:03:53:37 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:37.857109
512	info	::1 - - [25/Feb/2025:03:53:37 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:37.87514
513	info	::1 - - [25/Feb/2025:03:53:38 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:38.993148
514	info	::1 - - [25/Feb/2025:03:53:47 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:47.27702
515	info	::1 - - [25/Feb/2025:03:53:47 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:47.280144
516	info	::1 - - [25/Feb/2025:03:53:48 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:48.064121
517	info	::1 - - [25/Feb/2025:03:53:48 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:48.069185
518	info	::1 - - [25/Feb/2025:03:53:48 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:48.766488
519	info	::1 - - [25/Feb/2025:03:53:48 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:48.769112
520	info	::1 - - [25/Feb/2025:03:53:49 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:49.940508
521	info	::1 - - [25/Feb/2025:03:53:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:51.923879
522	info	::1 - - [25/Feb/2025:03:53:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:51.925276
523	info	::1 - - [25/Feb/2025:03:53:52 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:52.736485
524	info	::1 - - [25/Feb/2025:03:53:52 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:52.739034
525	info	::1 - - [25/Feb/2025:03:53:53 +0000] "PUT /loans/return/1 HTTP/1.1" 200 39 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 21:53:53.727046
526	info	::1 - - [25/Feb/2025:04:03:04 +0000] "GET /books HTTP/1.1" 200 1394 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:03:05.026809
527	info	::1 - - [25/Feb/2025:04:03:04 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:03:05.040876
528	info	::1 - - [25/Feb/2025:04:03:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:03:05.056174
529	info	::1 - - [25/Feb/2025:04:03:05 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:03:05.060744
530	info	::1 - - [25/Feb/2025:04:12:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:12:42.380373
531	info	::1 - - [25/Feb/2025:04:12:42 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:12:42.384657
532	info	::1 - - [25/Feb/2025:04:12:42 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:12:42.389502
533	info	::1 - - [25/Feb/2025:04:12:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:12:42.390535
534	info	::1 - - [25/Feb/2025:04:34:57 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:34:57.286014
535	info	::1 - - [25/Feb/2025:04:34:57 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:34:57.303068
536	info	::1 - - [25/Feb/2025:04:34:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:34:58.433921
537	info	::1 - - [25/Feb/2025:04:34:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:34:58.437327
538	info	::1 - - [25/Feb/2025:04:35:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:00.155984
539	info	::1 - - [25/Feb/2025:04:35:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:00.15799
540	info	::1 - - [25/Feb/2025:04:35:01 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:01.727486
541	info	::1 - - [25/Feb/2025:04:35:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:09.293365
542	info	::1 - - [25/Feb/2025:04:35:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:09.299171
543	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 22:35:14.14558
544	info	::1 - - [25/Feb/2025:04:35:14 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:14.146316
545	info	::1 - - [25/Feb/2025:04:35:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:14.167312
546	info	::1 - - [25/Feb/2025:04:35:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:14.168913
547	info	::1 - - [25/Feb/2025:04:35:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:15.671148
548	info	::1 - - [25/Feb/2025:04:35:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:15.681542
549	info	::1 - - [25/Feb/2025:04:35:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:17.032864
550	info	::1 - - [25/Feb/2025:04:35:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:17.036112
551	info	::1 - - [25/Feb/2025:04:35:19 +0000] "POST /loans/borrow HTTP/1.1" 201 48 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:19.096165
552	info	::1 - - [25/Feb/2025:04:35:23 +0000] "GET /loans HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:23.289058
553	info	::1 - - [25/Feb/2025:04:35:23 +0000] "GET /loans HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:35:23.291721
554	info	::1 - - [25/Feb/2025:04:39:53 +0000] "GET /loans HTTP/1.1" 200 1018 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:53.492608
555	info	::1 - - [25/Feb/2025:04:39:53 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:53.495717
556	info	::1 - - [25/Feb/2025:04:39:56 +0000] "GET /books/latest HTTP/1.1" 200 1395 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:56.5466
557	info	::1 - - [25/Feb/2025:04:39:56 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:56.548815
1351	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-03-01 21:01:35.105666
558	info	::1 - - [25/Feb/2025:04:39:58 +0000] "GET /books HTTP/1.1" 200 1395 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:58.446552
559	info	::1 - - [25/Feb/2025:04:39:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:58.44818
560	info	::1 - - [25/Feb/2025:04:39:59 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:59.624112
561	info	::1 - - [25/Feb/2025:04:39:59 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:39:59.626515
562	info	::1 - - [25/Feb/2025:04:40:01 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:01.130855
563	info	::1 - - [25/Feb/2025:04:40:03 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:03.605857
564	info	::1 - - [25/Feb/2025:04:40:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:06.160005
565	info	::1 - - [25/Feb/2025:04:40:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:06.163385
566	info	::1 - - [25/Feb/2025:04:40:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:07.238186
567	info	::1 - - [25/Feb/2025:04:40:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:07.239864
568	info	::1 - - [25/Feb/2025:04:40:08 +0000] "POST /loans/borrow HTTP/1.1" 201 48 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:08.314105
569	info	::1 - - [25/Feb/2025:04:40:10 +0000] "GET /loans HTTP/1.1" 200 1521 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:10.98088
570	info	::1 - - [25/Feb/2025:04:40:10 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:10.98426
571	info	::1 - - [25/Feb/2025:04:40:17 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:17.891994
572	info	::1 - - [25/Feb/2025:04:40:17 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:17.92288
573	info	::1 - - [25/Feb/2025:04:40:21 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:40:21.24185
574	info	::1 - - [25/Feb/2025:04:45:37 +0000] "GET /books HTTP/1.1" 200 1396 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:37.398998
575	info	::1 - - [25/Feb/2025:04:45:37 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:37.402512
576	info	::1 - - [25/Feb/2025:04:45:42 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:42.150163
577	info	::1 - - [25/Feb/2025:04:45:49 +0000] "GET /books/latest HTTP/1.1" 200 1396 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:49.28791
578	info	::1 - - [25/Feb/2025:04:45:49 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:49.292183
579	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 22:45:54.041082
580	info	::1 - - [25/Feb/2025:04:45:54 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:54.042176
581	info	::1 - - [25/Feb/2025:04:45:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:54.062923
582	info	::1 - - [25/Feb/2025:04:45:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:54.064428
583	info	::1 - - [25/Feb/2025:04:45:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:55.17202
584	info	::1 - - [25/Feb/2025:04:45:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:55.174411
585	info	::1 - - [25/Feb/2025:04:45:56 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:45:56.355549
586	info	::1 - - [25/Feb/2025:04:46:01 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:01.178217
587	info	::1 - - [25/Feb/2025:04:46:07 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:07.535047
1454	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-02 12:24:37.043675
588	info	::1 - - [25/Feb/2025:04:46:07 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:07.545551
589	info	::1 - - [25/Feb/2025:04:46:08 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:08.544739
590	info	::1 - - [25/Feb/2025:04:46:09 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:09.841446
591	info	::1 - - [25/Feb/2025:04:46:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:12.042749
592	info	::1 - - [25/Feb/2025:04:46:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:12.045723
593	info	::1 - - [25/Feb/2025:04:46:18 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:18.250884
594	info	::1 - - [25/Feb/2025:04:46:18 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:18.252718
595	info	::1 - - [25/Feb/2025:04:46:23 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:23.031126
596	info	::1 - - [25/Feb/2025:04:46:23 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:23.040074
597	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 22:46:27.468568
598	info	::1 - - [25/Feb/2025:04:46:27 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:27.471944
599	info	::1 - - [25/Feb/2025:04:46:27 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:27.487759
600	info	::1 - - [25/Feb/2025:04:46:27 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:27.491147
601	info	::1 - - [25/Feb/2025:04:46:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:28.336152
602	info	::1 - - [25/Feb/2025:04:46:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:28.341318
603	info	::1 - - [25/Feb/2025:04:46:29 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:29.334133
604	info	::1 - - [25/Feb/2025:04:46:33 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:33.056278
605	info	::1 - - [25/Feb/2025:04:46:33 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:33.060381
606	info	::1 - - [25/Feb/2025:04:46:34 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:34.675068
607	info	::1 - - [25/Feb/2025:04:46:36 +0000] "POST /loans/return HTTP/1.1" 404 152 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:46:36.213418
608	info	::1 - - [25/Feb/2025:04:50:05 +0000] "GET /loans HTTP/1.1" 403 53 "-" "curl/8.7.1"	2025-02-24 22:50:05.039058
609	info	::1 - - [25/Feb/2025:04:51:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:51:47.788804
610	info	::1 - - [25/Feb/2025:04:51:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:51:47.790644
611	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 22:51:55.098123
612	info	::1 - - [25/Feb/2025:04:51:55 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:51:55.099057
613	info	::1 - - [25/Feb/2025:04:51:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:51:55.11132
614	info	::1 - - [25/Feb/2025:04:51:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:51:55.113492
615	info	::1 - - [25/Feb/2025:04:53:29 +0000] "POST /loans/borrow HTTP/1.1" 403 40 "-" "curl/8.7.1"	2025-02-24 22:53:29.464623
616	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-24 22:54:44.944367
617	info	::1 - - [25/Feb/2025:04:54:44 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:44.950247
618	info	::1 - - [25/Feb/2025:04:54:44 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:44.958505
619	info	::1 - - [25/Feb/2025:04:54:44 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:44.958605
620	info	::1 - - [25/Feb/2025:04:54:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:46.033025
621	info	::1 - - [25/Feb/2025:04:54:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:46.03581
622	info	::1 - - [25/Feb/2025:04:54:47 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-24 22:54:47.086846
623	info	::1 - - [26/Feb/2025:00:10:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:10:02.73134
624	info	::1 - - [26/Feb/2025:00:10:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:10:02.742485
625	info	::1 - - [26/Feb/2025:00:12:02 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:02.75332
626	info	::1 - - [26/Feb/2025:00:12:02 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:02.756336
627	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 18:12:15.897462
628	info	::1 - - [26/Feb/2025:00:12:15 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:15.898568
629	info	::1 - - [26/Feb/2025:00:12:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:15.913921
630	info	::1 - - [26/Feb/2025:00:12:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:15.915744
631	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 18:12:22.178363
632	info	::1 - - [26/Feb/2025:00:12:22 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:22.179065
633	info	::1 - - [26/Feb/2025:00:12:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:22.196552
634	info	::1 - - [26/Feb/2025:00:12:22 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:22.197853
635	info	::1 - - [26/Feb/2025:00:12:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:22.199513
636	info	::1 - - [26/Feb/2025:00:12:22 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:22.201515
637	info	::1 - - [26/Feb/2025:00:12:50 +0000] "GET /logs HTTP/1.1" 200 28356 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:50.808035
638	info	::1 - - [26/Feb/2025:00:12:50 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:12:50.809441
639	info	::1 - - [26/Feb/2025:00:13:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:13:36.90533
640	info	::1 - - [26/Feb/2025:00:13:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:13:36.906746
641	info	::1 - - [26/Feb/2025:00:13:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:13:36.908661
642	info	::1 - - [26/Feb/2025:00:13:36 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:13:36.910182
643	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 18:15:03.748392
644	info	::1 - - [26/Feb/2025:00:15:03 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:03.74952
645	info	::1 - - [26/Feb/2025:00:15:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:03.7525
646	info	::1 - - [26/Feb/2025:00:15:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:03.75258
647	info	::1 - - [26/Feb/2025:00:15:09 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:09.283911
648	info	::1 - - [26/Feb/2025:00:15:09 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:09.285445
649	info	::1 - - [26/Feb/2025:00:15:11 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:11.800839
650	info	::1 - - [26/Feb/2025:00:15:14 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:14.579444
651	info	::1 - - [26/Feb/2025:00:15:36 +0000] "POST /loans/borrow HTTP/1.1" 400 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:36.474223
652	info	::1 - - [26/Feb/2025:00:15:52 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:52.791698
653	info	::1 - - [26/Feb/2025:00:15:52 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:52.793248
654	info	::1 - - [26/Feb/2025:00:15:57 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:57.120373
655	info	::1 - - [26/Feb/2025:00:15:57 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:57.12382
656	info	::1 - - [26/Feb/2025:00:15:58 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:58.719594
657	info	::1 - - [26/Feb/2025:00:15:58 +0000] "GET /loans HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:15:58.723384
658	info	::1 - - [26/Feb/2025:00:16:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:04.941759
659	info	::1 - - [26/Feb/2025:00:16:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:04.944182
660	info	::1 - - [26/Feb/2025:00:16:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:14.20249
661	info	::1 - - [26/Feb/2025:00:16:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:14.205255
662	info	::1 - - [26/Feb/2025:00:16:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:55.611656
663	info	::1 - - [26/Feb/2025:00:16:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:16:55.612988
664	info	::1 - - [26/Feb/2025:00:17:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:12.816431
665	info	::1 - - [26/Feb/2025:00:17:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:12.817851
666	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 18:17:17.066938
667	info	::1 - - [26/Feb/2025:00:17:17 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:17.069835
668	info	::1 - - [26/Feb/2025:00:17:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:17.096714
669	info	::1 - - [26/Feb/2025:00:17:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:17.097428
670	info	::1 - - [26/Feb/2025:00:17:17 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:17.098304
671	info	::1 - - [26/Feb/2025:00:17:17 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:17.101906
672	info	::1 - - [26/Feb/2025:00:17:18 +0000] "GET /logs HTTP/1.1" 200 28161 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:18.414473
673	info	::1 - - [26/Feb/2025:00:17:18 +0000] "GET /logs HTTP/1.1" 200 28164 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:17:18.419821
674	info	::1 - - [26/Feb/2025:00:32:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:16.603406
675	info	::1 - - [26/Feb/2025:00:32:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:16.606947
676	info	::1 - - [26/Feb/2025:00:32:16 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:16.60832
677	info	::1 - - [26/Feb/2025:00:32:16 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:16.611803
678	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 18:32:24.468261
679	info	::1 - - [26/Feb/2025:00:32:24 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:24.469056
680	info	::1 - - [26/Feb/2025:00:32:24 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:24.485758
681	info	::1 - - [26/Feb/2025:00:32:24 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:24.487021
682	info	::1 - - [26/Feb/2025:00:32:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:28.544804
683	info	::1 - - [26/Feb/2025:00:32:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:28.555018
1460	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-03-02 12:25:14.859762
684	info	::1 - - [26/Feb/2025:00:32:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:31.85472
685	info	::1 - - [26/Feb/2025:00:32:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:32:31.86879
686	info	::1 - - [26/Feb/2025:00:46:34 +0000] "GET /books/latest HTTP/1.1" - - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:34.995036
687	info	::1 - - [26/Feb/2025:00:46:35 +0000] "GET /books/latest HTTP/1.1" 200 1396 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:35.256247
688	info	::1 - - [26/Feb/2025:00:46:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:35.258749
689	info	::1 - - [26/Feb/2025:00:46:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:36.30459
690	info	::1 - - [26/Feb/2025:00:46:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:36.306717
691	info	::1 - - [26/Feb/2025:00:46:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:40.766389
692	info	::1 - - [26/Feb/2025:00:46:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:40.768587
693	info	::1 - - [26/Feb/2025:00:46:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:42.724414
694	info	::1 - - [26/Feb/2025:00:46:42 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:46:42.727694
695	info	::1 - - [26/Feb/2025:00:53:31 +0000] "GET /books HTTP/1.1" 200 1444 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:31.088993
696	info	::1 - - [26/Feb/2025:00:53:31 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:31.091889
697	info	::1 - - [26/Feb/2025:00:53:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:32.130046
698	info	::1 - - [26/Feb/2025:00:53:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:32.155339
699	info	::1 - - [26/Feb/2025:00:53:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:38.949123
700	info	::1 - - [26/Feb/2025:00:53:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:38.952073
701	info	::1 - - [26/Feb/2025:00:53:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:40.594588
702	info	::1 - - [26/Feb/2025:00:53:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 18:53:40.596218
703	info	::1 - - [26/Feb/2025:01:08:01 +0000] "GET /books/latest HTTP/1.1" 200 1444 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:01.649746
704	info	::1 - - [26/Feb/2025:01:08:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:01.660905
705	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 19:08:06.622172
706	info	::1 - - [26/Feb/2025:01:08:06 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:06.626077
707	info	::1 - - [26/Feb/2025:01:08:06 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:06.674827
708	info	::1 - - [26/Feb/2025:01:08:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:06.681017
709	info	::1 - - [26/Feb/2025:01:08:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:06.684715
710	info	::1 - - [26/Feb/2025:01:08:06 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:06.689959
711	info	::1 - - [26/Feb/2025:01:08:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:44.57809
712	info	::1 - - [26/Feb/2025:01:08:44 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:44.579523
713	info	::1 - - [26/Feb/2025:01:08:54 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:54.529932
1483	info	✅ Usuario autenticado: edsonalexisrodriguezibarra@gmail.com (ID: 5)	2025-03-04 18:00:09.187457
714	info	::1 - - [26/Feb/2025:01:08:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:08:54.53215
715	info	::1 - - [26/Feb/2025:01:09:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:00.514855
716	info	::1 - - [26/Feb/2025:01:09:00 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:00.517977
717	info	::1 - - [26/Feb/2025:01:09:05 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:05.509464
718	info	::1 - - [26/Feb/2025:01:09:05 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:05.515708
719	info	::1 - - [26/Feb/2025:01:09:12 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:12.517887
720	info	::1 - - [26/Feb/2025:01:09:12 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:12.532083
721	info	::1 - - [26/Feb/2025:01:09:15 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:15.523832
722	info	::1 - - [26/Feb/2025:01:09:15 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:15.52642
723	info	::1 - - [26/Feb/2025:01:09:19 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:19.519021
724	info	::1 - - [26/Feb/2025:01:09:19 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:19.522301
725	info	::1 - - [26/Feb/2025:01:09:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:23.517397
726	info	::1 - - [26/Feb/2025:01:09:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:23.521878
727	info	::1 - - [26/Feb/2025:01:09:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:27.510712
728	info	::1 - - [26/Feb/2025:01:09:27 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:27.51582
729	info	::1 - - [26/Feb/2025:01:09:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:33.524796
730	info	::1 - - [26/Feb/2025:01:09:33 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:33.537046
731	info	::1 - - [26/Feb/2025:01:09:39 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:39.514799
732	info	::1 - - [26/Feb/2025:01:09:39 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:39.518899
733	info	::1 - - [26/Feb/2025:01:09:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:43.512243
734	info	::1 - - [26/Feb/2025:01:09:43 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:09:43.515804
735	info	::1 - - [26/Feb/2025:01:10:18 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:18.575512
736	info	::1 - - [26/Feb/2025:01:10:18 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:18.578276
737	info	::1 - - [26/Feb/2025:01:10:41 +0000] "GET /books/undefined HTTP/1.1" 404 154 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:41.576849
738	info	::1 - - [26/Feb/2025:01:10:41 +0000] "GET /books/undefined HTTP/1.1" 404 154 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:41.578302
739	info	::1 - - [26/Feb/2025:01:10:41 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:41.583263
740	info	::1 - - [26/Feb/2025:01:10:41 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:10:41.58793
741	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 19:16:41.908757
742	info	::1 - - [26/Feb/2025:01:16:41 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:16:41.915719
743	info	::1 - - [26/Feb/2025:01:16:41 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:16:41.922567
1499	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-04 20:53:40.078949
744	info	::1 - - [26/Feb/2025:01:16:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:16:41.928127
745	info	::1 - - [26/Feb/2025:01:16:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:16:41.936031
746	info	::1 - - [26/Feb/2025:01:16:41 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:16:41.937396
747	info	::1 - - [26/Feb/2025:01:17:20 +0000] "POST /books HTTP/1.1" 400 47 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:17:20.289263
748	info	::1 - - [26/Feb/2025:01:25:59 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:25:59.674629
749	info	::1 - - [26/Feb/2025:01:25:59 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:25:59.679247
750	info	::1 - - [26/Feb/2025:01:25:59 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:25:59.682774
751	info	::1 - - [26/Feb/2025:01:25:59 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 19:25:59.685482
752	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 20:16:19.8295
753	info	::1 - - [26/Feb/2025:02:16:19 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:19.839341
754	info	::1 - - [26/Feb/2025:02:16:19 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:19.843647
755	info	::1 - - [26/Feb/2025:02:16:19 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:19.843815
756	info	::1 - - [26/Feb/2025:02:16:19 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:19.84664
757	info	::1 - - [26/Feb/2025:02:16:19 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:19.852993
758	info	::1 - - [26/Feb/2025:02:16:44 +0000] "POST /books HTTP/1.1" 500 212 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:16:44.948414
759	info	::1 - - [26/Feb/2025:02:19:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:19:02.223294
760	info	::1 - - [26/Feb/2025:02:19:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:19:02.225536
761	info	::1 - - [26/Feb/2025:02:19:12 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:19:12.199871
762	info	::1 - - [26/Feb/2025:02:19:12 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:19:12.203767
763	info	::1 - - [26/Feb/2025:02:21:46 +0000] "POST /books HTTP/1.1" 500 212 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:46.303085
764	info	::1 - - [26/Feb/2025:02:21:49 +0000] "GET /books HTTP/1.1" 200 1522 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:49.378778
765	info	::1 - - [26/Feb/2025:02:21:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:49.381708
766	info	::1 - - [26/Feb/2025:02:21:49 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:49.383151
767	info	::1 - - [26/Feb/2025:02:21:49 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:49.38686
768	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 20:21:52.842464
769	info	::1 - - [26/Feb/2025:02:21:52 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:52.847257
770	info	::1 - - [26/Feb/2025:02:21:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:52.8652
771	info	::1 - - [26/Feb/2025:02:21:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:52.866994
772	info	::1 - - [26/Feb/2025:02:21:52 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:52.870952
773	info	::1 - - [26/Feb/2025:02:21:52 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:21:52.875218
774	info	::1 - - [26/Feb/2025:02:22:11 +0000] "POST /books HTTP/1.1" 500 212 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:22:11.02989
775	info	::1 - - [26/Feb/2025:02:25:51 +0000] "POST /books HTTP/1.1" 500 212 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:25:51.132545
776	info	::1 - - [26/Feb/2025:02:29:26 +0000] "POST /books HTTP/1.1" 201 317 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:26.949425
777	info	::1 - - [26/Feb/2025:02:29:30 +0000] "GET /books HTTP/1.1" 200 1786 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:30.565879
778	info	::1 - - [26/Feb/2025:02:29:30 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:30.582741
779	info	::1 - - [26/Feb/2025:02:29:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:30.588737
780	info	::1 - - [26/Feb/2025:02:29:30 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:30.593285
781	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 20:29:33.743568
782	info	::1 - - [26/Feb/2025:02:29:33 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:33.746122
783	info	::1 - - [26/Feb/2025:02:29:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:33.759064
784	info	::1 - - [26/Feb/2025:02:29:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:33.761026
785	info	::1 - - [26/Feb/2025:02:29:33 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:33.762792
786	info	::1 - - [26/Feb/2025:02:29:33 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:33.767017
787	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 20:29:43.952013
788	info	::1 - - [26/Feb/2025:02:29:43 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:43.954323
789	info	::1 - - [26/Feb/2025:02:29:43 +0000] "GET /books/latest HTTP/1.1" 200 1284 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:43.96911
790	info	::1 - - [26/Feb/2025:02:29:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:43.975308
791	info	::1 - - [26/Feb/2025:02:29:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:47.469061
792	info	::1 - - [26/Feb/2025:02:29:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:29:47.470819
793	info	::1 - - [26/Feb/2025:02:31:09 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:31:09.208331
794	info	::1 - - [26/Feb/2025:02:31:09 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:31:09.211685
795	info	::1 - - [26/Feb/2025:02:31:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:31:32.210871
796	info	::1 - - [26/Feb/2025:02:31:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:31:32.213717
797	info	::1 - - [26/Feb/2025:02:35:56 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:35:56.342103
798	info	::1 - - [26/Feb/2025:02:35:56 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:35:56.346512
799	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 20:36:02.436801
800	info	::1 - - [26/Feb/2025:02:36:02 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:02.439958
801	info	::1 - - [26/Feb/2025:02:36:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:02.454368
802	info	::1 - - [26/Feb/2025:02:36:02 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:02.486086
803	info	::1 - - [26/Feb/2025:02:36:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:02.490331
804	info	::1 - - [26/Feb/2025:02:36:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:02.49279
805	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 20:36:13.377233
806	info	::1 - - [26/Feb/2025:02:36:13 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:13.379629
807	info	::1 - - [26/Feb/2025:02:36:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:13.393837
808	info	::1 - - [26/Feb/2025:02:36:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:13.398022
809	info	::1 - - [26/Feb/2025:02:36:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:14.56236
810	info	::1 - - [26/Feb/2025:02:36:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:14.569191
811	info	::1 - - [26/Feb/2025:02:36:16 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:16.779337
812	info	::1 - - [26/Feb/2025:02:36:16 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:16.780823
813	info	::1 - - [26/Feb/2025:02:36:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:54.286296
814	info	::1 - - [26/Feb/2025:02:36:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:54.287698
815	info	::1 - - [26/Feb/2025:02:36:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:55.842562
816	info	::1 - - [26/Feb/2025:02:36:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:36:55.843822
817	info	::1 - - [26/Feb/2025:02:37:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:37:06.200004
818	info	::1 - - [26/Feb/2025:02:37:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:37:06.202279
819	info	::1 - - [26/Feb/2025:02:39:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:39:22.906176
820	info	::1 - - [26/Feb/2025:02:39:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:39:22.908098
821	info	::1 - - [26/Feb/2025:02:48:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:48:04.952171
822	info	::1 - - [26/Feb/2025:02:48:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:48:04.974456
823	info	::1 - - [26/Feb/2025:02:48:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:48:20.019522
824	info	::1 - - [26/Feb/2025:02:48:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:48:20.022952
825	info	::1 - - [26/Feb/2025:02:50:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:50:45.764196
826	info	::1 - - [26/Feb/2025:02:50:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 20:50:45.801489
827	info	::1 - - [26/Feb/2025:03:03:45 +0000] "GET /books HTTP/1.1" 200 559 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:03:45.998741
828	info	::1 - - [26/Feb/2025:03:03:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:03:46.001054
829	info	::1 - - [26/Feb/2025:03:08:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:08:27.946244
830	info	::1 - - [26/Feb/2025:03:08:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:08:27.96081
831	info	::1 - - [26/Feb/2025:03:09:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:41.125042
832	info	::1 - - [26/Feb/2025:03:09:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:41.130713
833	info	::1 - - [26/Feb/2025:03:09:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:54.320116
834	info	::1 - - [26/Feb/2025:03:09:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:54.321317
835	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 21:09:58.638223
836	info	::1 - - [26/Feb/2025:03:09:58 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:58.643812
837	info	::1 - - [26/Feb/2025:03:09:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:58.659339
838	info	::1 - - [26/Feb/2025:03:09:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:58.66067
839	info	::1 - - [26/Feb/2025:03:09:58 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:58.668646
840	info	::1 - - [26/Feb/2025:03:09:58 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:09:58.673629
841	info	::1 - - [26/Feb/2025:03:10:13 +0000] "POST /books HTTP/1.1" 201 314 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:13.198924
842	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 21:10:19.32485
843	info	::1 - - [26/Feb/2025:03:10:19 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:19.325792
844	info	::1 - - [26/Feb/2025:03:10:19 +0000] "GET /books/latest HTTP/1.1" 200 1056 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:19.35577
845	info	::1 - - [26/Feb/2025:03:10:19 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:19.357516
846	info	::1 - - [26/Feb/2025:03:10:22 +0000] "GET /books HTTP/1.1" 200 721 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:22.580042
847	info	::1 - - [26/Feb/2025:03:10:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:22.581491
848	info	::1 - - [26/Feb/2025:03:10:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:27.768115
849	info	::1 - - [26/Feb/2025:03:10:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:10:27.772717
850	info	::1 - - [26/Feb/2025:03:11:39 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:11:39.159762
851	info	::1 - - [26/Feb/2025:03:11:39 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:11:39.161564
852	info	::1 - - [26/Feb/2025:03:11:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:11:54.69891
853	info	::1 - - [26/Feb/2025:03:11:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:11:54.712754
854	info	::1 - - [26/Feb/2025:03:18:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:18:51.166253
855	info	::1 - - [26/Feb/2025:03:18:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:18:51.168254
856	info	::1 - - [26/Feb/2025:03:19:21 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:19:21.192409
857	info	::1 - - [26/Feb/2025:03:19:21 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:19:21.209289
858	info	::1 - - [26/Feb/2025:03:20:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:20:49.155315
859	info	::1 - - [26/Feb/2025:03:20:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:20:49.157132
860	info	::1 - - [26/Feb/2025:03:25:19 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:19.099857
861	info	::1 - - [26/Feb/2025:03:25:19 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:19.108395
862	info	::1 - - [26/Feb/2025:03:25:25 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:25.616604
863	info	::1 - - [26/Feb/2025:03:25:25 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:25.630051
864	info	::1 - - [26/Feb/2025:03:25:27 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:27.280837
865	info	::1 - - [26/Feb/2025:03:25:27 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:27.283532
866	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 21:25:31.477041
867	info	::1 - - [26/Feb/2025:03:25:31 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:31.48049
868	info	::1 - - [26/Feb/2025:03:25:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:31.493123
869	info	::1 - - [26/Feb/2025:03:25:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:31.494894
870	info	::1 - - [26/Feb/2025:03:25:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:32.851045
871	info	::1 - - [26/Feb/2025:03:25:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:25:32.852669
872	info	::1 - - [26/Feb/2025:03:31:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:31:24.163843
873	info	::1 - - [26/Feb/2025:03:31:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:31:24.165582
874	info	::1 - - [26/Feb/2025:03:31:31 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:31:31.42254
875	info	::1 - - [26/Feb/2025:03:31:31 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:31:31.426898
876	info	::1 - - [26/Feb/2025:03:33:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:33:02.202541
877	info	::1 - - [26/Feb/2025:03:33:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:33:02.205764
878	info	::1 - - [26/Feb/2025:03:34:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:34:33.150118
879	info	::1 - - [26/Feb/2025:03:34:33 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:34:33.151786
880	info	::1 - - [26/Feb/2025:03:35:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:30.447954
881	info	::1 - - [26/Feb/2025:03:35:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:30.449794
882	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 21:35:37.821811
883	info	::1 - - [26/Feb/2025:03:35:37 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:37.822755
884	info	::1 - - [26/Feb/2025:03:35:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:37.844047
885	info	::1 - - [26/Feb/2025:03:35:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:37.846231
886	info	::1 - - [26/Feb/2025:03:35:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:38.806224
887	info	::1 - - [26/Feb/2025:03:35:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:35:38.808119
888	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-25 21:37:24.883269
889	info	::1 - - [26/Feb/2025:03:37:24 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:24.885034
890	info	::1 - - [26/Feb/2025:03:37:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:24.893079
891	info	::1 - - [26/Feb/2025:03:37:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:24.894206
892	info	::1 - - [26/Feb/2025:03:37:24 +0000] "GET /dashboard HTTP/1.1" 200 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:24.902694
893	info	::1 - - [26/Feb/2025:03:37:24 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:24.908518
894	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 21:37:30.642401
895	info	::1 - - [26/Feb/2025:03:37:30 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:30.643191
896	info	::1 - - [26/Feb/2025:03:37:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:30.659232
897	info	::1 - - [26/Feb/2025:03:37:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:30.660251
898	info	::1 - - [26/Feb/2025:03:37:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:32.000852
899	info	::1 - - [26/Feb/2025:03:37:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:37:32.005102
900	info	::1 - - [26/Feb/2025:03:48:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:45.428964
901	info	::1 - - [26/Feb/2025:03:48:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:45.438103
902	info	::1 - - [26/Feb/2025:03:48:46 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:46.689819
903	info	::1 - - [26/Feb/2025:03:48:46 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:46.695134
904	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-25 21:48:51.404971
905	info	::1 - - [26/Feb/2025:03:48:51 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:51.405677
906	info	::1 - - [26/Feb/2025:03:48:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:51.425162
907	info	::1 - - [26/Feb/2025:03:48:51 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:51.427063
908	info	::1 - - [26/Feb/2025:03:48:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:52.460054
909	info	::1 - - [26/Feb/2025:03:48:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-25 21:48:52.463851
910	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 18:41:59.992748
911	info	::1 - - [27/Feb/2025:00:41:59 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:00.003509
912	info	::1 - - [27/Feb/2025:00:42:00 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:00.009116
913	info	::1 - - [27/Feb/2025:00:41:59 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:00.008973
914	info	::1 - - [27/Feb/2025:00:42:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:01.226483
915	info	::1 - - [27/Feb/2025:00:42:01 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:01.228441
916	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 18:42:34.289366
917	info	::1 - - [27/Feb/2025:00:42:34 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:34.290684
918	info	::1 - - [27/Feb/2025:00:42:34 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:34.314984
919	info	::1 - - [27/Feb/2025:00:42:34 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:34.31769
920	info	::1 - - [27/Feb/2025:00:42:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:35.359954
921	info	::1 - - [27/Feb/2025:00:42:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:42:35.361622
922	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 18:45:43.751997
923	info	::1 - - [27/Feb/2025:00:45:43 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:43.756412
924	info	::1 - - [27/Feb/2025:00:45:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:43.773425
925	info	::1 - - [27/Feb/2025:00:45:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:43.774817
926	info	::1 - - [27/Feb/2025:00:45:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:44.977131
927	info	::1 - - [27/Feb/2025:00:45:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:44.979444
928	info	::1 - - [27/Feb/2025:00:45:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:56.60571
929	info	::1 - - [27/Feb/2025:00:45:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:45:56.612677
930	info	::1 - - [27/Feb/2025:00:47:52 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:47:52.506084
931	info	::1 - - [27/Feb/2025:00:48:13 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:48:13.666712
932	info	::1 - - [27/Feb/2025:00:49:16 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:16.168512
933	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 18:49:54.186572
934	info	::1 - - [27/Feb/2025:00:49:54 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:54.190609
935	info	::1 - - [27/Feb/2025:00:49:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:54.2141
936	info	::1 - - [27/Feb/2025:00:49:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:54.217105
937	info	::1 - - [27/Feb/2025:00:49:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:58.735299
938	info	::1 - - [27/Feb/2025:00:49:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:49:58.739599
939	info	::1 - - [27/Feb/2025:00:50:00 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:50:00.458986
940	info	::1 - - [27/Feb/2025:00:55:49 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:55:49.965924
941	info	::1 - - [27/Feb/2025:00:55:59 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 18:55:59.094105
942	info	::1 - - [27/Feb/2025:01:02:04 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:02:04.615364
943	info	::1 - - [27/Feb/2025:01:04:29 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:04:29.275315
944	info	::1 - - [27/Feb/2025:01:04:32 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 404 167 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:04:32.393534
945	info	::1 - - [27/Feb/2025:01:04:45 +0000] "GET / HTTP/1.1" 404 139 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:04:45.436186
946	info	::1 - - [27/Feb/2025:01:08:36 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 200 5580046 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:36.279634
947	info	::1 - - [27/Feb/2025:01:08:36 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:36.290573
948	info	::1 - - [27/Feb/2025:01:08:36 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:36.293072
949	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 19:08:40.512393
950	info	::1 - - [27/Feb/2025:01:08:40 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:40.513225
951	info	::1 - - [27/Feb/2025:01:08:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:40.532976
952	info	::1 - - [27/Feb/2025:01:08:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:40.53458
953	info	::1 - - [27/Feb/2025:01:08:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:41.722158
954	info	::1 - - [27/Feb/2025:01:08:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:41.726714
955	info	::1 - - [27/Feb/2025:01:08:46 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 206 1 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:46.162134
956	info	::1 - - [27/Feb/2025:01:08:53 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 206 1 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:08:53.434162
957	info	::1 - - [27/Feb/2025:01:10:06 +0000] "GET /uploads/NOMBRE_DEL_ARCHIVO.pdf HTTP/1.1" 404 169 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:10:06.701159
958	info	::1 - - [27/Feb/2025:01:10:58 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 206 1 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:10:58.052018
959	info	::1 - - [27/Feb/2025:01:11:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:01.335635
960	info	::1 - - [27/Feb/2025:01:11:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:01.342815
961	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 19:11:05.216478
962	info	::1 - - [27/Feb/2025:01:11:05 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:05.220012
963	info	::1 - - [27/Feb/2025:01:11:05 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:05.232846
964	info	::1 - - [27/Feb/2025:01:11:05 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:05.234334
965	info	::1 - - [27/Feb/2025:01:11:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:06.279011
966	info	::1 - - [27/Feb/2025:01:11:06 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:06.283568
967	info	::1 - - [27/Feb/2025:01:11:08 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 200 5580046 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:08.669315
968	info	::1 - - [27/Feb/2025:01:11:19 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:19.266829
969	info	::1 - - [27/Feb/2025:01:11:19 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:19.268094
970	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-26 19:11:24.504095
971	info	::1 - - [27/Feb/2025:01:11:24 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:24.507487
972	info	::1 - - [27/Feb/2025:01:11:24 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:24.5255
973	info	::1 - - [27/Feb/2025:01:11:24 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:24.52683
974	info	::1 - - [27/Feb/2025:01:11:25 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:25.579052
975	info	::1 - - [27/Feb/2025:01:11:25 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:25.580625
976	info	::1 - - [27/Feb/2025:01:11:29 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:29.732846
977	info	::1 - - [27/Feb/2025:01:11:55 +0000] "GET /uploads/1740539413154-IT.pdf HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:11:55.433115
978	info	::1 - - [27/Feb/2025:01:12:33 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:33.435858
979	info	::1 - - [27/Feb/2025:01:12:33 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:33.438997
980	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:12:52.24137
981	info	::1 - - [27/Feb/2025:01:12:52 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:52.242948
982	info	::1 - - [27/Feb/2025:01:12:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:52.255837
983	info	::1 - - [27/Feb/2025:01:12:52 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:52.262133
984	info	::1 - - [27/Feb/2025:01:12:52 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:52.265652
985	info	::1 - - [27/Feb/2025:01:12:52 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:12:52.271808
986	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:13:28.749159
987	info	::1 - - [27/Feb/2025:01:13:28 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:28.750903
988	info	::1 - - [27/Feb/2025:01:13:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:28.764034
989	info	::1 - - [27/Feb/2025:01:13:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:28.764989
990	info	::1 - - [27/Feb/2025:01:13:28 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:28.771947
991	info	::1 - - [27/Feb/2025:01:13:28 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:28.776879
992	info	::1 - - [27/Feb/2025:01:13:42 +0000] "GET /logs HTTP/1.1" 200 28138 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:42.150007
993	info	::1 - - [27/Feb/2025:01:13:42 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:42.151287
994	info	::1 - - [27/Feb/2025:01:13:44 +0000] "GET /logs HTTP/1.1" 200 28131 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:44.930695
995	info	::1 - - [27/Feb/2025:01:13:44 +0000] "GET /logs HTTP/1.1" 200 28299 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:44.935733
997	info	::1 - - [27/Feb/2025:01:13:51 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:51.381981
998	info	::1 - - [27/Feb/2025:01:13:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:51.403181
999	info	::1 - - [27/Feb/2025:01:13:51 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:51.404274
1000	info	::1 - - [27/Feb/2025:01:13:51 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:51.410656
1001	info	::1 - - [27/Feb/2025:01:13:51 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:13:51.414868
1002	info	::1 - - [27/Feb/2025:01:18:03 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:18:03.91841
1003	info	::1 - - [27/Feb/2025:01:18:21 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:18:21.823718
1004	info	::1 - - [27/Feb/2025:01:18:32 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:18:32.857623
1005	info	::1 - - [27/Feb/2025:01:18:53 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:18:53.820863
1006	info	::1 - - [27/Feb/2025:01:19:09 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:19:09.192113
1007	info	::1 - - [27/Feb/2025:01:19:30 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:19:30.365324
1008	info	::1 - - [27/Feb/2025:01:19:36 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:19:36.501163
1009	info	::1 - - [27/Feb/2025:01:19:50 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:19:50.026612
1010	info	::1 - - [27/Feb/2025:01:21:40 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:21:40.685474
1011	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:22:14.979593
1012	info	::1 - - [27/Feb/2025:01:22:14 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:22:14.982743
1013	info	::1 - - [27/Feb/2025:01:22:15 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:22:15.004759
1014	info	::1 - - [27/Feb/2025:01:22:15 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:22:15.0063
1015	info	::1 - - [27/Feb/2025:01:22:15 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:22:15.015739
1016	info	::1 - - [27/Feb/2025:01:22:15 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:22:15.021532
1017	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:42:43.552688
1018	info	::1 - - [27/Feb/2025:01:42:43 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:43.568638
1019	info	::1 - - [27/Feb/2025:01:42:43 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:43.571676
1020	info	::1 - - [27/Feb/2025:01:42:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:43.572521
1021	info	::1 - - [27/Feb/2025:01:42:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:43.572579
1022	info	::1 - - [27/Feb/2025:01:42:43 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:43.576168
1023	info	::1 - - [27/Feb/2025:01:42:44 +0000] "GET /logs HTTP/1.1" 200 28503 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:44.618775
1024	info	::1 - - [27/Feb/2025:01:42:44 +0000] "GET /logs HTTP/1.1" 200 28499 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:44.623309
1025	info	::1 - - [27/Feb/2025:01:42:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:56.445217
1026	info	::1 - - [27/Feb/2025:01:42:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:56.44717
1027	info	::1 - - [27/Feb/2025:01:42:56 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:56.452292
1028	info	::1 - - [27/Feb/2025:01:42:56 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:42:56.453175
1029	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-26 19:54:27.554059
1030	info	::1 - - [27/Feb/2025:01:54:27 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:27.566246
1031	info	::1 - - [27/Feb/2025:01:54:27 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:27.569863
1032	info	::1 - - [27/Feb/2025:01:54:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:27.570815
1033	info	::1 - - [27/Feb/2025:01:54:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:27.570871
1034	info	::1 - - [27/Feb/2025:01:54:27 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:27.574352
1035	info	::1 - - [27/Feb/2025:01:54:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:28.96617
1036	info	::1 - - [27/Feb/2025:01:54:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:28.968367
1037	info	::1 - - [27/Feb/2025:01:54:52 +0000] "PUT /books/1 HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:52.501322
1038	info	::1 - - [27/Feb/2025:01:54:57 +0000] "PUT /books/1 HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:54:57.197352
1039	info	::1 - - [27/Feb/2025:01:55:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:00.129985
1040	info	::1 - - [27/Feb/2025:01:55:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:00.131497
1041	info	::1 - - [27/Feb/2025:01:55:04 +0000] "PUT /books/1 HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:04.948251
1042	info	::1 - - [27/Feb/2025:01:55:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:14.695443
1043	info	::1 - - [27/Feb/2025:01:55:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:14.706883
1044	info	::1 - - [27/Feb/2025:01:55:35 +0000] "PUT /books/3 HTTP/1.1" 403 53 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 19:55:35.279766
1045	info	::1 - - [27/Feb/2025:02:17:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:28.282887
1046	info	::1 - - [27/Feb/2025:02:17:28 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:28.292742
1047	info	::1 - - [27/Feb/2025:02:17:34 +0000] "PUT /books/3 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:34.91506
1048	info	::1 - - [27/Feb/2025:02:17:36 +0000] "GET /books HTTP/1.1" 200 723 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:36.724274
1049	info	::1 - - [27/Feb/2025:02:17:44 +0000] "PUT /books/1 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:44.267197
1050	info	::1 - - [27/Feb/2025:02:17:45 +0000] "GET /books HTTP/1.1" 200 723 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:45.564548
1051	info	::1 - - [27/Feb/2025:02:17:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:54.457192
1052	info	::1 - - [27/Feb/2025:02:17:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:17:54.462061
1053	info	::1 - - [27/Feb/2025:02:19:39 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:19:39.596831
1054	info	::1 - - [27/Feb/2025:02:19:39 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:19:39.603867
1055	info	::1 - - [27/Feb/2025:02:19:47 +0000] "PUT /books/5 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:19:47.59911
1056	info	::1 - - [27/Feb/2025:02:19:48 +0000] "GET /books HTTP/1.1" 200 720 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:19:48.868237
1057	info	::1 - - [27/Feb/2025:02:32:55 +0000] "GET /books HTTP/1.1" 200 1658 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:32:55.718837
1058	info	::1 - - [27/Feb/2025:02:32:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:32:55.725432
1059	info	::1 - - [27/Feb/2025:02:34:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:34:02.689683
1060	info	::1 - - [27/Feb/2025:02:34:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:34:02.691852
1061	info	::1 - - [27/Feb/2025:02:34:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:34:55.675648
1062	info	::1 - - [27/Feb/2025:02:34:55 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:34:55.678171
1063	info	::1 - - [27/Feb/2025:02:35:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:04.634834
1064	info	::1 - - [27/Feb/2025:02:35:04 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:04.643678
1065	info	::1 - - [27/Feb/2025:02:35:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:07.626037
1066	info	::1 - - [27/Feb/2025:02:35:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:07.629256
1067	info	::1 - - [27/Feb/2025:02:35:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:32.681081
1068	info	::1 - - [27/Feb/2025:02:35:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:35:32.686045
1069	info	::1 - - [27/Feb/2025:02:36:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:17.649044
1070	info	::1 - - [27/Feb/2025:02:36:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:17.651658
1071	info	::1 - - [27/Feb/2025:02:36:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:20.613921
1072	info	::1 - - [27/Feb/2025:02:36:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:20.615481
1073	info	::1 - - [27/Feb/2025:02:36:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:22.626514
1074	info	::1 - - [27/Feb/2025:02:36:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:22.628337
1075	info	::1 - - [27/Feb/2025:02:36:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:24.619514
1076	info	::1 - - [27/Feb/2025:02:36:24 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:24.621863
1077	info	::1 - - [27/Feb/2025:02:36:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:27.621377
1078	info	::1 - - [27/Feb/2025:02:36:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:27.623267
1079	info	::1 - - [27/Feb/2025:02:36:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:38.655278
1080	info	::1 - - [27/Feb/2025:02:36:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:38.657501
1081	info	::1 - - [27/Feb/2025:02:36:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:43.623102
1082	info	::1 - - [27/Feb/2025:02:36:43 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:43.626081
1083	info	::1 - - [27/Feb/2025:02:36:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:44.621015
1084	info	::1 - - [27/Feb/2025:02:36:44 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:44.624283
1085	info	::1 - - [27/Feb/2025:02:36:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:46.626208
1086	info	::1 - - [27/Feb/2025:02:36:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:36:46.628378
1087	info	::1 - - [27/Feb/2025:02:37:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:37:27.845172
1088	info	::1 - - [27/Feb/2025:02:37:27 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-26 20:37:27.867605
1089	info	::1 - - [28/Feb/2025:02:55:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 20:55:56.370169
1090	info	::1 - - [28/Feb/2025:02:55:56 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 20:55:56.373936
1091	info	::1 - - [28/Feb/2025:03:07:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:07:03.701232
1092	info	::1 - - [28/Feb/2025:03:07:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:07:03.703451
1093	info	::1 - - [28/Feb/2025:03:31:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:31:35.235577
1094	info	::1 - - [28/Feb/2025:03:31:35 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:31:35.239687
1095	info	::1 - - [28/Feb/2025:03:41:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:41:23.596105
1096	info	::1 - - [28/Feb/2025:03:41:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:41:23.599157
1097	info	::1 - - [28/Feb/2025:03:46:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:20.594402
1098	info	::1 - - [28/Feb/2025:03:46:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:20.597081
1099	info	::1 - - [28/Feb/2025:03:46:26 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:26.572487
1100	info	::1 - - [28/Feb/2025:03:46:26 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:26.574211
1101	info	::1 - - [28/Feb/2025:03:46:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:49.937645
1102	info	::1 - - [28/Feb/2025:03:46:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:46:49.940005
1103	info	::1 - - [28/Feb/2025:03:47:57 +0000] "PUT /books/4 HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:47:57.767214
1104	info	::1 - - [28/Feb/2025:03:49:29 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:29.751858
1105	info	::1 - - [28/Feb/2025:03:49:29 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:29.754599
1106	info	::1 - - [28/Feb/2025:03:49:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:29.756078
1107	info	::1 - - [28/Feb/2025:03:49:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:29.758945
1108	info	::1 - - [28/Feb/2025:03:49:32 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:32.303875
1109	info	::1 - - [28/Feb/2025:03:49:32 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:32.323868
1110	info	::1 - - [28/Feb/2025:03:49:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:32.350358
1111	info	::1 - - [28/Feb/2025:03:49:32 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:32.354432
1112	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-27 21:49:38.493053
1113	info	::1 - - [28/Feb/2025:03:49:38 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:38.528196
1114	info	::1 - - [28/Feb/2025:03:49:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:38.616515
1115	info	::1 - - [28/Feb/2025:03:49:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:38.630954
1116	info	::1 - - [28/Feb/2025:03:49:38 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:38.637839
1117	info	::1 - - [28/Feb/2025:03:49:38 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:38.646998
1118	info	::1 - - [28/Feb/2025:03:49:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:41.518534
1119	info	::1 - - [28/Feb/2025:03:49:41 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:49:41.524729
1120	info	::1 - - [28/Feb/2025:03:50:01 +0000] "PUT /books/4 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:01.068228
1121	info	::1 - - [28/Feb/2025:03:50:03 +0000] "GET /books HTTP/1.1" 200 1658 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:03.735538
1122	info	::1 - - [28/Feb/2025:03:50:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:07.667959
1123	info	::1 - - [28/Feb/2025:03:50:07 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:07.676254
1124	info	::1 - - [28/Feb/2025:03:50:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:07.678757
1125	info	::1 - - [28/Feb/2025:03:50:07 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:07.684349
1126	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-27 21:50:14.303839
1127	info	::1 - - [28/Feb/2025:03:50:14 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:14.308228
1128	info	::1 - - [28/Feb/2025:03:50:14 +0000] "GET /books/latest HTTP/1.1" 200 1055 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:14.327252
1129	info	::1 - - [28/Feb/2025:03:50:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:14.328776
1130	info	::1 - - [28/Feb/2025:03:50:15 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:15.896286
1131	info	::1 - - [28/Feb/2025:03:50:15 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:50:15.89792
1132	info	::1 - - [28/Feb/2025:03:53:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:15.526484
1133	info	::1 - - [28/Feb/2025:03:53:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:15.527925
1134	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-27 21:53:22.146339
1135	info	::1 - - [28/Feb/2025:03:53:22 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:22.147725
1136	info	::1 - - [28/Feb/2025:03:53:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:22.166986
1137	info	::1 - - [28/Feb/2025:03:53:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:22.168221
1138	info	::1 - - [28/Feb/2025:03:53:22 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:22.176315
1139	info	::1 - - [28/Feb/2025:03:53:22 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:22.180125
1140	info	::1 - - [28/Feb/2025:03:53:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:23.485984
1141	info	::1 - - [28/Feb/2025:03:53:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:23.48909
1142	info	::1 - - [28/Feb/2025:03:53:43 +0000] "PUT /books/3 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:43.936733
1143	info	::1 - - [28/Feb/2025:03:53:45 +0000] "GET /books HTTP/1.1" 200 1658 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:45.194842
1144	info	::1 - - [28/Feb/2025:03:53:53 +0000] "PUT /books/3 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:53.399584
1145	info	::1 - - [28/Feb/2025:03:53:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:53:54.92337
1146	info	::1 - - [28/Feb/2025:03:54:00 +0000] "PUT /books/5 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:00.681325
1147	info	::1 - - [28/Feb/2025:03:54:02 +0000] "GET /books HTTP/1.1" 200 1658 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:02.322586
1148	info	::1 - - [28/Feb/2025:03:54:12 +0000] "PUT /books/3 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:12.003714
1149	info	::1 - - [28/Feb/2025:03:54:13 +0000] "GET /books HTTP/1.1" 200 1658 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:13.30464
1150	info	::1 - - [28/Feb/2025:03:54:57 +0000] "PUT /books/2 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:57.674433
1151	info	::1 - - [28/Feb/2025:03:54:58 +0000] "GET /books HTTP/1.1" 200 1665 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:54:58.724516
1152	info	::1 - - [28/Feb/2025:03:55:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:20.250896
1153	info	::1 - - [28/Feb/2025:03:55:20 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:20.252789
1154	info	::1 - - [28/Feb/2025:03:55:20 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:20.256513
1155	info	::1 - - [28/Feb/2025:03:55:20 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:20.256877
1156	info	::1 - - [28/Feb/2025:03:55:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:47.618426
1157	info	::1 - - [28/Feb/2025:03:55:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:55:47.619432
1158	info	::1 - - [28/Feb/2025:03:56:04 +0000] "PUT /books/5 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:04.658634
1159	info	::1 - - [28/Feb/2025:03:56:06 +0000] "GET /books HTTP/1.1" 200 1665 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:06.251194
1160	info	::1 - - [28/Feb/2025:03:56:17 +0000] "PUT /books/4 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:17.906915
1161	info	::1 - - [28/Feb/2025:03:56:19 +0000] "GET /books HTTP/1.1" 200 1665 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:19.140429
1162	info	::1 - - [28/Feb/2025:03:56:45 +0000] "PUT /books/5 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:45.867579
1163	info	::1 - - [28/Feb/2025:03:56:47 +0000] "GET /books HTTP/1.1" 200 1665 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:47.43217
1164	info	::1 - - [28/Feb/2025:03:56:57 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:57.816064
1165	info	::1 - - [28/Feb/2025:03:56:57 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:57.817206
1166	info	::1 - - [28/Feb/2025:03:56:57 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:57.819553
1167	info	::1 - - [28/Feb/2025:03:56:57 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:56:57.825906
1168	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-27 21:57:21.011048
1169	info	::1 - - [28/Feb/2025:03:57:21 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:57:21.012879
1170	info	::1 - - [28/Feb/2025:03:57:21 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:57:21.024729
1171	info	::1 - - [28/Feb/2025:03:57:21 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:57:21.027679
1172	info	::1 - - [28/Feb/2025:03:57:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:57:22.859257
1173	info	::1 - - [28/Feb/2025:03:57:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 21:57:22.86072
1174	info	::1 - - [28/Feb/2025:04:08:08 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:08:08.439931
1175	info	::1 - - [28/Feb/2025:04:08:08 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:08:08.485276
1176	info	::1 - - [28/Feb/2025:04:11:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:11:58.763383
1177	info	::1 - - [28/Feb/2025:04:11:58 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:11:58.765252
1178	info	::1 - - [28/Feb/2025:04:27:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:27:54.073235
1179	info	::1 - - [28/Feb/2025:04:27:54 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-27 22:27:54.083142
1180	info	::1 - - [28/Feb/2025:23:56:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 17:56:06.228341
1181	info	::1 - - [28/Feb/2025:23:56:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 17:56:06.238105
1183	info	::1 - - [01/Mar/2025:00:32:15 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:15.669534
1184	info	::1 - - [01/Mar/2025:00:32:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:15.683813
1185	info	::1 - - [01/Mar/2025:00:32:15 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:15.68541
1186	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-28 18:32:23.458983
1187	info	::1 - - [01/Mar/2025:00:32:23 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:23.460616
1188	info	::1 - - [01/Mar/2025:00:32:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:23.477737
1189	info	::1 - - [01/Mar/2025:00:32:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:23.484657
1190	info	::1 - - [01/Mar/2025:00:32:23 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:23.494177
1191	info	::1 - - [01/Mar/2025:00:32:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:32:23.499406
1192	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-28 18:34:23.505178
1193	info	::1 - - [01/Mar/2025:00:34:23 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:23.512362
1194	info	::1 - - [01/Mar/2025:00:34:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:23.522072
1195	info	::1 - - [01/Mar/2025:00:34:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:23.523412
1196	info	::1 - - [01/Mar/2025:00:34:23 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:23.532184
1197	info	::1 - - [01/Mar/2025:00:34:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:23.539505
1198	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-28 18:34:28.810357
1199	info	::1 - - [01/Mar/2025:00:34:28 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:28.811403
1200	info	::1 - - [01/Mar/2025:00:34:28 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:28.839063
1201	info	::1 - - [01/Mar/2025:00:34:28 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:28.840043
1202	warn	⚠ Intento de login fallido para usuario@gmail.com	2025-02-28 18:34:34.275063
1203	info	::1 - - [01/Mar/2025:00:34:34 +0000] "POST /auth/login HTTP/1.1" 401 37 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:34.279532
1204	info	::1 - - [01/Mar/2025:00:34:42 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:34:42.092179
1205	info	::1 - - [01/Mar/2025:00:35:02 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:02.993664
1206	info	::1 - - [01/Mar/2025:00:35:05 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:05.974545
1207	info	::1 - - [01/Mar/2025:00:35:06 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:06.80723
1208	info	::1 - - [01/Mar/2025:00:35:09 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:09.644028
1209	info	::1 - - [01/Mar/2025:00:35:14 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:14.476754
1210	info	::1 - - [01/Mar/2025:00:35:17 +0000] "POST /auth/login HTTP/1.1" 429 87 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:17.858718
1211	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-28 18:35:39.811637
1212	info	::1 - - [01/Mar/2025:00:35:39 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:39.813105
1213	info	::1 - - [01/Mar/2025:00:35:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:39.865176
1214	info	::1 - - [01/Mar/2025:00:35:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:35:39.871606
1215	info	::1 - - [01/Mar/2025:00:46:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:46:40.325727
1216	info	::1 - - [01/Mar/2025:00:46:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 18:46:40.327943
1217	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-02-28 19:30:13.902098
1218	info	::1 - - [01/Mar/2025:01:30:13 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:30:13.938339
1219	info	::1 - - [01/Mar/2025:01:30:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:30:13.943544
1220	info	::1 - - [01/Mar/2025:01:30:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:30:13.943611
1221	info	::1 - - [01/Mar/2025:01:32:33 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:33.319032
1222	info	::1 - - [01/Mar/2025:01:32:33 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:33.320954
1223	info	::1 - - [01/Mar/2025:01:32:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:36.19814
1224	info	::1 - - [01/Mar/2025:01:32:36 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:36.200075
1225	info	::1 - - [01/Mar/2025:01:32:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:39.313229
1226	info	::1 - - [01/Mar/2025:01:32:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:32:39.315641
1227	info	::1 - - [01/Mar/2025:01:39:21 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:21.215259
1228	info	::1 - - [01/Mar/2025:01:39:21 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:21.217221
1229	info	::1 - - [01/Mar/2025:01:39:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:29.597959
1230	info	::1 - - [01/Mar/2025:01:39:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:29.613497
1231	info	::1 - - [01/Mar/2025:01:39:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:31.047785
1232	info	::1 - - [01/Mar/2025:01:39:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:31.049531
1233	info	::1 - - [01/Mar/2025:01:39:32 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:32.815325
1234	info	::1 - - [01/Mar/2025:01:39:32 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:39:32.826236
1235	info	::1 - - [01/Mar/2025:01:42:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:42:37.374006
1236	info	::1 - - [01/Mar/2025:01:42:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 19:42:37.375598
1237	info	::1 - - [01/Mar/2025:02:43:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 20:43:09.809309
1238	info	::1 - - [01/Mar/2025:02:43:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 20:43:09.814507
1239	info	::1 - - [01/Mar/2025:02:43:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 20:43:35.64629
1240	info	::1 - - [01/Mar/2025:02:43:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 20:43:35.64779
1242	info	::1 - - [01/Mar/2025:03:26:10 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:26:10.170644
1243	info	::1 - - [01/Mar/2025:03:26:10 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:26:10.175978
1245	info	::1 - - [01/Mar/2025:03:26:10 +0000] "GET /books HTTP/1.1" 200 2060 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:26:10.176393
1244	info	::1 - - [01/Mar/2025:03:26:10 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:26:10.176237
1246	info	::1 - - [01/Mar/2025:03:26:10 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:26:10.182164
1247	info	::1 - - [01/Mar/2025:03:28:04 +0000] "POST /books/upload-csv HTTP/1.1" 500 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:28:04.735852
1248	info	::1 - - [01/Mar/2025:03:28:22 +0000] "POST /books/upload-csv HTTP/1.1" 500 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:28:22.50943
1249	info	::1 - - [01/Mar/2025:03:39:24 +0000] "POST /books/upload-csv HTTP/1.1" 500 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:39:24.851185
1250	info	::1 - - [01/Mar/2025:03:41:32 +0000] "POST /books/upload-csv HTTP/1.1" 500 50 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:41:32.599912
1251	info	::1 - - [01/Mar/2025:03:42:21 +0000] "POST /books/upload-csv HTTP/1.1" 200 58 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:21.046808
1252	info	::1 - - [01/Mar/2025:03:42:31 +0000] "GET /books HTTP/1.1" 200 3797 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:31.501217
1253	info	::1 - - [01/Mar/2025:03:42:31 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:31.505175
1254	info	::1 - - [01/Mar/2025:03:42:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:31.510172
1255	info	::1 - - [01/Mar/2025:03:42:31 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:31.511688
1256	info	::1 - - [01/Mar/2025:03:42:37 +0000] "GET /logs HTTP/1.1" 200 28394 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:37.88788
1257	info	::1 - - [01/Mar/2025:03:42:37 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:37.905903
1258	info	::1 - - [01/Mar/2025:03:42:45 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:45.26821
1259	info	::1 - - [01/Mar/2025:03:42:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:45.279992
1260	info	::1 - - [01/Mar/2025:03:42:45 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:45.282397
1261	info	::1 - - [01/Mar/2025:03:42:45 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:45.285915
1262	info	::1 - - [01/Mar/2025:03:42:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:46.515854
1263	info	::1 - - [01/Mar/2025:03:42:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:46.518291
1264	info	::1 - - [01/Mar/2025:03:42:53 +0000] "PUT /books/2 HTTP/1.1" 200 43 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:53.435144
1265	info	::1 - - [01/Mar/2025:03:42:54 +0000] "GET /books HTTP/1.1" 200 3796 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:42:54.758365
1266	info	::1 - - [01/Mar/2025:03:43:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:03.886315
1267	info	::1 - - [01/Mar/2025:03:43:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:03.888512
1268	info	::1 - - [01/Mar/2025:03:43:03 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:03.896745
1269	info	::1 - - [01/Mar/2025:03:43:03 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:03.90201
1271	info	::1 - - [01/Mar/2025:03:43:20 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:20.176703
1272	info	::1 - - [01/Mar/2025:03:43:20 +0000] "GET /books/latest HTTP/1.1" 200 1006 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:20.181746
1273	info	::1 - - [01/Mar/2025:03:43:20 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:20.186821
1274	info	::1 - - [01/Mar/2025:03:43:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:29.924092
1275	info	::1 - - [01/Mar/2025:03:43:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:29.925673
1276	info	::1 - - [01/Mar/2025:03:43:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:37.509193
1277	info	::1 - - [01/Mar/2025:03:43:37 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:37.511863
1278	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-02-28 21:43:47.287189
1279	info	::1 - - [01/Mar/2025:03:43:47 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:47.290477
1280	info	::1 - - [01/Mar/2025:03:43:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:47.30967
1281	info	::1 - - [01/Mar/2025:03:43:47 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:47.310723
1282	info	::1 - - [01/Mar/2025:03:43:47 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:47.321688
1283	info	::1 - - [01/Mar/2025:03:43:47 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-02-28 21:43:47.32885
1284	info	::1 - - [01/Mar/2025:23:06:07 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:07.819259
1285	info	::1 - - [01/Mar/2025:23:06:07 +0000] "GET /dashboard HTTP/1.1" 403 40 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:07.840024
1286	info	::1 - - [01/Mar/2025:23:06:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:07.846333
1287	info	::1 - - [01/Mar/2025:23:06:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:07.8465
1288	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-01 17:06:17.761234
1289	info	::1 - - [01/Mar/2025:23:06:17 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:17.762447
1290	info	::1 - - [01/Mar/2025:23:06:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:17.781596
1291	info	::1 - - [01/Mar/2025:23:06:17 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:17.782858
1292	info	::1 - - [01/Mar/2025:23:06:17 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:17.794912
1293	info	::1 - - [01/Mar/2025:23:06:17 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:06:17.800056
1294	info	::1 - - [01/Mar/2025:23:08:50 +0000] "GET /books HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:50.982792
1295	info	::1 - - [01/Mar/2025:23:08:50 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:50.98474
1296	info	::1 - - [01/Mar/2025:23:08:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:50.989752
1297	info	::1 - - [01/Mar/2025:23:08:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:50.989889
1298	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-01 17:08:53.475873
1299	info	::1 - - [01/Mar/2025:23:08:53 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:53.482001
1300	info	::1 - - [01/Mar/2025:23:08:53 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:53.493399
1301	info	::1 - - [01/Mar/2025:23:08:53 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:53.494541
1302	info	::1 - - [01/Mar/2025:23:08:53 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:53.496971
1303	info	::1 - - [01/Mar/2025:23:08:53 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:08:53.502008
1304	info	::1 - - [01/Mar/2025:23:09:10 +0000] "POST /books/upload-csv HTTP/1.1" 200 60 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:10.664692
1305	info	::1 - - [01/Mar/2025:23:09:22 +0000] "GET /books HTTP/1.1" 200 107982 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:22.404998
1306	info	::1 - - [01/Mar/2025:23:09:22 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:22.406547
1307	info	::1 - - [01/Mar/2025:23:09:22 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:22.411392
1308	info	::1 - - [01/Mar/2025:23:09:22 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:22.423981
1310	info	::1 - - [01/Mar/2025:23:09:44 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:44.120082
1311	info	::1 - - [01/Mar/2025:23:09:44 +0000] "GET /books/latest HTTP/1.1" 200 604 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:44.124834
1312	info	::1 - - [01/Mar/2025:23:09:44 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:44.125684
1313	info	::1 - - [01/Mar/2025:23:09:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:46.230662
1314	info	::1 - - [01/Mar/2025:23:09:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:09:46.237972
1315	info	::1 - - [01/Mar/2025:23:10:36 +0000] "GET /books/latest HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:36.288301
1316	info	::1 - - [01/Mar/2025:23:10:36 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:36.290106
1317	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-01 17:10:40.343003
1318	info	::1 - - [01/Mar/2025:23:10:40 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:40.345085
1319	info	::1 - - [01/Mar/2025:23:10:40 +0000] "GET /books HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:40.361029
1320	info	::1 - - [01/Mar/2025:23:10:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:40.36886
1321	info	::1 - - [01/Mar/2025:23:10:40 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:40.370108
1322	info	::1 - - [01/Mar/2025:23:10:40 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:10:40.376337
1323	info	::1 - - [01/Mar/2025:23:11:44 +0000] "POST /books/upload-csv HTTP/1.1" 200 59 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:11:44.148125
1324	info	::1 - - [01/Mar/2025:23:11:50 +0000] "GET /books HTTP/1.1" 200 3637 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:11:50.992943
1325	info	::1 - - [01/Mar/2025:23:11:50 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:11:50.99552
1326	info	::1 - - [01/Mar/2025:23:11:50 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:11:51.000278
1327	info	::1 - - [01/Mar/2025:23:11:51 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:11:51.007726
1329	info	::1 - - [01/Mar/2025:23:12:01 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:12:01.71153
1330	info	::1 - - [01/Mar/2025:23:12:01 +0000] "GET /books/latest HTTP/1.1" 200 607 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:12:01.725037
1331	info	::1 - - [01/Mar/2025:23:12:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:12:01.726268
1332	info	::1 - - [01/Mar/2025:23:12:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:12:03.58479
1333	info	::1 - - [01/Mar/2025:23:12:03 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:12:03.586244
1334	info	::1 - - [01/Mar/2025:23:49:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:49:30.163837
1335	info	::1 - - [01/Mar/2025:23:49:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 17:49:30.213275
1336	info	::1 - - [02/Mar/2025:02:57:29 +0000] "GET /books HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:57:29.742538
1337	info	::1 - - [02/Mar/2025:02:57:29 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:57:29.744759
1338	info	::1 - - [02/Mar/2025:02:59:11 +0000] "GET /books/latest HTTP/1.1" 200 2 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:11.716148
1339	info	::1 - - [02/Mar/2025:02:59:11 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:11.718001
1340	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-01 20:59:16.349725
1341	info	::1 - - [02/Mar/2025:02:59:16 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:16.350583
1342	info	::1 - - [02/Mar/2025:02:59:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:16.366078
1343	info	::1 - - [02/Mar/2025:02:59:16 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:16.37354
1344	info	::1 - - [02/Mar/2025:02:59:16 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:16.374379
1345	info	::1 - - [02/Mar/2025:02:59:16 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 20:59:16.380442
1346	info	::1 - - [02/Mar/2025:03:01:19 +0000] "POST /books/upload-csv HTTP/1.1" 200 59 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:19.389517
1347	info	::1 - - [02/Mar/2025:03:01:23 +0000] "GET /books HTTP/1.1" 200 11260 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:23.851628
1348	info	::1 - - [02/Mar/2025:03:01:23 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:23.854494
1349	info	::1 - - [02/Mar/2025:03:01:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:23.874056
1350	info	::1 - - [02/Mar/2025:03:01:23 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:23.879998
1352	info	::1 - - [02/Mar/2025:03:01:35 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:35.1068
1353	info	::1 - - [02/Mar/2025:03:01:35 +0000] "GET /books/latest HTTP/1.1" 200 2091 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:35.117838
1354	info	::1 - - [02/Mar/2025:03:01:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:01:35.118761
1355	info	::1 - - [02/Mar/2025:03:02:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:02:00.992897
1356	info	::1 - - [02/Mar/2025:03:02:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:02:00.994452
1357	info	::1 - - [02/Mar/2025:03:02:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:02:47.993016
1358	info	::1 - - [02/Mar/2025:03:02:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:02:47.994387
1359	info	::1 - - [02/Mar/2025:03:05:46 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:05:46.245718
1360	info	::1 - - [02/Mar/2025:03:05:46 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:05:46.247469
1361	info	::1 - - [02/Mar/2025:03:06:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:06:54.287101
1362	info	::1 - - [02/Mar/2025:03:06:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:06:54.288905
1363	info	::1 - - [02/Mar/2025:03:13:26 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:13:26.287177
1364	info	::1 - - [02/Mar/2025:03:13:26 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:13:26.289723
1365	info	::1 - - [02/Mar/2025:03:14:16 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:14:16.395816
1366	info	::1 - - [02/Mar/2025:03:14:16 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:14:16.397077
1367	info	::1 - - [02/Mar/2025:03:17:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:17:29.161858
1368	info	::1 - - [02/Mar/2025:03:17:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:17:29.164146
1369	info	::1 - - [02/Mar/2025:03:27:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:27:29.731599
1370	info	::1 - - [02/Mar/2025:03:27:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:27:29.733704
1371	info	::1 - - [02/Mar/2025:03:51:57 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:51:57.380419
1372	info	::1 - - [02/Mar/2025:03:53:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:53:01.690455
1373	info	::1 - - [02/Mar/2025:03:53:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:53:01.692109
1374	info	::1 - - [02/Mar/2025:03:53:28 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:53:28.357645
1375	info	::1 - - [02/Mar/2025:03:54:08 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:54:08.900427
1376	info	::1 - - [02/Mar/2025:03:54:08 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:54:08.901906
1377	info	::1 - - [02/Mar/2025:03:57:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:57:30.331924
1378	info	::1 - - [02/Mar/2025:03:57:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:57:30.334467
1379	info	::1 - - [02/Mar/2025:03:58:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:06.360928
1380	info	::1 - - [02/Mar/2025:03:58:10 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:10.563047
1381	info	::1 - - [02/Mar/2025:03:58:10 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:10.56514
1382	info	::1 - - [02/Mar/2025:03:58:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:14.731948
1383	info	::1 - - [02/Mar/2025:03:58:14 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:14.740851
1384	info	::1 - - [02/Mar/2025:03:58:18 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:18.733168
1385	info	::1 - - [02/Mar/2025:03:58:18 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:18.734698
1386	info	::1 - - [02/Mar/2025:03:58:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:45.902889
1387	info	::1 - - [02/Mar/2025:03:58:45 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:45.904437
1388	info	::1 - - [02/Mar/2025:03:58:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:47.048185
1389	info	::1 - - [02/Mar/2025:03:58:47 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:47.053499
1390	info	::1 - - [02/Mar/2025:03:58:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:49.476369
1391	info	::1 - - [02/Mar/2025:03:58:49 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:49.480926
1392	info	::1 - - [02/Mar/2025:03:58:50 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:50.78067
1393	info	::1 - - [02/Mar/2025:03:58:50 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:58:50.782182
1394	info	::1 - - [02/Mar/2025:03:59:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:09.649199
1395	info	::1 - - [02/Mar/2025:03:59:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:09.653188
1396	info	::1 - - [02/Mar/2025:03:59:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:13.413506
1397	info	::1 - - [02/Mar/2025:03:59:13 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:13.414836
1398	info	::1 - - [02/Mar/2025:03:59:58 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:58.170491
1399	info	::1 - - [02/Mar/2025:03:59:58 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 21:59:58.172195
1400	info	::1 - - [02/Mar/2025:04:01:34 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:34.75799
1401	info	::1 - - [02/Mar/2025:04:01:34 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:34.760511
1402	info	::1 - - [02/Mar/2025:04:01:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:38.210035
1403	info	::1 - - [02/Mar/2025:04:01:38 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:38.212855
1404	info	::1 - - [02/Mar/2025:04:01:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:39.53384
1405	info	::1 - - [02/Mar/2025:04:01:39 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:39.535409
1406	info	::1 - - [02/Mar/2025:04:01:53 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:53.79628
1407	info	::1 - - [02/Mar/2025:04:01:53 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:01:53.798091
1408	info	::1 - - [02/Mar/2025:04:02:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:43.304222
1409	info	::1 - - [02/Mar/2025:04:02:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:43.30569
1410	info	::1 - - [02/Mar/2025:04:02:52 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:52.272141
1411	info	::1 - - [02/Mar/2025:04:02:52 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:52.273993
1412	info	::1 - - [02/Mar/2025:04:02:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:55.273185
1413	info	::1 - - [02/Mar/2025:04:02:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:02:55.275359
1414	info	::1 - - [02/Mar/2025:04:04:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:04:01.839151
1415	info	::1 - - [02/Mar/2025:04:04:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:04:01.840799
1416	info	::1 - - [02/Mar/2025:04:06:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:06:07.959639
1417	info	::1 - - [02/Mar/2025:04:06:07 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:06:07.961199
1418	info	::1 - - [02/Mar/2025:04:06:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:06:09.855586
1419	info	::1 - - [02/Mar/2025:04:06:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:06:09.860151
1420	info	::1 - - [02/Mar/2025:04:11:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:03.850066
1421	info	::1 - - [02/Mar/2025:04:11:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:03.852583
1422	info	::1 - - [02/Mar/2025:04:11:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:30.288892
1423	info	::1 - - [02/Mar/2025:04:11:30 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:30.290509
1424	info	::1 - - [02/Mar/2025:04:11:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:55.409868
1425	info	::1 - - [02/Mar/2025:04:11:55 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:11:55.41182
1426	info	::1 - - [02/Mar/2025:04:12:41 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:12:41.475625
1427	info	::1 - - [02/Mar/2025:04:12:41 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:12:41.477679
1428	info	::1 - - [02/Mar/2025:04:13:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:13:35.948014
1429	info	::1 - - [02/Mar/2025:04:13:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:13:35.950256
1430	info	::1 - - [02/Mar/2025:04:16:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:16:29.391255
1431	info	::1 - - [02/Mar/2025:04:16:29 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:16:29.393872
1432	info	::1 - - [02/Mar/2025:04:16:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:16:35.629775
1433	info	::1 - - [02/Mar/2025:04:16:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:16:35.634428
1434	info	::1 - - [02/Mar/2025:04:17:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:17:31.133859
1435	info	::1 - - [02/Mar/2025:04:17:31 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:17:31.135421
1436	info	::1 - - [02/Mar/2025:04:18:20 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:18:20.036075
1437	info	::1 - - [02/Mar/2025:04:18:20 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:18:20.037692
1438	info	::1 - - [02/Mar/2025:04:22:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:22:35.899653
1439	info	::1 - - [02/Mar/2025:04:22:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:22:35.902571
1440	info	::1 - - [02/Mar/2025:04:24:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:24:01.264782
1441	info	::1 - - [02/Mar/2025:04:24:01 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:24:01.266587
1442	info	::1 - - [02/Mar/2025:04:24:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:24:12.40471
1443	info	::1 - - [02/Mar/2025:04:24:12 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:24:12.40702
1444	info	::1 - - [02/Mar/2025:04:27:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:27:54.374549
1445	info	::1 - - [02/Mar/2025:04:27:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 22:27:54.412637
1446	info	::1 - - [02/Mar/2025:05:36:23 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:36:23.441239
1447	info	::1 - - [02/Mar/2025:05:36:23 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:36:23.443504
1448	info	::1 - - [02/Mar/2025:05:47:25 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:47:25.271919
1449	info	::1 - - [02/Mar/2025:05:47:25 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:47:25.273485
1450	info	::1 - - [02/Mar/2025:05:53:38 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:53:38.828688
1451	info	::1 - - [02/Mar/2025:05:53:38 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:53:38.831414
1452	info	::1 - - [02/Mar/2025:05:59:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:59:06.79372
1453	info	::1 - - [02/Mar/2025:05:59:06 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-01 23:59:06.794886
1455	info	::1 - - [02/Mar/2025:18:24:37 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:24:37.049183
1456	info	::1 - - [02/Mar/2025:18:24:37 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:24:37.058485
1457	info	::1 - - [02/Mar/2025:18:24:37 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:24:37.065752
1458	info	::1 - - [02/Mar/2025:18:24:37 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:24:37.068535
1459	info	::1 - - [02/Mar/2025:18:24:37 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:24:37.07293
1461	info	::1 - - [02/Mar/2025:18:25:14 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:25:14.863514
1462	info	::1 - - [02/Mar/2025:18:25:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:25:14.882167
1463	info	::1 - - [02/Mar/2025:18:25:14 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:25:14.883145
1464	info	::1 - - [02/Mar/2025:18:28:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:28:43.620582
1465	info	::1 - - [02/Mar/2025:18:28:43 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:28:43.621718
1466	info	::1 - - [02/Mar/2025:18:30:26 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:30:26.510388
1467	info	::1 - - [02/Mar/2025:18:30:26 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:30:26.512361
1468	info	::1 - - [02/Mar/2025:18:33:46 +0000] "POST /users/register HTTP/1.1" 201 163 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:33:46.630912
1469	info	✅ Usuario autenticado: edsonalexisrodriguezibarra@gmail.com (ID: 5)	2025-03-02 12:33:54.785645
1470	info	::1 - - [02/Mar/2025:18:33:54 +0000] "POST /auth/login HTTP/1.1" 200 342 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:33:54.790416
1471	info	::1 - - [02/Mar/2025:18:33:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:33:54.817082
1472	info	::1 - - [02/Mar/2025:18:33:54 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:33:54.81802
1473	info	::1 - - [02/Mar/2025:18:36:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:36:46.501248
1474	info	::1 - - [02/Mar/2025:18:36:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:36:46.515088
1475	info	::1 - - [02/Mar/2025:18:37:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:37:03.782068
1476	info	::1 - - [02/Mar/2025:18:37:03 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:37:03.783627
1477	info	::1 - - [02/Mar/2025:18:41:57 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:41:57.258227
1478	info	::1 - - [02/Mar/2025:18:41:57 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 12:41:57.270202
1479	info	::1 - - [03/Mar/2025:00:39:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 18:39:35.533142
1480	info	::1 - - [03/Mar/2025:00:39:35 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-02 18:39:35.56595
1481	info	::1 - - [04/Mar/2025:00:04:11 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-03 18:04:11.826328
1482	info	::1 - - [04/Mar/2025:00:04:11 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-03 18:04:11.835854
1484	info	::1 - - [05/Mar/2025:00:00:09 +0000] "POST /auth/login HTTP/1.1" 200 342 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:09.226165
1485	info	::1 - - [05/Mar/2025:00:00:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:09.229137
1486	info	::1 - - [05/Mar/2025:00:00:09 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:09.231054
1487	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-04 18:00:13.747989
1488	info	::1 - - [05/Mar/2025:00:00:13 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:13.749074
1489	info	::1 - - [05/Mar/2025:00:00:13 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:13.769632
1490	info	::1 - - [05/Mar/2025:00:00:13 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:13.772046
1491	info	::1 - - [05/Mar/2025:00:00:13 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:13.781664
1492	info	::1 - - [05/Mar/2025:00:00:13 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:13.787817
1493	info	::1 - - [05/Mar/2025:00:00:16 +0000] "GET /logs HTTP/1.1" 200 29219 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:16.059315
1494	info	::1 - - [05/Mar/2025:00:00:16 +0000] "GET /logs HTTP/1.1" 200 29215 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:16.066246
1495	info	::1 - - [05/Mar/2025:00:00:18 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:18.380032
1496	info	::1 - - [05/Mar/2025:00:00:18 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:18.382333
1497	info	::1 - - [05/Mar/2025:00:00:18 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:18.386233
1498	info	::1 - - [05/Mar/2025:00:00:18 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 18:00:18.393731
1500	info	::1 - - [05/Mar/2025:02:53:40 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36"	2025-03-04 20:53:40.107453
1502	info	::1 - - [05/Mar/2025:02:53:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36"	2025-03-04 20:53:40.113474
1501	info	::1 - - [05/Mar/2025:02:53:40 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36"	2025-03-04 20:53:40.113528
1503	info	::1 - - [05/Mar/2025:02:53:40 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36"	2025-03-04 20:53:40.116814
1504	info	::1 - - [05/Mar/2025:02:53:40 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Mobile Safari/537.36"	2025-03-04 20:53:40.125032
1505	info	::1 - - [05/Mar/2025:02:53:43 +0000] "GET /logs HTTP/1.1" 200 29090 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:53:43.26053
1506	info	::1 - - [05/Mar/2025:02:53:43 +0000] "GET /logs HTTP/1.1" 200 29086 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:53:43.265244
1507	info	::1 - - [05/Mar/2025:02:58:53 +0000] "GET /logs HTTP/1.1" 200 29082 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:58:53.876806
1508	info	::1 - - [05/Mar/2025:02:58:53 +0000] "GET /logs HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:58:53.878759
1509	info	✅ Usuario autenticado: ealexisrdz19@gmail.com (ID: 4)	2025-03-04 20:59:00.43079
1510	info	::1 - - [05/Mar/2025:02:59:00 +0000] "POST /auth/login HTTP/1.1" 200 330 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:00.431827
1511	info	::1 - - [05/Mar/2025:02:59:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:00.452734
1512	info	::1 - - [05/Mar/2025:02:59:00 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:00.454392
1513	info	::1 - - [05/Mar/2025:02:59:00 +0000] "GET /dashboard HTTP/1.1" 200 51 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:00.46389
1514	info	::1 - - [05/Mar/2025:02:59:00 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:00.471131
1515	info	::1 - - [05/Mar/2025:02:59:05 +0000] "GET /logs HTTP/1.1" 200 28885 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:05.091391
1516	info	::1 - - [05/Mar/2025:02:59:05 +0000] "GET /logs HTTP/1.1" 200 28881 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 20:59:05.097159
1517	info	::1 - - [05/Mar/2025:03:00:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:02.399918
1518	info	::1 - - [05/Mar/2025:03:00:02 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:02.402655
1519	info	::1 - - [05/Mar/2025:03:00:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:02.406984
1520	info	::1 - - [05/Mar/2025:03:00:02 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:02.408378
1521	info	::1 - - [05/Mar/2025:03:00:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:30.908461
1522	info	::1 - - [05/Mar/2025:03:00:30 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:30.910856
1523	info	::1 - - [05/Mar/2025:03:00:34 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:34.402823
1524	info	::1 - - [05/Mar/2025:03:00:34 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:34.405816
1525	info	::1 - - [05/Mar/2025:03:00:34 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:34.411935
1526	info	::1 - - [05/Mar/2025:03:00:34 +0000] "GET /dashboard HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:34.419378
1527	info	✅ Usuario autenticado: usuario@gmail.com (ID: 2)	2025-03-04 21:00:40.018659
1528	info	::1 - - [05/Mar/2025:03:00:40 +0000] "POST /auth/login HTTP/1.1" 200 331 "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:40.019426
1529	info	::1 - - [05/Mar/2025:03:00:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:40.037315
1530	info	::1 - - [05/Mar/2025:03:00:40 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:40.038871
1531	info	::1 - - [05/Mar/2025:03:00:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:46.833497
1532	info	::1 - - [05/Mar/2025:03:00:46 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:00:46.835638
1533	info	::1 - - [05/Mar/2025:03:10:08 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:10:08.296394
1534	info	::1 - - [05/Mar/2025:03:10:08 +0000] "GET /books HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:10:08.312977
1535	info	::1 - - [05/Mar/2025:03:10:11 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:10:11.381647
1536	info	::1 - - [05/Mar/2025:03:10:11 +0000] "GET /books/latest HTTP/1.1" 304 - "http://localhost:5173/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/133.0.0.0 Safari/537.36"	2025-03-04 21:10:11.383425
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: alexisrodriguez
--

COPY public.users (id, nombre, email, password, rol) FROM stdin;
1	Alexis	alexis@gmail.com	$2b$10$U7fs/HIdZ8ooXjsLOmq8CeX3hX4yOTk8kNykA4oYgaBnEc.FmtBLe	admin
2	Usuario Normal	usuario@gmail.com	$2a$10$eF9HZFB6UeQWXzZaRwYJb.ZobdyZfQmSjWa1SXiaEdx6vpIYLJG3G	usuario
3	Hector	hector@gmail.com	$2b$10$l/0/YJyjh8zyNmGiOl0TLuOWVWnUt5YrtakiftzfFoPX.UR86zGQO	usuario
4	Administrador	ealexisrdz19@gmail.com	$2b$12$2tTcmZ.XGODM.g3rWIsS1OoicM0ptCi4nT/KjE/wfbBsjui2Rpxsa	admin
5	Alexis	edsonalexisrodriguezibarra@gmail.com	$2b$12$TcEpHm2R73GcGPYkCpSHSutTU3jzN4kuGuHeupmFD8DV9Q1/DGjLq	usuario
\.


--
-- Name: books_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexisrodriguez
--

SELECT pg_catalog.setval('public.books_id_seq', 579, true);


--
-- Name: loans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexisrodriguez
--

SELECT pg_catalog.setval('public.loans_id_seq', 3, true);


--
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexisrodriguez
--

SELECT pg_catalog.setval('public.logs_id_seq', 1536, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: alexisrodriguez
--

SELECT pg_catalog.setval('public.users_id_seq', 5, true);


--
-- Name: books books_pkey; Type: CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.books
    ADD CONSTRAINT books_pkey PRIMARY KEY (id);


--
-- Name: loans loans_pkey; Type: CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_pkey PRIMARY KEY (id);


--
-- Name: logs logs_pkey; Type: CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: loans loans_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.books(id) ON DELETE CASCADE;


--
-- Name: loans loans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: alexisrodriguez
--

ALTER TABLE ONLY public.loans
    ADD CONSTRAINT loans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

