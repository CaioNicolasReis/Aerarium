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
-- Data for Name: tipos_contas; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipos_contas VALUES (1, 'Conta corrente', NULL);
INSERT INTO public.tipos_contas VALUES (2, 'Conta poupança', NULL);
INSERT INTO public.tipos_contas VALUES (3, 'Conta salário', NULL);
INSERT INTO public.tipos_contas VALUES (4, 'Corretora', NULL);
INSERT INTO public.tipos_contas VALUES (5, 'Carteira digital', NULL);
INSERT INTO public.tipos_contas VALUES (6, 'Reserva liquidez imediata', NULL);
INSERT INTO public.tipos_contas VALUES (7, 'Dinheiro físico', NULL);
INSERT INTO public.tipos_contas VALUES (8, 'Outros', NULL);


--
-- Name: tipos_contas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipos_contas_id_seq', 8, true);


--
-- PostgreSQL database dump complete
--


