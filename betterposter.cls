%%%% Better Poster latex template v1.0 (2019/04/04)
%%%% GNU General Public License v3.0
%%%% Rafael Bailo
%%%% https://github.com/rafaelbailo/betterposter-latex-template
%%%%
%%%% Version v1.1 (Portrait support with the help of tikzposter)
%%%% GNU General Public License v3.0
%%%% Tony Zorman
%%%%
%%%% Original design from Mike Morrison
%%%% https://twitter.com/mikemorrison

%%% Boilerplate

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{betterposter}[2023-06-20 Better Poster latex template v1.1]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{family=BP, prefix=BP@}

\DeclareBoolOption{landscape}
\DeclareComplementaryOption{portrait}{landscape}

\ifBP@landscape
  \DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\else
  \DeclareOption*{\PassOptionsToClass{\CurrentOption}{tikzposter}}
\fi

\ProcessKeyvalOptions*
\ProcessOptions\relax

%%% Base class and geometry

\ifBP@landscape
  \LoadClass{article}
  \pagestyle{empty}

  % Paper size
  \RequirePackage{geometry}
  \geometry{a0paper}

  % Paper orientation
  \geometry{landscape}

  % Remove default margins
  \geometry{margin=0in}
\else
  \LoadClass[a0paper, portrait]{tikzposter}
  \usetheme{Simple}
  \tikzposterlatexaffectionproofoff
\fi

%%% Required packages

% Small separation on enumerate and itemize
\RequirePackage{enumitem}
\setlist{nolistsep}
\setenumerate{noitemsep}
\setitemize{noitemsep}
\setlength{\parindent}{0pt}

\RequirePackage{qrcode}

\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[ttscale=.85]{libertine}
\RequirePackage{libertinust1math}

% Colours
\RequirePackage{xcolor}
\definecolor{imperialblue}{RGB}{0,62,116}
\definecolor{empirical}{RGB}{0,77,64}
\definecolor{theory}{RGB}{26,35,126}
\definecolor{methods}{RGB}{140,22,22}
\definecolor{intervention}{RGB}{255,213,79}

\newcommand{\columnbackgroundcolor}{white}
\newcommand{\columnfontcolor}{black}
\newcommand{\maincolumnbackgroundcolor}{imperialblue}
\newcommand{\maincolumnfontcolor}{white}

% Graphics
\RequirePackage{graphicx}

% AMS packages
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

%%% Size commands

% Poster lengths
\newlength{\leftbarwidth}
\newlength{\rightbarwidth}
\newlength{\columnmarginvertical}
\newlength{\columnmarginhorizontal}
\newlength{\maincolumnmarginvertical}
\newlength{\maincolumnmarginhorizontal}

%%%% Sizing options

\newcommand{\fontsizestandard}{\fontsize{37.00}{55.50} \selectfont}
\newcommand{\fontsizemain}{\fontsize{96.00}{200.00} \selectfont}
\newcommand{\fontsizetitle}{\fontsize{72.00}{112.00} \selectfont}
\newcommand{\fontsizeauthor}{\fontsize{48.00}{68.00} \selectfont}
\newcommand{\fontsizesection}{\fontsize{48.00}{68.00} \selectfont}
\newcommand{\fontsizestandout}{\fontsize{50.00}{75.50} \selectfont}

% Default values for lengths
\setlength{\leftbarwidth}{0.24\paperwidth}
\setlength{\rightbarwidth}{0.24\paperwidth}
\setlength{\columnmarginvertical}{0.025\paperheight}
\setlength{\columnmarginhorizontal}{0.015\paperheight}
\setlength{\maincolumnmarginvertical}{0.07\paperheight}
\setlength{\maincolumnmarginhorizontal}{0.07\paperheight}

%%% Template commands

\ifBP@landscape
  % Main \betterposter command
  \newcommand{\betterposter}[3]{%
    \noindent
    % Left column
    \column%
      {\dimexpr 1.0\textheight\relax}%
      {\leftbarwidth}%
      {\columnbackgroundcolor}%
      {\columnfontcolor}%
      {\columnmarginvertical}%
      {\columnmarginhorizontal}%
      {#2}%
    % Central column
    \column%
      {\dimexpr 1.0\textheight\relax}%
      {\dimexpr 1.0\textwidth-\leftbarwidth-\rightbarwidth\relax}%
      {\maincolumnbackgroundcolor}%
      {\maincolumnfontcolor}%
      {\maincolumnmarginvertical}%
      {\maincolumnmarginhorizontal}%
      {#1}%
    % Right column
    \column%
      {\dimexpr 1.0\textheight\relax}%
      {\rightbarwidth}%
      {\columnbackgroundcolor}%
      {\columnfontcolor}%
      {\columnmarginvertical}%
      {\columnmarginhorizontal}%
      {#3}%
  }

  % Coloured column command
  \newcommand{\column}[7]{%
    \begin{minipage}[t][#1][t]{#2}%
      \noindent\colorbox{#3}{%
        \begin{minipage}[t][
          \dimexpr 1.0\textheight\relax
          ][t]{\dimexpr 1.0\textwidth-0\fboxrule-2\fboxsep\relax}
          {\leavevmode\color{#4}\centeredpage{#5}{#6}{#7}}
        \end{minipage}}%
    \end{minipage}%
  }

  % Page with margins command
  \newcommand{\centeredpage}[3]{%
    \begin{minipage}[c][\textheight][c]{\textwidth}
      \begin{center}
        \begin{minipage}[t][
          \dimexpr 1.0\textheight-2.0#1\relax
          ][t]{
            \dimexpr 1.0\textwidth-2.0#2\relax
          }
          {\fontsizestandard #3}
        \end{minipage}
      \end{center}
    \end{minipage}
  }
\else
  % A block divided into three columns.
  \newcommand{\betterThreeColumns}[3]{
    \begin{columns}
      \column{0.33}
      \betterBlock{}{#1}

      \column{0.33}
      \betterBlock{}{#2}

      \column{0.33}
      \betterBlock{}{#3}
    \end{columns}
  }

  \newcommand{\betterBlock}[3][]{
    \block[bodyinnersep=5pt,#1]{#2}{%
      \fontsizestandard%
      #3%
    }
  }
\fi

%% Main column command
\ifBP@landscape
  \newcommand{\maincolumn}[2]{
    \vfill{
      \fontsizemain

      #1

      \vspace{1em}
    }
    \vfill
    \begin{minipage}[t][0.25\textheight][b]{\textwidth}
      #2
    \end{minipage}
  }
\else
  \newcommand{\maincolumn}[2]{
    \block[bodyoffsetx=-43pt,titleinnersep=0,bodyinnersep=0,roundedcorners=0,linewidth=0pt]{}{%
      \coloredbox[bgcolor=imperialblue,roundedcorners=0,linewidth=0pt,width=\textwidth]{%
        \color{white}%
        \fontsizemain%
        #1
      }
    }
  }
\fi

% \section
\renewcommand{\section}[1]{

  \vspace{2em}{\fontsizesection\selectfont
    \textbf{\leavevmode
      #1
    }}\\[0.5em]
}

% \title
\renewcommand{\title}[1]{
  {\fontsizetitle\textsc{\leavevmode
      #1
    }}\\

}

% \author
\renewcommand{\author}[1]{
  {\color{gray}\fontsizeauthor
    #1
  }\\[-1.0em]

}

% \institution
\newcommand{\institution}[1]{
  \vspace{-1em}
  {\color{gray}
    #1
  }\\[-1.0em]

}

\ifBP@landscape
\else
  % Normally \maketitle would set this to a reasonable value, but we
  % don't use that, instead opting to redefine \title and friends. This
  % means that we have to set the value ourselves.
  \setlength{\TP@blocktop}{0.49\textheight}
\fi

\endinput
