# Power BI: modelos analíticos

## Modelo operacional de chamados

Fato principal: `Fato_Chamados`, com granularidade de uma linha por chamado.

Dimensões recomendadas:

- Dim_Data
- Dim_Area
- Dim_TipoSolicitacao
- Dim_Status
- Dim_SLA
- Dim_Analista
- Dim_Origem

## Modelo administrativo de logs

Fato principal: `Fato_AppLogs`, com granularidade de uma linha por evento do aplicativo.

## Medidas DAX públicas

```DAX
Total Chamados = DISTINCTCOUNT(Fato_Chamados[ChamadoCodigo])

Backlog =
CALCULATE(
    [Total Chamados],
    Fato_Chamados[StatusChamado] <> "Concluído"
)

Chamados Dentro do Prazo =
CALCULATE(
    [Total Chamados],
    Fato_Chamados[StatusSLA] IN {"Dentro do prazo", "Concluído no prazo"}
)

% SLA Cumprido =
DIVIDE([Chamados Dentro do Prazo], [Total Chamados])
```
