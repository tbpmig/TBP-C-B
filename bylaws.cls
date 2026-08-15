% Adapted from:
%   https://gist.github.com/166080
%   https://github.com/eyliu/MSAconstitution/blob/master/constitution.cls
% both by Elson Liu &lt;eyliu@umich.edu&gt;

%Reworked extensively by Mike Hand

\NeedsTeXFormat{LaTeX2e}[1994/06/01]

\ProvidesClass{bylaws}[2009/05/15 v0.0.1 Document class for typesetting a bylaws]



\RequirePackage{ifthen}
\RequirePackage{xspace}


\newcommand\@myptsize{}
\newboolean{@constitution}
\newboolean{@approved}
\newboolean{@printpreface}
\newboolean{@printoptional}
\newboolean{@officerdoc}

%Class options
\DeclareOption{bylaws}{\@constitutionfalse}
\DeclareOption{constitution}{\@constitutiontrue}
\DeclareOption{officerdoc}{\@officerdoctrue}
\DeclareOption{proposal}{\@approvedfalse}
\DeclareOption{final}{\@approvedtrue}
\DeclareOption{10pt}{\renewcommand\@myptsize{0}} % Corresponds to 10pt font
\DeclareOption{11pt}{\renewcommand\@myptsize{1}} % Corresponds to 11pt font
\DeclareOption{12pt}{\renewcommand\@myptsize{2}} % Corresponds to 12pt font
\DeclareOption{withoptional}{ \@printoptionaltrue}
\DeclareOption{withoutoptional}{\@printoptionalfalse}
\DeclareOption{withpreface}{\@printprefacetrue }
\DeclareOption{withoutpreface}{\@printprefacefalse}


\ExecuteOptions{proposal,bylaws,10pt,withoptional}
\ProcessOptions
\ifthenelse{\@myptsize = 0}{
\LoadClass[10pt]{report}
}{}
\ifthenelse{\@myptsize =1}{
\LoadClass[11pt]{report}
}{}
\ifthenelse{\@myptsize = 2}{
\LoadClass[12pt]{report}
}{}

%\newcommand\stuff{\begin{versiona}}
%\newcommand\stopstuff{\end{versiona}}

% Load packages and stuff
\RequirePackage[letterpaper,margin=1.5in]{geometry}
\RequirePackage[colorlinks,linkcolor=blue]{hyperref}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{paralist}
\RequirePackage{graphicx}
\RequirePackage{comment}

\if@printoptional
	\includecomment{optionalpart}
\else
	\excludecomment{optionalpart}
\fi
\if@printpreface
	\includecomment{preface}
\else
	\excludecomment{preface}
\fi

\def\@orglogo{}
\newcommand{\organization}[1]{\def\@orgname{#1\xspace}}
\newcommand{\adoptiondate}[1]{\def\@approvaldate{#1\xspace}}
\newcommand{\chapteramendmentdate}[1]{\def\@chapteramenddate{#1\xspace}}
\newcommand{\appendixamendmentdate}[1]{\def\@appendixamenddate{#1\xspace}}
\newcommand{\lastreviseddate}[1]{\def\@lastreviseddate{#1\xspace}}
\newcommand{\officerdocumenttitle}[1]{\def\@officerdoctitle{#1\xspace}}
\newcommand{\orglogo}[1]{\def\@orglogo{
\includegraphics[width=.5\textwidth]{#1}}}

\if@approved
	%\@ifundefined{@appendixamenddate}{\def\@appendixamenddate{BUTTER_SAUCE\xspace}}
	\if@officerdoc
		\def\@approval{Adopted: \@approvaldate\\
			      	Last revised: \@lastreviseddate}
	\else
	\if@constitution
		\def\@approval{Adopted: \@approvaldate
			     \@ifundefined{@chapteramenddate}{}{
			      \\ Last revised by the chapter: \@chapteramenddate
			      }}
	\else
		\def\@approval{Adopted: \@approvaldate\\
			      	Last revised by the chapter: \@chapteramenddate\\
			     	Appendices last revised by Officer Corps: \@appendixamenddate}
	\fi
	\fi
\else
	\RequirePackage[firstpage]{draftwatermark}
\RequirePackage{fancyhdr}
\setlength{\headheight}{15.2pt}
\pagestyle{fancy}
\lhead[]{}
\chead[]{DRAFT}
\rhead[]{}
%\lfoot[]{}
%\cfoot[]{}
%\rfoot[]{}
	\def\@approval{Draft revised: \today}

\fi

\let\olditem\item
%Numbers
\setcounter{secnumdepth}{4}
\setcounter{tocdepth}{3}

%This makes it so that chapters aren't their own pages.
\titleclass\chapter{straight}
%do this if bylaws
\newcommand\@chaptertitle{DEFAULT}
%do this if constitution
\if@officerdoc
\renewcommand\@chaptertitle{Policy}
\def\@doctype{\@officerdoctitle Policies}
\else
\if@constitution
\renewcommand\@chaptertitle{Article}
\def\@doctype{Constitution}
\else
\renewcommand\@chaptertitle{Bylaw}
\def\@doctype{Bylaws}
\fi
\fi
\newcommand{\changechaptername}[1]{\renewcommand\@chaptertitle{#1}}


\renewcommand{\maketitle}{
\newpage
 \null
\thispagestyle{empty}
 \begin{center}
  \quad\\[1 in]
{ \bf \LARGE\@orgname \\[1cm] \@doctype}\\ [1cm]
\large\@approval \\[2cm]
\@orglogo
 \end{center}
\newpage
} 

\titleformat{\chapter}[display]{\filcenter\normalfont\bfseries}{\@chaptertitle~\thechapter}{0pt}{\filcenter\normalfont\bfseries}
\titlespacing*{\chapter}{0mm}{*4}{*2.3}[0mm]
%Chapter(bylaw/article) numbers appear as Roman Numerals
\renewcommand\thechapter{\Roman{chapter}}

%Handle appendices
\let\oldappendix\appendix
\renewcommand{\appendix}{\oldappendix\titleformat{\chapter}[display]{\filcenter\normalfont\bfseries}{\appendixname\ \thechapter}{0pt}{\filcenter\normalfont\bfseries}}

%%Setup contents spacing
\titlecontents{part}
[1.5em]
{\bfseries}
{\contentslabel{2.3em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
%
\titlecontents{chapter}
[1.5em]
{\bfseries}
{\contentslabel{2.3em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
%
\titlecontents{section}
[4.5em]
{}
{\contentslabel{3em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
%
\titlecontents{subsection}
[7.5em]
{}
{\contentslabel{3em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}
\titlecontents{subsubsection}
[11.5em]
{}
{\contentslabel{4em}}
{\hspace*{-2.3em}}
{\titlerule*[1pc]{.}\contentspage}

%redefine the section,subsection,subsubsection styles
\titleformat{\section}[runin]{\normalfont\scshape}
{Section \thesection.}{.5em}{}[\quad]

%\titleformat{\subsection}[runin]{\normalfont}{(\alph{subsection})}{.5em}{\scshape}[\quad]
%\titlespacing{\subsection}{\parindent}{*2}{\wordsep}
\renewcommand{\thesubsection}{\thesection.\alph{subsection}}

%\titleformat{\subsubsection}[runin]{\normalfont}{(\roman{subsubsection})}{.5em}{\scshape}[\quad]
%\titlespacing{\subsubsection}{2\parindent}{*2}{\wordsep}
\renewcommand{\thesubsubsection}{\thesubsection.\roman{subsubsection}}

%Make enumerations and subsections behave with each other
\renewcommand{\theenumi}{\thesubsection}
\renewcommand{\theenumii}{.\roman{subsubsection}}
\renewcommand{\labelenumi}{(\alph{subsection})}
\renewcommand{\labelenumii}{(\roman{subsubsection})}
\renewcommand{\theenumiii}{.\arabic{enumiii}}
\renewcommand{\labelenumiii}{\arabic{enumiii}.}

%this makes it so that the officer descriptions which are in a description environment 
\newcommand{\officer}[1]{\item{{\bf #1}}\addcontentsline{toc}{subsection}{\protect\numberline{} #1}}
\newcommand{\itemnotoc}{\olditem}
%create enumerate environments for subsection and subsubsection so that the indentation is preserved
\newenvironment{enumsubsection}{
\setcounter{subsection}{0}
\renewcommand{\itemnotoc}{\addtocounter{subsection}{1}\olditem}
\renewcommand{\item}{\subsectionitem}
\begin{enumerate}}{\end{enumerate}\renewcommand{\item}{\olditem}\renewcommand{\itemnotoc}{\olditem}}

\newenvironment{enumsubsubsection}{
\setcounter{subsubsection}{0}

\renewcommand{\itemnotoc}{\addtocounter{subsubsection}{1}\olditem}
\renewcommand{\item}{\subsubsectionitem}
\begin{enumerate}}{\end{enumerate}\renewcommand{\item}{\subsubsection}\renewcommand{\itemnotoc}{\addtocounter{subsection}\olditem}}

%This allows starred and unstarred versions of the sub and subsub sectionitem commands where the starred version hides the title
\makeatletter
\def\subsubsectionitem{\@ifstar\@enumsubsubwstar\@enumsubsubwostar}
\def\@enumsubsubwostar#1{\addtocounter{subsubsection}{1}\olditem {\scshape #1}\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesubsubsection} #1}}
\def\@enumsubsubwstar#1{\addtocounter{subsubsection}{1}\olditem\addcontentsline{toc}{subsubsection}{\protect\numberline{\thesubsubsection}  #1}}
\makeatother

\makeatletter
\def\subsectionitem{\@ifstar\@enumsubwstar\@enumsubwostar}
\def\@enumsubwostar#1{\addtocounter{subsection}{1}\olditem {\scshape #1}\addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection} #1}}
\def\@enumsubwstar#1{\addtocounter{subsection}{1}\olditem \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}  #1}}
\makeatother


\RequirePackage{nicefrac}

\newcommand{\resetformat}{
\renewcommand{\item}{\olditem}
\renewcommand\theenumi{(\alph{enumi})}
\renewcommand\labelenumi{\theenumi}
\renewcommand\theenumii{(\arabic{enumii})}
\renewcommand\labelenumii{\theenumii}
}

%\newenvironment{optionalpart}{}{}
%\if@mike
%	%\newenvironment{optionalpart}{}{}
%\else
%	\renewenvironment{optionalpart}{BLAHGHGH}{DISUB}
%\fi
%\if@printoptional
%	
%\else
%\begin{comment}
%\fi
%}{
%\if@printoptional
%	
%\else
%\end{comment}
%\fi
%}
\newcommand\frontmatter{\pagenumbering{roman}\setcounter{page}{1}}
\newcommand\mainmatter{\pagenumbering{arabic}\setcounter{page}{1}}

\makeatletter
\newcommand{\dateapproved}{ 
\@approvaldate
}
\makeatother
