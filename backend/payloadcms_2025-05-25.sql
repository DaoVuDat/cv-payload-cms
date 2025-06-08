--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
-- Name: enum_projects_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_projects_status AS ENUM (
    'active',
    'completed',
    'paused',
    'draft'
);


ALTER TYPE public.enum_projects_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.media (
    id integer NOT NULL,
    alt character varying NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    url character varying,
    thumbnail_u_r_l character varying,
    filename character varying,
    mime_type character varying,
    filesize numeric,
    width numeric,
    height numeric,
    focal_x numeric,
    focal_y numeric
);


ALTER TABLE public.media OWNER TO postgres;

--
-- Name: media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.media_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.media_id_seq OWNER TO postgres;

--
-- Name: media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.media_id_seq OWNED BY public.media.id;


--
-- Name: payload_locked_documents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_locked_documents (
    id integer NOT NULL,
    global_slug character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_locked_documents OWNER TO postgres;

--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_locked_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_locked_documents_id_seq OWNER TO postgres;

--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_locked_documents_id_seq OWNED BY public.payload_locked_documents.id;


--
-- Name: payload_locked_documents_rels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_locked_documents_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer,
    media_id integer,
    projects_id integer
);


ALTER TABLE public.payload_locked_documents_rels OWNER TO postgres;

--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_locked_documents_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_locked_documents_rels_id_seq OWNER TO postgres;

--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_locked_documents_rels_id_seq OWNED BY public.payload_locked_documents_rels.id;


--
-- Name: payload_migrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_migrations (
    id integer NOT NULL,
    name character varying,
    batch numeric,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_migrations OWNER TO postgres;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_migrations_id_seq OWNER TO postgres;

--
-- Name: payload_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_migrations_id_seq OWNED BY public.payload_migrations.id;


--
-- Name: payload_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_preferences (
    id integer NOT NULL,
    key character varying,
    value jsonb,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.payload_preferences OWNER TO postgres;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_id_seq OWNER TO postgres;

--
-- Name: payload_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_preferences_id_seq OWNED BY public.payload_preferences.id;


--
-- Name: payload_preferences_rels; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payload_preferences_rels (
    id integer NOT NULL,
    "order" integer,
    parent_id integer NOT NULL,
    path character varying NOT NULL,
    users_id integer
);


ALTER TABLE public.payload_preferences_rels OWNER TO postgres;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payload_preferences_rels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNER TO postgres;

--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payload_preferences_rels_id_seq OWNED BY public.payload_preferences_rels.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    title character varying NOT NULL,
    description jsonb NOT NULL,
    start_date timestamp(3) with time zone NOT NULL,
    end_date timestamp(3) with time zone,
    status public.enum_projects_status NOT NULL,
    project_url character varying,
    repository_url character varying,
    featured boolean DEFAULT false,
    slug character varying,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.projects_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: projects_images; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_images (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    image_id integer NOT NULL,
    caption character varying,
    alt_text character varying NOT NULL
);


ALTER TABLE public.projects_images OWNER TO postgres;

--
-- Name: projects_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_role (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    role_title character varying NOT NULL
);


ALTER TABLE public.projects_role OWNER TO postgres;

--
-- Name: projects_technologies; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.projects_technologies (
    _order integer NOT NULL,
    _parent_id integer NOT NULL,
    id character varying NOT NULL,
    technology character varying NOT NULL
);


ALTER TABLE public.projects_technologies OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    updated_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    created_at timestamp(3) with time zone DEFAULT now() NOT NULL,
    email character varying NOT NULL,
    reset_password_token character varying,
    reset_password_expiration timestamp(3) with time zone,
    salt character varying,
    hash character varying,
    login_attempts numeric DEFAULT 0,
    lock_until timestamp(3) with time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: media id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media ALTER COLUMN id SET DEFAULT nextval('public.media_id_seq'::regclass);


--
-- Name: payload_locked_documents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_id_seq'::regclass);


--
-- Name: payload_locked_documents_rels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_locked_documents_rels_id_seq'::regclass);


--
-- Name: payload_migrations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_migrations ALTER COLUMN id SET DEFAULT nextval('public.payload_migrations_id_seq'::regclass);


--
-- Name: payload_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_id_seq'::regclass);


--
-- Name: payload_preferences_rels id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels ALTER COLUMN id SET DEFAULT nextval('public.payload_preferences_rels_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.media (id, alt, updated_at, created_at, url, thumbnail_u_r_l, filename, mime_type, filesize, width, height, focal_x, focal_y) FROM stdin;
\.


--
-- Data for Name: payload_locked_documents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_locked_documents (id, global_slug, updated_at, created_at) FROM stdin;
\.


--
-- Data for Name: payload_locked_documents_rels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_locked_documents_rels (id, "order", parent_id, path, users_id, media_id, projects_id) FROM stdin;
\.


--
-- Data for Name: payload_migrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_migrations (id, name, batch, updated_at, created_at) FROM stdin;
1	dev	-1	2025-05-25 06:35:43.827+00	2025-05-25 06:35:43.827+00
\.


--
-- Data for Name: payload_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_preferences (id, key, value, updated_at, created_at) FROM stdin;
1	projects-list	{"limit": 10, "preset": null, "columns": [{"active": true, "accessor": "title"}, {"active": true, "accessor": "description"}, {"active": true, "accessor": "technologies"}, {"active": true, "accessor": "role"}, {"active": false, "accessor": "id"}, {"active": true, "accessor": "startDate"}, {"active": true, "accessor": "endDate"}, {"active": false, "accessor": "status"}, {"active": false, "accessor": "images"}, {"active": false, "accessor": "projectUrl"}, {"active": false, "accessor": "repositoryUrl"}, {"active": false, "accessor": "featured"}, {"active": false, "accessor": "slug"}, {"active": false, "accessor": "updatedAt"}, {"active": false, "accessor": "createdAt"}]}	2025-05-25 07:45:50.854+00	2025-05-25 06:38:55.261+00
\.


--
-- Data for Name: payload_preferences_rels; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payload_preferences_rels (id, "order", parent_id, path, users_id) FROM stdin;
4	\N	1	user	1
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects (id, title, description, start_date, end_date, status, project_url, repository_url, featured, slug, updated_at, created_at) FROM stdin;
1	Demand Ordering Optimization Using Dragonfly and Particle Swarm Algorithms	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this project, I developed a hybrid metaheuristic solution combining the Dragonfly Algorithm (DA) and Particle Swarm Optimization (PSO) to optimize demand ordering strategies over various Fixed Order Period (FOP) intervals — including 1-day, 3-day, 5-day, and 7-day cycles. Implemented in MATLAB, the algorithm was designed to balance responsiveness and cost-efficiency by dynamically adjusting order schedules based on demand patterns and operational constraints.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The hybrid approach leveraged the exploration strength of the Dragonfly Algorithm and the convergence speed of PSO, resulting in faster convergence to high-quality solutions. By modeling and minimizing total cost—including holding, shortage, and ordering costs—this system effectively identified optimal ordering frequencies for different time horizons.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This work demonstrated the potential of bio-inspired algorithms in solving complex, real-world inventory management and supply chain challenges with a high degree of accuracy and adaptability.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2020-05-04 17:00:00+00	2020-12-09 17:00:00+00	completed	\N	\N	f	optimization-of-construction-planning-using-metaheuristic-algorithms	2025-05-25 07:24:51.256+00	2025-05-25 07:23:44.778+00
2	Facility Layout Optimization Using Ant Lion Optimization in MATLAB	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This component of the project focused on solving a facility layout optimization problem, where ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "m", "type": "text", "style": "", "detail": 0, "format": 2, "version": 1}, {"mode": "normal", "text": " facilities needed to be optimally placed across ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "n", "type": "text", "style": "", "detail": 0, "format": 2, "version": 1}, {"mode": "normal", "text": " predefined locations to minimize material handling costs and improve operational flow. I implemented the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Ant Lion Optimization (ALO)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " algorithm in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "MATLAB", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " to tackle this NP-hard combinatorial problem efficiently.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "ALO, inspired by the hunting mechanism of antlions in nature, was used to intelligently explore the solution space and identify optimal or near-optimal layouts based on distance and flow matrices. The algorithm’s adaptive search capabilities allowed it to balance exploration and exploitation effectively, making it well-suited for the dynamic constraints of real-world facility planning.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "By leveraging ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "MATLAB", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " for modeling, simulation, and result visualization, I created a solution that not only outperformed traditional heuristics but also offered a practical decision-support tool for layout planning in manufacturing or construction environments.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2020-12-16 17:00:00+00	2020-04-23 17:00:00+00	completed	\N	\N	f	facility-layout-optimization-using-ant-lion-optimization-in-matlab	2025-05-25 07:31:44.939+00	2025-05-25 07:31:01.736+00
3	Material Placement Optimization Using Enhanced Ant Lion Optimization in Python	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this phase of the project, I addressed the challenge of optimizing material placement within a set of predefined locations to reduce handling time and improve workflow efficiency. I developed an enhanced version of the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Ant Lion Optimization (ALO)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " algorithm in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Python", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", integrating two powerful strategies: ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "mutation operators", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " and ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "opposite-based learning (OBL)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ".", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This hybridization significantly boosted the algorithm’s exploration capabilities and convergence reliability. The mutation component introduced diversity into the search space, helping to escape local optima, while opposite-based learning accelerated convergence by evaluating both current and opposite solutions during the search process.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The resulting system intelligently positioned materials based on frequency of use, access priority, and spatial constraints, delivering tangible improvements in layout efficiency and operational cost.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2021-05-17 17:00:00+00	2021-12-29 17:00:00+00	completed	\N	\N	f	material-placement-optimization-using-enhanced-ant-lion-optimization-in-python	2025-05-25 07:35:17.376+00	2025-05-25 07:35:17.361+00
4	Time–Cost Tradeoff Optimization Using Moth–Flame Optimizer with Modified Adaptive Weights	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this phase, I tackled the classic time–cost management problem in project scheduling by implementing a ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Moth–Flame Optimizer (MFO)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " enhanced with a ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Modified Adaptive Weight", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " strategy in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Python", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ". The goal was to find optimal trade-offs between project duration and total cost under realistic constraints—such as resource limits and precedence relationships—by dynamically adjusting the MFO’s exploration–exploitation balance.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The modified adaptive weight approach recalibrates the influence of the “moth” population over iterations, improving convergence speed and solution diversity. This allowed the algorithm to more effectively navigate the non-linear time–cost surface, identifying Pareto-efficient schedules that reduce overall expenditure without unduly prolonging project timelines.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2021-09-30 17:00:00+00	2021-12-29 17:00:00+00	completed	\N	\N	f	time-cost-tradeoff-optimization-using-moth-flame-optimizer-with-modified-adaptive-weights	2025-05-25 07:37:03.103+00	2025-05-25 07:37:03.089+00
5	Thermal Parameter Optimization Using ANN and Grey Wolf Optimizer with IESVE-Generated Data	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this phase, I focused on optimizing building design parameters to achieve energy-efficient temperature regulation. Using ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "IESVE", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " solely as a data generation tool, I simulated a range of building scenarios under different environmental and structural configurations. The resulting dataset was then used to train an ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Artificial Neural Network (ANN)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "PyTorch", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", which served as a predictive model for indoor thermal performance.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "To fine-tune the input parameters (e.g., insulation thickness, HVAC settings, material properties), I applied the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Grey Wolf Optimizer (GWO)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": "—a nature-inspired metaheuristic well-suited for continuous optimization tasks. The ANN-GWO hybrid enabled rapid evaluation of design alternatives without the need for repeated IESVE simulations, significantly speeding up the optimization process.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This approach demonstrated the power of surrogate modeling in building energy analysis, providing a scalable and intelligent solution for early-stage design decisions in sustainable architecture.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2022-03-02 17:00:00+00	2022-05-28 17:00:00+00	completed	\N	\N	f	thermal-parameter-optimization-using-ann-and-grey-wolf-optimizer-with-iesve-integration	2025-05-25 07:41:26.883+00	2025-05-25 07:39:51.417+00
6	Parametric Glass Installation Design Using Grasshopper and African Vulture Optimization in C#	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This component focused on the parametric design of glass installations to regulate natural light and indoor temperature, contributing to both energy efficiency and occupant comfort. I developed a ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "custom Grasshopper plugin for Rhino", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", written in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "C#", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", which allowed designers to intuitively manipulate architectural parameters and immediately visualize their impact on environmental performance.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "To optimize the design, I implemented the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "African Vulture Optimization Algorithm (AVOA)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": "—a recent nature-inspired metaheuristic known for its strong balance between exploration and exploitation. The algorithm iteratively adjusted parameters such as glazing angle, tint level, and panel placement to maximize daylight utilization while minimizing thermal gain.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "By combining computational design with intelligent optimization, this tool empowered architects and engineers to make data-driven decisions during the early stages of design, ensuring aesthetics and sustainability were seamlessly integrated.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2023-03-07 17:00:00+00	2023-10-24 17:00:00+00	completed	\N	\N	t	parametric-glass-installation-design-using-grasshopper-and-african-vulture-optimization-in-c	2025-05-25 07:47:00.763+00	2025-05-25 07:47:00.729+00
7	Waste Collection Route Optimization Using Osprey Optimization Algorithm in MATLAB	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This project addressed the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Capacitated Vehicle Routing Problem (CVRP)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " in the context of trash collection logistics in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "District 2", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", where the objective was to determine the most efficient routes for a fleet of waste collection vehicles with capacity constraints. I implemented the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Osprey Optimization Algorithm (OOA)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": "—a recent nature-inspired metaheuristic—in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "MATLAB", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " to solve this complex, real-world combinatorial problem.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The algorithm intelligently assigned trash pickup points to vehicles, ensuring optimal route length while respecting vehicle capacity and operational limits. Through iterative refinement, OOA minimized the total distance traveled and balanced the load across the fleet, ultimately reducing fuel consumption and improving service reliability.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This work provided a scalable and adaptable solution for urban waste management, showcasing how advanced metaheuristics can drive real impact in smart city logistics.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2023-10-01 17:00:00+00	2023-12-24 17:00:00+00	completed	\N	\N	t	waste-collection-route-optimization-using-osprey-optimization-algorithm-in-matlab	2025-05-25 07:50:17.168+00	2025-05-25 07:50:17.116+00
8	Multi-Objective Facility Placement Optimization Using Hybrid Artificial Hummingbird Algorithm in MATLAB	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this advanced layout planning problem, I optimized the placement of facilities within a defined boundary while simultaneously satisfying ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "three critical objectives", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ": minimizing ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "risk", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", reducing ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "hoisting time", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", and enhancing ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "on-site safety", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ". The solution was developed in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "MATLAB", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", using a ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "hybrid multi-objective Artificial Hummingbird Algorithm (MO-AHA)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " enhanced with ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "three distinct Opposite-Based Learning (OBL)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " strategies.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This hybridization significantly improved the algorithm's convergence behavior and solution diversity. The OBL mechanisms enabled the model to efficiently explore the search space by evaluating complementary solutions, while MO-AHA mimicked hummingbirds’ intelligent foraging behavior to balance the conflicting objectives.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The resulting Pareto front allowed stakeholders to select from a range of trade-off solutions tailored to operational priorities, such as speed versus safety or cost versus risk, providing a practical tool for decision-making in high-risk construction environments.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2024-03-02 17:00:00+00	2024-04-30 17:00:00+00	completed	\N	\N	t	multi-objective-facility-placement-optimization-using-hybrid-artificial-hummingbird-algorithm-in-matlab	2025-05-25 07:51:50.725+00	2025-05-25 07:51:50.7+00
9	MISA Invoice Tracking System with Go Backend and Vue.js Frontend	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "In this project, I developed a full-stack ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "invoice tracking system", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " for monitoring the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "creation, modification, and deletion", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " of invoices within a business accounting environment. The system was built with a ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Go (Golang)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " backend, providing a robust and efficient API for processing and storing invoice activity logs, and a responsive ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Vue.js", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " frontend for user interaction and real-time updates.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Key features included activity logging, user role control, and detailed audit trails to ensure data integrity and transparency. The system also supported filtering, searching, and exporting logs, making it easier for accounting teams to trace changes and ensure compliance.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This project demonstrated my ability to build reliable, maintainable, and secure web applications with modern technologies and a focus on traceability and operational clarity.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2024-10-02 17:00:00+00	2025-02-27 17:00:00+00	completed	\N	\N	t	misa-invoice-tracking-system-with-go-backend-and-vue-js-frontend	2025-05-25 07:53:52.715+00	2025-05-25 07:53:52.685+00
10	Multi-Objective Construction Layout Optimization Application with Advanced Metaheuristics	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This project involved developing a sophisticated ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "construction layout optimization application", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " that addresses five critical objectives: ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "hoisting time, risk, safety, hazard safety, and transportation cost", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ". To solve this challenging multi-objective problem, I implemented and compared several cutting-edge metaheuristic algorithms, including:", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"tag": "ul", "type": "list", "start": 1, "format": "", "indent": 0, "version": 1, "children": [{"type": "listitem", "value": 1, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Multi-Objective Particle Swarm Optimization (MOPSO)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 2, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Opposite-Based Learning Multi-Objective Artificial Hummingbird Algorithm (oMOAHA)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 3, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Multi-Objective Artificial Hummingbird Algorithm (MOAHA)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 4, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Non-dominated Sorting Genetic Algorithm II (NSGA-II)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 5, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Genetic Algorithm (GA)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 6, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Grey Wolf Optimizer (GWO)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}, {"type": "listitem", "value": 7, "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "Artificial Hummingbird Algorithm (AHA)", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr"}], "listType": "bullet", "direction": "ltr"}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "The application provides an interactive ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "web interface", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " built with ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Svelte", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", delivering a seamless user experience and real-time feedback. The backend is powered by ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Golang", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", ensuring efficient computation and data management. For visualization, ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "ECharts", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": " was integrated to display complex multi-dimensional Pareto fronts and objective trade-offs through intuitive charts and graphs.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This comprehensive tool enables construction managers and planners to make data-driven decisions by balancing multiple conflicting objectives, enhancing project safety and efficiency while minimizing costs.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2025-03-14 17:00:00+00	\N	active	\N	https://github.com/DaoVuDat/optim-cons-app	t	multi-objective-construction-layout-optimization-application-with-advanced-metaheuristics	2025-05-25 07:57:47.093+00	2025-05-25 07:57:47.07+00
11	Parametric Sewage System Design Optimization Using Salp Swarm Algorithm in MATLAB	{"root": {"type": "root", "format": "", "indent": 0, "version": 1, "children": [{"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "This project focused on optimizing the design parameters of a sewage system, specifically selecting the type and diameter of pipes within a network to ensure efficient flow and cost-effectiveness. Implemented in ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "MATLAB", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": ", the solution employed the ", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}, {"mode": "normal", "text": "Salp Swarm Algorithm (SSA)", "type": "text", "style": "", "detail": 0, "format": 1, "version": 1}, {"mode": "normal", "text": "—a nature-inspired metaheuristic that mimics the swarming behavior of salps in oceans.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}, {"type": "paragraph", "format": "", "indent": 0, "version": 1, "children": [{"mode": "normal", "text": "By integrating hydraulic constraints, flow requirements, and cost factors into the objective function, the SSA algorithm efficiently explored the design space to identify optimal pipe configurations. This parametric approach enabled rapid evaluation of multiple scenarios, supporting sustainable and cost-efficient infrastructure planning.", "type": "text", "style": "", "detail": 0, "format": 0, "version": 1}], "direction": "ltr", "textStyle": "", "textFormat": 0}], "direction": "ltr"}}	2023-03-02 17:00:00+00	2023-11-03 17:00:00+00	completed	\N	\N	f	parametric-sewage-system-design-optimization-using-salp-swarm-algorithm-in-matlab	2025-05-25 08:00:18.329+00	2025-05-25 08:00:18.32+00
\.


--
-- Data for Name: projects_images; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_images (_order, _parent_id, id, image_id, caption, alt_text) FROM stdin;
\.


--
-- Data for Name: projects_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_role (_order, _parent_id, id, role_title) FROM stdin;
1	1	6832c5504ade5d062c099b69	Developer
1	2	6832c7304ade5d062c099b6d	Developer
1	3	6832c79e4ade5d062c099b77	Developer
1	4	6832c8704ade5d062c099b81	Developer
1	5	6832c8d64ade5d062c099b8d	Developer
1	6	6832c9ee4ade5d062c099b97	Developer
1	7	6832cb284ade5d062c099ba1	Developer
1	8	6832cbf04ade5d062c099baf	Developer
1	9	6832cc4e4ade5d062c099bb9	Developer
1	10	6832cd304ade5d062c099bcf	Developer
1	11	6832cdea4ade5d062c099bdb	Developer
\.


--
-- Data for Name: projects_technologies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.projects_technologies (_order, _parent_id, id, technology) FROM stdin;
1	1	6832c5494ade5d062c099b67	Matlab
1	2	6832c5d84ade5d062c099b6b	Matlab
2	2	6832c7574ade5d062c099b6f	Ant Lion Optimization Algorithm
1	3	6832c7754ade5d062c099b71	Python
2	3	6832c77b4ade5d062c099b73	Ant Lion Optimization with Mutation and Opposite-Based Learning
3	3	6832c7804ade5d062c099b75	NumPy and Matplotlib for modeling and visualization
1	4	6832c8564ade5d062c099b79	Python
2	4	6832c85d4ade5d062c099b7b	Moth–Flame Optimizer (MFO) with Modified Adaptive Weighting
3	4	6832c8634ade5d062c099b7d	NumPy for numerical computation
4	4	6832c8674ade5d062c099b7f	Matplotlib for convergence and Pareto-front visualization
1	5	6832c8bf4ade5d062c099b83	IESVE Simulation Software (for simulation data generation)
2	5	6832c8c44ade5d062c099b85	Python & PyTorch
3	5	6832c8c84ade5d062c099b87	Artificial Neural Networks (ANN)
4	5	6832c8cc4ade5d062c099b89	Grey Wolf Optimizer (GWO)
5	5	6832c8d04ade5d062c099b8b	Pandas, NumPy, and Matplotlib for data handling and visualization
1	6	6832c9be4ade5d062c099b8f	Rhino + Grasshopper (visual programming environment)
2	6	6832c9c34ade5d062c099b91	C# (for custom plugin development)
3	6	6832c9e44ade5d062c099b93	African Vulture Optimization Algorithm (AVOA)
4	6	6832c9e74ade5d062c099b95	Parametric modeling techniques for façade design
1	7	6832cb124ade5d062c099b99	MATLAB
2	7	6832cb184ade5d062c099b9b	Osprey Optimization Algorithm (OOA)
3	7	6832cb1c4ade5d062c099b9d	Capacitated Vehicle Routing Problem (CVRP) modeling
4	7	6832cb204ade5d062c099b9f	Geospatial data input and route visualization
1	8	6832cbd84ade5d062c099ba5	MATLAB
2	8	6832cbde4ade5d062c099ba7	Multi-Objective Artificial Hummingbird Algorithm (MO-AHA)
3	8	6832cbe24ade5d062c099ba9	Opposite-Based Learning (OBL) hybridization techniques
4	8	6832cbe74ade5d062c099bab	Risk, hoisting time, and safety objective modeling
5	8	6832cbec4ade5d062c099bad	Pareto-front visualization and analysis
1	9	6832cc2d4ade5d062c099bb1	Golang (backend REST API)
2	9	6832cc344ade5d062c099bb3	Vue.js (frontend interface)
3	9	6832cc394ade5d062c099bb5	SQLite
4	9	6832cc734ade5d062c099bbb	Docker
1	10	6832ccae4ade5d062c099bbd	Golang (backend API)
2	10	6832ccc64ade5d062c099bc1	Svelte (frontend framework)
3	10	6832ccc94ade5d062c099bc3	ECharts (data visualization)
4	10	6832cccd4ade5d062c099bc5	Multi-objective metaheuristic algorithms (MOPSO, oMOAHA, MOAHA, NSGA-II, GA, GWO, AHA)
5	10	6832ccd14ade5d062c099bc7	Multi-criteria decision analysis and Pareto optimization
1	11	6832cdcf4ade5d062c099bd1	MATLAB
2	11	6832cdd44ade5d062c099bd3	Salp Swarm Algorithm (SSA)
3	11	6832cde24ade5d062c099bd7	Hydraulic modeling and constraint handling
4	11	6832cde54ade5d062c099bd9	Cost and efficiency optimization
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, updated_at, created_at, email, reset_password_token, reset_password_expiration, salt, hash, login_attempts, lock_until) FROM stdin;
1	2025-05-25 06:37:00.116+00	2025-05-25 06:36:59.367+00	test@test.com	\N	\N	ea5dacc0c9e67442f76b9182f9cf3a81d77e0ebf42517611c356a2fe96d3def2	4638d9b7e235932887456a3287448acdc70d44db67f286561971484286ce8c4c984e965686dbc66eb92659e4d7f4d38ef07454d85665b2b6a952b8cf8cc4f88626e5b67a04b78ce6c3b349e594bd474561d6a91945ac401502354fdb17d8bbf5fdfe69977026c1f72ec2b31ac745481add325c7d0d26d8125c960946bd6e01fe6a4d50e808fb3b6e09816daa261e51737e073adc4744b794c4b1c48b3e2672eb51c172b31f29bca126f79e533b7d16f3151a03f54fe6f3cbddb8cace3d437c321f538513f3465653d358602acf4bd04db2d1ee54daf6e7c3e0c889acf3b6d9db1b85a4f0f4d02c1dd872901a6d1679d06c0a66b44aca50b1da616575d0601e1539148d7f2c5b582414128841d46b5ceaf28006a32eb5b90792d62bf7b9d73dea2fad66ea626bb0847f7ab24c2313e6159232059367cc5579511d463bb7e4cc65eee4e3135389813ddb4b9d7f2ee0eeec0588ea107b773d50b7eeda1ed5ef725e6def6c5687565083a58c00aa333fdc0cebe6446344fc2e4d26b55adc5ccfd1dc164bcb172ca83add9c0575dbe52d6f2f937d612844ae17336f06191d31e0ad39adfca59446bb65225023941ac22c7dbf8678f2f590d0d227b4f9b40819a4a0f10a3a845d907bb51f64c5d301b9437e0a13bf58167b59661de2274b5b30445ec116791b33e0f750abf4cebaf8c652af93d72b7e19a15245f780fa26d892dfeaa2	0	\N
\.


--
-- Name: media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.media_id_seq', 1, false);


--
-- Name: payload_locked_documents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_locked_documents_id_seq', 2, true);


--
-- Name: payload_locked_documents_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_locked_documents_rels_id_seq', 4, true);


--
-- Name: payload_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_migrations_id_seq', 1, true);


--
-- Name: payload_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_preferences_id_seq', 1, true);


--
-- Name: payload_preferences_rels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payload_preferences_rels_id_seq', 4, true);


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.projects_id_seq', 11, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- Name: media media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.media
    ADD CONSTRAINT media_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents payload_locked_documents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents
    ADD CONSTRAINT payload_locked_documents_pkey PRIMARY KEY (id);


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_pkey PRIMARY KEY (id);


--
-- Name: payload_migrations payload_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_migrations
    ADD CONSTRAINT payload_migrations_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences payload_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences
    ADD CONSTRAINT payload_preferences_pkey PRIMARY KEY (id);


--
-- Name: payload_preferences_rels payload_preferences_rels_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_pkey PRIMARY KEY (id);


--
-- Name: projects_images projects_images_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_images
    ADD CONSTRAINT projects_images_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects_role projects_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_role
    ADD CONSTRAINT projects_role_pkey PRIMARY KEY (id);


--
-- Name: projects_technologies projects_technologies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_technologies
    ADD CONSTRAINT projects_technologies_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: media_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_created_at_idx ON public.media USING btree (created_at);


--
-- Name: media_filename_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX media_filename_idx ON public.media USING btree (filename);


--
-- Name: media_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX media_updated_at_idx ON public.media USING btree (updated_at);


--
-- Name: payload_locked_documents_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_created_at_idx ON public.payload_locked_documents USING btree (created_at);


--
-- Name: payload_locked_documents_global_slug_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_global_slug_idx ON public.payload_locked_documents USING btree (global_slug);


--
-- Name: payload_locked_documents_rels_media_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_media_id_idx ON public.payload_locked_documents_rels USING btree (media_id);


--
-- Name: payload_locked_documents_rels_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_order_idx ON public.payload_locked_documents_rels USING btree ("order");


--
-- Name: payload_locked_documents_rels_parent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_parent_idx ON public.payload_locked_documents_rels USING btree (parent_id);


--
-- Name: payload_locked_documents_rels_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_path_idx ON public.payload_locked_documents_rels USING btree (path);


--
-- Name: payload_locked_documents_rels_projects_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_projects_id_idx ON public.payload_locked_documents_rels USING btree (projects_id);


--
-- Name: payload_locked_documents_rels_users_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_rels_users_id_idx ON public.payload_locked_documents_rels USING btree (users_id);


--
-- Name: payload_locked_documents_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_locked_documents_updated_at_idx ON public.payload_locked_documents USING btree (updated_at);


--
-- Name: payload_migrations_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_migrations_created_at_idx ON public.payload_migrations USING btree (created_at);


--
-- Name: payload_migrations_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_migrations_updated_at_idx ON public.payload_migrations USING btree (updated_at);


--
-- Name: payload_preferences_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_created_at_idx ON public.payload_preferences USING btree (created_at);


--
-- Name: payload_preferences_key_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_key_idx ON public.payload_preferences USING btree (key);


--
-- Name: payload_preferences_rels_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_order_idx ON public.payload_preferences_rels USING btree ("order");


--
-- Name: payload_preferences_rels_parent_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_parent_idx ON public.payload_preferences_rels USING btree (parent_id);


--
-- Name: payload_preferences_rels_path_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_path_idx ON public.payload_preferences_rels USING btree (path);


--
-- Name: payload_preferences_rels_users_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_rels_users_id_idx ON public.payload_preferences_rels USING btree (users_id);


--
-- Name: payload_preferences_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX payload_preferences_updated_at_idx ON public.payload_preferences USING btree (updated_at);


--
-- Name: projects_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_created_at_idx ON public.projects USING btree (created_at);


--
-- Name: projects_images_image_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_images_image_idx ON public.projects_images USING btree (image_id);


--
-- Name: projects_images_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_images_order_idx ON public.projects_images USING btree (_order);


--
-- Name: projects_images_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_images_parent_id_idx ON public.projects_images USING btree (_parent_id);


--
-- Name: projects_role_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_role_order_idx ON public.projects_role USING btree (_order);


--
-- Name: projects_role_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_role_parent_id_idx ON public.projects_role USING btree (_parent_id);


--
-- Name: projects_technologies_order_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_technologies_order_idx ON public.projects_technologies USING btree (_order);


--
-- Name: projects_technologies_parent_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_technologies_parent_id_idx ON public.projects_technologies USING btree (_parent_id);


--
-- Name: projects_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX projects_updated_at_idx ON public.projects USING btree (updated_at);


--
-- Name: users_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_created_at_idx ON public.users USING btree (created_at);


--
-- Name: users_email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX users_email_idx ON public.users USING btree (email);


--
-- Name: users_updated_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX users_updated_at_idx ON public.users USING btree (updated_at);


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_media_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_media_fk FOREIGN KEY (media_id) REFERENCES public.media(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_locked_documents(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_projects_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_projects_fk FOREIGN KEY (projects_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: payload_locked_documents_rels payload_locked_documents_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_locked_documents_rels
    ADD CONSTRAINT payload_locked_documents_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_parent_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_parent_fk FOREIGN KEY (parent_id) REFERENCES public.payload_preferences(id) ON DELETE CASCADE;


--
-- Name: payload_preferences_rels payload_preferences_rels_users_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payload_preferences_rels
    ADD CONSTRAINT payload_preferences_rels_users_fk FOREIGN KEY (users_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: projects_images projects_images_image_id_media_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_images
    ADD CONSTRAINT projects_images_image_id_media_id_fk FOREIGN KEY (image_id) REFERENCES public.media(id) ON DELETE SET NULL;


--
-- Name: projects_images projects_images_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_images
    ADD CONSTRAINT projects_images_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: projects_role projects_role_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_role
    ADD CONSTRAINT projects_role_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: projects_technologies projects_technologies_parent_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.projects_technologies
    ADD CONSTRAINT projects_technologies_parent_id_fk FOREIGN KEY (_parent_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

