--
-- PostgreSQL database dump
--

-- Dumped from database version 10.6
-- Dumped by pg_dump version 10.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: dblink; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS dblink WITH SCHEMA public;


--
-- Name: EXTENSION dblink; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION dblink IS 'connect to other PostgreSQL databases from within a database';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: beneficiary; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.beneficiary (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    fullname character varying(100),
    nric character varying(30),
    percentage numeric(19,2),
    relationship character varying(10),
    lfkproposal bigint
);


ALTER TABLE public.beneficiary OWNER TO admin;

--
-- Name: beneficiary_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.beneficiary_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.beneficiary_seq OWNER TO admin;

--
-- Name: commratedet; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.commratedet (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    applcode character varying(10),
    bascommrate numeric(19,2) NOT NULL,
    effdatefrom timestamp without time zone,
    effdateto timestamp without time zone,
    extracommrate numeric(19,2) NOT NULL,
    poldurafrom integer,
    poldurato integer,
    lfkcommratehdr bigint NOT NULL
);


ALTER TABLE public.commratedet OWNER TO admin;

--
-- Name: commratedet_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.commratedet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commratedet_seq OWNER TO admin;

--
-- Name: commratehdr; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.commratehdr (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    ratedesc character varying(50),
    ratename character varying(20) NOT NULL
);


ALTER TABLE public.commratehdr OWNER TO admin;

--
-- Name: commratehdr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.commratehdr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.commratehdr_seq OWNER TO admin;

--
-- Name: coverage; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.coverage (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    annzprem numeric(19,2),
    coverunit numeric(19,2),
    plancode character varying(30),
    plantype character varying(10),
    term integer,
    lfkproposal bigint
);


ALTER TABLE public.coverage OWNER TO admin;

--
-- Name: coverage_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.coverage_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.coverage_seq OWNER TO admin;

--
-- Name: document; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.document (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    filename character varying(100),
    lfkproposal bigint
);


ALTER TABLE public.document OWNER TO admin;

--
-- Name: document_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.document_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.document_seq OWNER TO admin;

--
-- Name: insured; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.insured (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    age integer,
    dob timestamp without time zone NOT NULL,
    email character varying(100),
    firstname character varying(50),
    gender character varying(10),
    height numeric(19,2),
    lastname character varying(50),
    snationality character varying(20),
    nric character varying(20),
    otherid character varying(20),
    race character varying(20),
    weight numeric(19,2),
    lfkproposal bigint
);


ALTER TABLE public.insured OWNER TO admin;

--
-- Name: insured_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.insured_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.insured_seq OWNER TO admin;

--
-- Name: planmaster; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.planmaster (
    lseqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    alwpremmethod character varying(100) NOT NULL,
    alwpremmode character varying(100) NOT NULL,
    approvedate timestamp without time zone NOT NULL,
    benefittype character varying(10),
    scurrency character varying(255) NOT NULL,
    launchdatefr timestamp without time zone,
    launchdateto timestamp without time zone,
    plancode character varying(10) NOT NULL,
    planname character varying(70),
    plantype character varying(10),
    prodcat character varying(10),
    singleprem boolean,
    status character varying(10),
    lfkcommratehdr bigint,
    lfkpremratehdr bigint,
    minsa numeric(19,2),
    maxsa numeric(19,2)
);


ALTER TABLE public.planmaster OWNER TO admin;

--
-- Name: planmaster_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.planmaster_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planmaster_seq OWNER TO admin;

--
-- Name: policyholder; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.policyholder (
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    age integer,
    dob timestamp without time zone NOT NULL,
    email character varying(100),
    firstname character varying(50),
    gender character varying(10),
    height numeric(19,2),
    lastname character varying(50),
    snationality character varying(20),
    nric character varying(20),
    otherid character varying(20),
    race character varying(20),
    weight numeric(19,2),
    proposal_seqid bigint NOT NULL
);


ALTER TABLE public.policyholder OWNER TO admin;

--
-- Name: premratedet; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.premratedet (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    amount numeric(19,2) NOT NULL,
    effdatefrom timestamp without time zone,
    effdatetp timestamp without time zone,
    entryagefrom integer NOT NULL,
    entryageto integer NOT NULL,
    polyearfrom integer NOT NULL,
    polyearto integer NOT NULL,
    rate numeric(19,2) NOT NULL,
    safrom numeric(19,2) NOT NULL,
    sato numeric(19,2) NOT NULL,
    lfkpremratehdr bigint NOT NULL
);


ALTER TABLE public.premratedet OWNER TO admin;

--
-- Name: premratedet_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.premratedet_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.premratedet_seq OWNER TO admin;

--
-- Name: premratehdr; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.premratehdr (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    discrate numeric(19,2) NOT NULL,
    ratedesc character varying(50),
    ratename character varying(20) NOT NULL
);


ALTER TABLE public.premratehdr OWNER TO admin;

--
-- Name: premratehdr_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.premratehdr_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.premratehdr_seq OWNER TO admin;

--
-- Name: proposal; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.proposal (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    accepteddate timestamp without time zone,
    benefitterm integer,
    cigperday integer,
    covterm integer,
    entrydate timestamp without time zone,
    instlprem numeric(19,2),
    maturitydate timestamp without time zone,
    plancode character varying(10),
    policyno character varying(20),
    premmethod character varying(10),
    premmode character varying(10),
    premterm integer,
    process_id integer,
    sproposalno character varying(20),
    recvdate timestamp without time zone,
    status character varying(10),
    sumassured numeric(19,2),
    transdate timestamp without time zone
);


ALTER TABLE public.proposal OWNER TO admin;

--
-- Name: proposal_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.proposal_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.proposal_seq OWNER TO admin;

--
-- Name: tsar; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tsar (
    seqid bigint NOT NULL,
    lastmodby character varying(255) NOT NULL,
    lastmoddate timestamp without time zone NOT NULL,
    fullname character varying(100),
    nric character varying(30),
    tsar numeric(19,2)
);


ALTER TABLE public.tsar OWNER TO admin;

--
-- Name: tsar_dup; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.tsar_dup (
    seqid bigint NOT NULL,
    lastmodby character varying(255),
    lastmoddate timestamp without time zone,
    fullname character varying(100),
    nric character varying(30),
    tsar numeric(19,2)
);


ALTER TABLE public.tsar_dup OWNER TO admin;

--
-- Name: tsar_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.tsar_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.tsar_seq OWNER TO admin;

--
-- Data for Name: beneficiary; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.beneficiary (seqid, lastmodby, lastmoddate, fullname, nric, percentage, relationship, lfkproposal) FROM stdin;
1	SYSTEM	2019-11-21 17:19:34.199	Tsan Je-Anne	000303145671	100.00	D	1
2	SYSTEM	2019-11-22 02:41:17.632	Krystal	941212145631	100.00	D	2
3	SYSTEM	2019-11-26 08:25:03.591	wahab	941212145631	100.00	F	5
4	SYSTEM	2019-11-26 08:36:03.396	Tsan	mohammed	100.00	F	7
5	SYSTEM	2019-11-26 10:24:18.855	testdad	672323243243	100.00	F	10
6	SYSTEM	2019-11-29 02:19:52.65	WYyeng Yui	880102-01-5666	100.00	D	26
7	SYSTEM	2019-11-29 04:15:51.831	Azizah Hamidi	941020-07-5682	100.00	D	27
8	SYSTEM	2019-11-29 04:31:30.299	Amanda	901212-12-5672	100.00	D	28
9	SYSTEM	2019-11-29 04:53:43.394	Tan Weng Wai	821002-03-7641	100.00	H	29
10	SYSTEM	2019-11-29 04:57:47.021	Tan Kar Wai	981010-10-5831	100.00	S	30
\.


--
-- Data for Name: commratedet; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.commratedet (seqid, lastmodby, lastmoddate, applcode, bascommrate, effdatefrom, effdateto, extracommrate, poldurafrom, poldurato, lfkcommratehdr) FROM stdin;
1	SYSTEM	2019-11-18 16:51:48.856	COMM	0.70	2019-01-01 08:00:00	2999-12-31 08:00:00	0.00	1	6	1
\.


--
-- Data for Name: commratehdr; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.commratehdr (seqid, lastmodby, lastmoddate, ratedesc, ratename) FROM stdin;
2	SYSTEM	2019-11-18 16:27:28.097	Commission Rate 2	COMMRATE2
1	SYSTEM	2019-11-18 16:41:18.041	Commission Rate 1	COMMRATE1
\.


--
-- Data for Name: coverage; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.coverage (seqid, lastmodby, lastmoddate, annzprem, coverunit, plancode, plantype, term, lfkproposal) FROM stdin;
\.


--
-- Data for Name: document; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.document (seqid, lastmodby, lastmoddate, filename, lfkproposal) FROM stdin;
8	SYSTEM	2020-01-03 03:29:42.27		30
9	SYSTEM	2020-01-03 03:29:56.613	SampleMedicalReport.pdf	30
\.


--
-- Data for Name: insured; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.insured (seqid, lastmodby, lastmoddate, age, dob, email, firstname, gender, height, lastname, snationality, nric, otherid, race, weight, lfkproposal) FROM stdin;
1	SYSTEM	2019-11-21 17:18:59.717	\N	1977-12-14 00:00:00	michael@gmail.com	Michael	M	\N	Tsan	\N	771214145631		C	\N	1
2	SYSTEM	2019-11-22 02:40:11.837	\N	1980-12-12 00:00:00	seanloo@gmail.com	Sean	M	\N	Loo	\N	801212145432		C	\N	2
3	SYSTEM	2019-11-26 08:24:30.405	\N	2010-06-29 00:00:00	haithem124@gmail.com	haithamm	M	\N	hashem	\N	801212145432		O	\N	5
4	SYSTEM	2019-11-26 08:35:22.008	\N	1985-06-18 00:00:00	hhhh@redhat.com	ahmed	M	\N	mohammed	\N	771214145631		O	\N	7
5	SYSTEM	2019-11-26 10:23:54.803	\N	2019-11-06 00:00:00	abcd@gmail.com	newtest	M	\N	newtestlast	\N	874344324324		C	\N	10
7	SYSTEM	2019-11-29 02:19:25.197	37	1982-02-02 00:00:00	cytan@gmail.com	CY	M	176.00	Teng	AL	820202-01-5215		C	65.00	26
10	SYSTEM	2019-11-29 04:30:33.715	31	1987-12-12 00:00:00	seanloo12345@gmail.com	Sean	M	175.00	Loo	MY	871212-12-7891		C	65.00	28
11	SYSTEM	2019-11-29 04:52:55.727	30	1988-12-12 00:00:00	limmeiling@hotmail.com	Mei Ling	F	165.00	Lim	MY	881212-10-7682		C	48.00	29
12	SYSTEM	2019-11-29 04:57:13.918	33	1986-03-05 00:00:00	tankl@hotmail.com	Keng Liang	M	175.00	Tan	MY	860305-06-7891		C	65.00	30
8	SYSTEM	2020-01-02 06:35:36.569	27	1992-05-25 00:00:00	hamidi@gmail.com	Hamidi	F	175.00	Zahid	MY	920525-01-1234		M	65.00	27
\.


--
-- Data for Name: planmaster; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.planmaster (lseqid, lastmodby, lastmoddate, alwpremmethod, alwpremmode, approvedate, benefittype, scurrency, launchdatefr, launchdateto, plancode, planname, plantype, prodcat, singleprem, status, lfkcommratehdr, lfkpremratehdr, minsa, maxsa) FROM stdin;
2	SYSTEM	2019-11-27 04:20:10.18	CASH	M,Q,H,A	2019-10-12 00:00:00	TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECMED	SECURE MEDICAL	B	TL	f	ACTV	2	2	0.00	300000.00
1	SYSTEM	2019-11-27 04:20:25.734	CASH	M,Q,H,A	2019-10-12 00:00:00	DEATH,TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECPRCT	SECURE PROTECT	B	TL	f	ACTV	1	1	0.00	300000.00
7	SYSTEM	2019-11-27 04:20:41.804	CASH,CC	M,A	2019-10-12 00:00:00	TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	GBSN003	Test Product 1	B	TL	f	ACTV	1	2	0.00	300000.00
6	SYSTEM	2019-11-27 04:20:52.705	CASH,CC	M,Q,H,A	2019-10-12 00:00:00	TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	GBSN0001	GBSN MEDICAL PRODUCT	B	TL	f	ACTV	1	2	0.00	300000.00
5	SYSTEM	2019-11-27 04:21:04.754	CASH,CC	M,Q,H,A	2019-10-12 00:00:00	TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECPRCT_E	Secure Protect Enhanced	B	TL	f	ACTV	1	2	0.00	300000.00
4	SYSTEM	2019-11-27 04:21:15.117	CASH,CC	M,Q,H,A	2019-11-06 00:00:00	DEATH,TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECEDU_E	Enhanced Secure Education	B	TL	f	ACTV	2	2	0.00	300000.00
3	SYSTEM	2019-11-27 04:21:27.345	CASH	M,Q,H,A	2019-11-06 00:00:00	DEATH,TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECEDU	SECURE EDUCATION	B	TL	f	ACTV	2	2	0.00	300000.00
9	SYSTEM	2020-01-02 06:20:20.021	CASH,CC	M,Q,H,A	2019-10-12 00:00:00	DEATH,TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	GBSN-Test	New Test Plan	B	TL	f	ACTV	1	2	100000.00	300000.00
10	SYSTEM	2020-01-03 03:13:17.234	CASH,CC	M,Q,H,A	2019-10-12 00:00:00	DEATH,TPD	MYR	2019-10-01 00:00:00	2999-12-31 00:00:00	SECEDU-T	Enhanced Secure Education	B	TL	f	ACTV	1	2	100000.00	300000.00
\.


--
-- Data for Name: policyholder; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.policyholder (lastmodby, lastmoddate, age, dob, email, firstname, gender, height, lastname, snationality, nric, otherid, race, weight, proposal_seqid) FROM stdin;
SYSTEM	2019-11-22 08:06:49.298	30	1977-12-14 00:00:00	yelee@redhat.com	Michaek	M	175.00	Tsan	MY	860211082656		C	65.00	4
SYSTEM	2019-11-25 16:11:32.586	42	1977-12-14 00:00:00	michael@gmail.com	Michael	M	175.00	Tsan	MY	850211082656		C	65.00	1
SYSTEM	2019-11-26 08:23:43.382	21	1999-02-11 00:00:00	haithem2@gmail.com	Haithm	M	190.00	Hashem	YE	640325145672		O	65.00	5
SYSTEM	2019-11-26 08:33:43.658	46	2000-06-13 00:00:00	dddd@hhh.com	Hashem	M	170.00	Nedhal	YE	850211082656		O	65.00	7
SYSTEM	2019-11-26 10:23:22.662	32	1990-10-31 00:00:00	abc@gmail.com	Testname	M	195.00	testlastname	MY	84567890234		C	80.00	10
SYSTEM	2019-11-26 10:35:50.145	21	2019-11-11 00:00:00	haithem124@gmail.com	Haithm Nedhal	F	190.00	Hashem	MY	801212145432		O	65.00	13
SYSTEM	2019-11-27 04:26:41.033	41	1977-12-14 00:00:00	testing@gmail.com	Michael	M	175.00	Tsan	MY	771214-14-5631		C	65.00	11
SYSTEM	2019-11-27 04:29:00.604	32	1986-12-23 00:00:00	ahmad@gmail.com	Ahmad	M	167.00	Zainuddin	MY	861223-14-5765		M	78.00	18
SYSTEM	2019-11-28 07:05:22.949	41	1977-12-15 00:00:00	test@gmail.com	Michael	M	175.00	Tsan	MY	771215-15-4521		C	65.00	23
SYSTEM	2019-11-28 07:55:32.295	42	1977-01-01 00:00:00	cheetan2@redhat.com	CY	M	175.00	Tan	AU	770101-01-2211		C	65.00	25
SYSTEM	2019-11-22 03:35:00.435	26	1986-02-11 00:00:00	c2@email.com	CY	M	180.00	Tan	ID	860211082656		C	65.00	3
SYSTEM	2019-11-28 08:02:16.734	43	1970-07-15 00:00:00	michaeltsan990@gmail.com	Sean	M	175.00	Loo	MY	640325145672		C	65.00	2
SYSTEM	2019-11-28 12:34:49.935	30	1988-12-12 00:00:00	cheetan@redhat.com	CY	F	168.00	Tan	AE	881212-01-2112		C	52.00	26
SYSTEM	2019-11-29 04:27:41.71	32	1987-09-13 00:00:00	seanloo@gmail.com	Sean 	M	160.00	Loo	MY	870913-06-7891		C	65.00	28
SYSTEM	2019-11-29 04:52:11.195	30	1989-10-10 00:00:00	limmeiling@hotmail.com	Mei Ling	F	165.00	Lim	MY	891010-12-7832		C	48.00	29
SYSTEM	2019-11-29 04:56:30.323	32	1987-04-15 00:00:00	tankl@hotmail.com	Keng Liang	M	175.00	Tan	MY	870415-10-5631		C	65.00	30
SYSTEM	2020-01-03 03:19:51.058	30	1990-01-03 00:00:00	hamidi@gmail.com	Hamidi	F	175.00	Zahid	MY	900103-01-1234		M	65.00	27
\.


--
-- Data for Name: premratedet; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.premratedet (seqid, lastmodby, lastmoddate, amount, effdatefrom, effdatetp, entryagefrom, entryageto, polyearfrom, polyearto, rate, safrom, sato, lfkpremratehdr) FROM stdin;
4	SYSTEM	2019-11-27 04:34:02.017	0.00	2019-01-01 00:00:00	2999-12-31 00:00:00	1	99	1	99	0.02	0.00	200000.00	1
2	SYSTEM	2019-11-27 04:34:25.639	0.00	2019-01-01 00:00:00	2999-12-31 00:00:00	31	60	1	99	0.03	200001.00	300000.00	1
1	SYSTEM	2019-11-27 04:34:49.016	0.00	2019-01-01 00:00:00	2999-12-31 00:00:00	1	99	1	99	0.04	300001.00	9999999.00	1
3	SYSTEM	2019-11-27 04:35:18.08	0.00	2019-11-01 00:00:00	2099-12-31 00:00:00	1	99	1	99	0.03	0.00	200000.00	2
5	SYSTEM	2019-11-27 04:35:30.488	0.00	2019-11-01 00:00:00	2099-12-31 00:00:00	1	99	1	99	0.04	200001.00	300000.00	2
6	SYSTEM	2019-11-27 04:35:42.044	0.00	2019-11-01 00:00:00	2099-12-31 00:00:00	1	99	1	99	0.05	300001.00	9999999.00	2
\.


--
-- Data for Name: premratehdr; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.premratehdr (seqid, lastmodby, lastmoddate, discrate, ratedesc, ratename) FROM stdin;
2	SYSTEM	2019-11-18 16:27:28.104	0.10	Premium Rate 2	PREMRATE2
1	SYSTEM	2019-11-18 16:41:18.048	0.10	Premium Rate 1	PREMRATE1
\.


--
-- Data for Name: proposal; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.proposal (seqid, lastmodby, lastmoddate, accepteddate, benefitterm, cigperday, covterm, entrydate, instlprem, maturitydate, plancode, policyno, premmethod, premmode, premterm, process_id, sproposalno, recvdate, status, sumassured, transdate) FROM stdin;
22	SYSTEM	2019-11-28 06:42:25.948	\N	\N	15	60	2019-11-13 00:00:00	12000.00	2069-11-13 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190001424	2019-11-13 00:00:00	S	300000.00	2019-11-13 00:00:00
10	SYSTEM	2019-11-28 06:58:06.868	\N	\N	10	30	2019-11-27 00:00:00	100000.00	2020-11-26 00:00:00	SECMED	\N	CC	Q	30	253	PROP20190009547	2019-11-27 00:00:00	S	100000.00	2019-11-27 00:00:00
23	SYSTEM	2019-11-28 07:25:26.541	\N	\N	10	50	2019-11-20 00:00:00	12000.00	2099-12-23 00:00:00	SECMED	\N	CASH	M	50	254	PROP20190007355	2019-11-20 00:00:00	S	300000.00	2019-11-20 00:00:00
24	SYSTEM	2019-11-28 07:52:35.642	\N	\N	15	45	2019-11-27 00:00:00	5400.00	2041-11-27 00:00:00	SECMED	\N	CASH	M	45	\N	PROP20190006018	2019-11-27 00:00:00	S	180000.00	2019-11-27 00:00:00
11	SYSTEM	2019-11-26 10:29:34.218	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190003202	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
12	SYSTEM	2019-11-26 10:31:11.07	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190003822	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
13	SYSTEM	2019-11-26 10:34:47.592	\N	\N	15	60	2019-11-01 00:00:00	1200.00	2019-11-13 00:00:00	SECPRCT	\N	CASH	M	60	\N	PROP20190004093	2019-10-28 00:00:00	S	300000.00	2019-11-20 00:00:00
14	SYSTEM	2019-11-26 10:38:40.745	\N	\N	15	60	2019-11-01 00:00:00	1200.00	2019-11-13 00:00:00	SECPRCT	\N	CASH	M	60	\N	PROP20190005088	2019-10-28 00:00:00	S	300000.00	2019-11-20 00:00:00
15	SYSTEM	2019-11-26 10:41:27.828	\N	\N	15	60	2019-11-01 00:00:00	1200.00	2019-11-13 00:00:00	SECPRCT	\N	CASH	M	60	\N	PROP20190003324	2019-10-28 00:00:00	S	300000.00	2019-11-20 00:00:00
16	SYSTEM	2019-11-26 10:41:57.561	\N	\N	5	60	2019-11-27 00:00:00	1200.00	2019-11-17 00:00:00	SECEDU	\N	CASH	M	50	\N	PROP20190008652	2019-11-10 00:00:00	S	300000.00	2019-11-15 00:00:00
17	SYSTEM	2019-11-26 10:59:39.799	\N	\N	15	60	2019-11-01 00:00:00	1200.00	2019-11-13 00:00:00	SECPRCT	\N	CASH	M	60	\N	PROP20190006539	2019-10-28 00:00:00	S	300000.00	2019-11-20 00:00:00
4	SYSTEM	2019-11-22 08:07:12.646	\N	\N	10	50	2019-11-20 00:00:00	1200.00	2069-11-13 00:00:00	GBSN003	\N	CASH	M	50	152	PROP20190008783	2019-11-20 00:00:00	S	300000.00	2019-11-20 00:00:00
19	SYSTEM	2019-11-27 03:12:44.449	\N	\N	0	30	2019-11-27 00:00:00	1500.00	2020-12-27 00:00:00	SECMED	\N	CASH	M	20	\N	PROP20190008440	2019-11-27 00:00:00	S	30000.00	2019-11-27 00:00:00
18	SYSTEM	2019-11-27 04:28:12.417	\N	\N	10	60	2019-11-28 00:00:00	10000.00	2069-11-28 00:00:00	SECEDU	\N	CASH	M	30	\N	PROP20190007146	2019-11-28 00:00:00	S	300000.00	2019-11-28 00:00:00
30	SYSTEM	2020-01-03 03:26:46.371	\N	\N	20	58	2020-01-02 00:00:00	6000.00	2068-11-29 00:00:00	SECEDU-T	\N	CASH	A	25	323	PROP20190004151	2020-01-02 00:00:00	A	200000.00	2020-01-02 00:00:00
3	SYSTEM	2020-01-03 00:45:19.915	\N	\N	10	60	2019-11-13 00:00:00	2000.00	2069-11-13 00:00:00	SECMED	POL20200008840	CASH	M	60	148	PROP20190009292	2019-11-13 00:00:00	AP	400000.00	2019-11-13 00:00:00
20	SYSTEM	2019-11-27 08:57:31.49	\N	\N	0	20	2019-11-27 00:00:00	\N	\N	SECMED	\N	CASH	H	20	\N	PROP20190003154	2019-11-27 00:00:00	S	100000.00	2019-11-27 00:00:00
21	SYSTEM	2019-11-27 09:07:42.516	\N	\N	0	20	2019-11-27 00:00:00	\N	2039-11-27 00:00:00	SECMED	\N	CASH	A	20	\N	PROP20190004360	2019-11-27 00:00:00	S	120000.00	2019-11-27 00:00:00
1	SYSTEM	2019-11-25 15:52:44.588	\N	\N	5	50	2019-11-13 00:00:00	1200.00	2069-11-13 00:00:00	SECPRCT	\N	CASH	M	50	173	PROP20190006599	2019-11-13 00:00:00	S	300000.00	2019-11-13 00:00:00
5	SYSTEM	2019-11-26 08:21:54.271	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190001505	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
6	SYSTEM	2019-11-26 08:26:35.352	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190003439	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
7	SYSTEM	2019-11-26 08:31:23.25	\N	\N	5	50	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	SECPRCT	\N	CASH	M	50	\N	PROP20190005047	2019-11-26 00:00:00	S	3000000.00	2019-11-26 00:00:00
8	SYSTEM	2019-11-26 08:58:44.425	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190002257	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
9	SYSTEM	2019-11-26 09:51:33.52	\N	\N	15	60	2019-11-26 00:00:00	1200.00	2019-11-26 00:00:00	GBSN0001	\N	CASH	M	60	\N	PROP20190009400	2019-11-26 00:00:00	S	300000.00	2019-11-26 00:00:00
28	SYSTEM	2019-11-29 04:36:13.178	\N	\N	15	50	2019-11-29 00:00:00	3600.00	2069-11-29 00:00:00	GBSN003	POL20190006561	CASH	A	20	302	PROP20190001760	2019-11-29 00:00:00	AP	120000.00	2019-11-29 00:00:00
2	SYSTEM	2019-11-29 03:05:56.382	\N	\N	15	60	2019-11-13 00:00:00	1200.00	2069-11-13 00:00:00	GBSN0001	POL20190002143	CASH	M	60	257	PROP20190003203	2019-11-13 00:00:00	AP	100000.00	2019-11-13 00:00:00
26	SYSTEM	2019-11-29 02:22:56.556	\N	\N	21	33	2019-11-27 00:00:00	12000.00	2019-11-27 00:00:00	SECMED	POL20190009054	CASH	M	33	297	PROP20190007172	2019-11-27 00:00:00	S	300000.00	2019-11-27 00:00:00
29	SYSTEM	2019-11-29 07:13:42.279	\N	\N	0	55	2019-11-29 00:00:00	2000.00	2079-11-29 00:00:00	SECPRCT	POL20190003924	CASH	A	30	304	PROP20190005307	2019-11-29 00:00:00	AP	100000.00	2019-11-29 00:00:00
25	SYSTEM	2019-11-28 16:28:14.5	\N	\N	15	42	2019-11-27 00:00:00	\N	2019-11-30 00:00:00	SECMED	POL20190001691	CASH	M	42	255	PROP20190007528	2019-11-27 00:00:00	AP	300000.00	2019-11-27 00:00:00
27	SYSTEM	2020-01-03 03:23:56.564	\N	\N	0	60	2020-01-03 00:00:00	3900.00	2079-11-29 00:00:00	SECEDU-T	POL20200006196	CASH	A	60	322	PROP20190008454	2020-01-03 00:00:00	AP	130000.00	2020-01-03 00:00:00
\.


--
-- Data for Name: tsar; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tsar (seqid, lastmodby, lastmoddate, fullname, nric, tsar) FROM stdin;
1	SYSTEM	2019-11-18 16:27:28.104	Peter Lee	860211082656	15000.00
2	SYSTEM	2019-11-18 16:27:28.104	John Tan	850211082656	20000.00
\.


--
-- Data for Name: tsar_dup; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.tsar_dup (seqid, lastmodby, lastmoddate, fullname, nric, tsar) FROM stdin;
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
1	\N	\N	\N	xxx	10000.00
\.


--
-- Name: beneficiary_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.beneficiary_seq', 10, true);


--
-- Name: commratedet_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.commratedet_seq', 1, false);


--
-- Name: commratehdr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.commratehdr_seq', 1, false);


--
-- Name: coverage_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.coverage_seq', 1, false);


--
-- Name: document_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.document_seq', 9, true);


--
-- Name: insured_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.insured_seq', 12, true);


--
-- Name: planmaster_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.planmaster_seq', 10, true);


--
-- Name: premratedet_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.premratedet_seq', 6, true);


--
-- Name: premratehdr_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.premratehdr_seq', 1, false);


--
-- Name: proposal_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.proposal_seq', 30, true);


--
-- Name: tsar_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.tsar_seq', 1, false);


--
-- Name: beneficiary beneficiary_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.beneficiary
    ADD CONSTRAINT beneficiary_pkey PRIMARY KEY (seqid);


--
-- Name: commratedet commratedet_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.commratedet
    ADD CONSTRAINT commratedet_pkey PRIMARY KEY (seqid);


--
-- Name: commratehdr commratehdr_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.commratehdr
    ADD CONSTRAINT commratehdr_pkey PRIMARY KEY (seqid);


--
-- Name: coverage coverage_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coverage
    ADD CONSTRAINT coverage_pkey PRIMARY KEY (seqid);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT document_pkey PRIMARY KEY (seqid);


--
-- Name: insured insured_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.insured
    ADD CONSTRAINT insured_pkey PRIMARY KEY (seqid);


--
-- Name: planmaster planmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.planmaster
    ADD CONSTRAINT planmaster_pkey PRIMARY KEY (lseqid);


--
-- Name: policyholder policyholder_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policyholder
    ADD CONSTRAINT policyholder_pkey PRIMARY KEY (proposal_seqid);


--
-- Name: premratedet premratedet_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.premratedet
    ADD CONSTRAINT premratedet_pkey PRIMARY KEY (seqid);


--
-- Name: premratehdr premratehdr_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.premratehdr
    ADD CONSTRAINT premratehdr_pkey PRIMARY KEY (seqid);


--
-- Name: proposal proposal_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.proposal
    ADD CONSTRAINT proposal_pkey PRIMARY KEY (seqid);


--
-- Name: tsar tsar_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.tsar
    ADD CONSTRAINT tsar_pkey PRIMARY KEY (seqid);


--
-- Name: policyholder uk_6attxwp58jqj4g7saa3diyrsx; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policyholder
    ADD CONSTRAINT uk_6attxwp58jqj4g7saa3diyrsx UNIQUE (email);


--
-- Name: planmaster uk_gpqpcw6fx7w1nqffc93ungeij; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.planmaster
    ADD CONSTRAINT uk_gpqpcw6fx7w1nqffc93ungeij UNIQUE (plancode);


--
-- Name: insured uk_k2mgd5h3s9ibhc6934dfscehg; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.insured
    ADD CONSTRAINT uk_k2mgd5h3s9ibhc6934dfscehg UNIQUE (email);


--
-- Name: coverage fk2hym07gjgg52lkm947yky0lv5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.coverage
    ADD CONSTRAINT fk2hym07gjgg52lkm947yky0lv5 FOREIGN KEY (lfkproposal) REFERENCES public.proposal(seqid);


--
-- Name: planmaster fk5iim4om94jke91oym81g30f0m; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.planmaster
    ADD CONSTRAINT fk5iim4om94jke91oym81g30f0m FOREIGN KEY (lfkcommratehdr) REFERENCES public.commratehdr(seqid);


--
-- Name: policyholder fkacwlhsl07n2193g8789vxvqo5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.policyholder
    ADD CONSTRAINT fkacwlhsl07n2193g8789vxvqo5 FOREIGN KEY (proposal_seqid) REFERENCES public.proposal(seqid);


--
-- Name: document fki4bjl6i2l4d1n9f6r8riw5kqd; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.document
    ADD CONSTRAINT fki4bjl6i2l4d1n9f6r8riw5kqd FOREIGN KEY (lfkproposal) REFERENCES public.proposal(seqid);


--
-- Name: beneficiary fkjja733kxw8dssi1cep2w1g0w5; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.beneficiary
    ADD CONSTRAINT fkjja733kxw8dssi1cep2w1g0w5 FOREIGN KEY (lfkproposal) REFERENCES public.proposal(seqid);


--
-- Name: insured fkm4jjrf42r77gluwhp7tmsh8f1; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.insured
    ADD CONSTRAINT fkm4jjrf42r77gluwhp7tmsh8f1 FOREIGN KEY (lfkproposal) REFERENCES public.proposal(seqid);


--
-- Name: planmaster fknhcwqi862xd2mny9vxjb058vg; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.planmaster
    ADD CONSTRAINT fknhcwqi862xd2mny9vxjb058vg FOREIGN KEY (lfkpremratehdr) REFERENCES public.premratehdr(seqid);


--
-- Name: premratedet fkp9vmqflicd7y38idsr063pm4m; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.premratedet
    ADD CONSTRAINT fkp9vmqflicd7y38idsr063pm4m FOREIGN KEY (lfkpremratehdr) REFERENCES public.premratehdr(seqid);


--
-- Name: commratedet fkt05cq0iheviu8nynpmm4nstii; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.commratedet
    ADD CONSTRAINT fkt05cq0iheviu8nynpmm4nstii FOREIGN KEY (lfkcommratehdr) REFERENCES public.commratehdr(seqid);


--
-- PostgreSQL database dump complete
--

