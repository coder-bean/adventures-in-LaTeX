" Vim with all enhancements
source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" LaTeX Settings
let g:tex_flavor = 'latex'

" Compile with MiKTeX pdflatex
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode $*'
let g:Tex_DefaultTargetFormat = 'pdf'
augroup LaTeXKeyMappings
  autocmd!
  autocmd FileType tex inoremap <C-m> \begin{bmatrix}<CR>  \end{bmatrix}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
autocmd FileType tex inoremap <C-k> \ket{}<Left>
 autocmd FileType tex inoremap <C-n> \begin{equation}<CR> \end{equation}<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
 autocmd FileType tex inoremap <C-i> $$<Left>

augroup END

" Define abbreviation for the LaTeX article template
iab article
\documentclass{article}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\title{Title}
\author{Your Name}
\date{\today}
\begin{document}
\maketitle
\section{Introduction}
\subsection{Subsection}
\subsubsection{Subsubsection}
\end{document}




