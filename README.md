# Backend Challenge

Este é um projeto Ruby para integração com uma API mock, projetado para coletar, processar e exibir dados de usuários de um SaaS fictício. A aplicação foi estruturada em três componentes principais para facilitar a manutenção, modularização e escalabilidade.

## Índice
1. [Pré-requisitos](#pré-requisitos)
2. [Instalação](#instalação)
3. [Configuração](#configuração)
4. [Execução](#execução)
5. [Estrutura do Projeto](#estrutura-do-projeto)
6. [Testes](#testes)
7. [Decisões Técnicas](#decisões-técnicas)

---

1. ## Pré-requisitos

- **Ruby 2.4.5**: Certifique-se de ter essa versão do Ruby instalada para compatibilidade com o projeto.
- **Bundler**: Para gerenciar as dependências do projeto.
- **Docker**: Para executar a API mock em um contêiner.

2. ## Instalação

**Clone o Repositório**

   ```
   git clone <url-do-repositorio>
   cd backend-challenge
   ```

**Instale as Dependências**

Certifique-se de que o bundler está instalado. Em seguida, instale as dependências do projeto:

```
gem install bundler
bundle install
```

3. ## Configuração

**Configuração do Docker**

Para rodar a API mock, execute o comando a partir da raiz do projeto:

```
docker-compose up -d
```

Isso irá iniciar o json-server na porta 8080, conforme configurado no arquivo docker-compose.yml.

**Configuração do Arquivo .env**

Crie um arquivo .env na raiz do projeto com o conteúdo abaixo, para definir a URL da API mock:

```
API_URL=http://0.0.0.0:8080
```

Este arquivo configura o endpoint da API para o UserFetcher.

4. ## Execução

Após instalar as dependências e configurar a aplicação, execute o main.rb para iniciar a coleta e exibição dos dados:

```
ruby main.rb
```

Este comando executará o processo completo:

- Buscar dados da API mock.
- Processar os dados aplicando regras de transformação.
- Exibir o resultado final no console.

5. ## Estrutura do Projeto

A estrutura do projeto foi separada em módulos para maior organização e escalabilidade:

* lib
    * user_fetcher.rb *(Classe responsável pela busca dos dados de usuários da API mock)*
    * user_processor.rb *(Classe que aplica regras de transformação e processamento dos dados)*
    * user_presenter.rb *(Classe que exibe os dados no console)*
* main.rb *(Arquivo principal que integra as três classes acima)*
* data
    * db.json *(Dados mock para a API, usado pelo json-server)*
* .env *(Arquivo de configuração para variáveis de ambiente)*
* spec *(Testes unitários e de integração)*
    * user_fetcher_spec.rb *(Teste para UserFetcher)*
    * user_processor_spec.rb *(Teste para UserProcessor)*
    * user_presenter_spec.rb *(Teste para UserPresenter)*
    * integration_spec.rb *(Teste de integração)*
* docker-compose.yml *(Configurações para rodar o serviço json-server na imagem vimagick)*
* .github
    * workflows
        * ruby.yml *(Pipeline de CI/CD básico para rodar testes automaticamente)*

6. ## Testes

Os testes foram desenvolvidos com RSpec, cobrindo unidades e integração.

**Execução dos Testes**

Para rodar todos os testes:

```
rspec
```

7. ## Decisões Técnicas

Organização Modular: A aplicação foi dividida em três módulos (UserFetcher, UserProcessor, UserPresenter) para seguir o princípio de responsabilidade única. Isso facilita a manutenção e expansão do código.

Uso de .env: O arquivo .env foi utilizado para configurar o endpoint da API. Isso facilita a alteração do ambiente de desenvolvimento sem necessidade de modificar o código.

Gem httparty: Escolhida para consumir a API mock devido à sua simplicidade e integração com APIs REST.

Teste e Cobertura: Utilizamos RSpec para testes de unidade e integração, além do SimpleCov para garantir a cobertura de código. A estrutura de testes permite verificar a integridade de cada componente e o fluxo completo da aplicação.

Uso do Docker e json-server: O Docker foi escolhido para simplificar a execução da API mock.