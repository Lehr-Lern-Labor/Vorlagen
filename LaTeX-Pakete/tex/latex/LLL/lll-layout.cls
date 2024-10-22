\ProvidesClass{lll-layout}
\RequirePackage{xkeyval}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{tikz}

% --------------------------------------------------------- Optionen für lll-color
\def\layout@theme{}
\def\layout@highlight{}
\def\layout@contrast{}
\def\layout@print{}
\define@key{layout}{theme}[black]{\def\layout@theme{theme=#1}}
\define@key{layout}{highlight}[black]{\def\layout@highlight{highlight=#1}}
\define@key{layout}{contrast}[black]{\def\layout@contrast{contrast=#1}}
\define@key{layout}{print}[true]{\def\layout@print{print=#1}}

% --------------------------------------------------------- Optionen für lll-arbeitsblatt
\def\layout@printlsg{}
\def\layout@lsgseite{}
\define@key{layout}{printlsg}[true]{\def\layout@printlsg{printlsg=#1}}
\define@key{layout}{lsgseite}[true]{\def\layout@lsgseite{lsgseite=#1}}

% --------------------------------------------------------- Optionen für lll-layout
\newif\iflayout@private\layout@privatetrue
\define@boolkey{layout}{public}[true]{\layout@privatefalse}
\define@boolkey{layout}{private}[true]{\layout@privatetrue}

\newcommand{\private}[2][]{%
	\iflayout@private%
		#2
	\else%
		#1
	\fi
}

\newif\iflayout@faOld\layout@faOldfalse
\define@boolkey{layout}{fa-old}[false]{\layout@faOldtrue}

\def\val{}
\def\nr{}
\def\@setheader{}
\define@choicekey{layout}{layout}[\val\nr]{lll,schule}{%
	\ifcase\nr\relax%lll
		\def\layout@theme{theme=lll}%
		\def\@setheader{%
			\geometry{top=2.2cm,headheight=35pt,headsep=1em}
			\AddToShipoutPictureBG{%
				\begin{tikzpicture}
					\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
					\draw [highlight, fill] (-0.5\paperwidth,0.5\paperheight-1.05cm) rectangle (0.5\paperwidth,0.5\paperheight-1.45cm);
					\node [anchor=east] at (0.5\paperwidth-0.86cm,0.5\paperheight-1.1cm) {\includegraphics[height=1cm]{img/lll-logo}};
					\node [anchor=south west] at (0.5\paperwidth-0.8cm,-0.5\paperheight+1.85cm) {\rotatebox{90}{\tiny\sffamily\@organisation}};
					\node [anchor=north west] at (-0.5\paperwidth+1.5cm,-0.5\paperheight+0.55cm) {\footnotesize\@anmerkung};
					\node [anchor=west,highlight,fill=white] at (-0.5\paperwidth+1.5cm,0.5\paperheight-1.31cm) {\normalfont\bfseries\sffamily\strut\@titel};
				\end{tikzpicture}
			}
		}
	\or%schule
		\def\layout@theme{theme=schule}%
		\def\@setheader{
			\geometry{top=2.2cm,headsep=1em,left=2cm}
			\AddToShipoutPictureBG{%
			   	\begin{tikzpicture}
			      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
			        \draw [rounded corners] (-0.5\paperwidth+0.5cm,-0.5\paperheight+0.55cm) rectangle (0.5\paperwidth-0.7cm,0.5\paperheight-0.85cm);
			        \node [rounded corners, draw, minimum height=0.8cm, minimum width=7cm,anchor=west,fill=white,text width=6.3cm] at (-0.5\paperwidth+1cm,0.5\paperheight-0.85cm){\strut\@titel};
			      	\node [anchor=south east] at (0.5\paperwidth-1cm,0.5\paperheight-0.85cm) {\footnotesize\@datum};
					\node [anchor=south west] at (0.5\paperwidth-0.8cm,-0.5\paperheight+1.85cm) {\rotatebox{90}{\tiny\sffamily\@organisation}};
					\node [anchor=north west] at (-0.5\paperwidth+1cm,-0.5\paperheight+0.55cm) {\footnotesize\@anmerkung};
			    \end{tikzpicture}
			}	
		}	
		\newcommand{\name}{%
			\AddToShipoutPictureFG*{%
				\AtTextUpperLeft{\makebox[\textwidth][r]{\raisebox{0.5ex}{\makebox[5cm]{Name: \hrulefill}}}}
			}%
		}
	\fi
}

%\DeclareOptionX*{\PackageWarning{lll-layout}{`\CurrentOption' ignored}} % geht...
%\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{scrartcl}} % geht nicht...
\ProcessOptionsX<layout>
\PassOptionsToClass{12pt}{scrartcl}
\LoadClass{scrartcl} 

\RequirePackage[ngerman]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[draft=false]{scrlayer-scrpage}
	\clearpairofpagestyles
	\pagestyle{scrheadings}

\RequirePackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
\RequirePackage{eso-pic}

\RequirePackage{geometry}
\geometry{left=1.5cm,right=1cm,bottom=1cm}
\@setheader

\RequirePackage{listings}

\renewcommand\thefootnote{\fnsymbol{footnote}}
\RequirePackage{perpage}
\MakePerPage[1]{footnote}

\AtBeginDocument{\raggedbottom}
	
\PassOptionsToPackage{\layout@theme,\layout@highlight,\layout@contrast,\layout@print}{lll-color}
\RequirePackage{lll-color}
\PassOptionsToPackage{\layout@printlsg,\layout@lsgseite}{lll-arbeitsblatt}

\RequirePackage[skins]{tcolorbox}
\RequirePackage{multicol}
\iflayout@faOld
	\RequirePackage{fontawesome}
\else
	\RequirePackage{betterfontawesome5}
\fi

\RequirePackage[pdfborder={0 0 0}]{hyperref}

\setlength{\parindent}{0pt}
\setlength{\parskip}{\medskipamount}
\newcommand{\@minipagerestore}{\setlength{\parskip}{\medskipamount}}

% ----- Infos
\def\@title{Titel}
\newcommand{\titel}[1]{\def\@titel{#1 \thepage}}

\def\@organisation{}
\newcommand{\organisation}[1]{\def\@organisation{#1}}

\def\@autor{}
\newcommand{\autor}[1]{\def\@autor{#1}}

\def\@datum{\today}
\newcommand{\datum}[1]{\def\@datum{#1}}

\def\@anmerkung{}
\newcommand{\anmerkung}[1]{\def\@anmerkung{#1}}

\RequirePackage{ccicons}
\newcommand{\lizenz}{\href{https://creativecommons.org/licenses/by/3.0/de/}{\ccby} \@autor}

% ----- Spalten
\newenvironment{spalten}[1][2]{%\vspace{-4ex}%
	\begin{multicols}{#1}\raggedcolumns%
}{%
	\end{multicols}
}


% ------------------------------------------------------- Kasten
\def\@symbheight{0.6cm}
\newcommand{\@icon}[2][highlight]{\resizebox{!}{\@symbheight}{\color{#1}#2 }}

\def\@iconKasten{\faLightbulbO}
\define@choicekey+{kasten}{symb}{none}{\renewcommand{\@icon}[2][]{}}{\def\@iconKasten{#1}}%
\def\kasten{\@ifstar\@@kasten\@kasten}

\newcommand{\@kasten}[3][]{%
\begingroup
	\vspace{2ex}%
	\setkeys{kasten}{#1}%
	\begin{tcolorbox}[%
		enhanced,
		width=\textwidth,
		drop fuzzy shadow southeast,
		parbox=false,
		colframe=highlight,
		colback=background
	]%
	\@icon{\@iconKasten}%
	\notempty{#2}{\textbf{#2}\\}#3\par
	\end{tcolorbox}\vspace{1ex}
\endgroup
}

\newcommand{\@@kasten}[1]{%
\begingroup
	\vspace{2ex}%
	\begin{tcolorbox}[%
		enhanced,
		width=\textwidth,
		drop fuzzy shadow southeast,
		parbox=false,
		colframe=highlight,
		colback=background
	]%
	#1\par
	\end{tcolorbox}\vspace{1ex}
\endgroup
}

\newcommand{\druckbereich}[1][0.5cm]{
	\AddToShipoutPictureFG{%
    		\begin{tikzpicture}
	      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
	       \draw[red] (-0.5\paperwidth+#1,-0.5\paperheight+#1) rectangle (0.5\paperwidth-#1,0.5\paperheight-#1);
     	\end{tikzpicture}
	}
}

% ------------------------------------------------------- listings
\lstset{
	basicstyle			= {\small\ttfamily},
%	backgroundcolor		= \color{gray!10},
	numbers				= left,
	numberstyle			= \tiny\ttfamily,
	xleftmargin			= 1.2em,
	keywordstyle			= \color{codeKeywords}\bfseries,
	commentstyle			= \color{codeComment},
	stringstyle			= \color{codeString},
	tabsize				= 4,
	extendedchars		= true,
	showstringspaces		= false,
%	morekeywords			= [2]{alert, foo, bar, if},
	literate				=%
						  {Ö}{{\"O}}1
						  {Ä}{{\"A}}1
						  {Ü}{{\"U}}1
						  {ß}{{\ss}}1
						  {ü}{{\"u}}1
						  {ä}{{\"a}}1
						  {ö}{{\"o}}1
						  {ß}{{\ss}}1
}