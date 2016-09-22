% http://ctan.mirrors.hoobly.com/macros/latex/doc/clsguide.pdf

% Rule of thumb: in class if specific to the class
%                in package if it can be in different class

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{eplbase}[2015/01/14 EPL summary class]

\DeclareOption{en}{\PassOptionsToPackage{english}{babel}}
\DeclareOption{fr}{\PassOptionsToPackage{frenchb}{babel}}

% If you want to compile without it
\DeclareOption{skiptoc}{\newcommand{\skiptableofcontents}{}}
\DeclareOption{skiptitle}{\newcommand{\skiptitlepage}{}}
\DeclareOption{license=none}{\newcommand{\nolicense}{}}

\DeclareOption{usereportclass}{\newcommand{\usereport}{}}
\DeclareOption{10pt}{
\ifcsname usereport\endcsname%
\PassOptionsToClass{10pt}{report}
\else%
\PassOptionsToClass{10pt}{article}
\fi%
}
\DeclareOption{landscape}{
\ifcsname usereport\endcsname%
\PassOptionsToClass{landscape}{report}
\else%
\PassOptionsToClass{landscape}{article}
\fi%
}

\DeclareOption*{\ClassError{eplbase}{I have not the faintest idea of what you wanted to do when you gave the the option ``\CurrentOption''. I could have just thrown a warning, ignore it and continue compiling but I think I will just stop here. Press ``H'' for help}{If you really don't understand why I say that, please ask on Github with an issue.}}

% relax is needed since \ProcessOptions* exists too
\ProcessOptions\relax

\ifcsname usereport\endcsname%
\LoadClass[a4paper]{report}
\else%
\LoadClass[a4paper]{article}
\fi%

\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lmodern}

\RequirePackage{babel}
\RequirePackage{iflang}

\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage{xparse}

%%% SECTION TITLE APPEARANCE
\RequirePackage{sectsty}
\allsectionsfont{\sffamily\mdseries\upshape} % (See the fntguide.pdf for font help)
% (This matches ConTeXt defaults)

% Color
% cfr http://en.wikibooks.org/wiki/LaTeX/Colors
\RequirePackage{color}
\RequirePackage[usenames,dvipsnames,svgnames,table]{xcolor}
\definecolor{dkgreen}{rgb}{0.25,0.7,0.35}
\definecolor{dkred}{rgb}{0.7,0,0}

%\RequirePackage{../../../eplcommon}

\newcommand{\annexe}{\part{Annexes}\appendix}

% Bibliography
\newcommand{\biblio}[1][plain]{\bibliographystyle{#1}\bibliography{biblio}}

\RequirePackage{fullpage}

% For multirow in tabular
\RequirePackage{multirow}
% For multiple columns like in beamer
\RequirePackage{multicol}

\RequirePackage{tikz}
\usetikzlibrary{positioning, calc}

% For tikz v3 or higher we should use the babel tikz library
% but for tikz v2 or lower it does not exists
\newif\iftikzthree
\begingroup
\def\getmainversion#1.#2\getmainversion{#1}
\ifnum\expandafter\getmainversion\pgfversion\getmainversion=3
  \global\tikzthreetrue
\fi
\endgroup

\iftikzthree
\usetikzlibrary{babel}
\else
\typeout{You have an old version of Tikz: \pgfversion, try to update some time ;)}
\fi

\RequirePackage{pdfpages}
%\usepackage{subfig}
% subfig is deprecated see
% http://en.wikibooks.org/wiki/LaTeX/Floats,_Figures_and_Captions#Subfloats
\usepackage{caption}
\usepackage{subcaption}

\usepackage{enumerate}

\RequirePackage{hyperref}

% le `[e ]' rend le premier argument (#1) optionnel
% avec comme valeur par défaut `e `
\DeclareDocumentCommand{\basehypertitle}{ O{e } m m m m m m m O{} }{

{\renewcommand{\and}{\unskip, }
\hypersetup{pdfauthor={#6},
            pdftitle={#8 #2 Q#3 - L#4#5},
            pdfsubject={#2}}
}

\title{\IfLanguageName{english}{#8 of }{#8 d#1}#2 Q#3 - L#4#5}
\author{#6}

\begin{document}

\ifthenelse{\isundefined{\skiptitlepage}}{
\begin{titlepage}
\maketitle
% Remove duplicate page number on title page
\thispagestyle{empty}

  	\paragraph{\IfLanguageName{english}{Important Information}{Informations importantes}}
   	\begin{center}
    	 \url{https://github.com/Gp2mv3/Syntheses}.
  	\end{center}
\end{titlepage}
}{}

\ifthenelse{\isundefined{\skiptableofcontents}}{
\tableofcontents
}{}
}

\endinput
