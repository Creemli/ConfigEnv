syntax on "开启语法高亮(需要安装vim-full)
set linebreak 
set textwidth=80
set nocompatible
set history=50
set ruler
set number
set hlsearch
set noincsearch
"set expandtab
set noerrorbells
set novisualbell
set vb t_vb= 
"set showmatch
set nocompatible
"close visual bell
set foldmethod=marker
set incsearch
set tabstop=4
set shiftwidth=4
set nobackup
set nowritebackup
"set noswapfile
"set smarttab
set smartindent
set autoindent
"set noautoindent
"设置在粘贴的时候不自动缩进
"set paste  
set cursorline 
set cindent
set wrap
set autoread
"set mouse=a 
"set the height of command line
set cmdheight=1
"set showtabline=2
"set clipboard+=unnamed
set tabpagemax=20
set laststatus=2
set statusline=\ [PWD]\ %r%{CurrectDir()}%h\ \ [File]\ %f%m%r%h\ %w\ %=[L\ %l,R\ %c,T\ %L]\ %=\ %P

set cscopequickfix=s-,c-,d-,i-,t-,e-
function! CurrectDir()
    let curdir = substitute(getcwd(), "", "", "g")
    return curdir
endfunction

if has("multi_byte")
    set encoding=utf-8
    set termencoding=utf-8
    set formatoptions+=mM
    set fencs=utf-8,gbk

    if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
        set ambiwidth=double
    endif

    if has("win32")
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        language messages zh_CN.utf-8
    endif
else
    echoerr "Sorry, this version of (g)vim was not compiled with +multi_byte"
endif
func Maximize_Window()
endfunc
set csprg=/usr/bin/cscope
let Tlist_Ctags_Cmd='/usr/bin/ctags'
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=0
if has("gui_running")
let Tlist_Auto_Open=1 
    colorscheme default
    set cursorline
    if has("win32")
        set gfn=Raize
        au GUIEnter * simalt ~x
    else
        set guifont=13
    autocmd GUIEnter * winpos 0 0 | set lines=50 columns=100
    endif
else
    colorscheme default
endif

if has("autocmd")
    filetype plugin indent on
    augroup vimrcEx
        au!
        autocmd FileType text setlocal textwidth=78
        autocmd BufReadPost *
                    \ if line("'\"") > 0 && line("'\"") <= line("$") |
                    \   exe "normal g`\"" |
                    \ endif
    augroup END
endif
" key stock
"map tn :tabnext<cr>
"map tp :tabprevious<cr>
"map td :tabnew .<cr>
"map te :tabedit
"map tc :tabclose<cr>
"map cs :!php -l %<cr>

"map <F10> :VSTreeExplore<cr>
"map <F11> :x<cr>
"map <F12> :q!<cr>
" vim: set et sw=4 ts=4 sts=4 fdm=marker ff=unix fenc=utf8
"定义CompileRun函数，用来调用进行编译和运行
map <F5> :call CompileRun()<CR> 
func CompileRun()
exec "w"
"C程序
if &filetype == 'c'
    exec "!gcc %  -o %<"
    exec "!./%<"
endif
endfunc 
map <F6> :call OpenTlist()<CR>
func OpenTlist()
if &filetype == 'c'
    exec "Tlist"
endif
endfunc
"新建.c,.h,.sh文件，自动插入文件头
autocmd BufNewFile *.[ch],*.sh, exec ":call SetTitle()" 
autocmd BufNewFile * normal G 
func SetTitle() 
if &filetype == 'sh'
    call setline(1,  "\#########################################################################")
    call setline(2,  "\# Copyright (c) 2009-~ Hu bin")
    call setline(3,  "\# ")
    call setline(4,  "\# This source code is released for free distribution under the terms of the")
    call setline(5,  "\# GNU General Public License")
    call setline(6,  "\# ")
    call setline(7,  "\# Author:    Hu bin<hb198708@gmail.com>")
    call setline(8,  "\# File Name: ".expand("%"))
    call setline(9,  "\# Description: ")
    call setline(10, "\#########################################################################")
    call setline(11, "\#!/bin/bash")
    call setline(12, "")
else
    call setline(1, "\/*")
    call setline(2,   " * Copyright (c) 2009-~ Hu bin")
    call setline(3,  " *")
    call setline(4,  " * This source code is released for free distribution under the terms of the")
    call setline(5,  " * GNU General Public License")
    call setline(6,  " *")
    call setline(7,  " * Author:       Hu Bin<hb198708@gmail.com>")
    call setline(8,  " * Created Time: ".strftime("%c"))
    call setline(9,  " * File Name:    ".expand("%"))
    call setline(10, " *")
    call setline(11, " * Description:  ")
    call setline(12, " */")
    call setline(13, "")
  if &filetype == 'c' 
    call setline(14, "\#include <stdio.h>")
    call setline(15, "")
    call setline(16, "int main(int args, char *argv[])")
    call setline(17, "{")
    call setline(18, "\t")
    call setline(19, "\treturn 0;")
    call setline(20, "}")
    autocmd BufNewFile * normal 17G 
  else
    call setline(14, "\#ifndef __H")
    call setline(15, "\#define __H")
    call setline(16, "")
    call setline(17, "")
    call setline(18, "")
    call setline(19, "\#endif")
    autocmd BufNewFile * normal 16G 
  endif
    
endif
endfunc
if has("cscope")

    """"""""""""" Standard cscope/vim boilerplate

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    if filereadable("cscope.out")
        cs add cscope.out  
    " else add the database pointed to by environment variable 
    elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
    endif

    " show msg when any other cscope db added
    set cscopeverbose  


    """"""""""""" My cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls
    "
    " Below are three sets of the maps: one set that just jumps to your
    " search result, one that splits the existing vim window horizontally and
    " diplays your search result in the new window, and one that does the same
    " thing, but does a vertical split instead (vim 6 only).
    "
    " I've used CTRL-\ and CTRL-@ as the starting keys for these maps, as it's
    " unlikely that you need their default mappings (CTRL-\'s default use is
    " as part of CTRL-\ CTRL-N typemap, which basically just does the same
    " thing as hitting 'escape': CTRL-@ doesn't seem to have any default use).
    " If you don't like using 'CTRL-@' or CTRL-\, , you can change some or all
    " of these maps to use other keys.  One likely candidate is 'CTRL-_'
    " (which also maps to CTRL-/, which is easier to type).  By default it is
    " used to switch between Hebrew and English keyboard mode.
    "
    " All of the maps involving the <cfile> macro use '^<cfile>$': this is so
    " that searches over '#include <time.h>" return only references to
    " 'time.h', and not 'sys/time.h', etc. (by default cscope will return all
    " files that contain 'time.h' as part of their name).


    " To do the first type of search, hit 'CTRL-\', followed by one of the
    " cscope search types above (s,g,c,t,e,f,i,d).  The result of your cscope
    " search will be displayed in the current window.  You can use CTRL-T to
    " go back to where you were before the search.  
    "

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>    
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>    


    " Using 'CTRL-spacebar' (intepreted as CTRL-@ by vim) then a search type
    " makes the vim window split horizontally, with search result displayed in
    " the new window.
    "
    " (Note: earlier versions of vim may not have the :scs command, but it
    " can be simulated roughly via:
    "    nmap <C-@>s <C-W><C-S> :cs find s <C-R>=expand("<cword>")<CR><CR>    

    nmap <C-@>s :scs find s <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>g :scs find g <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>c :scs find c <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>t :scs find t <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>e :scs find e <C-R>=expand("<cword>")<CR><CR>    
    nmap <C-@>f :scs find f <C-R>=expand("<cfile>")<CR><CR>    
    nmap <C-@>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>    
    nmap <C-@>d :scs find d <C-R>=expand("<cword>")<CR><CR>    


    " Hitting CTRL-space *twice* before the search type does a vertical 
    " split instead of a horizontal one (vim 6 and up only)
    "
    " (Note: you may wish to put a 'set splitright' in your .vimrc
    " if you prefer the new window on the right instead of the left

    nmap <C-@><C-@>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-@><C-@>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>    
    nmap <C-@><C-@>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>    
    nmap <C-@><C-@>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>


    """"""""""""" key map timeouts
    "
    " By default Vim will only wait 1 second for each keystroke in a mapping.
    " You may find that too short with the above typemaps.  If so, you should
    " either turn off mapping timeouts via 'notimeout'.
    "
    "set notimeout 
    "
    " Or, you can keep timeouts, by uncommenting the timeoutlen line below,
    " with your own personal favorite value (in milliseconds):
    "
    "set timeoutlen=4000
    "
    " Either way, since mapping timeout settings by default also set the
    " timeouts for multicharacter 'keys codes' (like <F1>), you should also
    " set ttimeout and ttimeoutlen: otherwise, you will experience strange
    " delays as vim waits for a keystroke after you hit ESC (it will be
    " waiting to see if the ESC is actually part of a key code like <F1>).
    "
    "set ttimeout 
    "
    " personally, I find a tenth of a second to work well for key code
    " timeouts. If you experience problems and have a slow terminal or network
    " connection, set it higher.  If you don't set ttimeoutlen, the value for
    " timeoutlent (default: 1000 = 1 second, which is sluggish) is used.
    "
    "set ttimeoutlen=100

endif

set listchars+=tab:▸\ ,trail:⋅,nbsp:⋅
