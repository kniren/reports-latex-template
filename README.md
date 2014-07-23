Documentation Repository
========================

The recommended way of working with this template is to use a plain
text editor and the make program to compile your LaTeX files.


Installation
------------

Clone the repository to your computer.

    git clone git@github.com:kniren/reports-latex-template.git

Create a branch with your name, make sure that it doesn't exists
already.

    git branch name
    git checkout name

When pushing the changes, make sure that you push all branches.

    git push --all


Compilation
-----------

To generate the report only for today:

    make 

To generate the report only for today and not cleaning the auxiliary
files. Useful for monitoring purposes that will compile when some file
on the document changes:

    make monitor 

To generate a document containing all the reports:

    make total

To include all the reports that belongs to the current month:

    make monthly

To include all the reports that belongs to the current year:

    make year

To remove all generated files in the output directory:

    make clean


Directrices
-----------

1. Write the reports following this naming structure `reports/YYYY-MM-DD-name.tex`.
2. Use the YYYY-MM-DD format for the main section of the document.
3. Write each sentence on a separate line so that we can version
   control the documentation more effectively.

        \section{YYYY-MM-DD} 

        This sentence and the one bellow.
        Will be interpreted as a paragraph.

        This is a new paragraph.
        ...

4. Commit often, push periodically.
