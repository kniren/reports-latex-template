all: today main clean_aux

monitor: today main

total: include_all main clean_aux
	
main: 
	@if [ ! -d output/reports ] ; then mkdir output/reports	; fi
	latexmk -outdir="output" -pdf documentation.tex

include_all: check_reports
	@($(foreach file, $(wildcard reports/*.tex),echo "\include{`echo $(file) | cut -d "." -f1 `}";)) > includes.tex

yearly: check_reports main clean_aux
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

monthly: check_reports main clean_aux
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

today: check_reports main
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@for file in reports/* ; do 									   \
		DOCYEAR=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f1 )	;  \
		LOCYEAR=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f1 ) ;  \
		DOCMONTH=$$(echo $$file | cut -d "/" -f2 | cut -d "-" -f2 )	;  \
		LOCMONTH=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f2 ) ;  \
		DOCDAY=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f3 )	;  \
		LOCDAY=$$(date -jnu +"%Y-%m-%d" 		 | cut -d "-" -f3 ) ;  \
		if [ $$DOCYEAR 	= $$LOCYEAR  ] 							       \
		&& [ $$DOCMONTH = $$LOCMONTH ]  							   \
		&& [ $$DOCDAY 	= $$LOCDAY   ];								   \
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

check_reports:
ifeq ($(shell find reports -maxdepth 1 -name "*.tex" ),)
	$(error No reports found)
endif

clean:
	@for file in output/* ; do 						\
		if [ $$file != output/README ] ; 			\
		   then 									\
		rm -R $$file ; 								\
		fi ; 										\
	done
