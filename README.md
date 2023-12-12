# Descrição do Projeto

O projeto consiste em um aplicativo Flutter que atende aos requisitos definidos para uma prova prática. O aplicativo possui três telas principais: Tela de Login Tela de cadastro e Tela de Captura de Informações.

## Descrição do Aplicativo

O aplicativo é desenvolvido em Flutter e implementa uma arquitetura limpa (Clean Architecture) para melhor organização e separação de responsabilidades. Além disso, utiliza bibliotecas importantes como Dartz para manipulação de Either e Failures, GetIt para injeção de dependência, e possui duas versões de gerenciamento de estado: uma utilizando Cubit e outra utilizando MobX. Para garantir a qualidade e robustez do código, foram incorporados testes unitários e de integração nas camadas de domain e data. Esses testes foram desenvolvidos utilizando a biblioteca de testes do Flutter e o framework Mockito para a criação de mocks, permitindo uma cobertura abrangente e eficaz. Além disso, foi implementado um pipeline de integração contínua e entrega contínua (CI/CD) para automatizar a execução dos testes. Utilizando o GitHub Actions, os testes são acionados automaticamente sempre que há alterações no repositório, garantindo uma validação contínua do código.

## Tela de Login

A Tela de Login é a primeira tela do aplicativo e é responsável por autenticar o usuário. Ela possui campos para inserir o login e senha, além de um label que redireciona para a política de privacidade. As validações são realizadas localmente, e a transição para a próxima tela ocorre quando as informações são preenchidas corretamente.

## Tela de Cadastro

A Tela de Cadastro é responsável por permitir que os usuários criem novas contas no aplicativo. Ela apresenta campos para inserir o nome de usuário e senha, realizando validações em tempo real. 

## Tela de Captura de Informações

A Tela de Captura de Informações é a terceira tela do aplicativo e permite que o usuário digite informações que são salvas persistentemente. Utilizando a biblioteca shared_preferences, as informações são mantidas mesmo após o fechamento do aplicativo. O estado é gerenciado por MobX, e a tela segue os princípios da arquitetura limpa.



## Arquitetura e Tecnologias Utilizadas

- **Clean Architecture:** Organização do código em camadas para separar responsabilidades e facilitar a manutenção.
- **Dartz:** Utilizado para lidar com operações assíncronas, Either e Failures, proporcionando tratamento de erros mais robusto.
- **GetIt:** Biblioteca de injeção de dependência para gerenciar a criação de instâncias de classes e facilitar a injeção de dependência.
- **Cubit:** Utilizado como uma das opções de gerenciamento de estado, oferecendo uma abordagem reativa e declarativa.
- **MobX:** Adotado como outra opção para gerenciamento de estado, especialmente eficaz para o desenvolvimento ágil e produtivo.

## Passo a Passo para Baixar e Testar o Projeto:

1. **Clone o Repositório:**
   ```bash
   git clone https://github.com/jonatascaetano/target-teste.git

2. **Instale as Dependências:**
   ```bash
   flutter pub get

3. **Execute o Aplicativo:**
   ```bash
   flutter run
