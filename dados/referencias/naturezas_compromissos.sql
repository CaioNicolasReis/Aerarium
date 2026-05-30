--
-- PostgreSQL database dump
--


-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

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
-- Data for Name: naturezas_compromissos; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.naturezas_compromissos VALUES (1, 'Cartão de Crédito', 'P');
INSERT INTO public.naturezas_compromissos VALUES (2, 'Assinatura / Recorrência', 'P');
INSERT INTO public.naturezas_compromissos VALUES (7, 'Imposto', 'P');
INSERT INTO public.naturezas_compromissos VALUES (8, 'Taxa / Juros', 'P');
INSERT INTO public.naturezas_compromissos VALUES (5, 'Aquisição de bem', 'P');
INSERT INTO public.naturezas_compromissos VALUES (4, 'Empréstimo concedido', 'A');
INSERT INTO public.naturezas_compromissos VALUES (10, 'Empréstimo', 'P');
INSERT INTO public.naturezas_compromissos VALUES (11, 'Financiamento', 'P');
INSERT INTO public.naturezas_compromissos VALUES (12, 'Parcelamento', 'P');


--
-- Name: naturezas_compromissos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.naturezas_compromissos_id_seq', 13, true);


--
-- PostgreSQL database dump complete
--


