# Excel de apoio: regras, SLA e atribuições

O Excel de apoio representa uma camada de regras antes da criação definitiva do chamado na Microsoft List.

## Papéis da base

| Aba conceitual | Finalidade pública |
|---|---|
| Dicionário | Explicação dos campos e fórmulas |
| Parâmetros | Regras de área, tipo, subtipo, SLA e responsável |
| Padrões | Valores padronizados para classificação e atribuição |
| Base | Base auxiliar de respostas e campos derivados |
| Histórico | Registros históricos ou base de apoio |
| Logs_App | Eventos de acesso, pesquisa e alteração |

## Recomendação técnica

Para crescimento e governança, as regras críticas devem migrar gradualmente para SQL Server ou Dataverse, mantendo o Excel como apoio controlado ou catálogo exportável.

## Modelo público de parametrização

```text
AreaResponsavel
TipoSolicitacao
SubTipoSolicitacao
SlaHorasUteis
ResponsavelPadrao
ExigeAnexo
ExigeDeAcordo
IntegracaoElegivel
Ativo
```
