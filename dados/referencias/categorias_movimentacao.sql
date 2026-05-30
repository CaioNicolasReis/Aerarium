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
-- Data for Name: cat_mov; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cat_mov VALUES (1, 'Receita', NULL, NULL);
INSERT INTO public.cat_mov VALUES (2, 'Gasto', NULL, NULL);
INSERT INTO public.cat_mov VALUES (4, 'Amortização', NULL, NULL);
INSERT INTO public.cat_mov VALUES (5, 'Aquisição de bem', NULL, NULL);
INSERT INTO public.cat_mov VALUES (6, 'Venda de bem', NULL, NULL);
INSERT INTO public.cat_mov VALUES (7, 'Manutenção de bem', NULL, NULL);
INSERT INTO public.cat_mov VALUES (8, 'Transferência', NULL, NULL);
INSERT INTO public.cat_mov VALUES (9, 'Reavaliação', NULL, NULL);
INSERT INTO public.cat_mov VALUES (12, 'Crédito', NULL, NULL);
INSERT INTO public.cat_mov VALUES (13, 'Dados históricos', NULL, NULL);
INSERT INTO public.cat_mov VALUES (14, 'Outros', NULL, NULL);
INSERT INTO public.cat_mov VALUES (15, 'Salário CLT', 1, NULL);
INSERT INTO public.cat_mov VALUES (16, 'Pró-labore', 1, NULL);
INSERT INTO public.cat_mov VALUES (17, 'Freelance', 1, NULL);
INSERT INTO public.cat_mov VALUES (18, 'Rendimento de investimento', 1, NULL);
INSERT INTO public.cat_mov VALUES (20, 'Reembolso / Estorno', 1, NULL);
INSERT INTO public.cat_mov VALUES (21, 'Cashback', 1, NULL);
INSERT INTO public.cat_mov VALUES (22, 'Presente / Doação recebida', 1, NULL);
INSERT INTO public.cat_mov VALUES (23, 'Outros', 1, NULL);
INSERT INTO public.cat_mov VALUES (32, 'Alimentação', 2, NULL);
INSERT INTO public.cat_mov VALUES (33, 'Habitação', 2, NULL);
INSERT INTO public.cat_mov VALUES (34, 'Transporte', 2, NULL);
INSERT INTO public.cat_mov VALUES (35, 'Saúde', 2, NULL);
INSERT INTO public.cat_mov VALUES (36, 'Cuidados pessoais', 2, NULL);
INSERT INTO public.cat_mov VALUES (37, 'Aprendizado', 2, NULL);
INSERT INTO public.cat_mov VALUES (38, 'Lazer', 2, NULL);
INSERT INTO public.cat_mov VALUES (39, 'Assinaturas', 2, NULL);
INSERT INTO public.cat_mov VALUES (40, 'Serviços', 2, NULL);
INSERT INTO public.cat_mov VALUES (41, 'Vestuário', 2, NULL);
INSERT INTO public.cat_mov VALUES (42, 'Tecnologia', 2, NULL);
INSERT INTO public.cat_mov VALUES (43, 'Presentes / Doações', 2, NULL);
INSERT INTO public.cat_mov VALUES (44, 'Pet', 2, NULL);
INSERT INTO public.cat_mov VALUES (45, 'Depreciação', 2, NULL);
INSERT INTO public.cat_mov VALUES (46, 'Outros', 2, NULL);
INSERT INTO public.cat_mov VALUES (3, 'Estorno de dívida', 4, NULL);
INSERT INTO public.cat_mov VALUES (19, 'Pagamento', 4, NULL);
INSERT INTO public.cat_mov VALUES (77, 'Ativo financeiro', 5, NULL);
INSERT INTO public.cat_mov VALUES (78, 'Bem físico', 5, NULL);
INSERT INTO public.cat_mov VALUES (79, 'Ativo financeiro', 6, NULL);
INSERT INTO public.cat_mov VALUES (80, 'Bem físico', 6, NULL);
INSERT INTO public.cat_mov VALUES (88, 'Habitação', 7, NULL);
INSERT INTO public.cat_mov VALUES (89, 'Eletrônico', 7, NULL);
INSERT INTO public.cat_mov VALUES (90, 'Veículo', 7, NULL);
INSERT INTO public.cat_mov VALUES (91, 'Outros', 7, NULL);
INSERT INTO public.cat_mov VALUES (92, 'Entre contas próprias', 8, NULL);
INSERT INTO public.cat_mov VALUES (93, 'Provisão', 8, NULL);
INSERT INTO public.cat_mov VALUES (94, 'Meta', 8, NULL);
INSERT INTO public.cat_mov VALUES (10, 'Reavaliação positiva', 9, NULL);
INSERT INTO public.cat_mov VALUES (11, 'Reavaliação negativa', 9, NULL);
INSERT INTO public.cat_mov VALUES (95, 'Empréstimo tomado', 12, NULL);
INSERT INTO public.cat_mov VALUES (96, 'Empréstimo concedido', 12, NULL);
INSERT INTO public.cat_mov VALUES (101, 'Saldo inicial', 13, NULL);
INSERT INTO public.cat_mov VALUES (102, 'Dívida legado', 13, NULL);
INSERT INTO public.cat_mov VALUES (24, 'Freelance Nacional', 17, NULL);
INSERT INTO public.cat_mov VALUES (25, 'Freelance Internacional', 17, NULL);
INSERT INTO public.cat_mov VALUES (48, 'Mercado', 32, NULL);
INSERT INTO public.cat_mov VALUES (49, 'Restaurante / Delivery', 32, NULL);
INSERT INTO public.cat_mov VALUES (50, 'Aluguel', 33, NULL);
INSERT INTO public.cat_mov VALUES (51, 'Condomínio', 33, NULL);
INSERT INTO public.cat_mov VALUES (52, 'Utilities', 33, NULL);
INSERT INTO public.cat_mov VALUES (53, 'Combustível', 34, NULL);
INSERT INTO public.cat_mov VALUES (54, 'Aplicativo', 34, NULL);
INSERT INTO public.cat_mov VALUES (55, 'Transporte público', 34, NULL);
INSERT INTO public.cat_mov VALUES (56, 'Manutenção de veículo', 34, NULL);
INSERT INTO public.cat_mov VALUES (57, 'Consulta / Exame', 35, NULL);
INSERT INTO public.cat_mov VALUES (58, 'Medicamento', 35, NULL);
INSERT INTO public.cat_mov VALUES (59, 'Suplementação', 35, NULL);
INSERT INTO public.cat_mov VALUES (60, 'Curso / Certificação', 37, NULL);
INSERT INTO public.cat_mov VALUES (61, 'Livro técnico / Material', 37, NULL);
INSERT INTO public.cat_mov VALUES (62, 'Livro / Leitura geral', 37, NULL);
INSERT INTO public.cat_mov VALUES (63, 'Produtividade / Trabalho', 39, NULL);
INSERT INTO public.cat_mov VALUES (64, 'Entretenimento', 39, NULL);
INSERT INTO public.cat_mov VALUES (65, 'Saúde / Bem-estar', 39, NULL);
INSERT INTO public.cat_mov VALUES (66, 'Infraestrutura', 39, NULL);
INSERT INTO public.cat_mov VALUES (67, 'Hardware', 42, NULL);
INSERT INTO public.cat_mov VALUES (68, 'Software / Licença', 42, NULL);
INSERT INTO public.cat_mov VALUES (69, 'Presente', 43, NULL);
INSERT INTO public.cat_mov VALUES (70, 'Doação', 43, NULL);
INSERT INTO public.cat_mov VALUES (71, 'Alimentação', 44, NULL);
INSERT INTO public.cat_mov VALUES (72, 'Saúde / Veterinário', 44, NULL);
INSERT INTO public.cat_mov VALUES (73, 'Outros', 44, NULL);
INSERT INTO public.cat_mov VALUES (74, 'IR', 47, NULL);
INSERT INTO public.cat_mov VALUES (75, 'IOF', 47, NULL);
INSERT INTO public.cat_mov VALUES (76, 'Outros', 47, NULL);
INSERT INTO public.cat_mov VALUES (26, 'Renda fixa', 77, NULL);
INSERT INTO public.cat_mov VALUES (27, 'Renda variável', 77, NULL);
INSERT INTO public.cat_mov VALUES (28, 'Cripto', 77, NULL);
INSERT INTO public.cat_mov VALUES (29, 'Eletrônico', 78, NULL);
INSERT INTO public.cat_mov VALUES (30, 'Veículo', 78, NULL);
INSERT INTO public.cat_mov VALUES (31, 'Imóvel', 78, NULL);
INSERT INTO public.cat_mov VALUES (83, 'Mobiliário', 78, NULL);
INSERT INTO public.cat_mov VALUES (112, 'Hardware', 78, NULL);
INSERT INTO public.cat_mov VALUES (81, 'Renda fixa', 79, NULL);
INSERT INTO public.cat_mov VALUES (82, 'Renda variável', 79, NULL);
INSERT INTO public.cat_mov VALUES (84, 'Cripto', 79, NULL);
INSERT INTO public.cat_mov VALUES (85, 'Eletrônico', 80, NULL);
INSERT INTO public.cat_mov VALUES (86, 'Veículo', 80, NULL);
INSERT INTO public.cat_mov VALUES (87, 'Imóvel', 80, NULL);
INSERT INTO public.cat_mov VALUES (97, 'Institucional', 95, NULL);
INSERT INTO public.cat_mov VALUES (98, 'Pessoal', 95, NULL);
INSERT INTO public.cat_mov VALUES (99, 'Institucional', 96, NULL);
INSERT INTO public.cat_mov VALUES (100, 'Pessoal', 96, NULL);
INSERT INTO public.cat_mov VALUES (47, 'Impostos', NULL, NULL);
INSERT INTO public.cat_mov VALUES (113, 'INSS', 47, NULL);


--
-- Name: cat_mov_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cat_mov_id_seq', 113, true);


--
-- PostgreSQL database dump complete
--


