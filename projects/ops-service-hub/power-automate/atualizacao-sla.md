# Power Automate: atualização recorrente de SLA

## Objetivo

Atualizar automaticamente a condição de SLA dos chamados pendentes ou em tratativa.

## Fluxo público

```text
Recorrência
  ↓
Inicializa data/hora de referência
  ↓
Busca chamados elegíveis
  ↓
Para cada chamado
  ↓
Calcula data final de SLA
  ↓
Define status do SLA
  ↓
Atualiza item na Microsoft List
```

## Regras recomendadas

- Considerar somente chamados não concluídos.
- Separar SLA de resposta e SLA de conclusão, se existirem.
- Registrar data da última avaliação.
- Evitar recalcular chamados encerrados sem necessidade.
- Monitorar falhas do fluxo.
