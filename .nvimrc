set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
"
Plugin 'gmarik/Vundle.vim'
Plugin 'https://github.com/OmniSharp/omnisharp-vim.git'
Plugin 'https://github.com/tpope/vim-dispatch.git'
Plugin 'https://github.com/vim-scripts/ScrollColors.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/vimwiki/vimwiki.git'
Plugin 'https://github.com/vim-scripts/DoxygenToolkit.vim.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
"Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plugin 'http://git.oschina.net/qiuchangjie/ShaderHighLight'
"Plugin 'https://github.com/davidhalter/jedi-vim.git'
Plugin 'https://github.com/nathanaelkane/vim-indent-guides.git'
Plugin 'https://github.com/tomasr/molokai.git'
Plugin 'https://github.com/altercation/vim-colors-solarized.git'
Plugin 'https://github.com/lifepillar/vim-wwdc17-theme.git'
Plugin 'itchyny/calendar.vim'
"Plugin 'flazz/vim-colorschemes'
Plugin 'airblade/vim-gitgutter'
Plugin 'https://github.com/hotwatermorning/auto-git-diff.git'
Plugin 'https://github.com/vim-scripts/git-log.git'
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
"Plugin 'roxma/nvim-completion-manager'
"Plugin 'roxma/python-support.nvim'
"Plugin 'git@github.com:Shougo/dein.vim.git'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'ryanoasis/vim-devicons'
" Plugin 'https://github.com/ervandew/supertab.git'
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList       - lists configured plugins
" " :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" " :PluginSearch foo - searches for foo; append `!` to refresh local cache
" " :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line
filetype plugin on
filetype indent on
filetype on
"let &termencoding=&encoding
set fileencodings=utf-8     ",gbk,ucs-bom,cp936
"set termencoding=utf-8,gbk,ucs-bom
"set encoding=utf-8

set diffexpr=MyDiff()"
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

"for GUI
set guioptions-=T
set guioptions-=m
"for terminal
set background=dark " Change to light if you want the light variant
if has('gui_running')
  colorscheme peachpuff " bandit fine_blue2 	fog wombat
  "set guifont=Monaco\ 9
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
else
  set t_Co=256
  "set background=light
  colo blue
endif

set ttimeoutlen=50
set laststatus=2
set statusline=%<%F\ %ybuf:%n%h%m%r%=%{tagbar#currenttag('%s','','')}\ %=%B@%O\ %r%P%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}

""""""""""""""""""""""""""""""""""""""
"diff 
set diffopt+=iwhite 
set diffexpr=""
"map tdf :let tg=input("compare to", expand("%<"), 

""""""""""""""""""""""""""""""""""""""
" synatx
"au FileType frag,vert,fp,vp,glsl,vsh,fsh setf glsl 
syntax on
syntax enable
syntax sync minlines=256
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set cursorline		"nocursorline ""hilight current line, nocursorline
set hlsearch
set nu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c/cpp indent
autocmd FileType c,cpp,mm setlocal expandtab
autocmd FileType c,cpp,mm setlocal textwidth=120
autocmd FileType c,cpp,mm setlocal wrap
autocmd FileType c,cpp,mm setlocal cindent
autocmd FileType c,cpp,mm setlocal cinoptions=h4,l1,g4,t0,i4,+4,(0,w1,W4
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" c#  indent 
autocmd FileType cs setlocal expandtab
autocmd FileType cs setlocal tabstop=4
autocmd FileType cs setlocal shiftwidth=4
autocmd FileType cs setlocal softtabstop=4
autocmd FileType cs setlocal autoindent
autocmd FileType cs setlocal textwidth=120
autocmd FileType cs setlocal wrap
autocmd FileType cs setlocal cindent
autocmd FileType cs setlocal cinoptions=f4,>4,h4,l1,g4,t0,i4,+4,(0,w1,W4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python indent
autocmd FileType *.py setlocal set expandtab
autocmd FileType *.py setlocal tabstop=4
autocmd FileType *.py setlocal shiftwidth=4
autocmd FileType *.py setlocal softtabstop=4
autocmd FileType *.py setlocal autoindent
autocmd FileType *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python set makeprg=python\ -c\ \"import\ py_compile,sys;\ sys.stderr=sys.stdout;\ py_compile.compile(r'%')\"
autocmd FileType python set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
autocmd FileType python nmap <F5> :!python %<CR>
autocmd FileType python set tabstop=4
autocmd FileType python set go+=b

" session"
function! SaveSession()
  let ch = confirm("save session ?", "&Yes\n&No", 1)
  if ch == 1
    exe ":wa"
    exe "mksession!"
  else
    echo "save session cancle."
  endif
endfunction
set sessionoptions=curdir,resize,folds,tabpages,resize,winpos,winsize
nmap <F3> :call SaveSession()<CR>
function! LoadSession(noConfirm)
  if filereadable("Session.vim")
    if(a:noConfirm)
      exe ":so Session.vim"
      exe ":UpdateTypesFile"
      return
    endif
    let ch = confirm("load last session ?", "&Yes\n&No", 1)
    if ch == 1
      exe ":so Session.vim"
    else
      echo "load seesion cancled."
    endif
  else
    exe ":NERDTree ."
  endif
endfunction
nmap <F4> :call LoadSession(0)<CR>

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

" comment line."
let g:commentPrefix = '//'
function! CommentLine()
    let commentPattern = '^\s*\t*' . g:commentPrefix
    let line = getline('.')
    if strlen(substitute(line, "[\s\t]", "", "")) < 1
        return
    endif
    if line =~ commentPattern
        let idx = stridx(line, g:commentPrefix[0], 0)
        let newline = strpart(line, 0, idx) 
        let newline = newline . strpart(line, idx + strlen(g:commentPrefix), strlen(line) - strlen(g:commentPrefix))
        call setline('.', newline)
    else
        let newline = g:commentPrefix . line
        call setline('.', newline)
    endif
    echo g:commentPrefix
endfunction
"""autocmd BufEnter *.c,cpp,cs let g:commentPrefix = '//'
"""autocmd BufEnter *.py let g:commentPrefix = '#'
autocmd FileType c,cpp,cs,py map <leader>m :call CommentLine()<CR>
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace current word.
vmap <leader>r "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap <leader>rw "xy:exe "%s/\\<" . @x . "\\>/" . input("replace all [<" . @x . ">] by: ") . "/cg"<CR>
vmap <leader>r$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>
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
		let g:g_my_search_path = expand("%:h") . '/**/*'
	endif
	let g:g_my_search_path = input("search [" . cw . "]: ",  g:g_my_search_path, "dir")
	echo "vimgrep " . cw . " " . g:g_my_search_path . ""
	exe  "vimgrep " . cw . " " . g:g_my_search_path . ""
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
	let newkw = input("Global Replace [" . g:g_my_search_keyword . "] by: ",  '')
	call inputrestore()

	if(a:matchWord == 0 )
		let replaceCmd =  ":s/" . g:g_my_search_keyword . "/" . newkw
	else
		let replaceCmd =  ":s/\\<" . g:g_my_search_keyword . "\\>/" . newkw
	endif
	if a:noConfirm == 0 
		let replaceCmd=  replaceCmd . "/g"
	else
		let replaceCmd=  replaceCmd . "/gc"
	endif
	call inputrestore()
    let lastline = -1
    let lastbnum = -1
    let replacedCnt = 0
	for qf in getqflist()
        try 
            let replacedCnt = replacedCnt + 1
            if qf.lnum == lastline
                echo 'skip line' . qf
                continue
            endif
            if qf.bufnr != lastbnum
                exe ":b" . qf.bufnr
                let lastbnum = qf.bufnr
            endif
            exe "" . qf.lnum . ""
            exe replaceCmd
            let lastline = qf.lnum
        catch /E259:/
            echo 'no fuck   ' . qf
        endtry
	endfor
    echo 'Replaced: ' . replacedCnt . '.'
endfunction

vmap <silent> <leader>gf "xy<CR>:call SearchWordGlobal(@x, 0)<CR>
vmap <silent> <leader>gfw "xy<CR>:call SearchWordGlobal(@x, 1)<CR>
nmap <silent> <leader>gf :call SearchWordGlobal(input("search: ", expand("<cword>")), 0)<CR>
nmap <silent> <leader>gfw :call SearchWordGlobal(input("search: ", expand("<cword>")), 1)<CR>
map <silent> <leader>gr :call ReplaceWordGlobal(1, 1)<CR>
map <silent> <leader>grw :call ReplaceWordGlobal(1, 0)<CR>
map <silent> <leader>u :e!<CR>

let my_g_extralHilight = ''
function! ExtralHilight(newkw)
    if strlen(a:newkw) < 1
        let g:my_g_extralHilight = ''
        return
    endif

    if strlen(g:my_g_extralHilight) > 0 
        let g:my_g_extralHilight = g:my_g_extralHilight . '\|\(' . newkw . '\)'
    endif
    exe '/' . g:my_g_extralHilight
endfunction
vmap <silent> <leader>fh "xy<CR>:call ExtralHilight(@x)<CR>
"}}}

" hex model
nnoremap <silent> hex  :%!xxd<CR>
nnoremap <silent> nhex  :%!xxd -r<CR>

" quick fixs
map <silent> tcn :cn<CR>
map <silent> tcp :cp<CR>
map <silent> tco :copen<CR>
map <silent> tcl :cclose<CR>

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
    exe "normal zf"
"    exe "normal zz"
  endif
endfunction
autocmd FileType c,cpp,h,cs nmap <silent> <leader>zf :call CreateFoldByRegion('{')<CR>


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

""""""""""""""""""""""""""""""for NERDTree"
" >> auto change current directory to current openning file.
let nerdTreeRoot = "."
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
function! OpenCurrentDirByNerd ()
    let curPath = substitute(expand("%:h:p"), '\s\+', '\\&', 'g')
    exe "NERDTree " . curPath
endfunction
nnoremap <silent> <F2> :call OpenCurrentDirByNerd()<CR>

""extract file name from full file location
function! ExtractFileName(fullName)"{{{
    let idot = strridx(a:fullName, "\\")
    if idot < 0 
        let idot = strridx(a:fullName, "/")
    endif
    let fname = strpart(a:fullName, idot + 1, strlen(a:fullName) - idot)
    return fname
endfunction"}}}

"open current file's header or cpp. toc : t mode o open c corespond."
function! OpenCorrespondFile()  "{{{
  let fname=expand("%")
  let ckword = expand('<cword>')
  let idot=strridx(fname, ".")
  if idot >0 
    let exh =tolower(strpart(fname, idot+1, 1))
    let mname = strpart(fname, 0, idot)
    let tryArray = []
    if exh == "c"
      call add(tryArray, mname . ".h")
      call add(tryArray, mname . ".H")
    elseif exh == "cpp"
      call add(tryArray, mname . ".h")
      call add(tryArray, mname . ".H")
    elseif exh == "mm"
      call add(tryArray, mname . ".h")
      call add(tryArray, mname . ".H")
    elseif exh == "h"
      call add(tryArray, mname . ".c")
      call add(tryArray, mname . ".cc")
      call add(tryArray, mname . ".CC")
      call add(tryArray, mname . ".C")
      call add(tryArray, mname . ".cpp")
      call add(tryArray, mname . ".CPP")
      call add(tryArray, mname . ".m")
      call add(tryArray, mname . ".M")
      call add(tryArray, mname . ".mm")
      call add(tryArray, mname . ".MM")
    endif
    let bfnum = bufnr("%")
    set nocsverb
    set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
    for tryFname in tryArray 
      if filereadable(tryFname) 
        break
      else
        let done = 0
        let tryFname = ExtractFileName(tryFname)
        try
          exe "cs f f " . tryFname
          let qflist = getqflist()
          if len(qflist) < 1 
            continue
          endif
          for qf in getqflist() " get file names
            let sfname = bufname(qf.bufnr)
            let sfname = ExtractFileName(sfname)
            if tryFname =~ sfname
              let tryFname = bufname(qf.bufnr)
              let done = 1
              break
            endif
          endfor
          if done == 1
            break
          endif
        catch /E259:/
          let done = 0
          let tryFname = ""
          continue
        endtry
      endif
    endfor
    set cscopequickfix=s-,c-,d-,i-,t-,e-,f0
    set csverb
    if len(tryFname) < 1
      echo "no cooresponed file of : " . expand("%:t")
    else
      exe "e " . fname 
      exe "vs " . tryFname
      call cursor(0, 0)
      let rslt =  search('\<' . ckword . '\>', 'w', line('$'))
      exe "normal zz"
    endif
  else
    echo fname . "is not a valid source file"
  endif
endfunction "}}}open current file's header or cpp. toc : t mode o open c corespond."
autocmd FileType c,cpp nnoremap <silent> toc : call OpenCorrespondFile()<CR>

"hihight tags
"nmap <F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --totals=yes .<CR><CR>
""""""""""""""""""""""""""""""""""""""
"cscope"
if has("cscope")
  set nocsverb
  "if filereadable("../cscope.out")
  "cs add ../cscope.out
  if filereadable("cscope.out")
    exe 'cs add cscope.out' 
  elseif $CSCOPE_DB != ""
    exe 'cs add $CSCOPE_DB' 
  endif
  set csverb
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-,f0
set cst     " nocst
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("%:t")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
"

""""""""""""""""""""""""""""""""""""""
"compiler
autocmd FileType c,cpp,h exe "let g:compiler_gcc_ignore_unmatched_lines=1"


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimgdb
"set previewheight=14
"run macros/gdb_mappings.vim
"set asm=0
"set gdbprg=/usr/bin/gdb

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" buffers switch, switching
function! ListBuffers()
  let bstr = ""
  silent redir => bstr
  silent exe 'ls'
  silent redir END
  let blst = []
  for b in split(bstr, '\n')
    let idx1 = stridx(b, '"', 0)
    let idx2 = strridx(b, '"', strlen(b) - 2)
    let b = strpart(b, idx1 + 1, idx2 - idx1 -1)
    if b[0] == '['
      continue        " skip specail buffer
    else
      call add(blst, b)
    endif
  endfor
  return blst
endfunction

function! SearchFile(openMode) "{{{
  let isDone = 0
  let searchFileCurrentKeyword = input("open:", "", "buffer")
  let choice = -1
  let candidate = []
  let curbuf = bufnr('%')
  set cscopequickfix=s-,c-,d-,i-,t-,e-,f-
  while isDone == 0
    let candidate = []
    let oldqf = getqflist()
    call setqflist(candidate)
    exe "cs find f " . searchFileCurrentKeyword . ""
    echo "--------------------------------------------------------------------------------" 
    let cnt = 0
    let selectList = []
    for qf in getqflist()
      if len(candidate) < 20
        let t = bufname(qf.bufnr)
        let item = '[' . cnt . ']' . t
        call add(selectList, item)
        call add(candidate, t)
        let cnt = cnt + 1
      else
        break
      endif
    endfor
    call setqflist(oldqf, '')
    if len(candidate) < 1
      echo 'no matches!'
      break
    elseif len(candidate) < 5
      let choice = inputlist(selectList)
      if choice > -1 && choice < len(selectList)
        break
      endif
    else 
      for item in selectList
        echo item
      endfor 
      let newfname = input("open:", searchFileCurrentKeyword, "buffer")
      if strlen(newfname) < 1
        echo 'user canceled.'
        break
      elseif newfname == searchFileCurrentKeyword " confirmed
        let choice = 0
        break
      else
        let searchFileCurrentKeyword = newfname
      endif
    endif
  endwhile
  if choice > -1 
    exe "b" . curbuf
    if strlen(a:openMode) > 0
      exe a:openMode . '%'
    endif
    let bnum = bufnr(candidate[choice])
    if bnum > -1
      exe "b" . bnum
    else
      exe "e " . candidate[choice]
    endif
  endif
  let candidate = []
  set cscopequickfix=s-,c-,d-,i-,t-,e-,f0
endfunction "}}}
nmap  <silent> tbs :call SearchFile('')<CR>
nmap  <silent> tvb :call SearchFile('vs')<CR>
nmap  <silent> tsb :call SearchFile('split')<CR>
nmap  <silent> tff :call SearchFile('tabnew')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for svn
nmap <silent> tvd :call SVNDiff()<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim viki
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let wiki_icloud = {}
let wiki_icloud.path = '~/Library/Mobile\ Documents/com~apple~CloudDocs/vimwiki'
let wiki_icloud.index = 'main'
let g:vimwiki_list = [wiki_icloud]
nmap <leader><Space> <Plug>VimwikiToggleListItem

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagHilight
" if ! exists('g:TagHighlightSettings')
"   let g:TagHighlightSettings = {}
" endif
" let g:TagHighlightSettings['CtagsExecutable'] = 'etags'
" let g:TagHighlightSettings['Recurse'] = 'True'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TagList
let g:tagbar_autoclose = 1
nnoremap <silent> T :TagbarToggle<CR>
let g:tagbar_left = 1

""""""""""""""""""""""""""""""""""""""""""" ctags"
"autocmd FileType c,cpp,h,hpp nnoremap ttf: ts expand("<cword>")<CR>
"autocmd! BufWritePost *.h silent exe "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --append=yes " . expand("%")
nnoremap <silent> tpj : exe "ptj " . expand("<cword>") . ""<CR>
set tags=tags

autocmd BufRead,BufNewFile *.proto setfiletype proto

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" youcompleteme
let g:ycm_enable_diagnostic_signs = 1
let g:ycm_warning_symbol = 'w>'
let g:ycm_error_symbol = 'e>'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_auto_stop_csharp_server = 1
let g:ycm_warning_symbol = ''
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_auto_trigger = 1
nnoremap <leader>yc :YcmForceCompileAndDiagnostics<CR>
noremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" color scheme scroller
nmap <leader>cs :SCROLL<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OmniSharp won't work without this setting
" filetype plugin on
let g:Omnisharp_start_server = 1
let g:OmniSharp_selector_ui = 'ctrlp'  " Use ctrlp.vim

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
let g:OmniSharp_typeLookupInPreview = 1

"Timeout in seconds to wait for a response from the server
let g:OmniSharp_timeout = 1

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
" let g:omnicomplete_fetch_documentation=1

"Move the preview window (code documentation) to the bottom of the screen, so it doesn't move the code!
"You might also want to look at the echodoc plugin
set splitbelow

" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic']			", 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    " autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    " autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    " autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    " autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    "  FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    "  FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    "  FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    "     autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    " autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    " autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
" nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
" vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
"  <leader>nm :OmniSharpRename<cr>
" nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
" ! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
"  <leader>rl :OmniSharpReloadSolution<cr>
" nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
"  <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
"  <leader>ss :OmniSharpStartServer<cr>
"  <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

" auto refresh log file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" thumbnail
" nnoremap <leader><tab> :Thumbnail<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" unity lo
let g:nvim_unity_log_linenum = 0
function! OpenUnityLog() 
    let logfileName = expand("~/Library/Logs/Unity/Editor.log")
    print "begin sync unity log..."
    try 
        exe "tabfind " . "unity_log_buf"
        exe "G"
        """  exe "r! sed -n " . g:nvim_unity_log_linenum . ',' . curline . 'p ' . logfileName
        let alst = readfile(logfileName)
        let lastline = len(alst)
        if lastline == g:nvim_unity_log_linenum 
            print 'No fresh log!'
            return 
        endif
        :put =alst[g:nvim_unity_log_linenum: lastline]
        let g:nvim_unity_log_linenum = lastline
    catch /E345:/
        tabnew "unity_log_buf"
        let alst = readfile(logfileName)
        let g:nvim_unity_log_linenum = len(alst)
        :put =alst[0: g:nvim_unity_log_linenum]
        setlocal buftype=nofile
        setlocal noswapfile
    endtry

	exe ":g/^(Filename:/d"
	exe ":g/^UnityEngine\\./d"
	exe ":g/^UnityEditor\\./d"
	exe ":g/^Wizard\\./d"
	exe ":g/^Spoine\\./d"
	exe ":g/^\\s*$/d"
	exe ":g/^\[\\w\\+/d"
	exe ":g/^System\./d"
endfunction
nmap <leader>lg :call OpenUnityLog()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" omni sharp
let g:OmniSharp_selector_ui='ctrlp'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrlp
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_regexp = 1
let g:ctrlp_working_path_mode = 'w'
let g:ctrlp_use_caching = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_depth = 20
let g:ctrlp_by_filename = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:16,results:16'
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'rtscript', 'changes' ]
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/*.meta,*/*.o,*/*.obj,*/*.png,*/*.jpg,*/*.asset,*/*.prefab,*/*.dll        " Linux/MacOSX
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" jedi for python 
""""""""""""""""""""""""""""""""""""""""
" for indent 
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:jedi#auto_initialization = 1
let g:jedi#popup_on_dot = 1
let g:jedi#auto_close_doc = 1
"let g:jedi#completions_command = "<C-N>"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for python completions
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
" language specific completions on markdown file
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')

" utils, optional
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline
"let g:airline_powerline_fonts=1
" let g:airline#extensions#ctrlp#color_template = 'insert' 
" let g:airline#extensions#ctrlp#color_template = 'normal'
" let g:airline#extensions#ctrlp#color_template = 'visual'
" let g:airline#extensions#ctrlp#color_template = 'replace'
" 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git log
let g:GITLOG_default_mode = 2
map <silent> <f7> :call GITLOG_ToggleWindows()<cr>
map <silent> <f8> :call GITLOG_FlipWindows()<cr>
let g:GITLOG_ignore_suffixes=['swp', 'swn', 'pyc', 'o', 'zip', 'tgz', 'gz']
let g:GITLOG_ignore_directories = ['.git', 'out']

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
let g:fzf_layout = { 'window': 'enew' }
let g:fzf_layout = { 'window': '-tabnew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'
