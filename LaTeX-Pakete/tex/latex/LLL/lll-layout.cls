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

\def\val{}
\def\nr{}
\def\@setheader{}
\define@choicekey{layout}{layout}[\val\nr]{lll,scdigi,schule}{%
	\ifcase\nr\relax%lll
		\def\layout@theme{theme=lll}%
		\def\@setheader{
			\geometry{top=2.2cm,headheight=35pt,headsep=1em}
			\AddToShipoutPictureBG{%
				\begin{tikzpicture}
			      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
			      	\draw [highlight, fill] (-0.5\paperwidth,13.8) rectangle (0.5\paperwidth,13.4);
			      	\node [anchor=east] at (9.64,13.75) {\includegraphics[height=1cm]{img/lll_logo}};
			      	\node [anchor=south west] at (9.7,-13) {\rotatebox{90}{\tiny\sffamily\@organisation}};
			      	\node [anchor=north west] at (-9.5,-14.3) {\footnotesize\@anmerkung};
			      	\node [anchor=west,highlight,fill=white] at (-8.54,13.54) {\normalfont\bfseries\sffamily\strut\@titel};
		    		\end{tikzpicture}
			}
		}
	\or%scdigi
		\def\layout@theme{theme=scdigi}%
		\def\@setheader{
			\geometry{top=4cm,headheight=3.4cm,headsep=1em}
			\AddToShipoutPictureBG{%
				\begin{tikzpicture}
			      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
			      	\node at (0,13) {\includegraphics[width=\paperwidth]{img/banner_schmal}};
			      	\node [rotate=90,anchor=north,white] at (9.7,13) {\tiny\sffamily\@datum}; 
			      	\node [anchor=south west] at (9.7,-13) {\rotatebox{90}{\tiny\sffamily\@organisation}};
			      	\node [anchor=north west] at (-9.5,-14.3) {\footnotesize\@anmerkung};
			      	\node [anchor=west, white] at (-8.68,13) {\normalfont\LARGE\bfseries\sffamily\strut\@titel};
		    		\end{tikzpicture}
			}
		}
	\or%Schule
		\def\layout@theme{theme=scdigi}%
		\def\@setheader{
			\geometry{top=1.7cm,headsep=1em}
			\AddToShipoutPictureBG{%
			   	\begin{tikzpicture}
			      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
			        \draw [rounded corners] (-10cm,-14.3cm) rectangle (9.8cm,14cm);
			        \node [rounded corners, draw, minimum height=0.8cm, minimum width=7cm,anchor=west,fill=white,text width=6.3cm] at (-9.5,14){\strut\@titel};
			      	\node [anchor=south east] at (9.5,14) {\footnotesize\@datum}; 
			      	\node [anchor=south west] at (9.7,-13) {\rotatebox{90}{\tiny\sffamily\@organisation}};
			      	\node [anchor=north west] at (-9.5,-14.3) {\footnotesize\@anmerkung};
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
\PassOptionsToClass{12pt}{scrartcl}
\ProcessOptionsX<layout>
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
\RequirePackage[left=2cm,width=18cm,bottom=1cm]{geometry}
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
\RequirePackage{fontawesome}

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