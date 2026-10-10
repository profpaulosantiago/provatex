# Gera as duas versões da prova: estudante e professor.
#
#   make             gera prova.pdf e prova-respostas.pdf
#   make estudante   gera só prova.pdf
#   make professor   gera só prova-respostas.pdf
#   make limpa       apaga os arquivos auxiliares do LaTeX
#
# Cada versão é compilada duas vezes, como de costume no LaTeX,
# para que contagens e referências fiquem corretas.

FONTES = prova.tex config.tex provatex.sty

all: estudante professor

estudante: prova.pdf

professor: prova-respostas.pdf

prova.pdf: $(FONTES)
	pdflatex prova.tex
	pdflatex prova.tex

prova-respostas.pdf: $(FONTES)
	pdflatex -jobname=prova-respostas "\def\comrespostas{}\input{prova}"
	pdflatex -jobname=prova-respostas "\def\comrespostas{}\input{prova}"

limpa:
	rm -f *.aux *.log *.out

.PHONY: all estudante professor limpa
