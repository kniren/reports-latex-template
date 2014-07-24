DATE=$(shell date -jnu +"%Y-%m-%d")

all: today main clean_aux

monitor: check_reports date main

total: include_all main clean_aux
	
main: 
	@if [ ! -d output/reports ] ; then mkdir output/reports	; fi
	latexmk -outdir="output" -pdf documentation.tex

include_all: check_reports
	@($(foreach file, $(wildcard reports/*.tex),echo "\include{`echo $(file) | cut -d "." -f1 `}";)) > includes.tex

date: check_reports
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@touch includes.tex
	@if [ -n $(DATE) ] ; then \
	 for file in reports/* ; do 									   \
		DOCYEAR=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f1 )	;  \
		LOCYEAR=$$(echo $(DATE) 	         	 | cut -d "-" -f1 ) ;  \
		DOCMONTH=$$(echo $$file | cut -d "/" -f2 | cut -d "-" -f2 )	;  \
		LOCMONTH=$$(echo $(DATE) 	         	 | cut -d "-" -f2 ) ;  \
		DOCDAY=$$(echo $$file 	| cut -d "/" -f2 | cut -d "-" -f3 )	;  \
		LOCDAY=$$(echo $(DATE) 	         	 	 | cut -d "-" -f3 ) ;  \
		if [ $$DOCYEAR  = $$LOCYEAR  ] &&     						   \
		   [ $$DOCMONTH = $$LOCMONTH ] &&	  						   \
		   [ $$DOCDAY   = $$LOCDAY   ] ; 							   \
		then 														   \
			echo \\include{reports/`echo $$file    |				   \
						   			cut -d "/" -f2 | 				   \
		 							cut -d "." -f1`} >> includes.tex ; \
		fi ; 														   \
	done ; \
    fi

yearly: check_reports main clean_aux
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@touch includes.tex
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

monthly: check_reports main clean_aux
	@if [ -e includes.tex ] ; then \
		rm includes.tex ; 	       \
	fi 
	@touch includes.tex
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

today: date check_reports main
 
clean_aux:
	@for file in output/* ; do 						\
		if [ $$file != output/README ] && 			\
		   [ $$file != output/documentation.pdf ] ; \
		   then 									\
		rm -R $$file ; 								\
		fi ; 										\
	done
	@for file in figures/* ; do						\
		if [ $$file != figures/README ] && 			\
		[ `echo $$file | cut -d "." -f2` = pdf ] ;  \
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
