*** Settings ***
Documentation     Testes de autenticacao e sessao - Mercado Livre API
Library           RequestsLibrary
Library           Collections
Resource          ../../../resources/keywords.robot

Suite Setup       Create Session    meli    https://api.mercadolibre.com
Suite Teardown    Delete All Sessions

*** Variables ***
${BASE_URL}       https://api.mercadolibre.com
${ITEM_ID}        MLB1234567890

*** Test Cases ***

TC001 - GET sites deve retornar 200 e lista de paises
    [Documentation]    Valida que o endpoint /sites retorna status 200 e uma lista de sites validos
    [Tags]    smoke    api    auth
    ${response}=    GET On Session    meli    /sites
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${body}
    Log    Sites disponiveis: ${body}

TC002 - GET categories deve retornar estrutura de payload correta
    [Documentation]    Valida que o endpoint de categorias retorna id e name no payload
    [Tags]    regression    api
    ${response}=    GET On Session    meli    /sites/MLB/categories
    Should Be Equal As Integers    ${response.status_code}    200
    ${categories}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${categories}
    ${first}=    Get From List    ${categories}    0
    Dictionary Should Contain Key    ${first}    id
    Dictionary Should Contain Key    ${first}    name
    Log    Primeira categoria: ${first}

TC003 - GET item com ID invalido deve retornar 404
    [Documentation]    Valida tratamento de erro para recurso inexistente (cenario negativo)
    [Tags]    negative    api    error-handling
    ${response}=    GET On Session    meli    /items/MLB000INVALID    expected_status=any
    Should Be Equal As Integers    ${response.status_code}    404
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    error
    Log    Erro retornado: ${body}[error]

TC004 - GET currency deve retornar BRL com campos obrigatorios
    [Documentation]    Valida payload completo da moeda BRL incluindo campos criticos
    [Tags]    regression    api    contract
    ${response}=    GET On Session    meli    /currencies/BRL
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    id
    Dictionary Should Contain Key    ${body}    symbol
    Dictionary Should Contain Key    ${body}    description
    Should Be Equal As Strings    ${body}[id]    BRL
    Log    Moeda: ${body}[description] - Simbolo: ${body}[symbol]

TC005 - GET search deve retornar resultados paginados
    [Documentation]    Valida que a busca retorna estrutura de paginacao e resultados
    [Tags]    regression    api    pagination
    &{params}=    Create Dictionary    q=notebook    limit=5
    ${response}=    GET On Session    meli    /sites/MLB/search    params=${params}
    Should Be Equal As Integers    ${response.status_code}    200
    ${body}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${body}    results
    Dictionary Should Contain Key    ${body}    paging
    ${results}=    Get From Dictionary    ${body}    results
    ${count}=    Get Length    ${results}
    Should Be True    ${count} <= 5
    Log    Resultados retornados: ${count}
