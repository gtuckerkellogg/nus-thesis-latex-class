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
\RequirePackage{iftex}



\str_const:Nn \c__classname_base_class_str { book }
\PassOptionsToClass{a4paper}{\c__classname_base_class_str}
\PassOptionsToClass{12pt}{\c__classname_base_class_str}
\PassOptionsToClass{oneside}{\c__classname_base_class_str}
\PassOptionsToClass{openright}{\c__classname_base_class_str}
\LoadClass { \c__classname_base_class_str }
\sys_if_engine_pdftex:TF {
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
  \RequirePackage{textcomp} % provides euro and other symbols
  } {
    \RequirePackage{fontspec}
    \sys_if_engine_xetex:T { \RequirePackage{xunicode} }
}


\cs_new:Npn \__nusthesis_titlepage_font: { \normalfont }
\cs_new:Npn \__nusthesis_chaphead_font: { \normalfont }
\cs_new:Npn \__nusthesis_heading_font: { \normalfont }

\tl_new:N \l__nusthesis_supervisor_tl
\tl_new:N \l__nusthesis_subtitle_tl
\tl_new:N \l__nusthesis_qualification_tl
\tl_new:N \l__nusthesis_keywords_tl

\seq_new:N \g__nusthesis_symbol_seq
\seq_new:N \g__nusthesis_abbrev_seq


\keys_define:nn { nus-thesis }
{
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
  , qualification .initial:n = { qualification~undefined  }
  , qualification .code:n = {\qualification{#1}}
  , strict .bool_set:N = \l__classname_nusstrict_bool
  , strict .initial:n = { false}
  , final .bool_set:N = \l__final_submission_bool
  , final .initial:n = { false }
  , advisor .tl_set:N = \l__thesis_advisor_tl
  , advisor .initial:n = {(advisor)}
  , examiners .tl_set:N = \l__thesis_examiners_tl
  , examiners .initial:n = {(examiners)}
  , font .choice:
  , font / times .code:n = {
    \RequirePackage{mathptmx}
  }
  , font / strict .meta:n = { font = times }  % Alias for backward compatibility
  , font / helvetica .code:n = {
    \RequirePackage[scaled=0.95]{helvet}
    \renewcommand{\familydefault}{\sfdefault}
    \RequirePackage{mathastext}
    \RequirePackage{arevmath}
    \RequirePackage[mono,varl]{inconsolata}
  }
  , font / palatino .code:n = {
    \RequirePackage[sc]{mathpazo}
    \RequirePackage[scaled=0.95]{helvet}
    \RequirePackage[varl]{inconsolata}
    \cs_set:Npn \__nusthesis_chaphead_font: { \sffamily }
    \cs_set:Npn \__nusthesis_heading_font: { \sffamily }
  }
  , font / libertine .code:n = {
    \sys_if_engine_pdftex:TF {
      \RequirePackage[scaled=0.9,varl]{inconsolata}
      \RequirePackage[mono=false,sb]{libertinus}
      \RequirePackage{libertinust1math}
    } {
      \RequirePackage{libertinus}
      \setmonofont[Scale=MatchUppercase]{Inconsolata}
    }
    \cs_set:Npn \__nusthesis_chaphead_font: { \sffamily }
    \cs_set:Npn \__nusthesis_heading_font: { \sffamily }
  }
  , font / noto .code:n = {
    \RequirePackage{notomath}
    \RequirePackage{inconsolata}
    \cs_set:Npn \__nusthesis_chaphead_font: { \sffamily }
    \cs_set:Npn \__nusthesis_heading_font: { \sffamily }
    \cs_set:Npn \__nusthesis_titlepage_font: { \sffamily }
  }
  , font / minionpro .code:n = {

    \RequirePackage[lf,minionint,loosequotes,footnotefigures]{MinionPro}
    \microtypesetup{kerning=false,expansion=false}
    \RequirePackage[lf]{MyriadPro}
    \RequirePackage[scaled=0.9,varl]{inconsolata}
    \cs_set:Npn \__nusthesis_chaphead_font: { \sffamily }
    \cs_set:Npn \__nusthesis_heading_font: { \sffamily }
    \cs_set:Npn \__nusthesis_titlepage_font: { \sffamily }
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

\NewDocumentCommand \ThesisSetup { m } {
  \keys_set:nn { nus-thesis } { #1 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[UKenglish]{isodate}

\RequirePackage[svgnames]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{pdflscape}
\RequirePackage{pstricks}

\RequirePackage{setspace}
\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1.5in]{geometry}
\RequirePackage{emptypage}

\RequirePackage[titles]{tocloft}
\RequirePackage{bookmark}

\RequirePackage{microtype}
\sys_if_engine_pdftex:TF {
  \microtypesetup{kerning=true}
  \SetExtraKerning[unit=character]{encoding=*}{\textemdash={100,100}}
}{}

\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}

\RequirePackage{amsmath}
\RequirePackage{mathtools}

\RequirePackage{longtable}
\RequirePackage{rotating}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{multicol}
\RequirePackage{mdwtab}

\RequirePackage{subcaption}
\RequirePackage{caption}

\RequirePackage[section]{placeins}

\RequirePackage{fancyvrb}
\RequirePackage{pbox}

\RequirePackage[title,titletoc]{appendix}

\RequirePackage{acronym}
\RequirePackage[abbreviations,prefix,postpunc={:},automake,toc=false]{glossaries-extra}
\makeglossaries[abbreviations]
\setglossarypreamble[abbreviations]{\addcontentsline{toc}{preface}{\glossarytitle}}
\newcommand{\glsxtrfootnote}[1]{\glsxtrshort{#1}\footnote{\Glsxtrlong{#1}.}\glsunset{#1}}
\newignoredglossary*{ignored}

\RequirePackage{hyperref}
\hypersetup{%
  hidelinks%
}
\RequirePackage[nameinlink,noabbrev, capitalise]{cleveref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\dim_const:Nn \c__nusthesis_toc_part_skip_dim { 2.25em }
\dim_const:Nn \c__nusthesis_toc_chapter_skip_dim { 1.5em }
\dim_const:Nn \c__nusthesis_toc_section_skip_dim { 1em }
\dim_const:Nn \c__nusthesis_toc_subsection_skip_dim { 1em }
\dim_const:Nn \c__nusthesis_toc_figure_skip_dim { 1em }
\dim_const:Nn \c__nusthesis_toc_table_skip_dim { 1em }

\dim_const:Nn \c__nusthesis_coverpage_title_vspace_dim { 0.3in }
\dim_const:Nn \c__nusthesis_coverpage_author_vspace_dim { 8cm }
\dim_const:Nn \c__nusthesis_coverpage_year_vspace_dim { 0.2cm }

\dim_const:Nn \c__nusthesis_titlepage_footer_vspace_dim { 2cm }

\dim_const:Nn \c__nusthesis_declaration_heading_vspace_dim { 1cm }
\dim_const:Nn \c__nusthesis_declaration_para_vspace_dim { 0.5cm }
\dim_const:Nn \c__nusthesis_declaration_signature_vspace_dim { 2cm }
\dim_const:Nn \c__nusthesis_declaration_sig_adjust_dim { -1cm }
\dim_const:Nn \c__nusthesis_declaration_author_adjust_dim { -0.5cm }
\dim_const:Nn \c__nusthesis_declaration_line_width_dim { 8cm }
\dim_const:Nn \c__nusthesis_declaration_line_thickness_dim { 0.5pt }
\dim_const:Nn \c__nusthesis_declaration_sig_image_width_dim { 0.6\textwidth }

\int_const:Nn \c__nusthesis_chapnum_fontsize_int { 100 }
\int_const:Nn \c__nusthesis_chapnum_baseline_int { 130 }
\dim_const:Nn \c__nusthesis_appendix_title_sep_dim { 20pt }

\dim_const:Nn \c__nusthesis_section_before_dim { 3.5ex }
\dim_const:Nn \c__nusthesis_section_after_dim { 2.3ex }
\dim_const:Nn \c__nusthesis_subsection_before_dim { 3.25ex }
\dim_const:Nn \c__nusthesis_subsection_after_dim { 1.5ex }
\dim_const:Nn \c__nusthesis_subsubsection_before_dim { 3.25ex }
\dim_const:Nn \c__nusthesis_subsubsection_after_dim { 1.5ex }

\dim_const:Nn \c__nusthesis_symbol_leftcol_dim { 2cm }   % Symbol/abbreviation column
\dim_const:Nn \c__nusthesis_symbol_midcol_dim { 1cm }    % Spacing column

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\doublespacing

\pagestyle{plain}

\graphicspath{ {./images/} }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tl_set:Nn \l__nusthesis_subtitle_tl { \space }
\tl_set:Nn \l__nusthesis_qualification_tl { }
\tl_set:Nn \l__nusthesis_keywords_tl { \space }

\NewDocumentCommand \supervisor { m } {
  \tl_set:Nn \l__nusthesis_supervisor_tl { #1 }
}

\NewDocumentCommand \subtitle { m } {
  \tl_set:Nn \l__nusthesis_subtitle_tl { #1 }
}

\NewDocumentCommand \qualification { m } {
  \tl_set:Nn \l__nusthesis_qualification_tl { #1 }
}

\NewDocumentCommand \keywords { m } {
  \tl_set:Nn \l__nusthesis_keywords_tl { #1 }
}

\cs_new:Npn \textsomels #1 {
  \sys_if_engine_xetex:TF {
    #1
  }
  {
    \textls[50]{#1}
  }
}

%% Preface
\providecommand*{\toclevel@preface}{1}
\edef\toclevel@preface{1}
\gdef\ttll@preface{0}

\titleclass{\preface}{top}
\newcounter{preface}

\titleformat{\preface}[display]{%
  % format
    \__nusthesis_chaphead_font:\setstretch{0.9}}{%
    % label
    }{%
    % sep
    0em}{%
    % beforecode
    \raggedleft\Huge}{%
    % aftercode
  }

\AfterEndPreamble{
    % Table of contents spacing - using constants defined above
    \setlength{\cftbeforepartskip}{\c__nusthesis_toc_part_skip_dim \@plus\p@}
    \setlength{\cftbeforechapskip}{\c__nusthesis_toc_chapter_skip_dim \@plus.2\p@}
    \setlength{\cftbeforesecskip}{\c__nusthesis_toc_section_skip_dim \@plus.2\p@}
    \setlength{\cftbeforesubsecskip}{\c__nusthesis_toc_subsection_skip_dim \@plus.2\p@}
    \setlength{\cftbeforefigskip}{\c__nusthesis_toc_figure_skip_dim}
    \setlength{\cftbeforetabskip}{\c__nusthesis_toc_table_skip_dim}
    \renewcommand{\@starttoc}[1]{%
      \begingroup
      \singlespacing%
      \parskip=\cftparskip
      \OLD@starttoc{#1}%
    \endgroup
  }
}

\renewcommand\listoftables{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listtablename}%
    {%
      \singlespacing%
    \addcontentsline{toc}{preface}{\listtablename}
      \@mkboth{%
          \MakeUppercase\listtablename}%
         {\MakeUppercase\listtablename}%
    \@starttoc{lot}%
    \if@restonecol\twocolumn\fi
    }
}

\renewcommand\listoffigures{%
    \if@twocolumn
      \@restonecoltrue\onecolumn
    \else
      \@restonecolfalse
    \fi
    \chapter*{\listfigurename}%
    {%
      \singlespacing%
    \addcontentsline{toc}{preface}{\listfigurename}
      \@mkboth{%
          \MakeUppercase\listfigurename}%
         {\MakeUppercase\listfigurename}%
    \@starttoc{lof}%
    \if@restonecol\twocolumn\fi
    }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand{\titlepage}{
  \__nusthesis_titlepage_font:
  \thispagestyle{empty}
  \begin{center}%
    \hyphenpenalty=10000
    {\Large\bfseries\text_uppercase:n {\@title}\\ }
    \normalsize\mdseries\text_uppercase:n {\l__nusthesis_subtitle_tl}
    \vfill%
  \titlepagebody
  \vfill
  \titlepagefooter
\end{center}
\normalfont
\clearpage{\thispagestyle{empty}\cleardoublepage}}

\renewcommand{\maketitle}{
  \frontmatter
  \pagestyle{empty}
  \coverpage
  \titlepage
  \setcounter{page}{1}
  \pagestyle{plain}
}

\renewcommand{\tablename}{Table}
\DeclareCaptionLabelFormat{bf}{\bfseries #1~#2}
\DeclareCaptionFormat{hfillstart}{#1#2#3}

\captionsetup[table]{
  font={small,sf},
  format=hfillstart,
  labelformat=bf,
  labelsep=period,
  width = 0.9\linewidth
}

\renewcommand{\figurename}{Figure}
\captionsetup[figure]{
  font={small,sf},
  labelformat=bf,
  labelsep=period,
  width = 0.9\linewidth
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\coverpage}{
  \thispagestyle{empty}\vspace*{\c__nusthesis_coverpage_title_vspace_dim}
  \begin{center}\hyphenpenalty=10000
    \Large\bfseries\text_uppercase:n {\@title}\\
    \large\mdseries\text_uppercase:n {\l__nusthesis_subtitle_tl}
  \end{center}\vspace*{\c__nusthesis_coverpage_author_vspace_dim}
  \begin{center}\hyphenpenalty=10000
    \large\bfseries\text_uppercase:n {\@author}
  \end{center}\vfill
  \begin{center}\hyphenpenalty=10000
    \normalsize\bfseries
    \large\text_uppercase:n {\l__thesis_university_tl}\vspace*{\c__nusthesis_coverpage_year_vspace_dim} \\
    \large\text_uppercase:n {\l__thesis_year_tl}
  \end{center}
  \cleardoublepage}

\cs_if_exist:cF { titlepagebody } {
  \NewDocumentCommand \titlepagebody { } {
    \Large\bfseries\text_uppercase:n {\@author}\\
    \textit{\mdseries(\l__nusthesis_qualification_tl)}
  }
}

\cs_if_exist:cF { titlepagefooter } {
  \NewDocumentCommand \titlepagefooter { } {
    \large\text_uppercase:n {
      \textsomels{A~\text_uppercase:n {\l__documenttype_tl}~submitted~
        for~the~Degree~of~\\\text_uppercase:n {\l__thesis_candidacy_tl} \\
        Department~of~ \text_uppercase:n {\l__thesis_department_tl}\\ \text_uppercase:n {\l__thesis_university_tl}}\\
      \vspace*{\c__nusthesis_titlepage_footer_vspace_dim}\l__thesis_year_tl\\}
      \bool_if:NTF \l__final_submission_bool {
        {Advisor} \\
        \l__thesis_advisor_tl \\
        Examiners \\
        \l__thesis_examiners_tl
      }{}
  }
}

\NewDocumentCommand \DeclarationPage { o }
{
  \begin{center}\hyphenpenalty=10000
    \__nusthesis_titlepage_font:\large\bfseries\text_uppercase:n {DECLARATION}\\
    \vspace*{\c__nusthesis_declaration_heading_vspace_dim}\mdseries%
      I~hereby~declare~that~the~\l__documenttype_tl{}~is~my~original\\
      work~and~it~has~been~written~by~me~in~its~entirety.\\
      I~have~duly~acknowledged~all~the~sources~of\\
      information~which~have~been~used~in~the~\l__documenttype_tl.\\
      \vspace*{\c__nusthesis_declaration_para_vspace_dim}
      This~\l__documenttype_tl{}~has~also~not~been~submitted~for~any\\
      degree~in~any~university~previously.\\
      \vspace*{\c__nusthesis_declaration_signature_vspace_dim}
      \IfValueT {#1}{
        \includegraphics[width=\c__nusthesis_declaration_sig_image_width_dim]{#1}\\
      \vspace*{\c__nusthesis_declaration_sig_adjust_dim}
    }
      \rule{\c__nusthesis_declaration_line_width_dim}{\c__nusthesis_declaration_line_thickness_dim}\\
      \vspace*{\c__nusthesis_declaration_author_adjust_dim}
      \@author \\
      \today
    \end{center}\cleardoublepage
}

%% titlesec
\definecolor{chaptergrey}{rgb}{0.6,0.6,0.6}

%%% chapter titles similar to quotchap
\cs_new:Npn \chapnum {
  \fontsize{\c__nusthesis_chapnum_fontsize_int}{\c__nusthesis_chapnum_baseline_int}\__nusthesis_chaphead_font:\bfseries\selectfont
  \color{chaptergrey}\raggedleft
}

\newenvironment{acknowledgements}{%
  \chapter*{Acknowledgements}
   \addcontentsline{toc}{preface}{Acknowledgements}
   }{%
     \newpage\cleardoublepage
}

\NewDocumentEnvironment{abstract}{o}
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

 \titlecontents{preface}
 [0pt]
 {\addvspace{1pc}%
   \mdseries\normalshape%
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
    \__nusthesis_chaphead_font:\setstretch{0.9}}{%
    % label
    \chapnum{\thechapter}}{%
    % sep
    0em}{%
    % beforecode
    \raggedleft\Huge}{%
    % aftercode
  }

\titleformat{\section}{\setstretch{1.2}\__nusthesis_heading_font:\raggedright\Large}{\thesection}{1em}{}
\titleformat{\subsection}{\setstretch{1.2}\__nusthesis_heading_font:\raggedright\large}{\thesubsection}{1em}{}

\titleformat{\subsubsection}{\setstretch{1.2}\__nusthesis_heading_font:\normalsize}{\thesubsubsection}{1em}{}

}

\bool_new:N \l__nusthesis_table_in_chapter_bool  %% has a table already appeared in this chapter
\bool_new:N \l__nusthesis_figure_in_chapter_bool  %% has a figure already appeared in this chapter

\AddToHook{env/table/before}{
  \bool_if:NF \l__nusthesis_table_in_chapter_bool {
    \bool_set_true:N \l__nusthesis_table_in_chapter_bool
    \addtocontents{lot}{\protect\contentsline{chapter}{\chaptertitlename \  \thechapter}{}{}}
  }
}

\AddToHook{env/longtable/before}{
  \bool_if:NF \l__nusthesis_table_in_chapter_bool {
    \bool_set_true:N \l__nusthesis_table_in_chapter_bool
    \addtocontents{lot}{\protect\contentsline{chapter}{\chaptertitlename \  \thechapter}{}{}}
  }
}

\AddToHook{env/sidewaystable/before}{
  \bool_if:NF \l__nusthesis_table_in_chapter_bool {
    \bool_set_true:N \l__nusthesis_table_in_chapter_bool
    \addtocontents{lot}{\protect\contentsline{chapter}{\chaptertitlename \  \thechapter}{}{}}
  }
}

\AddToHook{env/figure/before}{
  \bool_if:NF \l__nusthesis_figure_in_chapter_bool {
    \bool_set_true:N \l__nusthesis_figure_in_chapter_bool
    \addtocontents{lof}{\protect\contentsline{chapter}{\chaptertitlename \  \thechapter}{}{}}
  }
}

\NewDocumentCommand{\ResetFloatsInChapter}{}{
  \bool_set_false:N \l__nusthesis_table_in_chapter_bool
  \bool_set_false:N \l__nusthesis_figure_in_chapter_bool
}

\pretocmd{\chapter}{%
  \ResetFloatsInChapter{}}{}{}

\noappendicestocpagenum
\renewcommand{\appendixpagename}{\__nusthesis_chaphead_font: Appendices}

\g@addto@macro\appendix{%
\titleformat{\chapter}[display]
{\__nusthesis_chaphead_font:\Huge}{\chaptertitlename\ \thechapter}{\c__nusthesis_appendix_title_sep_dim}{\Huge}
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
\NewDocumentCommand \addsymbol { m m } {
  \addtocontents{los}{\protect \makenicesymbolline{#1}{#2}}
}

\NewDocumentCommand \addabbrev { m m } {
  \addtocontents{loab}{\protect \makeniceabbrevline{#1}{#2}}
}
\dim_new:N \l__nusthesis_symbol_leftcol_working_dim
\dim_set:Nn \l__nusthesis_symbol_leftcol_working_dim { \c__nusthesis_symbol_leftcol_dim }

\dim_new:N \l__nusthesis_symbol_midcol_working_dim
\dim_set:Nn \l__nusthesis_symbol_midcol_working_dim { \c__nusthesis_symbol_midcol_dim }

\dim_new:N \l__nusthesis_symbol_rightcol_working_dim
\dim_set:Nn \l__nusthesis_symbol_rightcol_working_dim {
  \hsize - \l__nusthesis_symbol_leftcol_working_dim - \l__nusthesis_symbol_midcol_working_dim
}
\def\makenicesymbolline#1#2{%
  \begin{minipage}[t]{\l__nusthesis_symbol_leftcol_working_dim}#1\end{minipage}%
  $\hspace{\l__nusthesis_symbol_midcol_working_dim}$%
  \begin{minipage}[t]{\l__nusthesis_symbol_rightcol_working_dim}#2\end{minipage}\newline}
\def\makeniceabbrevline#1#2{%
  % \begin{minipage}[t]{\l__nusthesis_symbol_leftcol_working_dim}#1\end{minipage}%
  % $\hspace{\l__nusthesis_symbol_midcol_working_dim}$%
  % \begin{minipage}[t]{\l__nusthesis_symbol_rightcol_working_dim}#2\end{minipage}\newline
  \acro{#1}{#2}}
\endinput
%%
%% End of file `nus-thesis.cls'.
