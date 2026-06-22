# qa-automation-portfolio

![CI](https://github.com/elyzioneto/qa-automation-portfolio/actions/workflows/ci.yml/badge.svg)
![Python](https://img.shields.io/badge/Python-3.11-blue)
![Robot Framework](https://img.shields.io/badge/Robot%20Framework-6.x-green)
![Playwright](https://img.shields.io/badge/Playwright-1.x-orange)

Suite de automacao de testes profissional com foco em qualidade de software em ambientes SaaS e e-commerce. Cobre testes de API REST, UI end-to-end e pipeline de CI/CD automatizado.

---

## Stack

| Camada | Tecnologia |
|---|---|
| Testes de API | Robot Framework + RequestsLibrary + Python |
| Testes de UI | Playwright (TypeScript) |
| CI/CD | GitHub Actions |
| Gestao de Bugs | Issues com labels de severidade |
| Documentacao | Markdown + docs/strategy.md |

---

## Estrutura do Projeto

```
qa-automation-portfolio/
├── tests/
│   ├── api/
│   │   ├── auth/           # Testes de autenticacao e sessao
│   │   ├── products/       # Endpoints de produtos (Mercado Livre API)
│   │   └── payments/       # Validacao de webhooks e billing
│   └── ui/
│       ├── checkout/       # Fluxo de checkout E2E
│       └── onboarding/     # Onboarding e cadastro
├── .github/
│   └── workflows/
│       └── ci.yml          # Pipeline automatizado
├── docs/
│   └── strategy.md         # Estrategia de testes e decisoes tecnicas
├── resources/
│   └── keywords.robot      # Keywords reutilizaveis
├── requirements.txt
└── README.md
```

---

## Como Executar

### Pre-requisitos

```bash
pip install -r requirements.txt
playwright install
```

### Testes de API

```bash
robot -d results tests/api/
```

### Testes de UI

```bash
npx playwright test tests/ui/
```

### Todos os testes (via CI)

O pipeline dispara automaticamente em cada push/PR para a branch `main`.

---

## Cobertura de Testes

- Autenticacao: login, logout, sessao expirada, token invalido
- - Produtos: listagem, busca, filtros, paginacao
  - - Pagamentos: webhook Stripe, billing recorrente, falha de pagamento
    - - UI Checkout: fluxo completo, campo invalido, timeout de sessao
     
      - ---

      ## Estrategia

      Consulte [docs/strategy.md](docs/strategy.md) para a estrategia completa, piramide de testes, criterios de aceite e decisoes tecnicas.

      ---

      ## Autor

      **Elyzio Neto** | QA Engineer Senior
      [LinkedIn](https://www.linkedin.com/in/netoelyzio) | [GitHub](https://github.com/elyzioneto)
