*** Settings ***
Documentation     Keywords reutilizaveis para os testes da suite QA Portfolio
Library           RequestsLibrary
Library           Collections
Library           String
Library           DateTime

*** Keywords ***

Verificar Status Code
    [Documentation]    Verifica se o status code da resposta e o esperado
    [Arguments]    ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
    Log    Status code validado: ${response.status_code}

Verificar Chave No Payload
    [Documentation]    Verifica se uma chave obrigatoria existe no payload JSON
    [Arguments]    ${payload}    ${key}
    Dictionary Should Contain Key    ${payload}    ${key}
    Log    Chave '${key}' encontrada no payload

Verificar Payload Nao Vazio
    [Documentation]    Verifica se o payload retornado nao e vazio
    [Arguments]    ${payload}
    Should Not Be Empty    ${payload}
    Log    Payload validado - nao vazio

Logar Tempo De Resposta
    [Documentation]    Loga o tempo de resposta da requisicao em ms
    [Arguments]    ${response}
    ${elapsed}=    Set Variable    ${response.elapsed.total_seconds()}
    Log    Tempo de resposta: ${elapsed}s
    RETURN    ${elapsed}

Verificar Content Type JSON
    [Documentation]    Verifica se o Content-Type da resposta e application/json
    [Arguments]    ${response}
    ${content_type}=    Get From Dictionary    ${response.headers}    Content-Type
    Should Contain    ${content_type}    application/json
    Log    Content-Type validado: ${content_type}
