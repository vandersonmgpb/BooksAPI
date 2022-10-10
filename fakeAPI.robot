*** Settings *** 
Documentation    Documentacao da API: https://fakerestapi.azurewebsites.net/swagger/ui/index#!/Books
Resource         ResourceAPI.robot
Suite Setup      Conectar a minha API


*** Test Case ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
#    - Conferir se retorna uma lista com 200 livros
#TO-DO: Buscar um livro especifico (GET em um livro especifico)
#    - Conferir se retorna todos os dados corretos do livro 15
#TO-DO: Cadastrar um novo livro (POST)
#    - Conferir se retorna todos os dados cadastrados para o novo livro
#TO-DO: Alterar um livro (PUT)
#    - Conferir se retorna todos os dados alterados  do livro 150
#TO-DO: Deletar um livro (DELETE)
#    - Conferir se deleta o livro 200

