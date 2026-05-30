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
-- Data for Name: tipos_bens; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipos_bens VALUES (1, 'Renda fixa', NULL);
INSERT INTO public.tipos_bens VALUES (2, 'Bem físico', NULL);
INSERT INTO public.tipos_bens VALUES (3, 'Renda variável', NULL);
INSERT INTO public.tipos_bens VALUES (4, 'Criptoativos', NULL);
INSERT INTO public.tipos_bens VALUES (5, 'Participações', NULL);
INSERT INTO public.tipos_bens VALUES (6, 'A receber', NULL);
INSERT INTO public.tipos_bens VALUES (7, 'Tesouro Direto', 1);
INSERT INTO public.tipos_bens VALUES (8, 'CDB', 1);
INSERT INTO public.tipos_bens VALUES (9, 'LCI / LCA', 1);
INSERT INTO public.tipos_bens VALUES (10, 'Debêntures', 1);
INSERT INTO public.tipos_bens VALUES (11, 'Ações', 3);
INSERT INTO public.tipos_bens VALUES (12, 'FIIs', 3);
INSERT INTO public.tipos_bens VALUES (13, 'ETFs', 3);
INSERT INTO public.tipos_bens VALUES (14, 'BDRs', 3);
INSERT INTO public.tipos_bens VALUES (15, 'Bitcoin', 4);
INSERT INTO public.tipos_bens VALUES (16, 'Altcoins', 4);
INSERT INTO public.tipos_bens VALUES (17, 'Stablecoins', 4);
INSERT INTO public.tipos_bens VALUES (18, 'Eletrônico', 2);
INSERT INTO public.tipos_bens VALUES (19, 'Veículo', 2);
INSERT INTO public.tipos_bens VALUES (20, 'Imóvel', 2);
INSERT INTO public.tipos_bens VALUES (21, 'Mobiliário', 2);
INSERT INTO public.tipos_bens VALUES (22, 'Cotas de empresa', 5);
INSERT INTO public.tipos_bens VALUES (23, 'Fundo de investimento', 5);
INSERT INTO public.tipos_bens VALUES (24, 'Empréstimo concedido', 6);
INSERT INTO public.tipos_bens VALUES (25, 'Depósito / Caução', 6);


--
-- Name: tipos_bens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipos_bens_id_seq', 25, true);


--
-- PostgreSQL database dump complete
--


