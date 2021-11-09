set nocompatible
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/scrooloose/nerdtree.git'
" Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'liuchengxu/vista.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'https://github.com/tpope/vim-fugitive.git'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'git@github.com:Mizux/vim-colorschemes.git'

" Plug 'lukas-reineke/indent-blankline.nvim', {branch = 'lua'}
Plug 'sheerun/vim-polyglot'

Plug 'OmniSharp/omnisharp-vim'
Plug 'git@github.com:dense-analysis/ale.git'

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

Plug 'Eric-Song-Nop/vim-glslx'
Plug 'puremourning/vimspector'


" Track the engine.
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/Yggdroot/indentLine'
" Plug 'git@github.com:kyazdani42/nvim-tree.lua.git'   " 0.5
" Plug 'git@github.com:lukas-reineke/indent-blankline.nvim.git'   " 0.5
" Plug 'https://github.com/adelarsq/neoline.vim'   " 0.5
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'
" Plug 'ryanoasis/vim-devicons'
Plug 'git@github.com:yamatsum/nvim-nonicons.git'
Plug 'nvim-lua/plenary.nvim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'mileszs/ack.vim'
Plug 'https://github.com/heavenshell/vim-pydocstring.git'

Plug 'norcalli/nvim-colorizer.lua'

Plug 'frazrepo/vim-rainbow'

"""color scheme
Plug 'https://github.com/lifepillar/vim-wwdc17-theme.git'
Plug 'https://github.com/arzg/vim-colors-xcode.git'
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'

" with tree-sitter
Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-nightfly-guicolors'

""" mark down
Plug 'davidgranstrom/nvim-markdown-preview'


call plug#end()



set diffexpr=MyDiff()"{{{
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set autoread
set cursorline		""hilight current line

if (has("termguicolors"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors
endif

set nu
filetype on
filetype plugin indent on
filetype indent plugin on
set hlsearch
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowrap
set expandtab


" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colo ayu
colo pencil

" colo xcodelighthc
" colo flattened_light
" colo challenger_deep
" There are 5 different styles of material available:
" colo material
" darker
" lighter
" oceanic
" palenight
" deep ocean
""""" Set the desired style using:
let g:material_style = 'oceanic'

set background=light

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"file encoding
set fileencodings=utf8,ucs-bom,gbk,cp936,gb18030
"set termencoding=utf-8,gbk,ucs-bom
set encoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" format

" session"{{{
function! SaveSession()
    let ch = confirm("save session ?", "&Yes\n&No", 1)
    if ch == 1
        exe ":wa!"
        exe "mksession! .session.vim"
    else
        echo "save session cancle."
    endif
endfunction
set sessionoptions=buffers,curdir,resize,folds,tabpages,slash,resize,winpos,winsize
nmap <F2> :call SaveSession()<CR>
function! LoadSession(confirmed)
    let aconf = a:confirmed
    if aconf != 1
        let aconf = confirm("load last session ?", "&Yes\n&No", 1)
    endif
    if aconf == 1
        exe ":so .session.vim"
    else
        echo "load seesion cancled."
    endif
endfunction
nmap <F3> :call LoadSession(0)<CR>
"}}}
let g_my_python_debug = ''
function! DebugPython()
    let g:g_my_python_debug = input('python3 debug:', expand('%'), 'file')
    sp
    let cmd = "terminal ipdb3 -c 'b " . expand('%') . ":" . line('.') . "' -c continue " . g:g_my_python_debug
    echo 'cmd:' cmd
    exe cmd
endfunction

function! RunPython()
    if len(g:g_my_python_debug) < 1
        let g:g_my_python_debug = input('python3 run:', expand('%'), 'file')
    endif
    sp
    exe 'terminal python3 ' . g:g_my_python_debug
endfunction

autocmd FileType python set makeprg=python3\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python nmap ¡ :call DebugPython()<CR>
autocmd FileType python nmap ™ :call RunPython()<CR>

function! Format_Python()
    let filtePattern = [":%s/\\s*:\\s*/:/g", ":%s/(\\s*/(/g", ":%s/\\s*)/)/g", ":%s/[\\s*/[/g", ":%s/\\s*]/]/g", ":%s/{\\s*/{/g", ":%s/\\s*}/}/g", ":%s/\\s*$//g"]
    call add(filtePattern, ":%s/\t/    /g")
    for  fp in filtePattern
        try
            exec fp
        catch E486
        endtry
    endfor
endfunction

autocmd FileType python nmap <leader>fm :call Format_Python()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comment line."
function! CommentLine()"{{{
    let commtdict = {
                \ 'lua': '--',
                \ 'toml': '#',
                \ 'java': '//',
                \ 'c': '//',
                \ 'cpp': '//',
                \ 'h': '//',
                \ 'cs': '//',
                \ 'typescript': '//',
                \ 'js': '//',
                \ 'javascript': '//',
                \ 'omnijs': '//',
                \ 'python': '#',
                \ 'vim': '"',
                \ 'shader': '//',
                \ 'glsl': '//',
                \ 'sh': '#',
                \ 'objc': '//',
                \}
    let ft = &filetype
    let commtchar = ''
    if has_key(commtdict, ft)
        let commtchar = commtdict[ft]
    else
        echo 'comment [' . ft . '] type is not supported yet!'
        return
    endif

    let commentPattern = '^\s*\t*' . commtchar . '\s*'
    let line = getline('.')
    if strlen(substitute(line, '[\s\t]', '', '')) < 1
        return
    endif
    " comment added.
    if line =~ commentPattern
        let idx = stridx(line, commtchar, 0)
        let lineIndent = strpart(line, 0, idx)
        let content = strpart(line, idx + strlen(commtchar), strlen(line) - strlen(commtchar) - idx)
        let content = substitute(content, '^\s*\t*', '', '')
        call setline('.', lineIndent . content)
        " uncomment.
    else
        let noindentLine = substitute(line, '^\s*\t*', '', '')
        let idx = stridx(line, noindentLine)
        let newline = strpart(line, 0, idx) . commtchar . ' ' . noindentLine
        call setline('.', newline)
    endif
endfunction"}}}
noremap  tm :call CommentLine()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace current word.
vmap tr "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap tr$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>
map  tu  zz:e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find word in directories."{{{
let g:ackprg = 'ag --nogroup --nocolor --column'
let g_my_search_replace_all = 0
let g_my_search_keyword = ''
function! SearchWordGlobal(keyword)
    let kw = a:keyword
    if len(kw) < 1
        normal! gv"xy
        let kw = @x
    endif
    """" escap
    let toescaps = [".", "/", "'", "[", "]"]
    for tk in toescaps
        let tidx = stridx(kw, tk)
        if tidx >= 0
            let kw = strpart(kw, 0, tidx) . '\' . strpart(kw, tidx, len(kw))
        endif
    endfor
    let extname = input("find with extension:", expand("%:e"))
    let g:ackprg = 'ag --nogroup --nocolor --column --' .  extname
    let cmdstr = "Ack " . kw . ""
    if isdirectory('Assets')
        let cmdstr = cmdstr . " ./Assets"
    endif
    exe cmdstr
    let g:g_my_search_keyword = kw
    " let wid = win_getid()
    " win_gotoid(wid)
    let qflst = getqflist()
    if len(qflst) > 0
        copen
        let g:g_my_search_replace_all = len(qflst)
    endif
    " echo 'search: [' . kw . "] matches " . len(qflst)
endfunction

nmap <silent> Tf :call SearchWordGlobal(expand("<cword>"))<CR>
vmap <silent> Tf :call SearchWordGlobal('')<CR>

function! SearchWordInCurrentFile(kw)
    let keyword = a:kw
    if len(keyword) < 1
        normal! gv"xy
        let keyword = @x
    endif
    exe "vimgrep /" . keyword . '/ %'
    " echo "CAg " . kw . ' ./**/*.' . expand("%:e")
    " let g:g_my_search_keyword = kw
    " let wid = win_getid()
    " win_gotoid(wid)
    " let qflst = getqflist()
    " if len(qflst) > 0
        " copen
        " let g:g_my_search_replace_all = len(qflst)
    " endif
    " echo 'search: [' . kw . "] matches " . len(qflst)
endfunction
nmap <silent> tf :call SearchWordInCurrentFile(expand("<cword>"))<CR>
vmap <silent> tf :call SearchWordInCurrentFile('')<CR>

" replace words in directories
function! ReplaceWordGlobal( noConfirm, matchWord)
    let qflst = getqflist()
    let g:g_my_search_replace_all = len(qflst) > 0
    if( g:g_my_search_replace_all == 0)
        return
    endif

    call inputsave()

    if(a:matchWord == 0 )
        let newkw = input("Replace [" . g:g_my_search_keyword . "]by ",  '')
        let replaceCmd =  ":%s/" . g:g_my_search_keyword . "/" . newkw
    else
        let replaceCmd =  ":%s/\\<" . g:g_my_search_keyword . "\\>/" . newkw
        let newkw = input("Replace Word[" . g:g_my_search_keyword . "]by ",  '')
    endif

    call inputrestore()

    if a:noConfirm == 0
        let replaceCmd=  replaceCmd . "/g"
    else
        let replaceCmd=  replaceCmd . "/gc"
    endif
    call inputrestore()
    let bufnums = []
    for qf in getqflist()
        if index(bufnums, qf.bufnr) > -1
            continue
        endif
        call add( bufnums, qf.bufnr )
    endfor
    echo 'fuck'  bufnums
    for bufnum in bufnums
        exe ":b" . bufnum
        exe replaceCmd
    endfor
endfunction

nmap <silent> zr :call ReplaceWordGlobal(1, 0)<CR>
nmap <silent> zw :call ReplaceWordGlobal(1, 1)<CR>
"}}}
" find word in correspond file
"function! SearchWordInCorrespondFile()
"let cw ="/" . input("corresponding search: ", expand("<cword>")) . "/g"
"let distPath = "" . expand("%<.cpp") . " " expand("%<.h") . " " . expand("%<.c")
"exe "vimgrep " . cw . " " . distPath . ""
"exe ":cw"
"endfunction
"autocmd FileType c,cpp nmap tof :call SearchWordInCorrespondFile()<CR>
"
" swap word
function SplitAndSwap()
    normal! gv"xy
    let keyword = @x

    let istailc = 0
    if keyword[ len(keyword) -1] == ';'
        let istailc = 1
    endif

    let words = split(keyword, '[:=;]')
    " echo words
    let outs = words[1] . " " . words[0]
    if istailc
        let outs = outs . ";"
    endif 
    for tw in words[2:]
        let outs = outs . tw
    endfor
    " echo "rslt: " . outs
    call setline(".", substitute(getline("."), keyword, outs, ""))
    return outs
endfunction
vmap <silent> ts: call SplitAndSwap()<CR>

function! ConvertTs2cs()
    let cmds = [
                \':%s/console.error(/Log.Error(/g',
                \':%s/console.log(/Log.Info(/g',
                \':%s/(\s*`/($"/gc',
                \':%s/^\s*\t*`/$"/gc',
                \':%s/`/"/g',
                \':%s/${/{/g',
                \':%s/\<let\>/var/g',
                \':%s/\.length/.Length/g',
                \':%s/\.clear/.Clear/g',
                \':%s/\<number\>/float/g',
                \':%s/\.push/.Add/g',
                \':%s/^\s*export\s\+function\s\+/public void /g',
                \':%s/^\s*export\s\+namesapce/public/g',
                \':%s/^\s*export\s\+/public/g',
                \':%s/math.floor/Mathf.Floor/g',
                \':%s/math.abs/Mathf.Abs/g',
                \':%s/math.random()/UnityEngine.Random.value/g',
                \':%s/Map</Dictionary</g',
                \':%s/\<toString\>/ToString/g',
                \]
    " echo cmds
    for tc in cmds
        try
            echo "regx:" . tc
            exe tc
        catch E486
            " echo "no need fix"
        endtry
    endfor
    return
endfunction

" hex model
nnoremap <silent> hex  :%!xxd<CR>
nnoremap <silent> nhex  :%!xxd -r<CR>

" quick fixs
map <silent> tcn :cn<CR>
map <silent> tcp :cp<CR>
map <silent> tco :copen<CR>
map <silent> tcl :cclose<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for folding  {{{
set foldcolumn=2
"set foldmethod=indent
set foldmethod=marker
set foldmarker={{{,}}}
function! CreateFoldByRegion(regionSign)
    let startLineNum = line('.')
    while stridx(getline(startLineNum), a:regionSign) < 0
        let startLineNum = startLineNum + 1
        if startLineNum == line('$')
            echo "reach end of file, can not create folding!"
            return
        endif
    endwhile
    exe "normal ^f" . a:regionSign
    if startLineNum == line('.')			"is current line.
        exe "normal V%zf"
    else
        let moveDown = startLineNum - line('.')
        exe "normal V" . moveDown . "j%zf"
    endif
endfunction
autocmd FileType c,cpp,h,cs nmap <silent> tzf :call CreateFoldByRegion('{')<CR>
nmap <silent> tza^ :call setline(v:lnum, getline(v:lnum) . "\t\t//{{{")<CR>
nmap <silent> tza$ :call setline(v:lnum, getline(v:lnum) . "\t\t//}}}")<CR>
""" }}}

" add file discription."{{{
function! AddDescription()
    echo ' in file description'
    let lineCnt = len(getbufline(bufname("%"), 0, "$"))
    if lineCnt > 1
        return 0
    endif
    let commtdict = {
                \ 'c': '//',
                \ 'ts': '//',
                \ 'cpp': '//',
                \ 'h': '//',
                \ 'cs': '//',
                \ 'python': '#',
                \ 'vim': '"',
                \ 'typescript': '//',
                \}
    let ft = &filetype
    let commtchar = ''
    if has_key(commtdict, ft)
        let commtchar = '' . commtdict[ft]
    else
        echo ft . ' type is not supported yet!'
        return
    endif

    let time = commtchar . " @" .  strftime("%c")
    let file =  commtchar . ' ' . expand("%")
    let author =  commtchar . " created by yuhui."
    let description = [file, commtchar, commtchar, author, time, '']
    let exfn = expand('%:e')
    if  exfn == "h"
        let macro = toupper(expand("%"))
        let tmacro = "#ifndef " . strpart(macro, 0, strlen(macro)-2) . "_H"
        ""echo macro
        call add(description, tmacro)
        ""echo description
        let macro = "#define " . strpart(macro, 0, strlen(macro)-2) . "_H"
        call add(description, macro)
        call add(description, " ")
        call add(description, "{")
        call add(description, "}")
        call add(description, "#endif")
    elseif exfn == 'c' || exfn == 'cpp'
        let isSrcFile = tolower(strpart(file, strlen(file) - 4, 4)) == '.cpp' ? 4 : tolower(strpart(file, strlen(file) - 2, 2)) == '.c' ? 2 : 0
        if isSrcFile > 0
            let theader = expand("%")
            let theader = strpart(file, 1, strlen(file) - isSrcFile)
            let theader = '#include "' . theader . 'h"'
            call add(description, theader)
            call add(description, '')
        endif
    elseif exfn == 'py'
        call insert(description, "#!/usr/bin/env python3", 0)
        call insert(description, "# -*- coding: utf-8 -*-", 1)
    else

    endif
    let fail= append(0, description)
    if fail
        return 1
    endif
endfunction
autocmd FileType typescript,c,cpp,h,cs,python exe "call AddDescription()"
"}}}
""""""""""""""""""""
" coc diagnostic status
function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status line
if  exists('g:gui_oni')
    set mouse=a
    " Turn off statusbar, because it is externalized
    " set noshowmode
    "set noruler
    " set laststatus=0
    " set noshowcmd
    set laststatus=2
    set statusline=%=%{"|"}%f\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('【%s】','','f')}%=\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}
else
    " let g:airline#extensions#coc#enabled = 1
    " let g:airline#extensions#ale#enabled = 1
    set laststatus=2
    set statusline=\|%-10f\ %y%=buf:%n%h%m%r
    set statusline+=%<%{FugitiveHead()}
    " set statusline+=%<%{'win:' . winnr()}
    " set statusline+=%{SyntasticStatuslineFlag()}
    " let g:airline_section_z = '%l/%L|B%n' 
    " set statusline+=%{StatusDiagnostic()}
    set statusline+=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\"}
    set statusline+=%k\|%(%l/%L%)\|%P
endif

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
nnoremap <silent> Tn :let curPath =expand("%:h:p")<Bar> exec "NERDTree " . (len(curPath)<1 ?  "." : curPath)<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" Vista"{{{
nnoremap <silent> Tv :Vista!! <CR>
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"open current file's header or cpp. toc : t mode o open c corespond."{{{
function! OpenFile2Cword(cfname)
    if filereadable(a:cfname)
        let kw = expand("<cword>")
        exe "vs " . a:cfname
        let searchcmd = "vimgrep /" . kw . "/ %"
        exe searchcmd
        exe "normal zz"
    else
        let ch = confirm("Do not exists, create file ?", "&Yes\n&No", 1)
        if ch = 1
            exe "vs " . a:cfname
        endif
    endif
endfunction

function! OpenCorrespondFile()
    let fname=expand("%")
    let idot=strridx(fname, ".")
    if idot >0
        let exh =tolower(strpart(fname, idot+1, 1))
        let mname = strpart(fname, 0, idot)
        if exh == "c"
            let cfname = mname . ".h"
        elseif exh == "cpp"
            let cfname = mname . ".h"
        elseif exh == "h"
            let cfname = mname . ".c"
            if filereadable(cfname)
                let cfname = mname . ".c"
            else
                let cfname = mname . ".cpp"
            endif
        endif
        call OpenFile2Cword(cfname)
    else
        echo fname . "is not a valid source file"
    endif
endfunction
autocmd FileType c,cpp,inl nnoremap <silent> toc : call OpenCorrespondFile()<CR>
"}}}
""""""""""""""""""""""""""""""""""""""
"diff
set diffopt+=iwhite
set diffexpr=""
"map tdf :let tg=input("compare to", expand("%<"),

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" synatx
"au FileType frag,vert,fp,vp,glsl,vsh,fsh setf glsl
syntax enable
syntax sync minlines=256
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color scroll
nmap <silent> <leader>cs :SCROLL<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
" AirlineTheme oceanicnextlight

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" higroup

highlight mhl1 ctermfg=red guifg=red ctermbg=gray
highlight mhl2 ctermfg=green guifg=green ctermbg=gray
highlight mhl3 ctermfg=blue guifg=blue ctermbg=gray
highlight CocErrorSign ctermbg=red ctermfg=white guifg=blue 
let _multiHiNames = ["mhl1", "mhl2", "mhl3"]
let _multiHiKws = {}
function! ExtralHilight(kw)
    if has_key(g:_multiHiKws, a:kw)
        let hmark = g:_multiHiKws[a:kw]
        call matchdelete(hmark)
        call remove(g:_multiHiKws, a:kw)
        echo "remove hilight [" . a:kw . "] remain " . len(g:_multiHiKws)
    else
        let hidx = len(g:_multiHiKws)
        if hidx >= len(g:_multiHiNames)
            let hidx = len(g:_multiHiNames) - 1
        endif
        let hname = g:_multiHiNames[hidx]
        let m = matchadd(hname, a:kw)
        let g:_multiHiKws[a:kw] = m
        echo "add hilight [" . a:kw . "] " . len(g:_multiHiKws)
    endif
endfunction
nmap <leader>h :call ExtralHilight(expand("<cword>"))<CR>
vmap <leader>h "xy:call ExtralHilight(@x)<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" terminal
function! OpenTerminalSplit(cmd)
    exe a:cmd
    exe ":terminal"
    setlocal nowrap
endfunction
nmap zm :call OpenTerminalSplit('20split')<CR>
nmap zvm :call OpenTerminalSplit('vs')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>
nnoremap <C-b> :Buffers<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "
" vim indent
let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " omnisharp
let g:OmniSharp_server_install='/Users/yuhui/work/tool/omnisharp-osx/'
let g:OmniSharp_server_path='/Users/yuhui/work/tool/omnisharp-osx/omnisharp/OmniSharp.exe'
let g:OmniSharp_server_display_loading = 1
let g:OmniSharp_server_use_mono = 1
let g:OmniSharp_server_stdio = 1
let g:OmniSharp_selector_ui = 'fzf'
let g:OmniSharp_start_server = 1
" let g:OmniSharp_selector_findusages = 'fzf'
let g:OmniSharp_popup = 1
" Update semantic highlighting after all text changes
let g:OmniSharp_highlight_types = 3
" Update semantic highlighting on BufEnter and InsertLeave
" let g:OmniSharp_highlight_types = 2
autocmd CursorHold *.cs OmniSharpTypeLookup
autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
autocmd FileType cs nmap <silent> <buffer> Fu <Plug>(omnisharp_find_usages)
autocmd FileType cs nmap <silent> <buffer> Ft <Plug>(omnisharp_find_type)
autocmd FileType cs nmap <silent> <buffer> Fs <Plug>(omnisharp_find_symbol)
autocmd FileType cs nmap <silent> <buffer> Fa <Plug>(omnisharp_code_actions)
autocmd FileType cs nmap <silent> <buffer> Fx <Plug>(omnisharp_fix_usings)
autocmd FileType cs nmap <silent> <buffer> Fk <Plug>(omnisharp_documentation)
autocmd FileType cs nmap <silent> <buffer> Fm <Plug>(omnisharp_code_format)
autocmd FileType cs nmap <silent> <buffer> Fr <Plug>(omnisharp_rename)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE

let g:ale_linters = { 'cs': ['OmniSharp'] }

" call ale#linter#Define('cs', {
" \   'name': 'omnisharp',
" \   'lsp': 'stdio',
" \   'executable': '/Users/yuhui/work/tool/omnisharp-osx/run',
" \   'command': '%e run',
" \   'project_root': '.',
" \})
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! NearestMethodOrFunction() abort
    " return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}|

" By default vista.vim never run if you don't call it explicitly.
" "
" " If you want to show the nearest function in your statusline
" automatically,
" " you can add the following line to your vimrc
" let g:vista#renderer#enable_icon = 1
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" vmap t=  <Plug>(coc-format-selected)
" nmap t=  <Plug>(coc-format-selected)

" devicons
let g:webdevicons_enable_nerdtree = 1
" let g:webdevicons_enable_airline_tabline = 0
" let g:webdevicons_enable_airline_statusline = 0
let g:webdevicons_enable_ctrlp = 0

""""""""""""""""""""
" doge 
"
let g:doge_enable_mappings = 1
let g:doge_mapping_comment_jump_forward = 1
let g:doge_mapping_comment_jump_backward = 1

""""""""""
" snippet
let g:vsnip_snippet_dir = expand('~/work/yuhuiVimConf/vsnips')
" NOTE: You can use other key to expand snippet.

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

" Jump forward or backward
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

" Select or cut text to use as $TM_SELECTED_TEXT in the next snippet.
" See https://github.com/hrsh7th/vim-vsnip/pull/50
nmap        s   <Plug>(vsnip-select-text)
xmap        s   <Plug>(vsnip-select-text)
nmap        S   <Plug>(vsnip-cut-text)
xmap        S   <Plug>(vsnip-cut-text)

"""""""""""""""""""""
" colorizer.lua
lua require'colorizer'.setup()
""""""""""""""""""""
" vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>vl :call vimspector#Launch()<CR>
nmap <leader>vr :VimspectorReset<CR>
nmap <leader>ve :VimspectorEval
nmap <leader>vw :VimspectorWatch
nmap <leader>vo :VimspectorShowOutput
nmap <leader>vi <Plug>VimspectorBalloonEval
xmap <leader>vi <Plug>VimspectorBalloonEval
let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]
"" launch debug
nmap † <Plug>VimspectorContinue
"" toggle breakpoint
nmap ∫ <Plug>VimspectorToggleBreakpoint
"" step into
nmap ˆ <Plug>VimspectorStepInto
"" step out
nmap ø <Plug>VimspectorStepOut
"" step over
nmap ˜ <Plug>VimspectorStepOver
"" up frame  | Move up a frame in the current call stack                 | 'vimspector#UpFrame()'                                            |
nmap ˚ <Plug>VimspectorUpFrame
"" down frame | Move down a frame in the current call stack               | 'vimspector#DownFrame()'                                          |" down frame
nmap ∆ <Plug>VimspectorDownFrame

""""""""""""""""""""
" clear cocos temp files
function! ClearCreatorTemps()
    let cmd = "terminal ls; echo '-------deleted----------'; rm -rf ./local ./temp ./library;ls"
    " echo 'cmd:' cmd
    exe cmd
endfunction

set spelllang=en,cjk


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
" let g:airline#extensions#coc#enabled = 1
" if hidden is not set, TextEdit might fail.
set hidden

let g:coc_global_extensions=['coc-omnisharp']

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap Trn <Plug>(coc-rename)

" Remap for format selected region
" xmap lf  <Plug>(coc-format-selected)
" nmap lf  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType python,typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `laap` for current paragraph
xmap ta  <Plug>(coc-codeaction-selected)
nmap ta  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap tac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap tqf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%<%{coc#status()}%{get(b:,'coc_current_function','')}%<

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction


function! SetupReHost()
    if writefile([v:servername], '/Users/yuhui/.config/nvim/nvimserver')
        echomsg 'nvim 服务器名称写出失败'
    endif
endfunction

function! OpenUnityLog() 
    exec "vert new"
    setlocal buftype=nofile
    setlocal noswapfile
    exec 'read ~/Library/Logs/Unity/Editor.log'
    let cmds = [
                \':g/^\s*com.unity.*/d',
                \':g/^Unity\w\+.*/d',
                \':g/^(Filename:.*/d',
                \':g/^BB.Log.*/d',
                \]
    " echo cmds
    for tc in cmds
        try
            echo "regx:" . tc
            exe tc
        catch E486
            " echo "no need fix"
        endtry
    endfor


endfunction
command  OpenUlog call OpenUnityLog()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" rainbow bracket
au FileType c,cpp,objc,objcpp,cs call rainbow#load()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git
map <leader>gu :G pull<CR>
map <leader>gp :G push<CR>


