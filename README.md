# provatex

Template LaTeX para provas objetivas do IFCE, baseado na classe
[`exam`](https://ctan.org/pkg/exam). Gera, a partir do mesmo arquivo, a
versão do estudante e a versão do professor, com as respostas.

## Arquivos

| Arquivo | Conteúdo |
| --- | --- |
| `prova.tex` | Orientações e questões da prova |
| `config.tex` | Dados da turma: curso, disciplina, professor, período, logo e cartão-resposta |
| `provatex.sty` | Aparência: pacotes, margens, cabeçalho, questões, alternativas e gabarito |
| `logo-ifce-bat-11pt.pdf` | Logo do campus, usado no cabeçalho |
| `gabarito.pdf` | Cartão-resposta gerado pelo EvalBee |
| `fontes/` | Fonte Open Sans (regular, negrito, itálico e negrito itálico) e sua licença |
| `Makefile` | Gera as duas versões da prova com um comando |

## Como compilar

Para gerar as duas versões de uma vez:

```bash
make
```

O resultado é:

- `prova.pdf`: versão do estudante, sem respostas.
- `prova-respostas.pdf`: versão do professor, com a alternativa certa em
  negrito e a lista de respostas no final. Este arquivo não vai para o
  repositório (está no `.gitignore`).

Sem o `make`, os comandos equivalentes são:

```bash
xelatex prova.tex
xelatex -jobname=prova-respostas "\def\comrespostas{}\input{prova}"
```

Rode cada um duas vezes. Para apagar os arquivos auxiliares do LaTeX
(`.aux`, `.log`), use `make limpa`.

## Como fazer uma nova prova

1. Copie `prova.tex` e `config.tex` para uma pasta nova, junto com
   `provatex.sty`, a pasta `fontes/`, o logo e o cartão-resposta.
2. Ajuste os dados da turma em `config.tex`.
3. Gere o cartão-resposta no EvalBee com o número de questões da prova e
   salve como `gabarito.pdf` (ou indique outro nome em `config.tex`).
4. Escreva as questões em `prova.tex`.

## Como escrever as questões

Cada questão objetiva segue este modelo. O número entre colchetes é a
pontuação:

```latex
\begin{question}[1]
Enunciado da questão.

\begin{choices}
    \CorrectChoice Alternativa correta.
    \choice Outra alternativa.
    \choice Outra alternativa.
    \choice Outra alternativa.
    \choice Outra alternativa.
\end{choices}
\end{question}
```

Basta marcar a alternativa certa com `\CorrectChoice`. O gabarito é montado
sozinho a partir dessas marcações.

A primeira linha do enunciado recebe recuo automático, alinhada com o início
da barra cinza do título.

## Opções de estilo

As letras das alternativas são maiúsculas (A, B, C...), iguais às do
cartão-resposta do EvalBee. Para usar minúsculas (a, b, c...), carregue o
estilo com a opção `minusculas` em `prova.tex`:

```latex
\usepackage[minusculas]{provatex}
```

A lista de respostas da versão do professor segue a mesma escolha.

Depois da última questão, antes de `\end{questions}`, ficam dois comandos:

- `\espacocalculos`: reserva o espaço para cálculos no fim da coluna.
- `\listaderespostas`: imprime a lista de respostas, só na versão do
  professor.

## Requisitos

A prova é compilada com **XeLaTeX**, porque a fonte Open Sans é carregada
da pasta `fontes/` do próprio projeto. Assim, ela sai igual em qualquer
computador, sem instalar a fonte no sistema. O português do Brasil vem da
definição embutida no próprio `babel`, sem depender do arquivo `brazil.ldf`.

No Fedora, os pacotes LaTeX usados podem ser instalados de uma vez com:

```bash
sudo dnf install texlive-xetex 'tex(fontspec.sty)' 'tex(exam.cls)' 'tex(babel.sty)' 'tex(multicol.sty)' 'tex(amsmath.sty)' 'tex(multirow.sty)' 'tex(tabularx.sty)' 'tex(siunitx.sty)' 'tex(tikz.sty)' 'tex(tcolorbox.sty)' 'tex(graphicx.sty)' 'tex(enumitem.sty)' 'tex(colortbl.sty)' 'tex(calc.sty)' 'tex(geometry.sty)'
```

Opcional, mas recomendado: as regras de divisão silábica do português, que
deixam o texto justificado mais uniforme. Sem elas a prova compila do mesmo
jeito, só sem dividir palavras no fim das linhas.

```bash
sudo dnf install texlive-hyphen-portuguese
```

## Licença da fonte

A Open Sans é distribuída sob a SIL Open Font License 1.1, cujo texto está
em `fontes/OFL.txt`.
