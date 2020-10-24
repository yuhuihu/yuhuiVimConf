set nocompatible
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'https://github.com/tpope/vim-fugitive.git'

Plug 'sheerun/vim-polyglot'

" Plug 'OmniSharp/omnisharp-vim'
Plug 'git@github.com:dense-analysis/ale.git'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'https://github.com/Yggdroot/indentLine'
Plug 'https://github.com/nathanaelkane/vim-indent-guides'
Plug 'git@github.com:rafi/awesome-vim-colorschemes.git'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'HerringtonDarkholme/yats.vim'
" Plug 'mhartington/nvim-typescript', {'do': './install.sh'}
Plug 'mileszs/ack.vim'

Plug 'https://github.com/heavenshell/vim-pydocstring.git'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction

Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
Plug 'git@github.com:chrisbra/csv.vim.git'

"""color scheme
Plug 'https://github.com/nightsense/vrunchbang.git'
Plug 'https://github.com/nightsense/snow.git'
Plug 'https://github.com/lifepillar/vim-wwdc17-theme.git'
Plug 'https://github.com/hzchirs/vim-material.git'
Plug 'https://github.com/beigebrucewayne/min_solo.git'
Plug 'https://github.com/fhrach4/neo-jungle256.git'
Plug 'https://github.com/arzg/vim-colors-xcode.git'
Plug 'https://github.com/vim-scripts/mayansmoke.git'
Plug 'https://github.com/lmintmate/blue-mood-vim.git'
Plug 'https://github.com/HenryNewcomer/vim-theme-mutenight-scene.git'
Plug 'https://github.com/schickele/vim.git'
Plug 'https://github.com/nightsense/seabird.git'
Plug 'ayu-theme/ayu-vim'
Plug 'mhartington/oceanic-next'

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


let g:airline_theme='oceanicnext'
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1

" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
" colo PaperColor
colo flattened_light
" colo challenger_deep

" set background=dark

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"file encoding
set fileencodings=utf8,ucs-bom,gbk,cp936,gb18030
"set termencoding=utf-8,gbk,ucs-bom
"set encoding=utf-8


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
function! CommentLine()"{{{
    let commtdict = {
                \ 'lua': '--',
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
    exe "Ack " . kw . ' ./'
    " echo "CAg " . kw . ' ./**/*.' . expand("%:e")
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

nmap <silent> <leader>f :call SearchWordGlobal(expand("<cword>"))<CR>
vmap <silent> <leader>f :call SearchWordGlobal('')<CR>

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
        call insert(description, "#!/usr/bin/env python3", 0)
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
    let g:airline_section_z = '%l/%L|B%n' 
    let g:airline#extensions#coc#enabled = 1
  let g:airline#extensions#ale#enabled = 1
endif

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
nnoremap <silent> <F7> :let curPath =expand("%:h:p")<Bar> exec "NERDTree " . (len(curPath)<1 ?  "." : curPath)<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" ctags"{{{
let g:tagbar_left = 1
let g:tagbar_autopreview = 0
nnoremap <silent> T :TagbarToggle<CR>
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
" higroup

highlight mhl1 ctermfg=red guifg=red ctermbg=gray
highlight mhl2 ctermfg=green guifg=green ctermbg=gray
highlight mhl3 ctermfg=blue guifg=blue ctermbg=gray

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" terminal
function! OpenTerminalSplit(cmd)
    exe a:cmd
    exe ":terminal"
    setlocal nowrap
endfunction
nmap <leader>m :call OpenTerminalSplit('20split')<CR>
nmap <leader>vm :call OpenTerminalSplit('vs')<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown preview
nnoremap <F11> :MarkdownPreview<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>
nnoremap <C-b> :Buffers<CR>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
            \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
let g:coc_global_extensions=[ 'coc-omnisharp' ]
let g:airline#extensions#coc#enabled = 1
" if hidden is not set, TextEdit might fail.
set hidden

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
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

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
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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
" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "" "
" vim indent
let g:indent_guides_enable_on_vim_startup = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " omnisharp
" let g:OmniSharp_server_path= '/Users/huyuhui/Downloads/omnisharp-osx/run'
" let g:OmniSharp_server_display_loading = 1
" let g:OmniSharp_server_stdio = 1
" let g:OmniSharp_selector_ui = 'ctrlp'
" let g:OmniSharp_start_server = 1

" Update semantic highlighting after all text changes
" let g:OmniSharp_highlight_types = 3
" Update semantic highlighting on BufEnter and InsertLeave
" let g:OmniSharp_highlight_types = 2
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE

let g:ale_linters = { 'cs': ['OmniSharp'] }

call ale#linter#Define('cs', {
            \   'name': 'omnisharp',
            \   'lsp': 'stdio',
            \   'executable': '/Users/huyuhui/Downloads/omnisharp-osx/run',
            \   'command': '%e run',
            \   'project_root': '.',
            \})



