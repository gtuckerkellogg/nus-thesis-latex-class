%%
%% This is file `nus-thesis.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% nus-thesis.dtx  (with options: `class')
%% -------------------------------------------------------------------------
%%   Copyright 2024 Greg Tucker-Kellogg
%% 
%%   This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
%%   International License (https://creativecommons.org/licenses/by-sa/4.0/).
%% -------------------------------------------------------------------------
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


\cs_new:Npn \__nusthesis_body_font: { \normalfont }          % Body text (main content)
\cs_new:Npn \__nusthesis_titlepage_font: { \normalfont }     % Title page elements
\cs_new:Npn \__nusthesis_chaphead_font: { \normalfont }      % Chapter headings
\cs_new:Npn \__nusthesis_heading_font: { \normalfont }       % Section/subsection headings
\cs_new:Npn \__nusthesis_caption_font: { \normalfont }       % Figure/table captions
\cs_new:Npn \__nusthesis_verbatim_font: { \ttfamily }        % Code/verbatim blocks
\cs_new:Npn \__nusthesis_math_setup: { }                     % Math font configuration hook

\bool_new:N \l__thesis_use_glossaries_bool

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\prop_new:N \g__nusthesis_fontthemes_prop

\str_new:N \l__nusthesis_engine_str
\sys_if_engine_pdftex:TF {
  \str_set:Nn \l__nusthesis_engine_str { pdftex }
} {
  \sys_if_engine_xetex:TF {
    \str_set:Nn \l__nusthesis_engine_str { xetex }
  } {
    \str_set:Nn \l__nusthesis_engine_str { luatex }
  }
}

\tl_new:N \l__nusthesis_theme_config_tl
\tl_new:N \l__nusthesis_theme_pdftex_tl
\tl_new:N \l__nusthesis_theme_xetex_tl
\tl_new:N \l__nusthesis_theme_luatex_tl
\tl_new:N \l__nusthesis_theme_fontspec_tl
\tl_new:N \l__nusthesis_hook_body_tl
\tl_new:N \l__nusthesis_hook_titlepage_tl
\tl_new:N \l__nusthesis_hook_chaphead_tl
\tl_new:N \l__nusthesis_hook_heading_tl
\tl_new:N \l__nusthesis_hook_caption_tl
\tl_new:N \l__nusthesis_hook_verbatim_tl
\tl_new:N \l__nusthesis_hook_math_tl

\keys_define:nn { nus-thesis / fonttheme }
{
  , pdftex .tl_set:N = \l__nusthesis_theme_pdftex_tl
  , pdftex .initial:n = { }
  , xetex .tl_set:N = \l__nusthesis_theme_xetex_tl
  , xetex .initial:n = { }
  , luatex .tl_set:N = \l__nusthesis_theme_luatex_tl
  , luatex .initial:n = { }
  , fontspec .tl_set:N = \l__nusthesis_theme_fontspec_tl
  , fontspec .initial:n = { }  % Common code for XeTeX/LuaTeX
  , hooks / body .code:n = { \cs_gset:Npn \__nusthesis_body_font: { #1 } }
  , hooks / titlepage .code:n = { \cs_gset:Npn \__nusthesis_titlepage_font: { #1 } }
  , hooks / chaphead .code:n = { \cs_gset:Npn \__nusthesis_chaphead_font: { #1 } }
  , hooks / heading .code:n = { \cs_gset:Npn \__nusthesis_heading_font: { #1 } }
  , hooks / caption .code:n = { \cs_gset:Npn \__nusthesis_caption_font: { #1 } }
  , hooks / verbatim .code:n = { \cs_gset:Npn \__nusthesis_verbatim_font: { #1 } }
  , hooks / math .code:n = { \cs_gset:Npn \__nusthesis_math_setup: { #1 } }
}

\msg_new:nnn { nus-thesis } { unknown-fonttheme } {
  Font~theme~'#1'~is~not~defined.~Available~themes~are~stored~in~
  \prop_map_function:NN \g__nusthesis_fontthemes_prop \__nusthesis_show_theme:nn
}

\cs_new:Npn \__nusthesis_show_theme:nn #1 #2 { #1,~ }

\cs_new:Npn \__nusthesis_load_fonttheme:n #1 {
  % Check if theme exists in property list
  \prop_if_in:NnTF \g__nusthesis_fontthemes_prop { #1 } {
    % Get theme configuration
    \prop_get:NnN \g__nusthesis_fontthemes_prop { #1 } \l__nusthesis_theme_config_tl

    % Parse the configuration and set temporary variables
    % NOTE: No group here - packages must be loaded at top level
    \keys_set:nV { nus-thesis / fonttheme } \l__nusthesis_theme_config_tl

    % Load engine-specific fonts
    \str_case:Vn \l__nusthesis_engine_str {
      { pdftex } {
        \tl_if_empty:NF \l__nusthesis_theme_pdftex_tl {
          \tl_use:N \l__nusthesis_theme_pdftex_tl
        }
      }
      { xetex } {
        % Try fontspec first (common code for XeTeX/LuaTeX), then xetex-specific
        \tl_if_empty:NTF \l__nusthesis_theme_fontspec_tl {
          \tl_if_empty:NF \l__nusthesis_theme_xetex_tl {
            \tl_use:N \l__nusthesis_theme_xetex_tl
          }
        } {
          \tl_use:N \l__nusthesis_theme_fontspec_tl
        }
      }
      { luatex } {
        % Try fontspec first (common code for XeTeX/LuaTeX), then luatex-specific
        \tl_if_empty:NTF \l__nusthesis_theme_fontspec_tl {
          \tl_if_empty:NF \l__nusthesis_theme_luatex_tl {
            \tl_use:N \l__nusthesis_theme_luatex_tl
          }
        } {
          \tl_use:N \l__nusthesis_theme_fontspec_tl
        }
      }
    }
    % Note: Font hooks are set globally during key processing (using \cs_gset:Npn)
  } {
    % Theme not found - show error
    \msg_error:nnn { nus-thesis } { unknown-fonttheme } { #1 }
  }
}

\cs_generate_variant:Nn \__nusthesis_load_fonttheme:n { V }

\tl_new:N \g__nusthesis_selected_fonttheme_tl

\NewDocumentCommand \DeclareThesisFontTheme { m m } {
  % Store the theme configuration in the property list
  \prop_gput:Nnn \g__nusthesis_fontthemes_prop { #1 } { #2 }

  % Also register this theme as a choice in the font key
  % Load the theme immediately when selected (must be in preamble)
  \keys_define:nn { nus-thesis } {
    , font / #1 .code:n = {
        \bool_if:NF \g__nusthesis_fonttheme_loaded_bool {
          \__nusthesis_load_fonttheme:n { #1 }
          \bool_gset_true:N \g__nusthesis_fonttheme_loaded_bool
        }
      }
  }
}

\NewDocumentCommand \UseFontTheme { m } {
  \__nusthesis_load_fonttheme:n { #1 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\keys_define:nn { nus-thesis / usertheme }
{
  , main-font .tl_set:N = \l__nusthesis_user_mainfont_tl
  , main-font .initial:n = { }
  , sans-font .tl_set:N = \l__nusthesis_user_sansfont_tl
  , sans-font .initial:n = { }
  , mono-font .tl_set:N = \l__nusthesis_user_monofont_tl
  , mono-font .initial:n = { }
  , math-font .tl_set:N = \l__nusthesis_user_mathfont_tl
  , math-font .initial:n = { }
  , chaphead-style .tl_set:N = \l__nusthesis_user_chaphead_tl
  , chaphead-style .initial:n = { }
  , heading-style .tl_set:N = \l__nusthesis_user_heading_tl
  , heading-style .initial:n = { }
  , titlepage-style .tl_set:N = \l__nusthesis_user_titlepage_tl
  , titlepage-style .initial:n = { }
  , caption-style .tl_set:N = \l__nusthesis_user_caption_tl
  , caption-style .initial:n = { }
}

\NewDocumentCommand \ThesisDefineFontTheme { m m } {
  % Parse user options
  \group_begin:
    \keys_set:nn { nus-thesis / usertheme } { #2 }

    % Build fontspec configuration
    \tl_clear:N \l_tmpa_tl

    % Load unicode-math if math font specified (must come before font setup)
    \tl_if_empty:NF \l__nusthesis_user_mathfont_tl {
      \tl_put_right:Nn \l_tmpa_tl { \RequirePackage{unicode-math} }
    }

    \tl_if_empty:NF \l__nusthesis_user_mainfont_tl {
      \tl_put_right:Nn \l_tmpa_tl { \setmainfont }
      \tl_put_right:NV \l_tmpa_tl \l__nusthesis_user_mainfont_tl
    }
    \tl_if_empty:NF \l__nusthesis_user_sansfont_tl {
      \tl_put_right:Nn \l_tmpa_tl { \setsansfont }
      \tl_put_right:NV \l_tmpa_tl \l__nusthesis_user_sansfont_tl
    }
    \tl_if_empty:NF \l__nusthesis_user_monofont_tl {
      \tl_put_right:Nn \l_tmpa_tl { \setmonofont }
      \tl_put_right:NV \l_tmpa_tl \l__nusthesis_user_monofont_tl
    }
    \tl_if_empty:NF \l__nusthesis_user_mathfont_tl {
      \tl_put_right:Nn \l_tmpa_tl { \setmathfont }
      \tl_put_right:NV \l_tmpa_tl \l__nusthesis_user_mathfont_tl
    }

    % Build hooks configuration
    \tl_clear:N \l_tmpb_tl
    \tl_if_empty:NF \l__nusthesis_user_chaphead_tl {
      \tl_put_right:Nn \l_tmpb_tl { hooks/chaphead = }
      \str_case:Vn \l__nusthesis_user_chaphead_tl {
        { serif } { \tl_put_right:Nn \l_tmpb_tl { \normalfont } }
        { sans } { \tl_put_right:Nn \l_tmpb_tl { \sffamily } }
        { mono } { \tl_put_right:Nn \l_tmpb_tl { \ttfamily } }
      }
      \tl_put_right:Nn \l_tmpb_tl { , }
    }
    \tl_if_empty:NF \l__nusthesis_user_heading_tl {
      \tl_put_right:Nn \l_tmpb_tl { hooks/heading = }
      \str_case:Vn \l__nusthesis_user_heading_tl {
        { serif } { \tl_put_right:Nn \l_tmpb_tl { \normalfont } }
        { sans } { \tl_put_right:Nn \l_tmpb_tl { \sffamily } }
        { mono } { \tl_put_right:Nn \l_tmpb_tl { \ttfamily } }
      }
      \tl_put_right:Nn \l_tmpb_tl { , }
    }
    \tl_if_empty:NF \l__nusthesis_user_titlepage_tl {
      \tl_put_right:Nn \l_tmpb_tl { hooks/titlepage = }
      \str_case:Vn \l__nusthesis_user_titlepage_tl {
        { serif } { \tl_put_right:Nn \l_tmpb_tl { \normalfont } }
        { sans } { \tl_put_right:Nn \l_tmpb_tl { \sffamily } }
        { mono } { \tl_put_right:Nn \l_tmpb_tl { \ttfamily } }
      }
      \tl_put_right:Nn \l_tmpb_tl { , }
    }
    \tl_if_empty:NF \l__nusthesis_user_caption_tl {
      \tl_put_right:Nn \l_tmpb_tl { hooks/caption = }
      \str_case:Vn \l__nusthesis_user_caption_tl {
        { serif } { \tl_put_right:Nn \l_tmpb_tl { \normalfont } }
        { sans } { \tl_put_right:Nn \l_tmpb_tl { \sffamily } }
        { mono } { \tl_put_right:Nn \l_tmpb_tl { \ttfamily } }
      }
      \tl_put_right:Nn \l_tmpb_tl { , }
    }

    % Store for use outside group
    \tl_gset_eq:NN \g_tmpa_tl \l_tmpa_tl
    \tl_gset_eq:NN \g_tmpb_tl \l_tmpb_tl
  \group_end:

  % Call low-level \DeclareThesisFontTheme with generated configuration
  \exp_args:Nnx \DeclareThesisFontTheme { #1 } {
    fontspec = { \exp_not:V \g_tmpa_tl },
    \exp_not:V \g_tmpb_tl
  }
}

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
  % Font themes are defined below using \DeclareThesisFontTheme
  , font / strict .meta:n = { font = times }  % Alias for backward compatibility
  , glossaries .bool_set:N = \l__thesis_use_glossaries_bool
  , glossaries .initial:n = { false }  % Default: don't load glossaries
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareThesisFontTheme{computermodern}{
  pdftex = {
    % Computer Modern is the default - no packages needed
    % Optionally load Latin Modern for better quality
    \RequirePackage{lmodern}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setmainfont{Latin~Modern~Roman}[Ligatures=TeX]
    \setsansfont{Latin~Modern~Sans}[Scale=MatchLowercase]
    \setmonofont{Latin~Modern~Mono}[Scale=MatchLowercase]
    \setmathfont{Latin~Modern~Math}
  },
  % All hooks use defaults (serif body, serif headings)
}

\DeclareThesisFontTheme{times}{
  pdftex = {
    \RequirePackage{mathptmx}  % Times + math support
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setmainfont{TeX~Gyre~Termes}[Ligatures=TeX]
    \setsansfont{TeX~Gyre~Heros}[Scale=0.95]
    \setmonofont{Latin~Modern~Mono}[Scale=MatchLowercase]
    \setmathfont{TeX~Gyre~Termes~Math}
  },
  % All hooks use defaults (serif body, serif headings)
}

\DeclareThesisFontTheme{helvetica}{
  pdftex = {
    \RequirePackage[scaled=0.95]{helvet}
    \renewcommand{\familydefault}{\sfdefault}
    \RequirePackage{mathastext}
    \RequirePackage{arevmath}
    \RequirePackage[mono,varl]{inconsolata}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setsansfont{TeX~Gyre~Heros}[Scale=0.95]
    \setmainfont{TeX~Gyre~Heros}[Scale=0.95]
    \setmonofont{Inconsolata}[Scale=MatchLowercase]
    \setmathfont{Fira~Math}  % Sans-serif math font
  },
  hooks/body = \sffamily,
  hooks/titlepage = \sffamily,
  hooks/chaphead = \sffamily,
  hooks/heading = \sffamily,
  hooks/caption = \sffamily,
}

\DeclareThesisFontTheme{palatino}{
  pdftex = {
    \RequirePackage[sc]{mathpazo}  % Palatino + smallcaps
    \RequirePackage[scaled=0.95]{helvet}
    \RequirePackage[varl]{inconsolata}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setmainfont{TeX~Gyre~Pagella}[Ligatures=TeX]
    \setsansfont{TeX~Gyre~Heros}[Scale=0.95]
    \setmonofont{Inconsolata}[Scale=MatchLowercase]
    \setmathfont{TeX~Gyre~Pagella~Math}
  },
  hooks/chaphead = \sffamily,
  hooks/heading = \sffamily,
  hooks/caption = \sffamily,
}

\DeclareThesisFontTheme{libertine}{
  pdftex = {
    \RequirePackage[scaled=0.9,varl]{inconsolata}
    \RequirePackage[mono=false,sb]{libertinus}
    \RequirePackage{libertinust1math}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \RequirePackage{libertinus}
    \setmonofont[Scale=MatchUppercase]{Inconsolata}
    \setmathfont{Libertinus~Math}
  },
  hooks/chaphead = \sffamily,
  hooks/heading = \sffamily,
  hooks/caption = \sffamily,
}

\DeclareThesisFontTheme{noto}{
  pdftex = {
    \RequirePackage{notomath}
    \RequirePackage{inconsolata}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setmainfont{Noto~Serif}
    \setsansfont{Noto~Sans}
    \setmonofont{Noto~Sans~Mono}[Scale=MatchLowercase]
    \setmathfont{STIXTwoMath-Regular.otf}  % Noto doesn't have a math font yet
  },
  hooks/titlepage = \sffamily,
  hooks/chaphead = \sffamily,
  hooks/heading = \sffamily,
  hooks/caption = \sffamily,
}

\DeclareThesisFontTheme{minionpro}{
  pdftex = {
    \RequirePackage[lf,minionint,loosequotes,footnotefigures]{MinionPro}
    \microtypesetup{kerning=false,expansion=false}
    \RequirePackage[lf]{MyriadPro}
    \RequirePackage[scaled=0.9,varl]{inconsolata}
  },
  fontspec = {
    \RequirePackage{unicode-math}
    \setmainfont{Minion~Pro}
    \setsansfont{Myriad~Pro}
    \setmonofont{Inconsolata}[Scale=0.9]
    \setmathfont{TeX~Gyre~Pagella~Math}  % Minion Math is commercial
  },
  %hooks/titlepage = \sffamily,
  hooks/chaphead = \sffamily,
  hooks/heading = \sffamily,
  hooks/caption = \sffamily,
}

\ProcessKeysOptions { nus-thesis }

\NewDocumentCommand \ThesisSetup { m } {
  \keys_set:nn { nus-thesis } { #1 }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[UKenglish]{isodate}

\RequirePackage[svgnames,table]{xcolor}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{pdflscape}
\RequirePackage{pstricks}

\RequirePackage{setspace}
\RequirePackage[top=1in, bottom=1in, left=1.5in, right=1.5in]{geometry}
\RequirePackage{emptypage}

\RequirePackage[titles]{tocloft}
\RequirePackage{bookmark}

\RequirePackage{silence}
\WarningFilter{microtype}{kerning codes list}
\RequirePackage[verbose=false]{microtype}
\sys_if_engine_pdftex:TF {
  \microtypesetup{kerning=true}
  \SetExtraKerning[unit=character]{encoding=*}{\textemdash={100,100}}
}{}

\RequirePackage{etoolbox}
\RequirePackage{titlesec}
\RequirePackage{titletoc}

\RequirePackage{amsmath}
\RequirePackage{mathtools}
\sys_if_engine_pdftex:F {
  \RequirePackage{unicode-math}
}

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

\AtEndPreamble{
  \bool_if:NT \l__thesis_use_glossaries_bool {
    \RequirePackage[abbreviations,prefix,postpunc={:},automake,toc=false]{glossaries-extra}
    \makeglossaries[abbreviations]
    \setglossarypreamble[abbreviations]{\addcontentsline{toc}{preface}{\glossarytitle}}
    \newcommand{\glsxtrfootnote}[1]{\glsxtrshort{#1}\footnote{\Glsxtrlong{#1}.}\glsunset{#1}}
    \newignoredglossary*{ignored}
  }
}

\RequirePackage{hyperref}
\hypersetup{%
  hidelinks%
}
\RequirePackage[nameinlink,noabbrev, capitalise]{cleveref}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\bool_new:N \g__nusthesis_fonttheme_loaded_bool

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
\dim_const:Nn \c__nusthesis_declaration_genai_vspace_dim { 0.7cm }
\dim_const:Nn \c__nusthesis_declaration_signature_vspace_dim { 2cm }
\dim_const:Nn \c__nusthesis_declaration_date_vspace_dim { 1cm }
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

%% Declaration Page Environment and Sub-commands
%%
%% Usage:
%%   \begin{declaration}
%%     \DeclarationStatement
%%     \DeclarationGenAI          % template B: AI used (default)
%%     \DeclarationGenAI[none]    % template A: no AI used
%%     \DeclarationGenAICustom{custom text}  % custom AI statement
%%     \DeclarationSignature[sig.png]  % optional signature image
%%   \end{declaration}
%%
%% Backward-compatible shorthand: \DeclarationPage[sig.png]

\NewDocumentEnvironment{declaration}{}
{%
  \clearpage
  \thispagestyle{plain}
  \setlength{\parindent}{0pt}%
  \begin{center}\hyphenpenalty=10000
    \__nusthesis_titlepage_font:\large\bfseries
    \text_uppercase:n{DECLARATION}
  \end{center}
  \vspace*{\c__nusthesis_declaration_heading_vspace_dim}
}{%
  \cleardoublepage
}

\NewDocumentCommand \DeclarationStatement {}
{
  \noindent
  I~hereby~declare~that~this~\l__documenttype_tl{}~is~my~original~work~and~has~been~written~by~me~in~its~entirety.
  I~have~duly~acknowledged~all~sources~of~information~which~have~been~used~in~the~\l__documenttype_tl.
  \par\vspace*{\c__nusthesis_declaration_para_vspace_dim}\noindent
  This~\l__documenttype_tl{}~has~not~been~submitted~for~any~degree~or~examination~in~any~other~university~or~institution~previously.
  \par
}

\NewDocumentCommand \DeclarationGenAI { O{used} }
{
  \vspace*{\c__nusthesis_declaration_genai_vspace_dim}
  \noindent{\bfseries Use~of~Generative~AI}\par\noindent
  \str_if_eq:nnTF {#1} {none}
    {
      I~declare~that~no~generative~artificial~intelligence~(AI)~tools~were~used~in~the~preparation~of~the~\l__documenttype_tl.
    }
    {
      I~acknowledge~the~use~of~generative~artificial~intelligence~(AI)~tools~in~the~preparation~of~this~\l__documenttype_tl,~solely~for~language~refinement,~structuring~and~proofreading~purposes.~All~AI-generated~outputs~have~been~critically~reviewed,~edited,~and~verified~by~me.~I~confirm~that~the~intellectual~content,~analysis,~and~conclusions~presented~are~entirely~my~own,~and~I~take~full~responsibility~for~the~work~submitted.
    }
  \par
}

\NewDocumentCommand \DeclarationGenAICustom { +m }
{
  \vspace*{\c__nusthesis_declaration_genai_vspace_dim}
  \noindent{\bfseries Use~of~Generative~AI}\par\noindent
  #1\par
}

\NewDocumentCommand \DeclarationSignature { o }
{
  \vspace*{\c__nusthesis_declaration_signature_vspace_dim}
  \begin{center}
    \IfValueT{#1}{
      \includegraphics[width=\c__nusthesis_declaration_sig_image_width_dim]{#1}\\
      \vspace*{\c__nusthesis_declaration_sig_adjust_dim}
    }
    \rule{\c__nusthesis_declaration_line_width_dim}{\c__nusthesis_declaration_line_thickness_dim}\\
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \@author\\
    \vspace*{\c__nusthesis_declaration_date_vspace_dim}
    \rule{\c__nusthesis_declaration_line_width_dim}{\c__nusthesis_declaration_line_thickness_dim}\\
    \vspace*{\c__nusthesis_declaration_author_adjust_dim}
    \today
  \end{center}
}

%% Backward-compatible \DeclarationPage wrapper
\NewDocumentCommand \DeclarationPage { o }
{
  \begin{declaration}
    \DeclarationStatement
    \IfValueTF{#1}
      { \DeclarationSignature[#1] }
      { \DeclarationSignature }
  \end{declaration}
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
