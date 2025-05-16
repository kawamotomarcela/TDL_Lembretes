```mermaid
graph TD
    Usuario -->|Acessa| AplicativoFlutter
    AplicativoFlutter --> LoginCadastro
    AplicativoFlutter --> VerificaConectividade
    AplicativoFlutter --> UI
    AplicativoFlutter --> Models
    AplicativoFlutter --> TaskModel
    AplicativoFlutter --> UsuarioModel
    AplicativoFlutter --> ModoOffline
    AplicativoFlutter --> TratamentoErros

    VerificaConectividade -->|Online| Online
    VerificaConectividade -->|Offline| Offline
    Online -->|Sincroniza com API| SincronizaAPI
    Offline -->|Salva localmente| SalvaLocal

    ModoOffline --> BancoLocal
    BancoLocal --> API
    API --> BancoDeDados

    UI --> Providers
    Providers --> Services
    Services --> Routes
    Routes --> I18n
    I18n --> Testes

    TratamentoErros --> SnackBars




```