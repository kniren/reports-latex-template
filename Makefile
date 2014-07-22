all: includes main clean_aux
	
main: 
	@if [ ! -d output/reports ] ; then mkdir output/reports	; fi
	latexmk -outdir="output" -pdf documentation.tex

includes:
	@($(foreach file, $(wildcard reports/*.tex),echo "\include{`echo $(file) | cut -d "." -f1 `}";)) > includes.tex

clean_aux:
	@for file in output/* ; do if [ $$file != output/README ] && [ $$file != output/documentation.pdf ] ; then rm -R $$file ; fi ; done

clean:
	rm -R output/*
