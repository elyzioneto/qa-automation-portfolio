# Estrategia de Testes - QA Automation Portfolio

## Objetivo

Documentar as decisoes tecnicas e estrategicas que guiam a construcao desta suite de testes, demonstrando maturidade em qualidade de software alem da escrita de codigo.

---

## Piramide de Testes Aplicada

```
        /\
               /UI\
                     / E2E \       <- Playwright: fluxos criticos apenas
                          /--------\
                              / API REST \    <- Robot Framework: maior cobertura
                                 /------------\
                                   /   Unit/Contrato \  <- validacao de payload/schema
                                    /------------------\
                                    ```

                                    A maior parte dos testes esta na camada de API REST, pois oferece:
                                    - Execucao mais rapida (sem overhead de browser)
                                    - Menor flakiness
                                    - Feedback mais rapido no CI/CD
                                    - Cobertura de contratos de integracao

                                    ---

                                    ## Decisoes Tecnicas

                                    ### Por que Robot Framework para API?
                                    - Sintaxe legivel por stakeholders nao-tecnicos (BDD-like)
                                    - Ecosistema maduro com RequestsLibrary
                                    - Facilidade de gerar reports HTML automaticamente
                                    - Suporte nativo a tags para execucao seletiva por ambiente

                                    ### Por que Playwright para UI?
                                    - Auto-wait nativo elimina a maioria dos flaky tests
                                    - Suporte a multiplos browsers com um unico comando
                                    - Trace viewer para debug de falhas no CI
                                    - Compatibilidade com TypeScript

                                    ### Por que API publica do Mercado Livre?
                                    - Representa o dominio real de atuacao (e-commerce/marketplaces)
                                    - Endpoint /sites e /search sao estaveis e nao requerem autenticacao
                                    - Permite demonstrar validacao de contrato, paginacao e tratamento de erro

                                    ---

                                    ## Tipos de Cenarios Cobertos

                                    | Tipo | Descricao | Tag |
                                    |---|---|---|
                                    | Smoke | Validacao minima de que o sistema esta operacional | `smoke` |
                                    | Regression | Cobertura completa de fluxos existentes | `regression` |
                                    | Negative | Comportamento esperado diante de inputs invalidos | `negative` |
                                    | Contract | Validacao de estrutura de payload (chaves obrigatorias) | `contract` |
                                    | E2E | Fluxos completos de usuario na UI | `e2e` |

                                    ---

                                    ## Criterios de Aceite (Definition of Done)

                                    - [ ] Teste tem `[Documentation]` descritiva
                                    - [ ] Teste tem `[Tags]` para rastreabilidade
                                    - [ ] Cenarios positivos, negativos e edge cases cobertos
                                    - [ ] Nenhum dado sensivel hardcoded (usar variaveis)
                                    - [ ] Pipeline CI/CD passa sem erros
                                    - [ ] Report HTML gerado e disponivel como artefato

                                    ---

                                    ## Shift-Left na Pratica

                                    A qualidade e integrada desde o refinamento:
                                    1. Criterios de aceite definidos antes do desenvolvimento
                                    2. Testes de API escritos a partir do contrato (API-first)
                                    3. Revisao de testabilidade durante o design tecnico
                                    4. Execucao automatica em cada PR via GitHub Actions

                                    ---

                                    ## Gestao de Bugs

                                    Bugs encontrados sao registrados como Issues no GitHub com:
                                    - Label de **severidade**: `critical`, `major`, `minor`, `trivial`
                                    - Label de **tipo**: `bug`, `regression`, `performance`
                                    - Template padrao: passos para reproducao, resultado esperado vs obtido, evidencia
