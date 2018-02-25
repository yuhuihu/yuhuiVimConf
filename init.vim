set nocompatible 
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/majutsushi/tagbar.git'
Plug 'https://github.com/vimwiki/vimwiki.git'
Plug 'https://github.com/vim-scripts/TagHighlight.git'
Plug 'https://github.com/vim-scripts/DoxygenToolkit.vim.git'
Plug 'https://github.com/vim-scripts/ScrollColors.git'
Plug 'https://github.com/scrooloose/syntastic.git'
Plug 'https://github.com/kien/ctrlp.vim.git'
Plug 'https://github.com/OmniSharp/omnisharp-vim.git'
Plug 'airblade/vim-gitgutter'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'https://github.com/zchee/deoplete-jedi.git'
Plug 'https://github.com/OrangeT/vim-csharp.git'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'
"""color scheme
Plug 'https://github.com/hzchirs/vim-material.git'
Plug 'https://github.com/beigebrucewayne/min_solo.git'
Plug 'https://github.com/fhrach4/neo-jungle256.git'

call plug#end()

let g:python2_host_prog = '/usr/local/bin/python2.7'
let g:python3_host_prog = '/usr/local/bin/python3.6'

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
colo shine
set background=dark
set guifont=Lucida\ Console:h12:w7
set nu
filetype on
filetype plugin indent on
set hlsearch
""set expandtab=0
set foldmethod=marker
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nowrap
set expandtab
hi IndentGuidesOdd  ctermbg=white
hi IndentGuidesEven ctermbg=lightgrey
let g:indent_guides_auto_colors=1
let g:indent_guides_enable_on_vim_startup = 1

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
nmap <F3> :call SaveSession()<CR>
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
autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python nmap <F5> :!python %<CR>
autocmd FileType python set tabstop=4
autocmd FileType python set go+=b
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" comment line."
function! CommentLine(commentPrefix)
  " let commentPrefix = '//'
  let commentPattern = '^\s*\t*' . a:commentPrefix
  let line = getline('.')
  if strlen(substitute(line, "[\s\t]", "", "")) < 1
    return
  endif
  if line =~ commentPattern
    let idx = stridx(line, a:commentPrefix[0], 0)
    let newline = strpart(line, 0, idx) 
    let newline = newline . strpart(line, idx + strlen(a:commentPrefix), strlen(line) - strlen(a:commentPrefix))
    call setline('.', newline)
  else
    let newline = a:commentPrefix . line
    call setline('.', newline)
  endif
endfunction
autocmd FileType c,cpp,cs map tm :call CommentLine('//')<CR>
autocmd FileType py map tm :call CommentLine('#')<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Doxygen"{{{
" nmap <leader>dc :Dox<CR>
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre="\\brief " 
let g:DoxygenToolkit_paramTag_pre="\\param " 
let g:DoxygenToolkit_returnTag="\\returns " 
"let g:DoxygenToolkit_blockHeader="--------------------------------------------"
let g:DoxygenToolkit_blockFooter="" 
let g:DoxygenToolkit_authorName="yuhuibear@gmail.com" 
"let g:DoxygenToolkit_licenseTag="private license"   
""}}}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace current word.
vmap tr "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap tr$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>
map  tu  zz:e!<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" find word in directories."{{{
let g_my_search_path = '**/*'
let g_my_search_replace_all = 0
let g_my_search_keyword = ''
function! SearchWordGlobal(vw, matchWord)
	if a:matchWord == 0
		let cw ="/" .  a:vw . "/g" 
	else
		let cw = "/\\<" . a:vw . "\\>/g"
	endif
	if strlen( g:g_my_search_path) < 1
		let g:g_my_search_path = expand("%:h") . '**/*'
	endif
	let g:g_my_search_path = input("search [" . cw . "] in dir(regx): ",  g:g_my_search_path, "dir")
	exe "noautocmd vimgrep " . cw . " " . g:g_my_search_path . ""
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
" buffers switch, switching
map <silent> tbn :bn<CR>
map <silent> tbp :bp<CR>
map <silent> tbd :bd<CR>
map <silent> tbs :buffers<CR>:exe "buf " . input("switch to :") . ""<CR>
map <silent> tvb :vs<CR>:winc w<CR>:buffers<CR>:exe "buf " . input("switch to :") . ""<CR>
map <silent> tsb :sp<CR>:winc w<CR>:buffers<CR>:exe "buf " . input("switch to :") . ""<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for folding 
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

" add file discription."{{{
function! AddDescription()

	let lineCnt = len(getbufline(bufname("%"), 0, "$"))
	if lineCnt > 1
		return 0
	endif
	let time ="* @" .  strftime("%c") 
	let file = "*" . expand("%")
	let author = "* created by yuhui."
	let description = ['/******************', file, "*", "*", author, time, '*******************/']
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
autocmd FileType c,cpp,h,cs exe ":call AddDescription()"
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
set laststatus=2
"set statusline=%<%F\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('%s','','')}\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}

""""""""""""""""""""""""""""""for NERDTree"{{{
" >> auto change current directory to current openning file.
nnoremap <silent> <F2> :let curPath =expand("%:h:p")<Bar> exe "NERDTree " . (len(curPath)<1 ?  "." : curPath)<CR>
"}}}

""""""""""""""""""""""""""""""""""""""""""" ctags"{{{
let g:tagbar_left = 1
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
nmap <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --totals=yes .<CR><CR>
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
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" ctrl p
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ *.meta

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  " let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif
let g:ctrlp_max_files=0
" let g:ctrlp_regexp = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = '~/.ctrp_cache/ctrlp'
let g:ctrlp_extensions = ['tag', 'buffertag', 'bookmarkdir']
let g:ctrlp_custom_ignore = {
			\ 'dir':  '\v[\/]\.(git|hg|svn)$',
			\ 'file': '\v\.(exe|so|dll|html|js|obj|meta|jpg|gif|png|jpeg|tiff|o|meta|prefab|asset|pyc)$',
			\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
			\ }
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
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
" deoplete jedi
let g:deoplete#sources#jedi#enable_cache = 1
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_start_length = 1
" deplete clang 
let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/4.0.1/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header = "/usr/local/Cellar/llvm/4.0.1/lib/clang"

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
	" autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	autocmd BufWritePost *.cs call OmniSharp#AddToProject()

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
