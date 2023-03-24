\ProvidesClass{lll-zertifikat}
\LoadClass{scrartcl} 

\RequirePackage{xkeyval}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{tikz}

\RequirePackage[ngerman]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}
\RequirePackage[T1]{fontenc}
\RequirePackage[draft=false]{scrlayer-scrpage}
	\clearpairofpagestyles
	\pagestyle{scrheadings}

\RequirePackage[ddmmyyyy]{datetime}
\renewcommand{\dateseparator}{.}
\RequirePackage{xspace}
\RequirePackage{eso-pic}
\RequirePackage[left=1.3cm,right=1.3cm,bottom=1cm]{geometry}
\pagenumbering{gobble}

\RequirePackage[theme=lll]{lll-color}

\AddToShipoutPictureBG{%
	\begin{tikzpicture}
      	\useasboundingbox(-0.5\paperwidth,-0.5\paperheight) rectangle (0.5\paperwidth,0.5\paperheight);
      	\draw [highlight, fill] (-0.5\paperwidth,9.8) rectangle (0.5\paperwidth,11.4);
      	\node [anchor=east] at (9.44,11) {\includegraphics[height=3cm]{img/lll-logo}};
    	\end{tikzpicture}
}

\AtBeginDocument{\sffamily\centering}

\def\@titel{Titel\xspace}
\newcommand{\titel}[1]{\def\@titel{#1\xspace}}

\def\@format{Workshop\xspace}
\newcommand{\format}[2][am]{\def\@format{#1 #2\xspace}}


\def\@datum{\today\xspace}
\newcommand{\datum}[2][am]{\def\@datum{#1 #2\xspace}}

\newcommand{\zertifikat}[1]{
	\null\vfill
	\vspace{2ex}
	\textcolor{highlight}{\fontsize{60}{60}\selectfont \textbf{Zertifikat}}%
	\vfill
	
	{\fontsize{40}{48}\selectfont #1}%
	\vspace{15ex}
	
	{\fontsize{20}{24}\selectfont hat \@datum erfolgreich \@format\\}%
	\vspace{5ex}
	
	{\fontsize{30}{48}\selectfont \@titel}%
	\vspace{5ex}
	
	{\fontsize{20}{24}\selectfont im Lehr-Lern-Labor Informatik Karlsruhe\\ am KIT teilgenommen.\\}%
	
	\vfill
	
	\begin{minipage}{0.78\textwidth}\color{gray}
	Im Lehr-Lern-Labor Informatik Karlsruhe wollen wir an den beiden Standorten an
	der Pädagogischen Hochschule Karlsruhe und dem Karlsruher Institut für Technologie (KIT) Schülerinnen und Schülern die Möglichkeit geben, Denkweisen der Informatik hautnah zu erfahren, um sich in der digitalisierten Welt zu orientieren. 
	Der Aufbau wird seit 01.09.2019 von der Vector Stiftung gefördert.
	\end{minipage}\hfill
	\begin{minipage}{0.15\textwidth}
	\includegraphics[width=\textwidth]{img/lll-kit_logo}\\
	\vspace{-0.5ex}
	
	\includegraphics[width=\textwidth]{img/lll-vector_logo}
	\end{minipage}
	\newpage
}