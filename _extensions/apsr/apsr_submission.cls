%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% apsr_submission.cls, v1.2, 2020/02/14
% Developed by Overleaf
% 
% This class file enables authors to prepare 
% manuscripts for submission to APSR.
%
% v1.01: corrected ASPR typos to APSR
% v1.1: Uses chicago-apsr.bst that doesn't shorten first names
% v1.2: Updates autowc to be compatible with Overleaf's build flow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{apsr_submission}[2020/02/14 v1.2]

\newif\if@biblatex
\newif\if@blind
\newif\if@twocol
\newif\if@onehalfspace
\newif\if@doublespace
\newif\if@extracover
\newif\if@autowc
\DeclareOption{biblatex}{\@biblatextrue}
\DeclareOption{bibtex}{\@biblatexfalse}
\DeclareOption{twocolumn}{\@twocoltrue}
\DeclareOption{blind}{\@blindtrue}
\DeclareOption{nonblind}{\@blindfalse}
\DeclareOption{singlespace}{\@onehalfspacefalse\@doublespacefalse}
\DeclareOption{onehalfspace}{\@onehalfspacetrue\@doublespacefalse}
\DeclareOption{doublespace}{\@onehalfspacefalse\@doublespacetrue}
\DeclareOption{autowc}{\@autowctrue}
\DeclareOption{titlepage}{\@extracovertrue}
\ExecuteOptions{blind,doublespace}
\ProcessOptions\relax
\LoadClass[twoside,12pt]{article}

\RequirePackage{silence}
\WarningFilter*{hyperref}{Ignoring empty anchor}
\WarningFilter*{hyperref}{Rerun to get}
\WarningFilter*{microtype}{Unknown slot number of character}

%% Language and font encodings
\RequirePackage[english]{babel}
\RequirePackage{ifxetex,ifluatex,ifpdf}
\ifxetex\else
  \ifluatex\else
    \RequirePackage[utf8]{inputenc}
\fi\fi
\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext,newtxmath}
\RequirePackage{microtype}
\RequirePackage{textcase}
\RequirePackage{lettrine}
\RequirePackage{xpatch}
\RequirePackage[framemethod=tikz]{mdframed}

%% Sets page size and margins
\RequirePackage[letterpaper,top=1.8cm,bottom=2.2cm,left=2.1cm,right=2.5cm,columnsep=0.65cm,footskip=2.5\baselineskip,headsep=1.5\baselineskip]{geometry}


%% Front matters
\def\@authorlist{}
\def\@authorinfo{}
\def\@authorlistblind{}
\def\@authorinfoblind{}
\def\@runningauthor{}
\def\@runningtitle{}
\def\@journalname{American Political Science Review}
\def\@publishername{American Political Science Association}
\def\@publishedyear{\the\year}

\renewcommand{\author}[3]{%
  \appto{\@authorlist}{%
    {\noindent\Large%
      \ifxetex\MakeUppercase{#1}%
      \else\ifpdf
        \textls[80]{\MakeUppercase{#1}}%
          \else\MakeUppercase{#1}%
      \fi\fi%
    }\hspace{1em}%
    {\itshape\large #2}\par\vskip3pt}%
    \authorinfo{#3\par}
}

\RequirePackage[style]{abstract}
\RequirePackage{environ}
\RequirePackage[explicit]{titlesec}
\RequirePackage{tikz,pgffor}
\RequirePackage{fancyhdr}
\RequirePackage{setspace}
\RequirePackage{lastpage}

\AtBeginDocument{\RequirePackage[hidelinks]{hyperref}}

\setcounter{DefaultLines}{3}
\setlength{\DefaultFindent}{0.25em}
\setlength{\DefaultNindent}{0pt}
\appto{\LettrineFontHook}{\bfseries}
\renewcommand{\LettrineTextFont}{\upshape}
\renewcommand{\LettrineSecondString}{l}
\newcommand{\dropcap}[2][]{\lettrine[#1] #2}

\renewcommand{\abstitlestyle}[1]{}
\setlength{\absleftindent}{2em}
\setlength{\absrightindent}{2em}
\setlength{\absparindent}{0pt}
\renewcommand{\abstracttextfont}{\itshape\noindent\dropcap[findent=0.5em]}

\let\maketitle\relax

\newcommand{\authorinfo}[1]{\appto{\@authorinfo}{#1}}
\let\thanks\authorinfo
\newcommand{\runningauthor}[1]{\def\@runningauthor{#1}}
\newcommand{\runningtitle}[1]{\def\@runningtitle{#1}}
\newcommand{\publishedyear}[1]{\def\@publishedyear{#1}}

\RequirePackage[marginal]{footmisc}
\setlength{\footnotemargin}{0.25em}
\def\blfootnote{\gdef\@thefnmark{}\@footnotetext}
\renewcommand{\footnotelayout}{\small}
\if@doublespace
  \appto{\footnotelayout}{\doublespacing}
\fi
\if@onehalfspace
  \appto{\footnotelayout}{\onehalfspacing}
\fi

\renewcommand{\@maketitle}{%
  \vspace*{\baselineskip}
  {\fontfamily{qhvc}\fontseries{b}\fontsize{20pt}{24pt}\selectfont\raggedright\@title\par\vskip3pt}
  {\@authorlist\par}
}

\if@blind
  \newcommand{\@anonymizeauthors}{
    \def\@authorlistblind{}
    \def\@authorinfoblind{}
    \patchcmd{\author}{\@authorlist}{\@authorlistblind}{}{}
    \patchcmd{\authorinfo}{\@authorinfo}{\@authorinfoblind}{}{}
    \author{Anonymised Author(s)}{Anonymised Institution(s)}{Anonymised submission.\par\medskip\textbf{This is a  manuscript submitted for review.}}
    \gdef\@runningauthor{Anonymised Author(s)}
    \let\@authorlist\@authorlistblind
    \let\@authorinfo\@authorinfoblind
}
\else
  \let\@anonymizeauthors\relax
\fi

\def\@totalwordcount{0}
\newcommand{\totalwordcount}[1]{%
  %% Only allow total word count to be changed it if it's still 0
  \if@autowc%
    \ClassWarning{apsr_submission.cls}{\string\totalwordcount{} is ignored when autowc is active.}
  \else
    \def\@totalwordcount{#1}
  \fi
}
\if@autowc
  \RequirePackage[realmainfile]{currfile}
  \RequirePackage{bashful}
  \immediate{\write18{cp \currfilebase.tex \jobname.tex}}
  \newcommand{\@autowordcount}{%
    \def\@totalwordcount{\splice{texcount -1 -sum=1,1,1,0,0,0,0 -merge -incbib -utf8 -relaxed \jobname.tex}}}%
\else
  \let\@autowordcount\relax
\fi


\NewEnviron{frontmatter}{%
  \def\apsr@frontmatter{
    \@maketitle\BODY%
    \if@autowc\@autowordcount\fi%
    {\centering Word Count: \@totalwordcount\par}%
  }
  \appto{\@authorinfo}{\par\medskip\textbf{This is a  manuscript submitted for review.}\par}
  \if@twocol
    \if@extracover
      \setcounter{page}{0}
      \onecolumn\apsr@frontmatter
      \blfootnote{\hspace*{-\footnotemargin}\@authorinfo}
      \thispagestyle{empty}\clearpage
    \fi
    %% Anonymise main text only
    \if@blind\@anonymizeauthors\fi
    \twocolumn[\apsr@frontmatter\bigskip]
  \else
    \if@extracover
      \setcounter{page}{0}
      \apsr@frontmatter
      \blfootnote{\hspace*{-\footnotemargin}\@authorinfo}
      \thispagestyle{empty}\clearpage
    \fi
    %% Anonymise main text only
    \if@blind\@anonymizeauthors\fi
    \apsr@frontmatter
  \fi
  \thispagestyle{titlepage}
  \blfootnote{\hspace*{-\footnotemargin}\@authorinfo}
}{}

\AfterEndEnvironment{frontmatter}{
  \if@onehalfspace\onehalfspacing\fi%
  \if@doublespace\doublespacing\fi%
}


\setcounter{secnumdepth}{3}

\titleformat{\section}{\sffamily\bfseries\large\raggedright}{}{0pt}{\MakeTextUppercase{#1}}

\titleformat{\subsection}{\sffamily\bfseries\large\raggedright}{}{0pt}{#1}

\titleformat{\subsubsection}[runin]{\itshape\bfseries}{}{0pt}{#1}

\titlespacing*{\section}{0pt}{1.25\baselineskip}{0.25\baselineskip}

\titlespacing*{\subsection}{0pt}{1.25\baselineskip}{0.25\baselineskip}

\RequirePackage{enumitem}
\setlist{noitemsep,topsep=0.5\baselineskip,leftmargin=2\parindent}

\RequirePackage{quoting}
\quotingsetup{font=small,indentfirst=false,begintext={``},endtext={''},vskip=0.5\baselineskip,leftmargin=\parindent,rightmargin=0pt}

\fancyhf{}
\renewcommand{\headrulewidth}{1pt}
\fancyhead[RO]{\footnotesize\@runningtitle}
\fancyhead[LE]{\footnotesize\@runningauthor}
\fancyfoot[LE,RO]{\thepage}
\pagestyle{fancy}
\fancypagestyle{titlepage}{%
  \pagestyle{fancy}
  \fancyhead[RO]{\footnotesize Page \thepage{} of \pageref{LastPage}}
  \fancyhead[LO]{\footnotesize%
  \textit{Submission to \@journalname}\\[-\baselineskip]%
  \raisebox{-1.25\baselineskip}[0pt][0pt]{doi:xx.xxxx/xxxxx}
  }
}
\cfoot{%
  \tikz[remember picture,overlay]
  \ifnumodd{\thepage}{%
    \node[transform shape,rotate=90,anchor=north,yshift=-2pt,text=gray!10,font=\scriptsize] at (current page.west) 
  }{%
     \node[transform shape,rotate=-90,anchor=north,yshift=-2pt,text=gray!10,font=\scriptsize] at (current page.east) 
   }
      {\foreach \n in {1,...,10}{APSR Submission Template\hspace{1em}}};
}

%% Easiest way to get framed floats, both single-column and wide
\RequirePackage[framestyle=fbox,framefit=yes,heightadjust=all,framearound=all,font=sf]{floatrow}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{mdframed}
\newcommand{\makeframedenv}[1]{%
  \cspreto{#1}{\begin{mdframed}}
  \csappto{end#1}{\end{mdframed}}
}
\AtBeginDocument{%
  \@ifpackageloaded{longtable}{
    \floatsetup[longtable]{LTcapwidth=table}
    \makeframedenv{longtable}
  }{}
  \@ifpackageloaded{supertabular}{
    \makeframedenv{supertabular}
  }{}
  \@ifpackageloaded{rotating}{
    \makeframedenv{sidewaystable}
    \makeframedenv{sidewayfigure}
  }{}
}
\floatsetup{capposition=top,midcode=rule,}
\captionsetup*{
  figurename=FIGURE,tablename=TABLE,
  font={bf,sf},
  labelsep=period,
  justification=justified,
  footfont={sf,md,small},
  singlelinecheck=false}
\pretocmd{\floatfoot}{\rule{\hsize}{0.4pt}\vskip-0.75em}{}{}
\newcommand{\floatnote}[1]{\floatfoot{\textit{Note: }#1}}

\if@biblatex
  \RequirePackage{csquotes}
  \RequirePackage[natbib,style=chicago-authordate,backend=biber,sorting=nyt]{biblatex}
\else
  \RequirePackage{natbib}
  \bibliographystyle{chicago-apsr}
  \setcitestyle{aysep={}}
\fi
\renewcommand{\bibfont}{\small}

\endinput