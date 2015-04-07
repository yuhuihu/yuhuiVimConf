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
Plugin 'https://github.com/rom399/vim-colorsheme-scroller.git'
Plugin 'https://github.com/majutsushi/tagbar.git'
Plugin 'https://github.com/scrooloose/nerdtree.git'
Plugin 'https://github.com/vimwiki/vimwiki.git'
Plugin 'https://github.com/vim-scripts/DoxygenToolkit.vim.git'
Plugin 'https://github.com/itchyny/thumbnail.vim.git'
Plugin 'https://github.com/scrooloose/syntastic.git'
Plugin 'https://github.com/Valloric/YouCompleteMe.git'
Plugin 'https://github.com/kien/ctrlp.vim.git'
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
syntax on

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
else
  set t_Co=16
  set background=light
  syntax enable
  colo darkblue
  " colo delek
  " murphy		
  " bandit 
  " color  molokai 
  " color lettuce
  " color navajo-night
  " colorscheme candycode 
  " desert256		
  " colorscheme calmar256-light
  " colorscheme xoria256
  " colorscheme molokai
endif

"let &termencoding=&encoding
set fileencodings=utf-8     ",gbk,ucs-bom,cp936
"set termencoding=utf-8,gbk,ucs-bom
"set encoding=utf-8
set laststatus=2
set statusline=%<%F\ %y[buf:%n]%h%m%r%=%-14.(ln:%l,%c%V%)\   
set statusline+=%{&fenc!=''?&fenc:&enc}\ %r%P\ 
set statusline+=[%-12{strftime(\"%m-%d\ %H:%M\")}] 
set updatetime=16000

""""""""""""""""""""""""""""""""""""""
"diff 
set diffopt+=iwhite 
set diffexpr=""
"map tdf :let tg=input("compare to", expand("%<"), 

""""""""""""""""""""""""""""""""""""""
" synatx
"au FileType frag,vert,fp,vp,glsl,vsh,fsh setf glsl 
syntax enable
syntax sync minlines=256
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set cursorline		"nocursorline ""hilight current line, nocursorline
set hlsearch
filetype on
""set expandtab=0
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nu
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python indent
autocmd BufRead *.py setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

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
" c#  indent 
autocmd FileType cs setlocal shiftwidth=4
autocmd FileType cs setlocal tabstop=4
autocmd FileType cs setlocal softtabstop=4
autocmd FileType cs setlocal expandtab
autocmd FileType cs setlocal textwidth=120
autocmd FileType cs setlocal wrap
autocmd FileType cs setlocal cindent
autocmd FileType cs setlocal cinoptions=f4,>4,h4,l1,g4,t0,i4,+4,(0,w1,W4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python indent
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

"Doxygen"
let g:DoxygenToolkit_compactOneLineDoc = "yes"
let g:DoxygenToolkit_authorName="yuhuibear@gmail.com" 
"let g:DoxygenToolkit_licenseTag="private license"   
""

" comment line."
function! CommentLine()
  let commentPrefix = '//'
  let commentPattern = '^\s*\t*' . commentPrefix
  let line = getline('.')
  if strlen(substitute(line, "[\s\t]", "", "")) < 1
    return
  endif
  if line =~ commentPattern
    let idx = stridx(line, commentPrefix[0], 0)
    let newline = strpart(line, 0, idx) 
    let newline = newline . strpart(line, idx + strlen(commentPrefix), strlen(line) - strlen(commentPrefix))
    call setline('.', newline)
  else
    let newline = commentPrefix . line
    call setline('.', newline)
  endif
endfunction
autocmd FileType c,cpp,cs map tm :call CommentLine()<CR>
"

" replace current word.
vmap <leader>r "xy:exe "%s/" . @x . "/" . input("replace all [" . @x . "] by: ") . "/cg"<CR>
vmap <leader>rw "xy:exe "%s/\\<" . @x . "\\>/" . input("replace all [<" . @x . ">] by: ") . "/cg"<CR>
vmap <leader>r$ "xy:exe ",$s/" . @x . "/" . input("replace to end [" . @x . "] by: ") . "/cg"<CR>

let g:yuhuiGlobalSearchPath  = "."
" find word in directories."
function! SearchWordGlobal(vw, replacedBy)
  let cw ="/" .  a:vw . "/g" 
  let distPath = ""
  if strlen(a:replacedBy) > 0
    let distPath = input("replace [" . cw . "] >> [" . a:replacedBy . "] in: ",  g:yuhuiGlobalSearchPath, "dir")
  else
    let distPath = input("search [" . cw . "]: ",  g:yuhuiGlobalSearchPath, "dir")
  endif
  let g:yuhuiGlobalSearchPath = distPath
  let cmdstr =  "noautocmd vimgrep " . cw . " " . distPath . ""
  echo cmdstr
  exe cmdstr
  if strlen(a:replacedBy) > 0
    let replaceCount = 1
    for qf in getqflist()
      exe "cr " . replaceCount 
      exe "b" . qf.bufnr
      call cursor(qf.lnum, qf.col)
      try
        exe "s/" . a:vw . "/" . a:replacedBy . "/gc"
        exe "w"
      catch /E486:/
      endtry
      let replaceCount = replaceCount + 1
    endfor
  else
    exe ":cw"
  endif
endfunction
vmap <silent> <leader>gf "xy<CR>:call SearchWordGlobal(@x, "")<CR>
nmap <silent> <leader>gf :call SearchWordGlobal(input("search: ", expand("<cword>")), "")<CR>
nmap <silent> <leader>gr :call SearchWordGlobal(input("search: ", expand("<cword>")), input("replace by:", ""))<CR>
vmap <silent> <leader>gr "xy<CR>:call SearchWordGlobal(@x, input("replace by:", ""))<CR>
vmap <silent> <leader>grw "xy<CR>:call SearchWordGlobal("\\<" . @x . "\\>", input("replace word by:", ""))<CR>

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
  endif
endfunction
autocmd FileType c,cpp,h nmap <silent> tzf :call CreateFoldByRegion('{')<CR>

" add file discription."
let g:enableAutoFileDescription = 1
function! AddDescription()

  let lineCnt = line("$")
  if lineCnt > 1 || g:enableAutoFileDescription == 0
    return 0
  endif
  let time ="* @" .  strftime("%c") 
  let fileName = expand("%")
  let author = "* created by yuhui."
  let description = ['/******************', ('* file: ' . fileName), '*', '*', author, time, '*******************/']
  let exfn = tolower(strpart(fileName, strlen(fileName)-2, strlen(fileName)))
  if  exfn == ".h"
    let macro = toupper(expand("%"))
    let tidx = strridx(macro, '/')
    let macro = strpart(macro, tidx + 1, strlen(macro) - tidx)
    let macro = substitute(macro, "[ \\./]", "_", "g")
    let macro = substitute(macro, ".\.\w*$", "", "")
    let ifnmacro = "#ifndef " . macro . "_H"
    call add(description, ifnmacro)
    ""echo description
    let defmacro = "#define " . macro . "_H"
    call add(description, defmacro)
    call add(description, " ")
    call add(description, "{")
    call add(description, "}")
    call add(description, "#endif")
  else
    let isSrcFile = tolower(strpart(fileName, strlen(fileName) - 4, 4)) == '.cpp' ? 4 : tolower(strpart(fileName, strlen(fileName) - 2, 2)) == '.c' ? 2 : 0
    if isSrcFile > 0
      let theader = expand("%")
      let theader = substitute(theader, '.*/', '' , '')
      let tidx = strridx(theader, '.')
      let theader = strpart(theader, 0, tidx)
      let theader = '#include "' . theader . '.h"'
      call add(description, theader)
      call add(description, '')
    endif
  endif
  let fail= append(0, description)
  if fail
    return 1
  endif
endfunction
autocmd FileType c,cpp,h exe ":call AddDescription()"

function! Snippet_generate_attrAccessor(attrName)

endfunction

""""""""""""""""""""""""""""""for NERDTree"
" >> auto change current directory to current openning file.
let nerdTreeRoot = "."
nnoremap <silent> <F2> :let curPath =expand("%:h:p")<Bar> exe "NERDTree " . (len(curPath)<1 ?
      \nerdTreeRoot : curPath) . ""<CR>exe ":! cd " . (len(curPath)<1 ?
      \nerdTreeRoot : curPath) . ""<CR>


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

"This is the default value, setting it isn't actually necessary
let g:OmniSharp_host = "http://localhost:2000"

"Set the type lookup function to use the preview window instead of the status line
"let g:OmniSharp_typeLookupInPreview = 1

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
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
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
    " autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    " autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END


" this setting controls how long to wait (in ms) before fetching type / symbol information.
set updatetime=500
" Remove 'Press Enter to continue' message when type information is longer than one line.
set cmdheight=2

" Contextual code actions (requires CtrlP or unite.vim)
nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

" rename with dialog
nnoremap <leader>nm :OmniSharpRename<cr>
" nnoremap <F2> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <leader>rl :OmniSharpReloadSolution<cr>
nnoremap <leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <leader>tp :OmniSharpAddToProject<cr>

" (Experimental - uses vim-dispatch or vimproc plugin) - Start the omnisharp server for the current solution
nnoremap <leader>ss :OmniSharpStartServer<cr>
nnoremap <leader>sp :OmniSharpStopServer<cr>

" Add syntax highlighting for types and interfaces
nnoremap <leader>th :OmniSharpHighlightTypes<cr>
"Don't ask to save when changing buffers (i.e. when jumping to a type definition)
set hidden

