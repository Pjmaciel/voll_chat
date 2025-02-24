# Chat App - Backend (Rails API)

## Índice
1. [Visão Geral](#visão-geral)
2. [Tecnologias Utilizadas](#tecnologias-utilizadas)
3. [Diferenciais Implementados](#diferenciais-implementados)
4. [Como Configurar e Executar o Backend](#como-configurar-e-executar-o-backend)
    - [Requisitos Prévios](#requisitos-prévios)
    - [Passo a Passo para Configuração](#passo-a-passo-para-configuração)
5. [Endpoints da API](#endpoints-da-api)
6. [WebSockets (ActionCable)](#websockets-actioncable)
7. [Executando Testes](#executando-testes)
8. [Estrutura do Projeto](#estrutura-do-projeto)
9. [Solução de Problemas Comuns](#solução-de-problemas-comuns)
10. [Próximos Passos](#próximos-passos)

## Visão Geral

Este é o backend de uma aplicação que permite que usuários troquem mensagens em tempo real, fornecendo uma API REST completa com autenticação e WebSockets para comunicação em tempo real.

## Tecnologias Utilizadas

- **Ruby 3.3.0**
- **Rails 7.1.5** (modo API)
- **PostgreSQL** como banco de dados relacional
- **Redis** para ActionCable
- **JWT** para autenticação da API
- **ActiveModelSerializers** para serialização JSON
- **ActionCable** para WebSockets em tempo real
- **Rswag** para documentação da API
- **RSpec, FactoryBot e Faker** para testes

## Diferenciais Implementados

- **Comunicação em tempo real via WebSocket** utilizando ActionCable
- **Autenticação JWT** para garantir a segurança das requisições
- **Documentação completa da API** com Swagger (Rswag)
- **Testes automatizados** utilizando RSpec, FactoryBot e Action Cable Testing

## Como Configurar e Executar o Backend

### Requisitos Prévios

- Ruby 3.3.0 (recomendado usar um gerenciador como RVM ou rbenv)
- PostgreSQL 15
- Redis (para ActionCable)

### Passo a Passo para Configuração

1. **Clone o repositório**
   ```bash
   git clone https://github.com/seu-usuario/chat-app-backend.git
   cd chat-app-backend
   ```

2. **Instale as dependências**
   ```bash
   bundle install
   ```

3. **Configure o banco de dados**

   Verifique o arquivo `config/database.yml` e ajuste as credenciais conforme necessário:
   ```yaml
   default: &default
     adapter: postgresql
     encoding: unicode
     pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
     username: <%= ENV.fetch("DB_USERNAME", "postgres") %>
     password: <%= ENV.fetch("DB_PASSWORD", "postgres") %>
     host: <%= ENV.fetch("DB_HOST", "localhost") %>
   ```

   Você pode configurar estas variáveis de ambiente ou ajustar os valores diretamente no arquivo.

4. **Crie e configure o banco de dados**
   ```bash
   rails db:create
   rails db:migrate
   ```

5. **Carregue os dados de exemplo (opcional)**
   ```bash
   rails db:seed
   ```

   Isso criará três usuários para teste:
    - Email: alice@example.com, Senha: password123
    - Email: bob@example.com, Senha: password123
    - Email: carlos@example.com, Senha: password123

6. **Configure o Redis para ActionCable**

   Verifique se o Redis está instalado e rodando em sua máquina.

   O arquivo `config/cable.yml` deve estar configurado assim para desenvolvimento:
   ```yaml
   development:
     adapter: redis
     url: redis://localhost:6379/1
   ```

7. **Inicie o servidor Rails**
   ```bash
   rails server
   ```

8. **Verifique se está funcionando**
    - Acesse: http://localhost:3000/api-docs
    - Você deve ver a documentação Swagger da API

## Endpoints da API

A API possui os seguintes endpoints principais:

- **POST /api/v1/users** - Criar uma nova conta
- **POST /api/v1/auth/login** - Fazer login e obter token JWT
- **GET /api/v1/users** - Listar usuários (requer autenticação)
- **GET /api/v1/messages** - Listar mensagens (requer autenticação)
- **POST /api/v1/messages** - Enviar uma mensagem (requer autenticação)

Para detalhes completos da API, consulte a documentação Swagger em http://localhost:3000/api-docs

## WebSockets (ActionCable)

O backend suporta comunicação em tempo real via WebSockets usando ActionCable:

- **Channel:** `ChatChannel`
- **URL de conexão:** `ws://localhost:3000/cable?token=JWT_TOKEN`

Os clientes precisam se autenticar com o token JWT como parâmetro de query na URL de conexão.

## Executando Testes

```bash
# Execute todos os testes
rspec

# Execute testes específicos
rspec spec/models/user_spec.rb
rspec spec/controllers/api/v1/messages_controller_spec.rb
```

## Estrutura do Projeto

```
app/
├── channels/
│   ├── application_cable/
│   │   ├── channel.rb
│   │   └── connection.rb
│   └── chat_channel.rb         # Canal WebSocket para mensagens em tempo real
├── controllers/
│   ├── api/
│   │   └── v1/
│   │       ├── authentication_controller.rb  # Controlador de autenticação
│   │       ├── messages_controller.rb        # Controlador de mensagens
│   │       └── users_controller.rb           # Controlador de usuários
│   └── application_controller.rb
├── models/
│   ├── message.rb              # Modelo de mensagens
│   └── user.rb                 # Modelo de usuários
├── serializers/
│   ├── message_serializer.rb   # Serialização JSON para mensagens
│   └── user_serializer.rb      # Serialização JSON para usuários
└── lib/
    └── json_web_token.rb       # Utilitário para codificação/decodificação JWT
```

## Solução de Problemas Comuns

1. **Erro de conexão com o PostgreSQL**
    - Verifique se o PostgreSQL está rodando
    - Confirme as credenciais no arquivo `config/database.yml`

2. **Erro de conexão com o Redis**
    - Verifique se o Redis está instalado e rodando
    - Certifique-se de que a URL no `config/cable.yml` está correta

3. **Problemas com o ActionCable**
    - Verifique se as origens permitidas em `config/environments/development.rb` estão configuradas corretamente

## Próximos Passos

1. Implementar suporte a envio de arquivos
2. Adicionar paginação na listagem de mensagens
3. Criar endpoint de métricas (/metrics)
4. Implementar processamento assíncrono de mensagens com Sidekiq

---

Desenvolvido como parte do desafio para Desenvolvedor Júnior.