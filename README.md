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
pdflatex prova.tex
pdflatex -jobname=prova-respostas "\def\comrespostas{}\input{prova}"
```

Rode cada um duas vezes. Para apagar os arquivos auxiliares do LaTeX
(`.aux`, `.log`), use `make limpa`.

## Como fazer uma nova prova

1. Copie `prova.tex` e `config.tex` para uma pasta nova, junto com
   `provatex.sty`, o logo e o cartão-resposta.
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

Depois da última questão, antes de `\end{questions}`, ficam dois comandos:

- `\espacocalculos`: reserva o espaço para cálculos no fim da coluna.
- `\listaderespostas`: imprime a lista de respostas, só na versão do
  professor.

## Requisitos

Uma instalação do TeX Live com os pacotes usados em `provatex.sty`. No
Fedora, todos podem ser instalados de uma vez com:

```bash
sudo dnf install 'tex(exam.cls)' 'tex(inputenc.sty)' 'tex(fontenc.sty)' 'tex(cm-super-t1.enc)' 'tex(babel.sty)' 'tex(brazil.ldf)' 'tex(multicol.sty)' 'tex(amsmath.sty)' 'tex(multirow.sty)' 'tex(tabularx.sty)' 'tex(siunitx.sty)' 'tex(tikz.sty)' 'tex(tcolorbox.sty)' 'tex(graphicx.sty)' 'tex(enumitem.sty)' 'tex(colortbl.sty)' 'tex(calc.sty)' 'tex(geometry.sty)'
```
