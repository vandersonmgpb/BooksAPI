*** Settings *** 
Documentation    Documentacao da API: https://fakerestapi.azurewebsites.net/index.html
Library          RequestsLibrary
Library          Collections

*** Variables ***
${URL_API}    https://fakerestapi.azurewebsites.net/api/v1
&{Book_15}    id=15
...           title=Book 15
...           pageCount=1500  

*** Keywords ***
##### SETUP E TEARDOWN
Conectar a minha API
    Create Session    fakeAPI    ${URL_API}

#### Acoes
Requisitar todos os livros
    ${RESPOSTA}     Get Request    fakeAPI    Books
    Log             ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}     Get Request    fakeAPI    Books/${ID_LIVRO}
    Log             ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

Cadastrar um novo livro
    ${HEADERS}      Create Dictionary    content-type=application/json
    ${RESPOSTA}     Post Request    fakeAPI    Books
    ...                             data={"id": 2323, "title": "teste", "description": "teste", "pageCount": 200, "excerpt": "teste", "publishDate": "2022-10-13T19:57:08.849Z"}
    ...                             headers=${HEADERS}
    Log         ${RESPOSTA.text}
    Set Test Variable    ${RESPOSTA}

#### Conferencias
Conferir o status code
    [Arguments]    ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]    ${REASON_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna uma lista com "${QTDE_LIVROS}" livros
    Length Should Be    ${RESPOSTA.json()}    ${QTDE_LIVROS}

Conferir se retorna todos os dados corretos do livro 15
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id             ${Book_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title          ${Book_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount      ${Book_15.pageCount}
    Should Not Be Empty    ${RESPOSTA.json()["description"]}        
    Should Not Be Empty    ${RESPOSTA.json()["excerpt"]}   
    Should Not Be Empty    ${RESPOSTA.json()["publishDate"]} 
    