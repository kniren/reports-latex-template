all: includes main clean_aux
	
main: 
	@if [ ! -d output/reports ] ; then mkdir output/reports	; fi
	latexmk -outdir="output" -pdf documentation.tex

includes:
	@($(foreach file,$(wildcard reports/*.tex),echo "\include{`echo $(file) | cut -d "." -f1 `}";)) > includes.tex

clean_aux:
	@$(foreach file,$(wildcard output/*),  $(if $(filter-out $(file),output/documentation.pdf) , rm -R $(file);))

clean:
	rm -R output/*
