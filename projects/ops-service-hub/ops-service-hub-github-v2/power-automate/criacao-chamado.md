# Power Automate: fluxo de criação do chamado

## Etapas públicas

1. Quando uma nova resposta é submetida.
2. Coleta as informações do formulário.
3. Ajusta links e consolida anexos.
4. Inicializa variáveis auxiliares.
5. Normaliza data e hora de abertura.
6. Consulta Excel de apoio para SLA e atribuição.
7. Cria registro na Microsoft List.
8. Monta HTML do e-mail.
9. Anexa cabeçalho e rodapé institucionais, quando aplicável.
10. Envia e-mail para o solicitante.

## Pseudocódigo

```text
on_new_response():
    response = get_response_details()
    attachments = normalize_attachment_links(response)
    opened_at = normalize_datetime(response.submission_time)
    rules = lookup_rules(response.area, response.type, response.subtype)
    ticket = build_ticket(response, rules, opened_at, attachments)
    list_id = create_sharepoint_item(ticket)
    email_body = render_email(ticket)
    send_email(response.requester_email, email_body)
```

## Boas práticas

- Separar expressões complexas em composes nomeados.
- Registrar falhas em tabela/lista de monitoramento.
- Evitar valores fixos diretamente no fluxo.
- Usar catálogo de regras para SLA e responsável.
- Não expor conexões, URLs ou IDs no repositório público.
