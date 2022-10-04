Analisador Léxico - Calculadora

## Arquivos

`calculadora.l`: Arquivo léxico
`calculadora.y`: Arquivo "gramática"

## Compilador

- Compilar todo o código (passo a passo na próxima sessão):
  - `make`

### Passos

- Compilar o flex:
  - `flex calculadora.l`
- Compilar o léxico:
  - `gcc lex.yy.c -o code.out`
- Executar o:
  - `./code.out test.3m`

---

Trabalho: https://birl-language.github.io/

---

Gramática da linguagem C: https://www.quut.com/c/ANSI-C-grammar-y.html
