# 🧮 MathBus

**MathBus — Aprimore sua matemática básica**

O **MathBus** é uma aplicação desenvolvida para tornar a prática de matemática básica mais simples, acessível e interativa.

A ideia surgiu a partir de uma situação cotidiana: o tempo gasto em deslocamentos por transporte público. Em vez de considerar esse período apenas como tempo ocioso, surgiu a ideia de utilizá-lo para realizar atividades produtivas, dando origem ao conceito do MathBus e ao seu nome.

* **Math** → matemática;
* **Bus** → ônibus.

O **Bus** representa a inspiração original do projeto: a ideia de aproveitar o tempo normalmente gasto em deslocamentos para realizar uma atividade produtiva.

## 🚀 Versão Atual - 1.0.0

A versão **1.0.0** disponibiliza exercícios envolvendo as quatro operações matemáticas básicas:

* ➕ Adição
* ➖ Subtração
* ✖️ Multiplicação
* ➗ Divisão

O usuário pode configurar os exercícios de acordo com suas necessidades e resolver as questões apresentadas pela aplicação.

## 🎯 Objetivo

O principal objetivo do MathBus é proporcionar uma forma simples e interativa de **praticar matemática básica**.

A aplicação busca transformar momentos disponíveis do dia a dia em oportunidades de aprendizado, permitindo que o usuário pratique matemática **onde e quando quiser**.

## ✨ Funcionalidades

### Exercícios de matemática

A aplicação permite praticar:

* Adição;
* Subtração;
* Multiplicação;
* Divisão.

### Configuração dos exercícios

Antes de iniciar uma sessão, é possível configurar:

* Quantidade de questões;
* Valor mínimo dos operandos;
* Valor máximo dos operandos;
* Quantidade de operandos.

### Resolução das questões

Durante o exercício, o usuário pode:

* Visualizar a expressão matemática;
* Informar sua resposta;
* Verificar a resposta;
* Receber feedback imediato;
* Limpar a resposta digitada;
* Utilizar um espaço para realizar cálculos manualmente.

### Progresso

A aplicação apresenta o progresso da sessão, indicando:

* Questão atual;
* Quantidade total de questões;
* Barra de progresso.

Ao finalizar todas as questões, o usuário pode **refazer o exercício** ou **voltar para a tela inicial**.

## 💡 Exemplo

Uma configuração pode gerar uma questão como:

```text
25 + 13 + 7 = ?
```

O usuário informa o resultado e recebe imediatamente o feedback sobre sua resposta.

## 🛠️ Tecnologias

O projeto foi desenvolvido utilizando:
* **Flutter**
* **Dart**
* **GoRouter**
* **KaTeX**
* **Signature**

## 🏗️ Arquitetura

O projeto utiliza uma organização baseada em **features**, separando as responsabilidades da aplicação em camadas.

De forma geral:

```text
lib/
├── core/
├── features/
│   ├── exercise/
│   └── scratchpad/
└── shared/
```

A lógica relacionada aos exercícios é mantida separada da camada de apresentação, permitindo que as regras de geração, cálculo e validação sejam desenvolvidas independentemente da interface.

## 📄 Licença

Este projeto está em desenvolvimento e faz parte do portfólio de **Renan Lopes Lima Teles**.
