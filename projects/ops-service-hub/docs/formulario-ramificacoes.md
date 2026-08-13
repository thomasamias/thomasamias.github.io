# Formulário ramificado

## Setores macro

- Control Desk
- WFM
- MOP
- Planejamento
- Relatórios
- Telecom

## Padrão de desenho

Cada ramificação deve ser documentada como uma regra de roteamento:

```text
Setor responsável + tipo de solicitação + subtipo + campos obrigatórios + anexos + destino
```

## Exemplo público

| Setor | Tipo macro | Campos condicionais | Destino |
|---|---|---|---|
| WFM | Ajuste de escala | Data, arquivo padrão, observação | Chamado operacional |
| MOP | Inclusão ou alteração | Dados do colaborador, datas e anexos | Chamado operacional |
| Telecom | Usuário Genesys | Organização, tipo de acesso, e-mail | Integração elegível |
| Telecom | Filas | Nome da fila, categoria, prioridade | Análise e automação |
| Relatórios | Extração ou inconsistência | Relatório, necessidade, evidência | Fila de relatórios |
| Planejamento | De acordo | Data, motivo, impacto | Validação operacional |
```
