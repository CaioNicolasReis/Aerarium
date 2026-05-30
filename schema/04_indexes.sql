--
-- Indices
-- Gerado por dump.sh — nao editar a mao.
--

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET client_min_messages = warning;
SELECT pg_catalog.set_config('search_path', '', false);

--
-- Name: bens_data_aquisicao_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bens_data_aquisicao_idx ON public.bens USING btree (data_aquisicao);


--
-- Name: bens_id_moeda_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bens_id_moeda_idx ON public.bens USING btree (id_moeda);


--
-- Name: bens_id_tipo_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bens_id_tipo_idx ON public.bens USING btree (id_tipo);


--
-- Name: compromissos_data_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX compromissos_data_idx ON public.compromissos USING btree (data);


--
-- Name: compromissos_data_vencimento_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX compromissos_data_vencimento_idx ON public.compromissos USING btree (data_vencimento);


--
-- Name: compromissos_id_entidade_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX compromissos_id_entidade_idx ON public.compromissos USING btree (id_entidade);


--
-- Name: compromissos_id_natureza_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX compromissos_id_natureza_idx ON public.compromissos USING btree (id_natureza);


--
-- Name: contas_id_entidade_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX contas_id_entidade_idx ON public.contas USING btree (id_entidade);


--
-- Name: contas_id_tipo_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX contas_id_tipo_idx ON public.contas USING btree (id_tipo);


--
-- Name: cotacoes_id_moeda_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cotacoes_id_moeda_idx ON public.cotacoes USING btree (id_moeda);


--
-- Name: entidades_id_tipo_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX entidades_id_tipo_idx ON public.entidades USING btree (id_tipo);


--
-- Name: movimentacoes_conta_destino_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_conta_destino_idx ON public.movimentacoes USING btree (conta_destino);


--
-- Name: movimentacoes_conta_origem_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_conta_origem_idx ON public.movimentacoes USING btree (conta_origem);


--
-- Name: movimentacoes_data_evento_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_data_evento_idx ON public.movimentacoes USING btree (data_evento);


--
-- Name: movimentacoes_data_liquidacao_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_data_liquidacao_idx ON public.movimentacoes USING btree (data_liquidacao);


--
-- Name: movimentacoes_id_bem_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_id_bem_idx ON public.movimentacoes USING btree (id_bem);


--
-- Name: movimentacoes_id_cat_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_id_cat_idx ON public.movimentacoes USING btree (id_cat);


--
-- Name: movimentacoes_id_compromisso_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX movimentacoes_id_compromisso_idx ON public.movimentacoes USING btree (id_compromisso);


