--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: answerkey; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.answerkey (
    "questionId" bigint NOT NULL,
    questionkey "char" NOT NULL,
    keytext character varying NOT NULL,
    isvalid boolean NOT NULL
);


ALTER TABLE public.answerkey OWNER TO postgres;

--
-- Name: questionbank; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questionbank (
    questionid bigint NOT NULL,
    qtext character varying NOT NULL
);


ALTER TABLE public.questionbank OWNER TO postgres;

--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.test (
    testid bigint NOT NULL,
    testname character varying(100) NOT NULL,
    testdescription character varying(250),
    questioncount bigint,
    totalmarks bigint
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: testcollection; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.testcollection (
    testid bigint NOT NULL,
    questionid bigint NOT NULL
);


ALTER TABLE public.testcollection OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    username character varying(100) NOT NULL,
    email character varying(100),
    mobileno bigint,
    password character varying(200)
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: userrecord; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.userrecord (
    username character varying(20) NOT NULL,
    testid bigint NOT NULL,
    questionid bigint NOT NULL,
    keysequence "char"[] NOT NULL,
    date date NOT NULL,
    locked boolean NOT NULL
);


ALTER TABLE public.userrecord OWNER TO postgres;

--
-- Data for Name: answerkey; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answerkey ("questionId", questionkey, keytext, isvalid) FROM stdin;
\.


--
-- Data for Name: questionbank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questionbank (questionid, qtext) FROM stdin;
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (testid, testname, testdescription, questioncount, totalmarks) FROM stdin;
\.


--
-- Data for Name: testcollection; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testcollection (testid, questionid) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (username, email, mobileno, password) FROM stdin;
atulagrax	atulagrawal1901@gmail.com	7008251350	demo#01
student1	student1@gmail.co.in	9855500912	password1
student2	student2@yahoo.com	809932132	password2
student3	student3@kiit.co.in	9931295123	password3
Student4 KIIT	student4@gmail.com	9876512345	password1234
Student5 KIIT	student5@gmail.com	7777712345	pass@demo12
Student10KIIT	student10@gmail.com	1234554321	password1234
Student11KIIT	student11@gmail.com	1234554321	password1234
Student12KIIT	student12@gmail.com	1234554321	password1234
Student13KIIT	student13@gmail.com	1234554321	\N
Student15KIIT	student15@gmail.com	1234554321	\N
Student41 KIIT	student41@gmail.com	1234554321	\N
Student42 KIIT	student42@gmail.com	1234554321	\N
Student43 KIIT	student43@gmail.com	1234554321	$2a$10$ekKaJo.mUEupZdveMzQWv.xxw0o6AVtcbXnxXi/DMrxSBtoLANSKO
Student44 KIIT	student44@gmail.com	1234554321	$2a$10$qrd13mDiMHFyPtIAye8/F.NohIrJ4fESqprmzhNGzSEn5fxJitFSa
Student45 KIIT	student45@gmail.com	1234554321	$2a$10$JkBPCjIJJW.byet98aZm7ux9j0xrWvpx4zqRhz9QjjA9VuusmsT1K
Student46 KIIT	student46@gmail.com	1234554321	$2a$10$Mw0Nh1TW0yuKiN//GhWA.eOqBXeJGa0yvJlAdS5bQpdv.jq2/Qxo2
\.


--
-- Data for Name: userrecord; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.userrecord (username, testid, questionid, keysequence, date, locked) FROM stdin;
\.


--
-- Name: answerkey QuestionBank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answerkey
    ADD CONSTRAINT "QuestionBank_pkey" PRIMARY KEY ("questionId", questionkey);


--
-- Name: questionbank QuestionBank_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questionbank
    ADD CONSTRAINT "QuestionBank_pkey1" PRIMARY KEY (questionid);


--
-- Name: test Test_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test
    ADD CONSTRAINT "Test_pkey" PRIMARY KEY (testid, testname);


--
-- Name: user username_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT username_pk PRIMARY KEY (username) INCLUDE (email);


--
-- Name: email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX email_idx ON public."user" USING btree (email) INCLUDE (email, mobileno);


--
-- Name: mobile_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mobile_idx ON public."user" USING btree (mobileno);


--
-- PostgreSQL database dump complete
--

