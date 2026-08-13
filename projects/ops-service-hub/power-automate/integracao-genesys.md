# Power Automate: integração Genesys Cloud

## Objetivo

Executar automações específicas para chamados elegíveis, como operações relacionadas a usuários, filas ou configurações operacionais.

## Padrão recomendado

```text
Chamado elegível
  ↓
Validação de campos obrigatórios
  ↓
Autenticação segura
  ↓
Chamada HTTP/API
  ↓
Registro de retorno
  ↓
Atualização do chamado
  ↓
Log de sucesso ou falha
```

## Segurança

- Nunca versionar token, client secret, client id ou URL interna.
- Usar conectores, cofres de segredo ou variáveis seguras.
- Registrar somente resumo técnico público.
