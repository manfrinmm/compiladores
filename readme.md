Projeto em: https://github.com/manfrinmm/compiladores/tree/Trabalho

## Arquivos

`birl.l`: Arquivo léxico
`birl.y`: Arquivo "gramática"
`output.txt`: Árvore Abstrata

### Testes

`test2.birl`: Compilação correta
`test2-error.birl`: Erro sintático

## Executar

- `./birl.out nomeDoArquivo.birl`

## Compilador

- Compilar todo o código (passo a passo na próxima sessão):
  - `make`

### Passos

- Compilar o flex:
  - `flex birl.l`
- Compilar o léxico:
  - `gcc lex.yy.c -o birl.out`
- Executar o:
  - `./birl.out test2.birl`

---

# Referência

- Trabalho: https://birl-language.github.io/
- Códigos:
  - https://github.com/thborges/cmp2019
  - https://github.com/manfrinmm/compiladores
