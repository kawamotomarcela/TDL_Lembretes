# Projeto_TDL Lembretes  
**Status:** Em desenvolvimento ⚠️👍  

#### **Instituição:** Unimar | Universidade de Marília  
#### **Curso:** Análise e Desenvolvimento de Sistemas  
#### **Termo:** 5° B  

## 👥 Nomes - Grupo:
- Carlos Eduardo Colombo (1976794)  
- Hugo Yudy Hiraishi (1961997)  
- Larah Valentini Mallavazi (1964244)  
- Marcela Kawamoto Fernandes (1965868)  
- José Vittor Raymundo Guarido (1963254)  
- Thiago Silvério Pereira (1969855)  

## 📋 Sobre o Projeto

O **TDLembretes** é um aplicativo de **gerenciamento de tarefas com sistema de bonificação**, permitindo que o usuário organize suas rotinas diárias, semanais ou mensais de forma simples e motivadora.

A ideia é ir além de uma simples *to-do list*: o usuário acumula **pontos ao cumprir tarefas**, que podem ser usados em uma **loja interna**, estimulando a produtividade com um sistema de recompensas.

### ✅ Funcionalidades atuais

1. **Criação e organização de tarefas**
   - Cadastro de tarefas com **título, descrição, data e hora**.  
   - Definição de **prioridade** (baixa, média, alta).  
   - Tarefas personalizadas por usuário.

2. **Sistema de bonificação**
   - Cada tarefa possui uma **pontuação**.  
   - Ao concluir tarefas, o usuário **ganha pontos**.  
   - Pontos podem ser usados na **loja de recompensas/cupons**.

3. **Temas e idiomas**
   - Suporte a **modo claro** e **modo escuro**.  
   - Ajuste de **idioma** (Português / Inglês).  
   - Preferências salvas localmente.

4. **Integração com backend**
   - Comunicação via **API REST** em ASP.NET Core.  
   - Validação de usuário, tarefas oficiais, pontos e histórico.

---

# 🚀 Tecnologias utilizadas

- Flutter SDK (3.x ou superior)  
- Dart  
- Provider (gerenciamento de estado)  
- Shared Preferences (armazenamento local)  
- HTTP Client (integração com API REST)  
- Google Fonts  
- Sqflite (SQLite local)  
- Image Picker (seleção/envio de imagens)  
- fl_chart (gráficos)  
- table_calendar (componente de calendário)  

---

# 📂 Estrutura do projeto

```text
Frontend/
  ├── lib/
  │   ├── models/        # Modelos de dados (usuário, tarefas, produtos, etc.)
  │   ├── pages/         # Telas principais (home, tarefas, loja, perfil, premium...)
  │   ├── components/    # Widgets reutilizáveis
  │   ├── services/      # Acesso à API, persistência, helpers
  │   ├── utils/         # Funções auxiliares, formatadores, temas
  │   └── main.dart      # Ponto de entrada do app
  ├── assets/            # Imagens, ícones, fontes
  ├── android/
  ├── ios/
  ├── web/
  ├── pubspec.yaml
  └── analysis_options.yaml
