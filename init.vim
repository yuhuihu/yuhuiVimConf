set nocompatible
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'liuchengxu/vista.vim'

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'pappasam/coc-jedi', { 'do': 'yarn install --frozen-lockfile && yarn build' }

Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'mhartington/formatter.nvim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }  " tooooooo slow.

" Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
" - shell repl
" - nvim lua api
" - scientific calculator
" - comment banner
" - etc

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'git@github.com:Mizux/vim-colorschemes.git'
" Plug 'romgrk/nvim-treesitter-context'


Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'sheerun/vim-polyglot'

Plug 'OmniSharp/omnisharp-vim'
" Plug 'git@github.com:dense-analysis/ale.git'

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

Plug 'Eric-Song-Nop/vim-glslx'
Plug 'mfussenegger/nvim-dap'
Plug 'leoluz/nvim-dap-go'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'rcarriga/nvim-dap-ui'
" Plug 'puremourning/vimspector'


" Track the engine.
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
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
Plug 'folke/lsp-colors.nvim'


" with tree-sitter
Plug 'marko-cerovac/material.nvim'
Plug 'bluz71/vim-nightfly-guicolors'

""" mark down
Plug 'davidgranstrom/nvim-markdown-preview'

"""" neovim lua plugin
Plug 'mjlbach/neovim-ui'
Plug 'nvim-lua/plenary.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'kyazdani42/nvim-tree.lua'
" Plug 'TimUntersberger/neogit'

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


set background=dark
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" colo ayu
" colo xcodewwdc
" colo pencil
" colo lucario
" colo slate
colo nightfly

" colo xcodedark
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
" set sessionoptions=buffers,curdir,resize,folds,tabpages,slash,resize,winpos,winsize
set sessionoptions=curdir,resize,folds,tabpages,slash,resize,winpos,winsize,terminal
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
let g_my_runner2files = {}
function! DebugPython()
    let bname = bufnr()
    let exname = ''
    if has_key(g:g_my_runner2files, bname)
        let exname = g:g_my_runner2files[bname]
    end
    let exname = input('python3 debug:', len(exname) > 0 ? exname : expand('%'), 'file')
    let g:g_my_runner2files[bname]=exname
    " eval("let g:g_my_runner2files." . bname . " = exname")
    vs
    let cmd = "terminal pdbr -c 'b " . expand('%') . ":" . line('.') . "' -c continue " . exname
    " echo 'cmd:' cmd
    exe cmd
endfunction

function! RunCmdForCurFile()
    let bname = bufnr()
    let exname = ''
    if has_key(g:g_my_runner2files, bname)
        let exname = g:g_my_runner2files[bname]
    end
    let ftype2runners = {
                \ 'go': 'go',
                \ 'python': 'python3',
                \ 'sh': 'sh',
                \}
    let ft = &filetype
    let runner = ''
    if has_key(ftype2runners, ft)
        let runner = ftype2runners[ft]
    else
        echo 'no runner for [' . ft . '] type is not supported yet!'
        return
    endif

    let exname = input(runner . ' :', len(exname) > 0 ? exname : expand('%'), 'file')
    let g:g_my_runner2files[bname]=exname
    " eval("let g:g_my_runner2files." . bname . " = exname")
    7sp
    exe 'terminal ' . runner . ' ' . exname
endfunction

autocmd FileType python set makeprg=python3\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
" autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python nmap ¡ :call DebugPython()<CR>
nmap ™ :call RunCmdForCurFile()<CR>

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

" autocmd FileType python nmap <leader>fm :call Format_Python()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comment line."
function! CommentLine()"{{{
    let commtdict = {
                \ 'lua': '--',
                \ 'toml': '#',
                \ 'yaml': '#',
                \ 'yaml.docker': '#',
                \ 'java': '//',
                \ 'go': '//',
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
"
function EscapeLitters(win)
    let kw = a:win
    let toescaps = [".", "/", "'", "[", "]"]
    for tk in toescaps
        let tidx = stridx(kw, tk)
        if tidx >= 0
            let kw = strpart(kw, 0, tidx) . '\' . strpart(kw, tidx, len(kw))
        endif
    endfor
    return kw
endfunction

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
    let kw = EscapeLitters(kw)
    let hint = "find [" . kw . "] by extension:"
    let extname = input(hint, expand("%:e"))
    if len(extname) == 0 || extname == "*" 
        let g:ackprg = 'ag -a --nogroup --nocolor --column '
    else
        let g:ackprg = 'ag --nogroup --nocolor --column --' .  extname
    endif
    let cmdstr = "Ack '" . kw . "'"
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
    let keyword = EscapeLitters(a:kw)
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
    set statusline+=\|%<%{FugitiveHead()}\|
    " set statusline+=%<%{'win:' . winnr()}
    " set statusline+=%{SyntasticStatuslineFlag()}
    " let g:airline_section_z = '%l/%L|B%n' 
    " set statusline+=%{StatusDiagnostic()}
    set statusline+=%{(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"\|\"}
    set statusline+=%k%(%l/%L%)\|%P
endif

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
" nnoremap <silent> Tn :let curPath =expand("%:h:p")<Bar> exec "NvimTreeFindFileToggle " . (len(curPath)<1 ?  "." : curPath)<CR>
nnoremap <silent> Tn :NvimTreeFindFileToggle<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" Vista"{{{
" How each level is indented and what to prepend.
" This could make the display more compact or more spacious.
" e.g., more compact: ["▸ ", ""]
" Note: this option only works for the kind renderer, not the tree renderer.
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

" Executive used when opening vista sidebar without specifying it.
" See all the avaliable executives via `:echo g:vista#executives`.
let g:vista_default_executive = 'ctags'

" Set the executive for some filetypes explicitly. Use the explicit executive
" instead of the default one for these filetypes when using `:Vista` without
" specifying the executive.
let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'php': 'vim_lsp',
  \ 'python': 'vim_lsp',
  \ }

" Declare the command including the executable and options used to generate ctags output
" for some certain filetypes.The file path will be appened to your custom command.
" For example:
let g:vista_ctags_cmd = {
      \ 'haskell': 'hasktags -x -o - -c',
      \ }

" To enable fzf's preview window set g:vista_fzf_preview.
" The elements of g:vista_fzf_preview will be passed as arguments to fzf#vim#with_preview()
" For example:
let g:vista_fzf_preview = ['right:50%']
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
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
    " if isdirectory("./venv")
        " exe ":terminal source ./venv/bin/activate"
    " else
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
" let g:OmniSharp_server_install='/Users/yuhui/work/tool/omnisharp-osx/'
" let g:OmniSharp_server_path='/Users/yuhui/work/tool/omnisharp-osx/omnisharp/OmniSharp.exe'
" let g:OmniSharp_server_display_loading = 1
" let g:OmniSharp_server_use_mono = 1
" let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_selector_ui = 'fzf'
" let g:OmniSharp_start_server = 1
" let g:OmniSharp_selector_findusages = 'fzf'
" let g:OmniSharp_popup = 1
" " Update semantic highlighting after all text changes
" let g:OmniSharp_highlight_types = 3
" " Update semantic highlighting on BufEnter and InsertLeave
" let g:OmniSharp_highlight_types = 2
" autocmd CursorHold *.cs OmniSharpTypeLookup
" autocmd FileType cs nmap <silent> <buffer> gd <Plug>(omnisharp_go_to_definition)
" autocmd FileType cs nmap <silent> <buffer> Fu <Plug>(omnisharp_find_usages)
" autocmd FileType cs nmap <silent> <buffer> Ft <Plug>(omnisharp_find_type)
" autocmd FileType cs nmap <silent> <buffer> Fs <Plug>(omnisharp_find_symbol)
" autocmd FileType cs nmap <silent> <buffer> <leader><space> <Plug>(omnisharp_code_actions)
" autocmd FileType cs nmap <silent> <buffer> Fx <Plug>(omnisharp_fix_usings)
" autocmd FileType cs nmap <silent> <buffer> Fk <Plug>(omnisharp_documentation)
" autocmd FileType cs nmap <silent> <buffer> Fm :OmniSharpCodeFormat<CR>
" autocmd FileType cs nmap <silent> <buffer> Fr <Plug>(omnisharp_rename)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE

" let g:ale_linters = { 'cs': ['OmniSharp'] }

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
" let g:vimspector_base_dir=expand( '$HOME/.config/nvim/vimspector-config' )
" let g:vimspector_enable_mappings = 'HUMAN'
" nmap <leader>vl :call vimspector#Launch()<CR>
" nmap <leader>vr :VimspectorReset<CR>
" nmap <leader>ve :VimspectorEval
" nmap <leader>vw :VimspectorWatch
" nmap <leader>vo :VimspectorShowOutput
" nmap <leader>vi <Plug>VimspectorBalloonEval
" xmap <leader>vi <Plug>VimspectorBalloonEval
" let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-go', 'CodeLLDB', 'vscode-node-debug2' ]
"" launch debug  alt+t
" nmap † <Plug>VimspectorContinue
"" toggle breakpoint  alt+b
" nmap ∫ <Plug>VimspectorToggleBreakpoint
"" step into  alt+i
" nmap ˆ <Plug>VimspectorStepInto
"" step out alt+o
" nmap ø <Plug>VimspectorStepOut
"" step over alt+n
" nmap ˜ <Plug>VimspectorStepOver
"" up frame  | Move up a frame in the current call stack      alt+k           | 'vimspector#UpFrame()'                                            |
" nmap ˚ <Plug>VimspectorUpFrame
"" down frame | Move down a frame in the current call stack    alt+∆           | 'vimspector#DownFrame()'                                          |" down frame
" nmap ∆ <Plug>VimspectorDownFrame

""""""""""""""""""""
" clear cocos temp files
function! ClearCreatorTemps()
    let cmd = "terminal ls; echo '-------deleted----------'; rm -rf ./local ./temp ./library;ls"
    " echo 'cmd:' cmd
    exe cmd
endfunction

set spelllang=en,cjk


function! SetupReHost()
    if writefile([v:servername], '/Users/yuhui/.config/nvim/nvimserver')
        echomsg 'nvim 服务器名称写出失败'
    endif
endfunction
command SetUnitEditor call SetupReHost()

function! OpenAndroidLog() 
    exec "vert new"
    exec "terminal adb logcat '*:S' Unity -v color>~/Downloads/adblog.txt"
    exec 'read ~/Downloads/adblog.txt'
    " setlocal buftype=nowrite
    " setlocal noswapfile
    " let cmds = [
                " \':g/^\s*/d',
                " \]
    " echo cmds
    " for tc in cmds
        " try
            " echo "regx:" . tc
            " exe tc
        " catch E486
            " echo "no need fix"
        " endtry
    " endfor

endfunction
command  OpenAlog call OpenAndroidLog()


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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plush by text
function! PlusTxt(pat, value)
    let cline = getline('.')
    let newline = substitute(cline, a:pat, (split(cline[:-2], ' ')[2] + a:value) . ',', '')
    call setline('.',  newline)
endfunction

command PlusTxt call PlusTxt('\d\+', 10)
set completeopt=menu,menuone,noselect

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim lsp
" some shortcuts
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader><space>    <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> Tr    <cmd>lua vim.lsp.buf.renname()<CR>
nnoremap <silent> <leader>F    <cmd>lua vim.lsp.buf.formatting()<CR>
" nnoremap <silent> <space>a    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python 

" use omni completion provided by lsp
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nnoremap <silent> <leader>fh :DiffviewFileHistory<CR>

set completeopt=menu,menuone,noselect
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    mapping = {
      ['<C-l>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-h>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      -- ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
    sources = cmp.config.sources(
    {
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    },
    {
        { name = 'buffer' },
    }),
    {
        {name = 'cmp_tabnine'},
    },
    -- completion = {
        -- autocomplete = true, -- disable auto-completion.
    -- },
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  require('lspconfig').pylsp.setup {
      filetypes = {"python"},
      settings = {
         formatCommand = {"black"}
         -- pyls = { 
           --   plugins = { 
             --     pycodestyle =  { enabled = false }, 
               --   pylint =  { enabled = false }
                 -- }
             -- }
          }
  }
  require('lspconfig')['sumneko_lua'].setup {
    settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Setup your lua path
            path = 'lua-language-server',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      }
  }
  require('lspconfig')['vimls'].setup { }
  -- omnisharp lsp config
  require'lspconfig'.omnisharp.setup {
      capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function(_, bufnr)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/Users/yuhui/work/tool/omnisharp-osx/run", "--languageserver" , "--hostPID", tostring(pid) },
  }

  require('lspconfig').gopls.setup{
  cmd = {'gopls'},
  -- for postfix snippets and analyzers
  capabilities = capabilities,
  settings = {
      gopls = {
          experimentalPostfixCompletions = true,
          analyses = {
              unusedparams = true,
              shadow = true,
              },
          staticcheck = true,
          },
      },
  on_attach = on_attach,
  }

EOF
""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" formatter
lua <<EOF
require('formatter').setup({
 filetype = {
    python = {
      -- prettier
      function()
        return {
          exe = "black",
          args = {'-' },
          stdin = true
        }
      end
    },
    lua = {
      function()
        return {
          exe = "stylua",
          args = {
            "-",
          },
          stdin = true,
        }
      end,
    },
  }
})
EOF
nnoremap <silent> Fm :Format<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lsp-colors
lua <<EOF
-- Lua
require("lsp-colors").setup({
  Error = "#db4b4b",
  Warning = "#e0af68",
  Information = "#0db9d7",
  Hint = "#10B981"
})
EOF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indent_blankline
lua <<EOF
vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
    show_end_of_line = false,
    show_current_context = true,
    show_current_context_start = false,
}


--------------------
-- tabnine
-- require('cmp').setup{
-- sources = {
--     { name = 'cmp_tabnine' },
--     }
-- }
local tabnine = require('cmp_tabnine.config')
tabnine:setup({
	max_lines = 100;
	max_num_results = 5;
	sort = true;
	run_on_every_keystroke = true;
	snippet_placeholder = '..';
	ignored_file_types = { -- default is not to ignore
		-- uncomment to ignore in lua:
		-- lua = true
	};
})

require'nvim-tree'.setup{
  view = {
    mappings = {
      list = {
    --    { key = "<CR>", action = "edit_in_place" }
      }
    }
  } 
}

-- {{{
local cb = require'diffview.config'.diffview_callback

require'diffview'.setup {
  diff_binaries = false,    -- Show diffs for binaries
  enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
  use_icons = true,         -- Requires nvim-web-devicons
  icons = {                 -- Only applies when use_icons is true.
    folder_closed = "",
    folder_open = "",
  },
  signs = {
    fold_closed = "",
    fold_open = "",
  },
  file_panel = {
    position = "left",                  -- One of 'left', 'right', 'top', 'bottom'
    width = 35,                         -- Only applies when position is 'left' or 'right'
    height = 10,                        -- Only applies when position is 'top' or 'bottom'
    listing_style = "tree",             -- One of 'list' or 'tree'
    tree_options = {                    -- Only applies when listing_style is 'tree'
      flatten_dirs = true,              -- Flatten dirs that only contain one single dir
      folder_statuses = "only_folded",  -- One of 'never', 'only_folded' or 'always'.
    },
  },
  file_history_panel = {
    position = "bottom",
    width = 35,
    height = 16,
    log_options = {
      max_count = 256,      -- Limit the number of commits
      follow = false,       -- Follow renames (only for single file)
      all = false,          -- Include all refs under 'refs/' including HEAD
      merges = false,       -- List only merge commits
      no_merges = false,    -- List no merge commits
      reverse = false,      -- List commits in reverse order
    },
  },
  default_args = {    -- Default args prepended to the arg-list for the listed commands
    DiffviewOpen = {},
    DiffviewFileHistory = {},
  },
  hooks = {},         -- See ':h diffview-config-hooks'
  key_bindings = {
    disable_defaults = false,                   -- Disable the default key bindings
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
      ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
      ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
      ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
      ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
    },
    file_panel = {
      ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["-"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
      ["S"]             = cb("stage_all"),            -- Stage all entries.
      ["U"]             = cb("unstage_all"),          -- Unstage all entries.
      ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
      ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
      ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    file_history_panel = {
      ["g!"]            = cb("options"),            -- Open the option panel
      ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
      ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
      ["zR"]            = cb("open_all_folds"),
      ["zM"]            = cb("close_all_folds"),
      ["j"]             = cb("next_entry"),
      ["<down>"]        = cb("next_entry"),
      ["k"]             = cb("prev_entry"),
      ["<up>"]          = cb("prev_entry"),
      ["<cr>"]          = cb("select_entry"),
      ["o"]             = cb("select_entry"),
      ["<2-LeftMouse>"] = cb("select_entry"),
      ["<tab>"]         = cb("select_next_entry"),
      ["<s-tab>"]       = cb("select_prev_entry"),
      ["gf"]            = cb("goto_file"),
      ["<C-w><C-f>"]    = cb("goto_file_split"),
      ["<C-w>gf"]       = cb("goto_file_tab"),
      ["<leader>e"]     = cb("focus_files"),
      ["<leader>b"]     = cb("toggle_files"),
    },
    option_panel = {
      ["<tab>"] = cb("select"),
      ["q"]     = cb("close"),
    },
  },
}
-- }}}

require("nvim-dap-virtual-text").setup({
    enabled = true,                     -- enable this plugin (the default)
    enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,            -- show stop reason when stopped for exceptions
    commented = false,                  -- prefix virtual text with comment string
    -- experimental features:
    virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
                                        -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
})
curgitpath = require('lspconfig.util').find_git_ancestor(vim.loop.fs_realpath('.'))
if curgitpath == nil or #curgitpath < 1 then
    curgitpath = "."
end
require('dap-go').setup()

local dap = require('dap')
dap.adapters.go = function(callback, config)
    local stdout = vim.loop.new_pipe(false)
    local handle
    local pid_or_err
    local port = 38697
    local opts = {
      stdio = {nil, stdout},
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    }
    handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
      stdout:close()
      handle:close()
      if code ~= 0 then
        print('dlv exited with code', code)
      end
    end)
    assert(handle, 'Error running dlv: ' .. tostring(pid_or_err))
    stdout:read_start(function(err, chunk)
      assert(not err, err)
      if chunk then
        vim.schedule(function()
          require('dap.repl').append(chunk)
        end)
      end
    end)
    -- Wait for delve to start
    vim.defer_fn(
      function()
        callback({type = "server", host = "127.0.0.1", port = port})
      end,
      100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
-- dap.configurations.go = {
--     {
--       type = "go",
--       name = "Debug",
--       request = "launch",
--       program = "${file}"
--     },
--     {
--       type = "go",
--       name = "Debug test", -- configuration for debugging test files
--       request = "launch",
--       mode = "test",
--       program = "${file}"
--     },
--     -- works with go.mod packages and sub packages 
--     {
--       type = "go",
--       name = "Debug test (go.mod)",
--       request = "launch",
--       mode = "test",
--       program = "./${relativeFileDirname}"
--     } 
-- }

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  sidebar = {
    -- You can change the order of elements in the sidebar
    elements = {
      -- Provide as ID strings or tables with "id" and "size" keys
      {
        id = "scopes",
        size = 0.25, -- Can be float or integer > 1
      },
      { id = "breakpoints", size = 0.25 },
      { id = "stacks", size = 0.25 },
      { id = "watches", size = 00.25 },
    },
    size = 40,
    position = "left", -- Can be "left", "right", "top", "bottom"
  },
  tray = {
    elements = { "repl" },
    size = 10,
    position = "bottom", -- Can be "left", "right", "top", "bottom"
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})

-- open dap-ui by event.
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

EOF

""""""""""""""""""""
" dap

nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <F12> :lua require'dap'.step_out()<CR>

nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>

