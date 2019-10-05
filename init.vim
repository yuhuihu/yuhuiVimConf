set nocompatible 
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'https://github.com/vim-scripts/ScrollColors.git'
" Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/yuhuihu/vim-glsl.git'
Plug 'https://github.com/tpope/vim-fugitive.git'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/Yggdroot/indentLine'
Plug 'git@github.com:rafi/awesome-vim-colorschemes.git'

Plug 'w0rp/ale'

Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'OmniSharp/omnisharp-vim'
" Plug 'deoplete-plugins/deoplete-jedi'

Plug 'https://github.com/heavenshell/vim-pydocstring.git'
" Plug 'https://github.com/vim-syntastic/syntastic.git'
" Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
" Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
" Plug 'https://github.com/Glench/Vim-Jinja2-Syntax.git'
" Plug 'https://github.com/tomtom/tcomment_vim.git'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}

"""color scheme
Plug 'https://github.com/nightsense/vrunchbang.git'
Plug 'https://github.com/nightsense/snow.git'
Plug 'https://github.com/lifepillar/vim-wwdc17-theme.git'
Plug 'https://github.com/hzchirs/vim-material.git'
Plug 'https://github.com/beigebrucewayne/min_solo.git'
Plug 'https://github.com/fhrach4/neo-jungle256.git'
Plug 'https://github.com/vim-scripts/mayansmoke.git'
Plug 'https://github.com/lmintmate/blue-mood-vim.git'
Plug 'https://github.com/HenryNewcomer/vim-theme-mutenight-scene.git'
Plug 'https://github.com/schickele/vim.git'
Plug 'https://github.com/nightsense/seabird.git'

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
set hlsearch
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowrap
set expandtab

colo mayansmoke
" set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ag
if executable('ag')
    " ag for vim grep
    " set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    set grepprg=ag\ --vimgrep
    " bind \ (backward slash) to grep shortcut
    command! -nargs=+ -complete=file -bar CAg silent! grep! <args>|cwindow|redraw!
endif


" session"{{{
function! SaveSession()
    let ch = confirm("save session ?", "&Yes\n&No", 1)
    if ch == 1
        exe ":wa"
        exe "mksession! .session.vim"
    else
        echo "save session cancle."
    endif
endfunction
set sessionoptions=buffers,curdir,resize,folds,tabpages,slash,resize,winpos,winsize
nmap <F3> :call SaveSession()<CR>
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
nmap <F4> :call LoadSession(0)<CR>
"}}}
let g_my_python_debug = ''
function! DebugPython()
    let g:g_my_python_debug = input('python3 debug:', g:g_my_python_debug, 'file')
    sp
    let cmd = "terminal python3 -m pdb -c 'b " . expand('%') . ":" . line('.') . "' -c continue " . g:g_my_python_debug
    echo 'fuck cmd:' cmd
    exe cmd
endfunction

let g_my_python_run = ''
function! RunPython()
    let g:g_my_python_run = input('python3 run:', g:g_my_python_run, 'file')
    sp
    exe 'terminal python3 ' . g:g_my_python_run
endfunction

autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType python nmap <silent> <leader>i <Plug>(pydocstring)
autocmd FileType python nmap <F9> :call DebugPython()<CR>
autocmd FileType python nmap <F10> :call RunPython()<CR>

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
function! CommentLine()
    let commtdict = {
                \ 'c': '//',
                \ 'cpp': '//',
                \ 'h': '//',
                \ 'cs': '//',
                \ 'python': '#',
                \ 'vim': '"',
                \ 'shader': '//',
                \ 'glsl': '//',
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
endfunction
noremap  tm :call CommentLine()<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace current word.
vmap tr "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap tr$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>
map  tu  zz:e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find word in directories."{{{
let g_my_search_replace_all = 0
let g_my_search_keyword = ''
function! SearchWordGlobal(vw, matchWord)
    if a:matchWord == 0
        let cw ="/" .  a:vw . "/" 
    else
        let cw = "/\\<" . a:vw . "\\>/"
    endif
    exe "CAg " . cw 
    copen
    let qflst = getqflist()
    let g:g_my_search_replace_all = len(qflst) > 0
    let g:g_my_search_keyword = a:vw
endfunction

nmap <silent> <leader>f :exe 'CAg ' . expand("<cword>")<CR>
nmap <silent> <leader>w :exe 'CAg \<' . expand("<cword>") . '\>'<CR>
vmap <silent> <leader>f :y"x <Bar> exe 'CAg ' . @x<CR>

" replace words in directories
function! ReplaceWordGlobal( noConfirm, matchWord)
    let qflst = getqflist()
    let g:g_my_search_replace_all = len(qflst) > 0
    if( g:g_my_search_replace_all == 0) 
        return
    endif

    call inputsave()
    let newkw = input("Replace [" . g:g_my_search_keyword . "]by ",  '')
    call inputrestore()

    if(a:matchWord == 0 )
        let replaceCmd =  ":%s/" . g:g_my_search_keyword . "/" . newkw
    else
        let replaceCmd =  ":%s/\\<" . g:g_my_search_keyword . "\\>/" . newkw
    endif
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

nmap <silent> <leader>r :call ReplaceWordGlobal(1, 0)<CR>
nmap <silent> <leader>rw :call ReplaceWordGlobal(1, 1)<CR>
"}}}
" find word in correspond file
"function! SearchWordInCorrespondFile()
"let cw ="/" . input("corresponding search: ", expand("<cword>")) . "/g" 
"let distPath = "" . expand("%<.cpp") . " " expand("%<.h") . " " . expand("%<.c")
"exe "vimgrep " . cw . " " . distPath . ""
"exe ":cw"
"endfunction
"autocmd FileType c,cpp nmap tof :call SearchWordInCorrespondFile()<CR>

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
                \ 'cpp': '//',
                \ 'h': '//',
                \ 'cs': '//',
                \ 'python': '#',
                \ 'vim': '"',
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
        call insert(description, "#!/usr/bin/env python", 0)
        call insert(description, "# -*- coding: utf-8 -*-", 1)
    else

    endif
    let fail= append(0, description)
    if fail
        return 1
    endif
endfunction
autocmd FileType c,cpp,h,cs,python exe "call AddDescription()"
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"file encoding
set fileencodings=utf8,ucs-bom,gbk,cp936,gb18030
"set termencoding=utf-8,gbk,ucs-bom
"set encoding=utf-8
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
    set statusline=%<%f\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('【%s】','','f')}%=\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}
else
    set laststatus=2
    " set statusline=%<%f\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('【%s】','','f')}%=\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}
    " set statusline+=%{SyntasticStatuslineFlag()}
    let g:airline_section_z = '%l/%L'
endif

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
nnoremap <silent> <F7> :let curPath =expand("%:h:p")<Bar> exec "NERDTree " . (len(curPath)<1 ?  "." : curPath)<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" ctags"{{{
let g:tagbar_left = 1
let g:tagbar_autopreview = 0
nnoremap <silent> T :TagbarToggle<CR>
"autocmd FileType c,cpp,h,hpp nnoremap ttf: ts expand("<cword>")<CR>
autocmd FileType c,cpp,h,hpp nnoremap ttn: tn<CR>
autocmd FileType c,cpp,h,hpp nnoremap ttp: tp<CR>
nnoremap <silent> tpj : exe "ptj " . expand("<cword>") . ""<CR>
nnoremap <silent> tpn : ptn<CR>
nnoremap <silent> tpp : ptp<CR>
set tags=../tags,tags				
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
" vim wiki
let g:vimwiki_list = [{'path': '~/Library/Mobile Documents/com~apple~CloudDocs/vimwiki/', 'auto_tags': 1}]
nmap <leader><space> <Plug>VimwikiToggleListItem
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unity log
function! OpenUnityLog()
    let logfileName = expand("~/Library/Logs/Unity/Editor.log")
    exe "tabfind " . logfileName
    exe ":g/^(Filename:/d"
    exe ":g/^UnityEngine\\./d"
    exe ":g/^UnityEditor\\./d"
    exe ":g/^YLMobile\\./d"
    exe ":g/^\\s$/d"
    exe ":g/^Apollo./d"
    exe ":g/^\[\\w\\+/d"
endfunction
nmap <leader>lg :call OpenUnityLog()<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" higroup

highlight mulHl1 ctermfg=red guifg=red
highlight mulHl2 ctermfg=green guifg=green
highlight mulHl3 ctermfg=blue guifg=blue
highlight mulHl4 ctermfg=magenta ctermbg=black guifg=IndianRed
highlight mulHl5 ctermfg=green ctermbg=black guifg=chartreuse


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" terminal
function! OpenTerminalSplit()
    20split
    exe ":terminal"
    setlocal nowrap
endfunction
nmap <leader>m :call OpenTerminalSplit()<CR>


" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('sources', {
            \ 'cs': ['omnisharp'],
            \ })

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_selectionUI="quickfix"
let g:LanguageClient_serverCommands = {
            \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
            \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
            \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
            \ 'python': ['/usr/local/bin/pyls'],
            \ 'ruby': ['~/.rbenv/shims/solargraph', 'stdio'],
            \ 'java': ['/Users/huyuhui/work/java/java-language-server/dist/launch_mac.sh --quiet'],
            \ }
nnoremap <leader>C :call LanguageClient_contextMenu()<CR>
" Or map each action separately
" nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

""""""""""""""""""""
" Set the type lookup function to use the preview window instead of echoing it
"let g:OmniSharp_typeLookupInPreview = 1
"
let g:OmniSharp_server_stdio = 1

" Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 5

" Don't autoselect first omnicomplete option, show options even if there is only
" one (so the preview documentation is accessible). Remove 'preview' if you
" don't want to see any documentation whatsoever.
set completeopt=longest,menuone

" Fetch full documentation during omnicomplete requests.
" There is a performance penalty with this (especially on Mono).
" By default, only Type/Method signatures are fetched. Full documentation can
" still be fetched when you need it with the :OmniSharpDocumentation command.
"let g:omnicomplete_fetch_full_documentation = 1

" Set desired preview window height for viewing documentation.
" You might also want to look at the echodoc plugin.
set previewheight=5

" Tell ALE to use OmniSharp for linting C# files, and no other linters.
" let g:ale_linters = { 'cs': ['OmniSharp'] }

" Fetch semantic type/interface/identifier names on BufEnter and highlight them
let g:OmniSharp_highlight_types = 1

augroup omnisharp_commands
    autocmd!

    " When Syntastic is available but not ALE, automatic syntax check on events
    " (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    " Update the highlighting whenever leaving insert mode
    autocmd InsertLeave *.cs call OmniSharp#HighlightBuffer()

    " Alternatively, use a mapping to refresh highlighting for the current buffer
    autocmd FileType cs nnoremap <buffer> <Leader>th :OmniSharpHighlightTypes<CR>

    " The following commands are contextual, based on the cursor position.
    autocmd FileType cs nnoremap <buffer> gd :OmniSharpGotoDefinition<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fi :OmniSharpFindImplementations<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fs :OmniSharpFindSymbol<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>fu :OmniSharpFindUsages<CR>

    " Finds members in the current buffer
    " autocmd FileType cs nnoremap <buffer> <Leader>fm :OmniSharpFindMembers<CR>

    autocmd FileType cs nnoremap <buffer> <Leader>fx :OmniSharpFixUsings<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>tt :OmniSharpTypeLookup<CR>
    autocmd FileType cs nnoremap <buffer> <Leader>dc :OmniSharpDocumentation<CR>
    autocmd FileType cs nnoremap <buffer> <C-\> :OmniSharpSignatureHelp<CR>
    autocmd FileType cs inoremap <buffer> <C-\> <C-o>:OmniSharpSignatureHelp<CR>

    " Navigate up and down by method/property/field
    autocmd FileType cs nnoremap <buffer> <C-k> :OmniSharpNavigateUp<CR>
    autocmd FileType cs nnoremap <buffer> <C-j> :OmniSharpNavigateDown<CR>
augroup END

" Contextual code actions (uses fzf, CtrlP or unite.vim when available)
nnoremap <Leader><Space> :OmniSharpGetCodeActions<CR>
" Run code actions with text selected in visual mode to extract method
xnoremap <Leader><Space> :call OmniSharp#GetCodeActions('visual')<CR>

" Rename with dialog
" nnoremap <Leader>nm :OmniSharpRename<CR>
nnoremap <F2> :OmniSharpRename<CR>
" Rename without dialog - with cursor on the symbol to rename: `:Rename newname`
" command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

nnoremap <Leader>cf :OmniSharpCodeFormat<CR>

" Start the omnisharp server for the current solution
nnoremap <Leader>ss :OmniSharpStartServer<CR>
nnoremap <Leader>sp :OmniSharpStopServer<CR>

let g:OmniSharp_open_quickfix = 0
let g:OmniSharp_selector_ui = 'fzf'
" Enable snippet completion
" let g:OmniSharp_want

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown preview 
nnoremap <F11> :MarkdownPreview<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>
nnoremap <leader>t :Tags<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1
let g:ale_sign_error = 'E>'
let g:ale_sign_warning = 'W-'
