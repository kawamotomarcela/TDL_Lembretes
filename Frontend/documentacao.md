# 🧠 Fase 1: Análise e Planejamento

## 1.1 📡 Identificação dos Endpoints

O aplicativo **TDL Lembretes** utilizará uma **API REST** desenvolvida em **.NET C#**.  
Os principais recursos identificados até o momento são:

- **Usuários**
  - Endpoints necessários:
    - Login
    - Cadastro
    - Recuperação de informações
- **Tarefas**
  - Endpoints necessários:
    - Criar
    - Editar
    - Excluir
    - Listar
    - Alterar status

As operações seguem o padrão **RESTful**, utilizando os métodos HTTP `GET`, `POST`, `PUT` e `DELETE`.  
Todas as requisições e respostas são no formato **JSON**, garantindo compatibilidade com o Flutter no frontend.

---

## 1.2 🧱 Modelagem de Dados

A estrutura de dados já foi definida no projeto Flutter, com duas classes principais:

- **`TaskModel`**
  - Campos: `id`, `título`, `data`, `categoria`, `prioridade`, `status`, `alarmeAtivado`
- **`UsuarioModel`**
  - Campos: `id`, `nome`, `email`, `telefone`, `pontos`

Ambos os modelos possuem métodos `fromJson`/`toJson` (ou `fromMap`/`toMap`), permitindo:

- Conversão entre JSON e objetos Dart
- Integração com banco de dados local (`sqflite`)
- Integração com a API externa

Cada modelo representa uma tabela no banco de dados local.

---

## 1.3 🔗 Estratégia de Conectividade

O app funcionará em dois modos:

- **Online**
  - Conecta-se à API `.NET` para realizar operações remotas
- **Offline**
  - Dados são lidos e salvos no banco local (`sqflite`)

Essa estratégia garante acesso às tarefas mesmo sem internet.  
No futuro, será possível incluir **sincronização automática** assim que a conexão for restabelecida.  
O gerenciamento de conectividade será planejado para detectar mudanças de rede, garantindo uma boa experiência ao usuário.

---

## 1.4 ⚠️ Tratamento de Erros

A aplicação tratará erros em diferentes níveis:

- **Erros de rede:** Sem conexão, timeout
- **Erros da API:** Requisições inválidas (400), falhas internas (500)
- **Erros do cliente:** Campos vazios, formatos inválidos
- **Erros de autenticação/autorização**

A notificação ao usuário será feita via:

- **SnackBars**
- **Validações visuais nos formulários**

---

## 1.5 🏗️ Arquitetura

O projeto Flutter segue uma **arquitetura modular por camadas**, com pastas organizadas:

- `models/` → modelos de dados
- `providers/` → gerenciamento de estado (`ChangeNotifier`)
- `services/` → serviços e lógica de negócios
- `routes/` → navegação
- `pages/` → telas
- `l10n/` → internacionalização

Além disso:

- Suporte a múltiplos idiomas (pt/en), com o pacote `intl` e arquivos `.arb`
- Arquitetura pensada para facilitar **manutenção**, **reutilização** e **escalabilidade**

---
