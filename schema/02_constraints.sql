--
-- Primary keys e unique constraints
-- Gerado por dump.sh — nao editar a mao.
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET client_min_messages = warning;
SELECT pg_catalog.set_config('search_path', '', false);

--
-- Name: bens bens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bens
    ADD CONSTRAINT bens_pkey PRIMARY KEY (id);


--
-- Name: cat_mov cat_mov_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_mov
    ADD CONSTRAINT cat_mov_pkey PRIMARY KEY (id);


--
-- Name: compromissos compromissos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compromissos
    ADD CONSTRAINT compromissos_pkey PRIMARY KEY (id);


--
-- Name: contas contas_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contas
    ADD CONSTRAINT contas_nome_key UNIQUE (nome);


--
-- Name: contas contas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contas
    ADD CONSTRAINT contas_pkey PRIMARY KEY (id);


--
-- Name: cotacoes cotacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cotacoes
    ADD CONSTRAINT cotacoes_pkey PRIMARY KEY (id);


--
-- Name: entidades entidades_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entidades
    ADD CONSTRAINT entidades_nome_key UNIQUE (nome);


--
-- Name: entidades entidades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entidades
    ADD CONSTRAINT entidades_pkey PRIMARY KEY (id);


--
-- Name: moedas moedas_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moedas
    ADD CONSTRAINT moedas_nome_key UNIQUE (nome);


--
-- Name: moedas moedas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.moedas
    ADD CONSTRAINT moedas_pkey PRIMARY KEY (id);


--
-- Name: movimentacoes movimentacoes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_pkey PRIMARY KEY (id);


--
-- Name: naturezas_compromissos naturezas_compromissos_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.naturezas_compromissos
    ADD CONSTRAINT naturezas_compromissos_nome_key UNIQUE (nome);


--
-- Name: naturezas_compromissos naturezas_compromissos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.naturezas_compromissos
    ADD CONSTRAINT naturezas_compromissos_pkey PRIMARY KEY (id);


--
-- Name: status status_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_nome_key UNIQUE (nome);


--
-- Name: status status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.status
    ADD CONSTRAINT status_pkey PRIMARY KEY (id);


--
-- Name: tipos_bens tipos_bens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_bens
    ADD CONSTRAINT tipos_bens_pkey PRIMARY KEY (id);


--
-- Name: tipos_contas tipos_contas_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_contas
    ADD CONSTRAINT tipos_contas_nome_key UNIQUE (nome);


--
-- Name: tipos_contas tipos_contas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_contas
    ADD CONSTRAINT tipos_contas_pkey PRIMARY KEY (id);


--
-- Name: tipos_entidades tipos_entidades_nome_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_entidades
    ADD CONSTRAINT tipos_entidades_nome_key UNIQUE (nome);


--
-- Name: tipos_entidades tipos_entidades_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_entidades
    ADD CONSTRAINT tipos_entidades_pkey PRIMARY KEY (id);


