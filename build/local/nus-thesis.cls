%%
%% This is file `nus-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nus-thesis.dtx  (with options: `class')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from nus-thesis.cls.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file nus-thesis.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
\NeedsTeXFormat{LaTeX2e}[2022-06-01]
\RequirePackage{l3keys2e}
\ProvidesExplClass{nus-thesis}
{2024-11-29}{0.0.0.a}{NUS thesis class}
\str_const:Nn \c__classname_base_class_str { book }
\PassOptionsToClass{a4paper}{\c__classname_base_class_str}
\PassOptionsToClass{12pt}{\c__classname_base_class_str}

\newcommand{\nusthesis@titlepagefont}{\normalfont}
\newcommand{\nusthesis@chapheadfont}{\normalfont}
\newcommand{\nusthesis@headingfont}{\normalfont}

\keys_define:nn { nus-thesis }
{
  , openright .bool_set:N = \l__classname_openright_bool
  , openright .initial:n = { false }
  , author .tl_set:N = \l__thesis_author_tl
  , author .code:n = { \author{#1} }
  , author .initial:n = { (author~undefined)  }
  , title .tl_set:N = \l__thesis_title_tl
  , title .code:n = { \title{#1} }
  , title .initial:n = { (title~undefined) }
  , university .tl_set:N = \l__thesis_university_tl
  , university .initial:n = { National~University~of~Singapore }
  , department .tl_set:N = \l__thesis_department_tl
  , department .initial:n = { (department) }
  , document-type .tl_set:N = \l__documenttype_tl
  , document-type .initial:n = { thesis }
  , candidacy .tl_set:N = \l__thesis_candidacy_tl
  , candidacy .initial:n = { (candidacy) }
  , field .tl_set:N = \l__degree_field_tl
  , field .initial:n = { (field) }
  , submission-year .tl_set:N = \l__thesis_year_tl
  , submission-year .initial:n =  { \number\year }
  , qualification .tl_set:N = \l__thesis_qualification_tl
  , qualification .initial:n = { (qualification undefined)  }
  , qualification .code:n = {\qualification{#1}}
  , strict .bool_set:N = \l__classname_nusstrict_bool
  , strict .initial:n = { false}
  , font .choice:
  , font / strict .code:n = {
    \RequirePackage{mathptmx}
  }
  , font / helvetica .code:n = {
    \RequirePackage{helvet}
    \renewcommand{\familydefault}{\sfdefault}
    \RequirePackage[eulergreek]{sansmath}
    \sansmath
  }
  , font / palatino .code:n = {
    \RequirePackage[sc]{mathpazo}
    \RequirePackage{gillius}
    \renewcommand{\nusthesis@chapheadfont}{\sffamily}
    \renewcommand{\nusthesis@headingfont}{\sffamily}
  }
  , font / libertine .code:n = {
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[scaled=0.9,varl]{inconsolata}
    \RequirePackage[mono=false,sb]{libertine}
    \RequirePackage{libertinust1math}
    \renewcommand{\nusthesis@chapheadfont}{\sffamily}
    \renewcommand{\nusthesis@headingfont}{\sffamily}
  }
  , font / minionpro .code:n = {
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
    \RequirePackage[scaled=0.9,varl]{inconsolata}
    \RequirePackage[lf,fullfamily,opticals,minionint,loosequotes,footnotefigures]{MinionPro}
    \RequirePackage{gillius}
    \renewcommand{\nusthesis@chapheadfont}{\sffamily}
    \renewcommand{\nusthesis@headingfont}{\sffamily}
    \renewcommand{\nusthesis@titlepagefont}{\sffamily}
  }
  % \DeclareDefaultOption
  , unknown .code:n =
  {
    \iow_term:x
    {
      Passing~option~\CurrentOption \c_space_tl to~
      \str_use:N \c__classname_base_class_str
    }
    \PassOptionsToClass { \CurrentOption } { \c__classname_base_class_str }
  }
}

\ProcessKeysOptions { nus-thesis }

\bool_if:NTF \l__classname_openright_bool
{
  \PassOptionsToClass{openright}{\c__classname_base_class_str}
}{
  \PassOptionsToClass{oneside}{\c__classname_base_class_str}
}

\LoadClass { \c__classname_base_class_str }

\DeclareDocumentCommand \ThesisSetup { m } {
  \keys_set:nn { nus-thesis } { #1 }
}

\RequirePackage[UKenglish]{isodate}
\RequirePackage{color}
\RequirePackage{iftex}
\RequirePackage[svgnames]{xcolor}
\RequirePackage[]{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{setspace}
\RequirePackage{bookmark}
\RequirePackage{titlesec}
\RequirePackage{titletoc}
\RequirePackage{ifthen}
\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1.5in]{geometry}
\RequirePackage{amsmath}
\RequirePackage{lipsum}
\RequirePackage{subfig}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{mathtools}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{fancyvrb}
\RequirePackage{pbox}
\RequirePackage{pdflscape}
\RequirePackage{pstricks}
\RequirePackage{acronym}
\RequirePackage[section]{placeins}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage[title,titletoc]{appendix}
\RequirePackage{mdwtab}
\RequirePackage{caption}
\RequirePackage{floatrow}
\RequirePackage[tracking=true]{microtype}

\ifPDFTeX%
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{textcomp} % provides euro and other symbols
\else % if luatex or xelatex
  \RequirePackage{fontspec}
  \RequirePackage{xunicode}
\fi

%%%% fonts

\RequirePackage{hyperref}
\hypersetup{
  linkcolor = DarkBlue,
  citecolor = DarkBlue,
  plainpages = false,
  hypertexnames = false,
  allbordercolors = white,
}
\RequirePackage[nameinlink,noabbrev, capitalise]{cleveref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\doublespacing

\pagestyle{plain}
\RequirePackage{emptypage}
\graphicspath{ {./images/} }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\gdef\@subtitle{\space}
\gdef\@qualification{\relax}
\gdef\@keywords{\space}
\gdef\nus@abbrev{\space Test \space MAC }

\def\supervisor#1{\gdef\@supervisor{#1}}
\def\subtitle#1{\gdef\@subtitle{#1}}
\def\qualification#1{\gdef\@qualification{#1}}
\def\keywords#1{\gdef\@keywords{#1}}

\newcommand*{\textsomels}[1]{\textls[50]{#1}}

%% Preface
\providecommand*{\toclevel@preface}{1}
\edef\toclevel\@preface{1}
\gdef\ttll@preface{0}

\titleclass{\preface}{top}
\newcounter{preface}

\titleformat{\preface}[display]{%
  % format
    \nusthesis@chapheadfont\setstretch{0.9}}{%
    % label
    }{%
    % sep
    0em}{%
    % beforecode
    \raggedleft\Huge}{%
    % aftercode
  }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\titlepage}{
  \nusthesis@titlepagefont
  \thispagestyle{empty}
  \begin{center}%
    \hyphenpenalty=10000
    {\LARGE\uppercase\expandafter{\@title}\\ }
    \normalsize\mdseries\uppercase\expandafter{\@subtitle}
    \vfill%
  \titlepagebody
  \vfill
  \titlepagefooter
\end{center}
\normalfont
\clearpage{\thispagestyle{empty}\cleardoublepage}}

\renewcommand{\maketitle}{
  \coverpage
  \titlepage
}

\renewcommand{\tablename}{Table}
\DeclareCaptionLabelFormat{bf}{\bfseries #1~#2}
\DeclareCaptionFormat{hfillstart}{#1#2#3}
\DeclareFloatFont{normalsize}{\normalsize}
\floatsetup[table]{capposition=top}

\captionsetup[table]{
  font={small,sf},
  format=hfillstart,
  labelformat=bf,
  labelsep=newline,
  justification=centering,
}

\renewcommand{\figurename}{Figure}
\captionsetup[figure]{
  font={small,sf},
  labelformat=bf,
  labelsep=period,
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\coverpage}{
  \thispagestyle{empty}\vspace*{0.3in}
  \begin{center}\hyphenpenalty=10000
    \Large\bfseries\uppercase\expandafter{\@title}\\
    \large\mdseries\uppercase\expandafter{\@subtitle}
  \end{center}\vspace*{8cm}
  \begin{center}\hyphenpenalty=10000
    \large\bfseries\uppercase\expandafter{\@author}
  \end{center}\vfill
  \begin{center}\hyphenpenalty=10000
    \normalsize\bfseries
    \large\uppercase\expandafter{\l__thesis_university_tl}\vspace*{0.2cm} \\
    \large\uppercase\expandafter{\l__thesis_year_tl}
  \end{center}
  \newpage}

\@ifundefined{titlepagebody}{
  \newcommand{\titlepagebody}{
    \Large\bfseries\uppercase\expandafter{\@author}\\
    \textit{\expandafter{\@qualification}}
  }}{}

\@ifundefined{titlepagefooter}{
  \newcommand{\titlepagefooter}{\large\uppercase\expandafter{
      \textsomels{A~\uppercase\expandafter{\l__documenttype_tl}~submitted~
        for~the~Degree~of~\\\uppercase\expandafter{\l__thesis_candidacy_tl} \\
        in~\uppercase\expandafter{\l__degree_field_tl} \\
        Department~of~ \uppercase\expandafter{\l__thesis_department_tl}\\ \uppercase\expandafter{\l__thesis_university_tl}}\\
      \vspace*{2cm}\l__thesis_year_tl\\
    }}}{}

\@ifundefined{declarationpage}{
  \newcommand{\declarationpage}{
    \begin{center}\hyphenpenalty=10000
      \nusthesis@titlepagefont\large\bfseries\uppercase\expandafter{DECLARATION}
    \end{center}
    \vspace*{1cm}
    \begin{center}\hyphenpenalty=10000
      I~hereby~declare~that~the~\l__documenttype_tl{}~is~my~original\\
      work~and~it~has~been~written~by~me~in~its~entirety.\\
      I~have~duly~acknowledged~all~the~sources~of\\
      information~which~have~been~used~in~the~\l__documenttype_tl.\\
      \vspace*{0.5cm}
      This~\l__documenttype_tl{}~has~also~not~been~submitted~for~any\\
      degree~in~any~university~previously.\\
      \vspace*{2cm}
      % \begin{figure}[!h]
      %   \subfloat{ \includegraphics[width=0.3\textwidth]{signature} }
      % \end{figure}
      \vspace*{-1cm}
      \begin{center}
        \rule{8cm}{0.5pt}
      \end{center}
      \vspace*{-0.5cm}
      \@author \\
      \today
    \end{center}\newpage}} {}

%% titlesec
\definecolor{chaptergrey}{rgb}{0.6,0.6,0.6}

%%% chapter titles similar to quotchap
\newcommand*{\chapnum}{%
  \fontsize{100}{130}\nusthesis@chapheadfont\bfseries\selectfont%
\color{chaptergrey}\raggedleft}

\newcommand{\acknowledgements}[1]{
  \chapter*{Acknowledgements}
  #1\cleardoublepage
}

\renewenvironment{acknowledgements}{%
  \chapter*{Acknowledgements}
   \addcontentsline{toc}{preface}{Acknowledgements}
   }{%
   \cleardoublepage
}

\newcommand{\abstract}[1]{
  \chapter*{Abstract}
  \addcontentsline{toc}{preface}{Abstract}
  #1\cleardoublepage
}

\RenewDocumentEnvironment{abstract}{o}
{%
  \IfNoValueTF{#1}{
 \chapter*{Abstract}%
 \addcontentsline{toc}{preface}{Abstract}%
  }{
 \chapter*{#1~Abstract}%
 \addcontentsline{toc}{preface}{#1~Abstract}%
}

  }{%
    \cleardoublepage%
}

 \titlecontents{chapter}
 [0pt]
 {\addvspace{1pc}%
     \bfseries%
 }%
 {\contentsmargin{0pt}%
  \thecontentslabel\quad}
 {\contentsmargin{0pt}%
 }
 {\hfill\contentspage}

 \titlecontents{preface}
 [0pt]
 {\addvspace{0.5pc}%
     \normalshape%
 }%
 {\contentsmargin{0pt}%
  \thecontentslabel\quad}
 {\contentsmargin{0pt}%
 }
 {\hfill\contentspage}

\bool_if:NTF \l__classname_nusstrict_bool
{
}{
  \titleformat{\chapter}[display]{%
    % format
    \nusthesis@chapheadfont\setstretch{0.9}}{%
    % label
    \chapnum{\thechapter}}{%
    % sep
    0em}{%
    % beforecode
    \raggedleft\Huge}{%
    % aftercode
  }

\titleformat{\section}{\setstretch{1.2}\nusthesis@headingfont\raggedright\Large}{\thesection}{1em}{}
\titleformat{\subsection}{\setstretch{1.2}\nusthesis@headingfont\raggedright\large}{\thesubsection}{1em}{}

\titleformat{\subsubsection}{\setstretch{1.2}\nusthesis@headingfont\normalsize}{\thesubsubsection}{1em}{}

}

\noappendicestocpagenum
\renewcommand{\appendixpagename}{\nusthesis@chapheadfont Appendices}
\g@addto@macro\appendix{%
\titleformat{\chapter}[display]
{\nusthesis@chapheadfont\Huge}{\chaptertitlename\ \thechapter}{20pt}{\Huge}
\cleardoublepage
 \addtocontents{toc}%
          {\protect\contentsline{part}{\appendixtocname}{}{}}%
\appendixpage
}

\crefname{appsec}{Appendix}{Appendices}
\crefname{figure}{Fig.}{Fig.}
\crefname{table}{Table}{Tables}
\crefname{equation}{}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\losymbolsname{List~of~Symbols}
\def\loabbrevname{List~of~Abbreviations}
\def\listofsymbolsnabbrev{
  \chapter*{\losymbolsname \@mkboth
    {\uppercase{\losymbolsname}}{\uppercase{\losymbolsname}}}
  \@starttoc{los}
  \chapter*{\loabbrevname \@mkboth
    {\uppercase{\loabbrevname}}{\uppercase{\loabbrevname}}}
  \begin{acronym}[RADAR12345]
    \@starttoc{loab}
  \end{acronym}
}
\def\addsymbol#1#2{%
  \addtocontents{los}{\protect \makenicesymbolline{#1}{#2}}}
\def\addabbrev#1#2{%
  \addtocontents{loab}{\protect \makeniceabbrevline{#1}{#2}}}
\newdimen\@lcsym %width of left column
\@lcsym=2cm      %default 3cm
\newdimen\@mcsym %width of mid column (space)
\@mcsym=1cm      %default 2cm
\newdimen\@rcsym %width of right column
\@rcsym=\hsize   %initial width=textwidth
\advance\@rcsym by -\@lcsym %subtract lcsym
\advance\@rcsym by -\@mcsym %subtract mid
\def\makenicesymbolline#1#2{%
  \begin{minipage}[t]{\@lcsym}#1\end{minipage}%
  $\hspace{\@mcsym}$%
  \begin{minipage}[t]{\@rcsym}#2\end{minipage}\newline}
\def\makeniceabbrevline#1#2{%
  % \begin{minipage}[t]{\@lcsym}#1\end{minipage}%
  % $\hspace{\@mcsym}$%
  % \begin{minipage}[t]{\@rcsym}#2\end{minipage}\newline
  \acro{#1}{#2}}
\endinput
%%
%% End of file `nus-thesis.cls'.
