# 📌 TDL Lembretes – Flutter + .NET

Bem-vindo ao projeto **TDL Lembretes**, um sistema de gerenciamento de tarefas com:

- ✅ Frontend em **Flutter**
- ✅ Backend em **.NET C#**
- ✅ Internacionalização (Português / Inglês)
- ✅ Integração com base local e servidor

---

## 🛠️ Pré-requisitos

### 🔹 Flutter

- Flutter SDK >= 3.7.2 < 4.0.0
- Dart SDK
- Android Studio ou VS Code
- Emulador ou dispositivo Android/iOS

### 🔹 .NET

- .NET SDK 7.0 ou superior

---

## 🚀 Como rodar o projeto

### 1. Instalar dependências do Flutter

flutter pub get

### 2. Rodar app Flutter

flutter run

### 3. Rodar o backend (.NET)

cd ../Backend  
dotnet run --launch-profile "http"

### 4. Encerrar backend manualmente (se necessário)

taskkill /F /IM TDLembretes.exe

---

## 🌍 Traduções (Internacionalização)

Este projeto utiliza `intl_utils` para internacionalização com arquivos `.arb`.

### Arquivos de tradução:

- lib/l10n/intl_pt.arb
- lib/l10n/intl_en.arb

### Exemplo de uso:

Text(S.of(context).save)

### Após editar `.arb`, rode:

flutter pub run intl_utils:generate

---

## 🧰 Comandos úteis

| Ação                           | Comando                                                             |
|--------------------------------|----------------------------------------------------------------------|
| Instalar pacotes               | flutter pub get                                                     |
| Rodar app Flutter              | flutter run                                                         |
| Gerar traduções                | flutter pub run intl_utils:generate                                 |
| Limpar e reinstalar tudo       | flutter clean && flutter pub get && flutter pub run intl_utils:generate |
| Atualizar pacotes              | flutter pub upgrade                                                 |
| Atualizar com maiores versões  | flutter pub upgrade --major-versions                                |
| Rodar servidor (.NET)          | dotnet run --launch-profile "http"                                  |
| Encerrar backend travado       | taskkill /F /IM TDLembretes.exe                                     |

---