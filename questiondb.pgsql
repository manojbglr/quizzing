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
    questionid bigint NOT NULL,
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
    username character varying(50) NOT NULL,
    testid bigint NOT NULL,
    questionid bigint NOT NULL,
    date date NOT NULL,
    locked boolean NOT NULL,
    keysequence character varying NOT NULL
);


ALTER TABLE public.userrecord OWNER TO postgres;

--
-- Name: usertest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usertest (
    username character varying(100) NOT NULL,
    testid bigint NOT NULL,
    attemptno bigint NOT NULL,
    attemptedon date NOT NULL,
    score bigint NOT NULL,
    percent numeric NOT NULL,
    starttime time with time zone NOT NULL,
    endtime time with time zone
);


ALTER TABLE public.usertest OWNER TO postgres;

--
-- Data for Name: answerkey; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.answerkey (questionid, questionkey, keytext, isvalid) FROM stdin;
1	a	This is optiona	t
1	b	This is option b	f
1	c	This is option c	f
1	d	This is option D	t
2	a	Question 2 Otion 1	f
2	b	Question 2 option 2	t
2	c	Option 3 of Question 2	f
2	d	Forth otion of Q2	f
\.


--
-- Data for Name: questionbank; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questionbank (questionid, qtext) FROM stdin;
1	Question 1 asks yu to solve a difficut case of scenarios. Choose all correct options from the isted choices below.
2	Question 2 Difficuty eve is enormous. Choose all statements which are true from teh choices provided.
\.


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test (testid, testname, testdescription, questioncount, totalmarks) FROM stdin;
1	SoftSkills-Presentation	To Test Presentation Skills of an Engineering Student	20	20
2	OSExpertise	This Test asseses the operating system appreciation by a computer science sophomore	15	30
3	CISCOCertification	A CISCO engineers requires Edge devices skill sets to be successfull in the field. A knwledge of components making up teh network will help with quick turnaround of issues.	20	50
4	DataStructures	Can a candidate solve data representation and analysis chalenges? What are the performance considerations? How do we ensure data is consistent and durable?	15	20
5	LanguageSkills-Java	Java being a very popular programming language for modern IT solutions, does the candidate possess enough understanding of encapsulating logical concerns around a modular solution?	25	25
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

COPY public.userrecord (username, testid, questionid, date, locked, keysequence) FROM stdin;
atulagrawal1901@gmail.com	1	1	2023-06-15	t	abc
atulagrawal1901@gmail.com	1	2	2023-06-15	t	a
student4@gmail.com	1	2	2023-06-15	t	a
student4@gmail.com	1	1	2023-06-15	t	a
student10@gmail.com	1	2	2023-06-15	t	a
student10@gmail.com	1	1	2023-06-15	t	a
student10@gmail.com	2	1	2023-06-15	t	a
student10@gmail.com	3	1	2023-06-15	t	a
student10@gmail.com	4	1	2023-06-15	t	a
student10@gmail.com	5	1	2023-06-15	t	bc
\.


--
-- Data for Name: usertest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usertest (username, testid, attemptno, attemptedon, score, percent, starttime, endtime) FROM stdin;
atulagrawal1901@gmail.com	4	1	2023-05-03	0	0	19:21:01-07	\N
atulagrawal1901@gmail.com	4	11	2023-05-03	0	0	19:26:01-07	\N
atulagrawal1901@gmail.com	4	3	2023-05-03	0	0	19:27:30-07	\N
atulagrawal1901@gmail.com	4	4	2023-05-03	0	0	19:55:37-07	\N
atulagrawal1901@gmail.com	4	5	2023-05-03	0	0	19:59:18-07	\N
atulagrawal1901@gmail.com	4	6	2023-06-14	0	0	20:01:05-07	\N
atulagrawal1901@gmail.com	4	7	2023-06-14	0	0	20:04:45-07	\N
student4@gmail.com	4	1	2023-06-14	0	0	20:05:57-07	\N
student43@gmail.com	4	1	2023-06-14	0	0	20:18:50-07	\N
\.


--
-- Name: answerkey QuestionBank_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.answerkey
    ADD CONSTRAINT "QuestionBank_pkey" PRIMARY KEY (questionid, questionkey);


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
-- Name: userrecord userrecord_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrecord
    ADD CONSTRAINT userrecord_pkey PRIMARY KEY (username, testid, questionid);


--
-- Name: usertest usertest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usertest
    ADD CONSTRAINT usertest_pkey PRIMARY KEY (username, testid, attemptno);


--
-- Name: email_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX email_idx ON public."user" USING btree (email) INCLUDE (email, mobileno);


--
-- Name: mobile_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX mobile_idx ON public."user" USING btree (mobileno);


--
-- Name: userrecord email; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.userrecord
    ADD CONSTRAINT email FOREIGN KEY (username) REFERENCES public."user"(email) NOT VALID;


--
-- PostgreSQL database dump complete
--

