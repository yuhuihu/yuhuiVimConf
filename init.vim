set nocompatible 
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/vim-scripts/TagHighlight.git'
Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/OmniSharp/omnisharp-vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/davidhalter/jedi-vim.git'
Plug 'https://github.com/zchee/deoplete-jedi.git'
Plug 'https://github.com/OrangeT/vim-csharp.git'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/Yggdroot/indentLine.git'
Plug 'https://github.com/heavenshell/vim-pydocstring.git'
Plug 'https://github.com/vim-syntastic/syntastic.git'
Plug 'https://github.com/ludovicchabant/vim-gutentags.git'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax.git'
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

" Plug 'iamcco/mathjax-support-for-mkdp'
" Plug 'iamcco/markdown-preview.vim'
call plug#end()

let g:python2_host_prog = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.7'

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
colo torte
set background=dark
set guifont=Monaco\ Console:h12:w7
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
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim indent color
hi IndentGuidesOdd  ctermbg=lightgrey
hi IndentGuidesEven ctermbg=darkgrey
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4

" session"{{{
function! SaveSession()
	let ch = confirm("save session ?", "&Yes\n&No", 1)
	if ch == 1
		exe ":wa"
		exe "mksession!"
	else
		echo "save session cancle."
	endif
endfunction
set sessionoptions=buffers,curdir,resize,folds,tabpages,slash,resize,winpos,winsize
nmap <F5> :call SaveSession()<CR>
function! LoadSession(confirmed)
	let aconf = a:confirmed
	if aconf != 1
		let aconf = confirm("load last session ?", "&Yes\n&No", 1)
	endif
	if aconf == 1
		exe ":so Session.vim"
	else
		echo "load seesion cancled."
	endif
endfunction
nmap <F4> :call LoadSession(0)<CR>
"}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c/cpp indent
autocmd FileType c,cpp,mm setlocal shiftwidth=4
autocmd FileType c,cpp,mm setlocal tabstop=4
autocmd FileType c,cpp,mm setlocal softtabstop=4
autocmd FileType c,cpp,mm setlocal expandtab
autocmd FileType c,cpp,mm setlocal textwidth=120
autocmd FileType c,cpp,mm setlocal wrap
autocmd FileType c,cpp,mm setlocal cindent
autocmd FileType c,cpp,mm setlocal cinoptions=h4,l1,g4,t0,i4,+4,(0,w1,W4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python indent
let g_my_python_debug = ''
function! DebugPython()
    let g:g_my_python_debug = input('debug:', g:g_my_python_debug, 'file')
    sp
    let cmd = "terminal python3 -m pdb -c 'b " . expand('%') . ":" . line('.') . "' -c continue " . g:g_my_python_debug
    echo 'fuck cmd:' cmd
    exe cmd
endfunction

let g_my_python_run = ''
function! RunPython()
    let g:g_my_python_run = input('run:', g:g_my_python_run, 'file')
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
function! CommentLine(commentPrefix)
    let commentPattern = '^\s*\t*' . a:commentPrefix
    let line = getline('.')
    if strlen(substitute(line, '[\s\t]', '', '')) < 1
        return
    endif
    if line =~ commentPattern
        let idx = stridx(line, a:commentPrefix, 0)
        let newline = strpart(line, 0, idx) 
        let newline = newline . strpart(line, idx + strlen(a:commentPrefix), strlen(line) - strlen(a:commentPrefix) - idx)
        call setline('.', newline)
    else
        let noindentLine = substitute(line, '^\s*\t*', '', '')
        let idx = stridx(line, noindentLine)
        let newline = strpart(line, 0, idx) . a:commentPrefix . noindentLine
        call setline('.', newline)
    endif
endfunction
"autocmd FileType c,cpp,cs map tm :call CommentLine('// ')<CR>
autocmd FileType python map tm :call CommentLine('# ')<CR>
" autocmd FileType vim map tm :call CommentLine('" ')<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace current word.
vmap tr "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap tr$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>
map  tu  zz:e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find word in directories."{{{
let g_my_search_path = '.'
let g_my_search_replace_all = 0
let g_my_search_keyword = ''
function! SearchWordGlobal(vw, matchWord)
	if a:matchWord == 0
		let cw ="/" .  a:vw . "/g" 
	else
		let cw = "/\\<" . a:vw . "\\>/g"
	endif
	if strlen( g:g_my_search_path) < 1
		let g:g_my_search_path = expand("%:h") . './'
	endif
	let g:g_my_search_path = input("search [" . cw . "] in dir(regx): ",  g:g_my_search_path, "dir")
    if g:g_my_search_path == '%'
        exe "noautocmd vimgrep " . cw . "%"
    else
        let fext = expand("%:e")
        if strlen(fext) > 0
            let fext = '.' . fext
        endif
        if g:g_my_search_path[strlen(g:g_my_search_path) - 1] != '/'
            let g:g_my_search_path = g:g_my_search_path . '/'
        endif
        exe "noautocmd vimgrep " . cw . " " . g:g_my_search_path . "**/*" . fext
    endif
	exe ":cw"
	let qflst = getqflist()
	let g:g_my_search_replace_all = len(qflst) > 0
	let g:g_my_search_keyword = a:vw
endfunction
" replace words in directories
function! ReplaceWordGlobal( noConfirm, matchWord)
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
vmap <silent> <leader>gf "xy<CR>:call SearchWordGlobal(@x, 0)<CR>
vmap <silent> <leader>gfw "xy<CR>:call SearchWordGlobal(@x, 1)<CR>
nmap <silent> <leader>gf :call SearchWordGlobal(input("search: ", expand("<cword>")), 0)<CR>
nmap <silent> <leader>gfw :call SearchWordGlobal(input("search: ", expand("<cword>")), 1)<CR>
nmap <silent> <leader>gr :call ReplaceWordGlobal(1, 0)<CR>
nmap <silent> <leader>grw :call ReplaceWordGlobal(1, 1)<CR>
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
function! AddDescription(commentChar)
    echo ' in file description'
	let lineCnt = len(getbufline(bufname("%"), 0, "$"))
	if lineCnt > 1
		return 0
	endif
	let time = a:commentChar . " @" .  strftime("%c") 
	let file =  a:commentChar . expand("%")
	let author =  a:commentChar . created by yuhui."
	let description = [a:commentChar, file, a:commentChar, a:commentChar, author, time, a:commentChar]
	let exfn = tolower(strpart(file, strlen(file)-2, strlen(file)))
	if  exfn == ".h"
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
	else
		let isSrcFile = tolower(strpart(file, strlen(file) - 4, 4)) == '.cpp' ? 4 : tolower(strpart(file, strlen(file) - 2, 2)) == '.c' ? 2 : 0
		if isSrcFile > 0
			let theader = expand("%")
			let theader = strpart(file, 1, strlen(file) - isSrcFile)
			let theader = '#include "' . theader . 'h"'
			call add(description, theader)
			call add(description, '')
		endif
	endif
	let fail= append(0, description)
	if fail
		return 1
	endif
endfunction
" autocmd FileType c,cpp,h,cs exec :call AddDescription('//')<CR>
" autocmd FileType python exec : call AddDescription('"')
"}}}
"for GUI
set guioptions-=T
set guioptions-=m
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"file encoding
set fileencodings=utf8,ucs-bom,gbk,cp936,gb18030
"set termencoding=utf-8,gbk,ucs-bom
"set encoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" status line
if  exists('g:gui_oni')
    " Turn off statusbar, because it is externalized
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
else
    set laststatus=2
    set statusline=%<%F\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('【%s】','','f')}%=\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}
    " set statusline+=%{SyntasticStatuslineFlag()}
endif

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
nnoremap <silent> <F7> :let curPath =expand("%:h:p")<Bar> exec "NERDTree " . (len(curPath)<1 ?  "." : curPath)<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" ctags"{{{
let g:tagbar_left = 1
let g:tagbar_autopreview = 1
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
""""""""""""""""""""""""""""""""""""""
"hihight tags
"nmap <F11> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --totals=yes .<CR><CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"cscope"{{{
if has("cscope")
	set nocsverb
	"if filereadable("../cscope.out")
	"cs add ../cscope.out
	if filereadable("./cscope.out")
		cs add ./cscope.out
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-
function! CscopeFind(tkw)
	let model = input("s-symbol\ng-definition\nd-called\nc-calling\nt-text\ne-egrep\nf-file\ni-include\nmodel: ", "c")
	let cmd = ": cs find " . model . " " . a:tkw " <CR>"
	exe cmd
	exe ": copen"
endfunction
vmap <silent> tcf "xy<CR>:call CscopeFind(@x)<CR>
nmap <silent> tcf :call CscopeFind(input("search: ", expand("<cword>"), "tag"))<CR>
"}}}
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ctrl p
if executable('ag')
    " ag for vim grep
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
    set grepformat=%f:%l:%c:%m,%f:%l:%m

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let ignoreAg = join(['"subs"'], ' ')
    let agcmd = 'ag %s -l --nocolor --ignore-dir ' . ignoreAg . ' -g ""'
    "     echo 'agcmd:' agcmd
    let g:ctrlp_user_command = agcmd
endif
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40 
let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = '~/.ctrp_cache/ctrlp'
let g:ctrlp_extensions = ['buffertag' ]
let g:ctrlp_buftag_ctags_bin = 'ctags'
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn|subs)$',
			\ 'file': '\v\.(exe|so|dll|html|js|obj|meta|jpg|gif|png|jpeg|tiff|o|meta|prefab|asset|pyc|venv)$',
			\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
			\ }
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
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
" deoplete all
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\ 'auto_complete_delay': 200,
\ 'smart_case': v:true,
\ })
" deoplete jedi
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#auto_complete_start_length = 2
let g:jedi#show_call_signatures = 1
let g:jedi#popup_on_dot = 0
" deplete clang 
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/4.0.1/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/4.0.1/lib/clang"
" javascript
" Set bin if you have many instalations
let g:deoplete#sources#ternjs#tern_bin = '/usr/local/bin/tern'
let g:deoplete#sources#ternjs#timeout = 1

" Whether to include the types of the completions in the result data. Default: 0
let g:deoplete#sources#ternjs#types = 1

" Whether to include the distance (in scopes for variables, in prototypes for 
" properties) between the completions and the origin position in the result 
" data. Default: 0
let g:deoplete#sources#ternjs#depths = 1

" Whether to include documentation strings (if found) in the result data.
" Default: 0
let g:deoplete#sources#ternjs#docs = 1

" When on, only completions that match the current word at the given point will
" be returned. Turn this off to get all results, so that you can filter on the 
" client side. Default: 1
let g:deoplete#sources#ternjs#filter = 0

" Whether to use a case-insensitive compare between the current word and 
" potential completions. Default 0
let g:deoplete#sources#ternjs#case_insensitive = 1

" When completing a property and no completions are found, Tern will use some 
" heuristics to try and return some properties anyway. Set this to 0 to 
" turn that off. Default: 1
let g:deoplete#sources#ternjs#guess = 0

" Determines whether the result set will be sorted. Default: 1
let g:deoplete#sources#ternjs#sort = 0

" When disabled, only the text before the given position is considered part of 
" the word. When enabled (the default), the whole variable name that the cursor
" is on will be included. Default: 1
let g:deoplete#sources#ternjs#expand_word_forward = 0

" Whether to ignore the properties of Object.prototype unless they have been 
" spelled out by at least two characters. Default: 1
let g:deoplete#sources#ternjs#omit_object_prototype = 0

" Whether to include JavaScript keywords when completing something that is not 
" a property. Default: 0
let g:deoplete#sources#ternjs#include_keywords = 1

" If completions should be returned when inside a literal. Default: 1
let g:deoplete#sources#ternjs#in_literal = 0


"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" omnisharp
"
" OmniSharp won't work without this setting
filetype plugin on

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
let g:OmniSharp_typeLookupInPreview = 0

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 2
let g:Omnisharp_start_server=1
let g:OmniSharp_selector_ui='ctrlp'

"Showmatch significantly slows down omnicomplete
"when the first match contains parentheses.
set noshowmatch

"Super tab settings - uncomment the next 4 lines
"let g:SuperTabDefaultCompletionType = 'context'
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
"let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
"let g:SuperTabClosePreviewOnPopupClose = 1

"don't autoselect first item in omnicomplete, show if only one item (for preview)
"remove preview if you don't want to see any documentation whatsoever.
set completeopt=longest,menuone,preview
" Fetch full documentation during omnicomplete requests. 
" There is a performance penalty with this (especially on Mono)
" By default, only Type/Method signatures are fetched. Full documentation can still be fetched when
" you need it with the :OmniSharpDocumentation command.
let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic']		" , 'issues']

augroup omnisharp_commands
	autocmd!

	"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" Synchronous build (blocks Vim)
	"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
	" Builds can also run asynchronously with vim-dispatch installed
	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr> 
    " automatic syntax check on events (TextChanged requires Vim 7.4)
	autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	" autocmd BufWritePost *.cs call OmniSharp#AddToProject()

	"show type information automatically when the cursor stops moving
	" autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"The following commands are contextual, based on the current cursor position.

	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
	" autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	" autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	" autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr> "finds members in the current buffer
	" cursor can be anywhere on the line containing an issue 
	" autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>  
	" autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	" autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	" autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	"	autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr> "navigate up by method/property/field
	"	autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr> "navigate down by method/property/field
augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP)
" nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
"vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
" nnoremap <leader>rn :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
" command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
" nnoremap <leader>rl :OmniSharpReloadSolution<cr>
" nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
" nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
" nnoremap <leader>ss :OmniSharpStartServer<cr>
" nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" markdown 
let g:mkdp_auto_start = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" higroup

highlight mulHl1 ctermfg=red guifg=red
highlight mulHl2 ctermfg=green guifg=green
highlight mulHl3 ctermfg=blue guifg=blue
highlight mulHl4 ctermfg=magenta ctermbg=black guifg=IndianRed
highlight mulHl5 ctermfg=green ctermbg=black guifg=chartreuse

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" syntax
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

set signcolumn=yes
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_exe = 'python3 -m flake8'
let g:syntastic_warning_symbol = '❗'
let g:syntastic_style_warning_symbol = '❗'
let g:syntastic_error_symbol = '➤'
let g:syntastic_style_error_symbol = '➤'
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "passive_filetypes": ["html"]
            \}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" terminal
function! OpenTerminalSplit()
    20split
    exe ":terminal"
	setlocal nowrap
endfunction
nmap <leader>m :call OpenTerminalSplit()<CR>
tnoremap <Esc> <C-\><C-n>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" semshi
" let g:semshi#active = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mark down preview
" " set to 1, the nvim will open the preview window once enter the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will just refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it just can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server only listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" switch browser to open preview page
" default: ''
let g:mkdp_browser = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {}
    \ }

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''
