--
-- Foreign keys
-- Gerado por dump.sh — nao editar a mao.
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET client_min_messages = warning;
SELECT pg_catalog.set_config('search_path', '', false);

--
-- Name: bens bens_id_moeda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bens
    ADD CONSTRAINT bens_id_moeda_fkey FOREIGN KEY (id_moeda) REFERENCES public.moedas(id);


--
-- Name: bens bens_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bens
    ADD CONSTRAINT bens_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipos_bens(id);


--
-- Name: cat_mov cat_mov_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cat_mov
    ADD CONSTRAINT cat_mov_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES public.cat_mov(id);


--
-- Name: compromissos compromissos_id_entidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compromissos
    ADD CONSTRAINT compromissos_id_entidade_fkey FOREIGN KEY (id_entidade) REFERENCES public.entidades(id);


--
-- Name: compromissos compromissos_id_natureza_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.compromissos
    ADD CONSTRAINT compromissos_id_natureza_fkey FOREIGN KEY (id_natureza) REFERENCES public.naturezas_compromissos(id);


--
-- Name: contas contas_id_bem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contas
    ADD CONSTRAINT contas_id_bem_fkey FOREIGN KEY (id_bem) REFERENCES public.bens(id);


--
-- Name: contas contas_id_entidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contas
    ADD CONSTRAINT contas_id_entidade_fkey FOREIGN KEY (id_entidade) REFERENCES public.entidades(id);


--
-- Name: contas contas_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contas
    ADD CONSTRAINT contas_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipos_contas(id);


--
-- Name: cotacoes cotacoes_id_moeda_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cotacoes
    ADD CONSTRAINT cotacoes_id_moeda_fkey FOREIGN KEY (id_moeda) REFERENCES public.moedas(id);


--
-- Name: entidades entidades_id_tipo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entidades
    ADD CONSTRAINT entidades_id_tipo_fkey FOREIGN KEY (id_tipo) REFERENCES public.tipos_entidades(id);


--
-- Name: movimentacoes movimentacoes_conta_destino_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_conta_destino_fkey FOREIGN KEY (conta_destino) REFERENCES public.contas(id);


--
-- Name: movimentacoes movimentacoes_conta_origem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_conta_origem_fkey FOREIGN KEY (conta_origem) REFERENCES public.contas(id);


--
-- Name: movimentacoes movimentacoes_id_bem_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_id_bem_fkey FOREIGN KEY (id_bem) REFERENCES public.bens(id);


--
-- Name: movimentacoes movimentacoes_id_cat_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_id_cat_fkey FOREIGN KEY (id_cat) REFERENCES public.cat_mov(id);


--
-- Name: movimentacoes movimentacoes_id_compromisso_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_id_compromisso_fkey FOREIGN KEY (id_compromisso) REFERENCES public.compromissos(id);


--
-- Name: movimentacoes movimentacoes_id_status_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.movimentacoes
    ADD CONSTRAINT movimentacoes_id_status_fkey FOREIGN KEY (id_status) REFERENCES public.status(id);


--
-- Name: tipos_bens tipos_bens_id_pai_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipos_bens
    ADD CONSTRAINT tipos_bens_id_pai_fkey FOREIGN KEY (id_pai) REFERENCES public.tipos_bens(id);


--
-- PostgreSQL database dump complete
--


