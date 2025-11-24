# 📌 TDL Lembretes – Flutter + .NET

O **TDL Lembretes** é um sistema de gerenciamento de tarefas com foco em produtividade e gamificação.  
Você organiza suas tarefas, ganha pontos (tokens) e pode trocá-los por recompensas na loja interna.

---

## 🎯 Principais Funcionalidades

### 👤 Autenticação & Perfil
- Login e cadastro de usuário (email, senha, telefone).
- Edição de dados do perfil (nome, telefone, email, senha).
- Alteração de imagem de perfil via URL.
- Persistência de sessão usando o backend em .NET.

### ✅ Tarefas Personalizadas
- Criação, edição e exclusão de tarefas pessoais.
- Definição de:
  - Título
  - Descrição
  - Data e hora de vencimento
  - Prioridade (baixa, média, alta)
  - Alarme (ativar/desativar)
- Mudança de status da tarefa (em andamento, concluída, expirada).

### 🎯 Tarefas Oficiais
- “Missões especiais” definidas pelo sistema.
- Podem render pontos extras ao serem concluídas.
- Envio de **comprovação (URL de imagem)** para validar a tarefa.
- Feedback visual e snackbar de sucesso/erro.

### 🪙 Pontos (Tokens) & Gamificação
- Sistema de pontos para o usuário.
- Exibição do total de tokens em um card dedicado.
- Tarefas oficiais podem adicionar pontos ao saldo.

### 🛍 Loja & Cupons
- Lista de produtos disponíveis:
  - Nome, descrição, preço, imagem, quantidade.
  - Tratamento para produto **esgotado**.
  - Modal de detalhes com botão de “Comprar”.
- Página de cupons:
  - Cupons vinculados ao usuário.
  - Nome, descrição e custo em pontos.
  - Preparado para integração com resgate de cupons.

### 📅 Calendário
- Visão de calendário com eventos especiais pré-cadastrados (feriados, datas marcantes).
- Lista de eventos do dia selecionado.
- Pronto para receber eventos futuros integrados ao backend.

### ⚙️ Configurações (Settings)
- Escolha de **tema**:
  - Claro
  - Escuro
  - Sistema
- Escolha de **idioma**:
  - Português (`pt`)
  - Inglês (`en`)
- Preferências salvas em armazenamento local (SharedPreferences).

### 🌐 IP do Servidor (Backend)
- Tela de configuração de IP dentro do app:
  - Diálogo para digitar o IP do backend.
  - Teste de conexão via socket.
  - Se conectar, IP é salvo nas preferências.
  - Se falhar, mostra snackbar de erro.

---

## 🧱 Tecnologias

### 🔹 Frontend (Mobile)
- **Flutter** (3.7.2+)
- **Dart**
- Provider (gerência de estado)
- Internacionalização com `intl` / `intl_utils`
- `flutter_multi_formatter` para formatação de telefone
- Temas customizados (claro/escuro) e `ColorScheme`

### 🔹 Backend
- **.NET 7+** (C#)
- API REST para autenticação, tarefas, tarefas oficiais, produtos, cupons etc.

---

## 🛠️ Pré-requisitos

### 🔹 Flutter
- Flutter SDK `>= 3.7.2 < 4.0.0`
- Dart SDK
- Android Studio ou VS Code
- Emulador ou dispositivo físico (Android/iOS)

### 🔹 .NET
- .NET SDK **7.0 ou superior**
- Ter o projeto do backend do TDL Lembretes configurado (pasta `Backend` ou similar)

---

## 🚀 Como rodar o projeto

### 1️⃣ Instalar dependências do Flutter

```bash
flutter pub get
