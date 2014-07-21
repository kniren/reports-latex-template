\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{documentation}[2014/07/21 Documentation class for reports in LaTeX]
\LoadClass[11pt,a4paper,oneside]{article}

% Loading Packages
\RequirePackage{graphicx}			% Allows graphics loading
\RequirePackage[utf8]{inputenc}		% Set encoding to UTF-8
\RequirePackage{setspace}		    % Allows paragraph spacing
\RequirePackage{subcaption}         % Allows subcations
\RequirePackage{titlesec}           % Allows title formatting

% Formatting the section style
\titleformat{\section}
    {\Large\scshape\raggedright}
    {}{0em}
    {}
    [\titlerule]
  
 \titleformat{\subsection}
    {\large\scshape\raggedright}
    {}{0em}
    {}

% Setting document options
\doublespacing
\graphicspath{ {figures/} }
\pagestyle{plain}
