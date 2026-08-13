# Fluxo operacional atual

## Jornada ponta a ponta

```mermaid
sequenceDiagram
    participant Usuario as Solicitante
    participant Forms as Microsoft Forms
    participant Flow as Power Automate
    participant Excel as Excel de apoio
    participant List as Microsoft List
    participant Apps as Power Apps
    participant SLA as Flow SLA
    participant Genesys as Genesys Cloud
    participant BI as Power BI

    Usuario->>Forms: Envia solicitação ramificada
    Forms->>Flow: Nova resposta submetida
    Flow->>Flow: Coleta detalhes e normaliza campos
    Flow->>Excel: Consulta regras, SLA e atribuições
    Flow->>List: Cria chamado operacional
    Flow->>Usuario: Envia e-mail de abertura
    Apps->>List: Consulta e trata chamado
    Apps->>BI: Gera eventos de log para auditoria
    SLA->>List: Atualiza status de SLA por recorrência
    Flow->>Genesys: Executa ação elegível quando aplicável
    List->>BI: Alimenta painéis operacionais
```

## Responsabilidades principais

- Formulário: captura estruturada e direcionamento por ramificações.
- Power Automate de criação: normaliza, consulta regras e cria chamado.
- Excel de apoio: suporta atribuição, SLA, padrões e regras auxiliares.
- Microsoft List: repositório operacional para o app e BI.
- Power Apps: interface de tratativa, resposta e atualização.
- Power Automate de SLA: manutenção recorrente do prazo.
- Genesys Cloud: execução de processos elegíveis.
- Power BI: acompanhamento operacional e administrativo.
