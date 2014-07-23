\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{documentation}[2014/07/21 Documentation class for reports in LaTeX]
\LoadClass[11pt,a4paper,oneside]{article}

% Loading Packages
\RequirePackage{amsmath}            % Better math environment
\RequirePackage{booktabs}           % Better tables
\RequirePackage{graphicx}			% Allows graphics loading
\RequirePackage[utf8]{inputenc}		% Set encoding to UTF-8
\RequirePackage{setspace}		    % Allows paragraph spacing
\RequirePackage{subcaption}         % Allows subcations
\RequirePackage{url}                % Support for url commands
    \RequirePackage{titlesec}           % Allows title formatting
\RequirePackage[activate={true,nocompatibility},final,tracking=true,kerning=true,spacing=true,factor=1100,stretch=10,shrink=10]{microtype}
\RequirePackage{cleveref}           % Better references

% Formatting the section style
\titleformat{\section}
    {\Large\scshape\center}
    {}{0em}
    {\hrule}
    [\titlerule]
  
 \titleformat{\subsection}
    {\large\scshape\center}
    {}{0em}
    {}

 \titleformat{\subsubsection}
    {\small\scshape\center}
    {}{0em}
    {}

\titlespacing\section{0pt}{24pt plus 2pt minus 2pt}{36pt plus 2pt minus 2pt}
\titlespacing\subsection{0pt}{24pt plus 2pt minus 2pt}{24pt plus 2pt minus 2pt}
\titlespacing\subsubsection{0pt}{12pt plus 2pt minus 2pt}{12pt plus 2pt minus 2pt}


% Setting document options
\doublespacing
\graphicspath{figures/}
\pagestyle{plain}
