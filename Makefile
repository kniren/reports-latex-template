all: include_all main clean_aux
	
main: 
	@if [ ! -d output/reports ] ; then mkdir output/reports	; fi
	latexmk -outdir="output" -pdf documentation.tex

include_all:
	@($(foreach file, $(wildcard reports/*.tex),echo "\include{`echo $(file) | cut -d "." -f1 `}";)) > includes.tex

yearly: main clear_aux
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@for file in reports/* ; do 									   \
		DOCYEAR=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f1 )	;  \
		LOCYEAR=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f1 ) ;  \
		if [ $$DOCYEAR = $$LOCYEAR ];								   \
		then 														   \
			echo \\include{reports/`echo $$file    |				   \
						   			cut -d "/" -f2 | 				   \
		 							cut -d "." -f1`} >> includes.tex ; \
		fi ; 														   \
	done
	@touch includes.tex

monthly: main clear_aux
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@for file in reports/* ; do 									   \
		DOCYEAR=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f1 )	;  \
		LOCYEAR=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f1 ) ;  \
		DOCMONTH=$$(echo $$file | cut -d "/" -f2 | cut -d "-" -f2 )	;  \
		LOCMONTH=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f2 ) ;  \
		if [ $$DOCYEAR = $$LOCYEAR ]  && [ $$DOCMONTH = $$LOCMONTH ];  \
		then 														   \
			echo \\include{reports/`echo $$file    |				   \
						   			cut -d "/" -f2 | 				   \
		 							cut -d "." -f1`} >> includes.tex ; \
		fi ; 														   \
	done
	@touch includes.tex
 
clean_aux:
	@for file in output/* ; do 						\
		if [ $$file != output/README ] && 			\
		   [ $$file != output/documentation.pdf ] ; \
		   then 									\
		rm -R $$file ; 								\
		fi ; 										\
	done

clean:
	rm -R output/*
