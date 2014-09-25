" VIMRC HEADER ============================================================= {{{

"  Last Modified:	25 Sep 2014  12:27PM

"  Documentation: type :help vim_config or open doc/vim_config.txt

" }}}
" ENVIRONMENT SETTINGS ===================================================== {{{

" Use Vim settings, rather than Vi settings
" This must be first, because it changes other options as a side effect.
set nocompatible

" use pathogen to load plugins
filetype off
call pathogen#infect()
call pathogen#helptags()

" Enable filetype specific plugin files and indent files
filetype plugin indent on

" Set MS_Windows behavior
" source $VIMRUNTIME/mswin.vim
" behave mswin

" Enable keyword matching using %
source $VIMRUNTIME/macros/matchit.vim

" Keep 50 lines of command line history
set history=50

" Setup viminfo file
" Marks will be remembered for the last 100 files edited
" Contents of registers 50 lines deep will be remembered
" Registers with more than 10 Kbyte text are skipped
" Disable the effect of 'hlsearch' when loading viminfo
" No marks stored for files on A: or B:
" Save and restore global variables
" Set path for viminfo
if has('win32')
	set viminfo='100,<50,s10,h,rA:,rB:,!,n$VIM/viminfo
elseif has('unix')
	set viminfo='100,<50,s10,h,!,n$HOME/.vim/viminfo
endif

" Use unix file format even with windows
set fileformats=unix,dos

" Disable alt keys windows behavior - allows user mapping to alt keys
set winaltkeys=no

" Disable backup file generation
set nobackup
set nowritebackup
set noswapfile

" Mouse selecting text will put vim in visual mode instead of selection mode
set selectmode=key

" Set what the right mouse button is used for - shouldn't be using mouse anyway
set mousemodel=popup

" For visual and select mode, do not include the character under cursor
set selection=exclusive

" Change map leader from default \ to ,
let mapleader = ','
let maplocalleader = '\'

" Automatically reread file if it has been modified outside of vim
set autoread

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" }}}
" DISPLAY SETTINGS ========================================================= {{{

" Enable tab pages, disable other gui clutter.
" The 'e' is superceded by g:airline#extensions#tabline#enabled = 1
set guioptions=e

" Enable syntax
syntax on

" Don't try to highlight lines longer than 800 characters
set synmaxcol=800

" Set colorscheme
colorscheme bsbase16
set background=dark

" Enable line numbers
set number

" When selecting text, display width for one line or height for multiple lines
" This value will be displayed under the statusline plugin - airline
set ruler

" Highlight the cursor line in the current window and in normal mode.
augroup cline
    autocmd!
    autocmd WinLeave,InsertEnter * set nocursorline
    autocmd WinEnter,InsertLeave * set cursorline
augroup END

" Set tab size
set tabstop=4
set shiftwidth=4

" Set font
if has('win32')
	set guifont=Consolas:h10
elseif has('unix')
	set guifont=Inconsolata\ 10
endif

" Line Wrap
set nowrap
set showbreak=?
nnoremap <silent> <leader>w :set wrap!<CR>

" List Mode
set nolist
set listchars=tab:>=,eol:¬,extends:>,precedes:<,trail:?
" Toggles invisible characters
nnoremap <silent> <leader>ic :set nolist!<CR>

" Window size and position
set lines=72
set columns=134
winpos 960 0

" Display incomplete commands
set showcmd

" Hide mouse pointer when typing.  Pointer restored if mouse moved
set mousehide

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" New splits will be placed below and to the right
set splitbelow
set splitright

" For filetypes with textwidth, highlight the textwidth+1 column
set colorcolumn=+1
nnoremap <leader>C :call ToggleCC()<CR>

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
augroup last_position
	autocmd!
	autocmd BufReadPost *
				\ if line("'\"") > 1 && line("'\"") <= line("$") |
				\   execute "normal! g`\"" |
				\ endif
augroup END

" Resize splits when the window is resized
augroup window_resize
	autocmd!
	autocmd VimResized * :silent wincmd =
augroup END

" Redraw my screen
nnoremap <leader>R :syntax sync fromstart<cr>:redraw!<cr>

" Maximize/Restore Window
noremap <leader>W :call MaxRestoreWindow()<CR><C-W>=

" Make more context visible when in the middle of a window
set scrolloff=3
set sidescroll=1
set sidescrolloff=10

" Allow visual block selection for lines of uneven length
set virtualedit+=block

" }}}
" FOLDING ================================================================== {{{

set foldmethod=marker
set foldlevelstart=1
set foldcolumn=0
nnoremap <leader>Z :call ToggleFoldColumn()<CR>

" Use <space> to open and close folds
nnoremap <Space> za
vnoremap <Space> za

" Focus the current line.  Basically:
" 1. Close all folds.
" 2. Open just the folds containing the current line.
" 3. Move the line to a little bit (15 lines) above the center of the screen.
" This mapping wipes out the z mark.
nnoremap <leader>z mzzMzvzz15<c-e>`z

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

function! MyFoldText() " {{{
let line = getline(v:foldstart)
 
let nucolwidth = &fdc + &number * &numberwidth
let windowwidth = winwidth(0) - nucolwidth - 3
let foldedlinecount = v:foldend - v:foldstart
 
" expand tabs into spaces
let onetab = strpart(' ', 0, &tabstop)
let line = substitute(line, '\t', onetab, 'g')
 
let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
return line . repeat(" ",fillcharcount) . foldedlinecount . '  '
endfunction " }}}

set foldtext=MyFoldText()

" }}}
" FILETYPE SPECIFIC ======================================================== {{{

" Text file specific ======================================================= {{{
" For all text files set 'textwidth' to 80 characters.
augroup filetype_text
	autocmd!
	autocmd BufEnter,BufWrite *.txt setfiletype text
	autocmd FileType text setlocal textwidth=80
	autocmd FileType text setlocal formatoptions=wantq
	autocmd FileType text setlocal autoindent
augroup END " }}}
" Vim file specific ======================================================== {{{
augroup filetype_vim
	autocmd!
	autocmd FileType vim setlocal textwidth=80
	autocmd FileType vim setlocal foldlevel=0
augroup END " }}}
" VHDL file specfic ======================================================== {{{

augroup filetype_vhdl
	autocmd!
	autocmd BufEnter,BufWrite *.vho setfiletype vhdl

" Increment/Decrement a hex number within quotes =========================== {{{
" Insert underscores every 4 characters
" Vim only supports 8 hex characters
" This should probably be implemented as a function but I'm not a vim script
" wizard so I got frustrated and gave up.	
	autocmd FileType vhdl :command! -buffer -nargs=? HexIncrement 
				\:execute 'normal vi"<Esc>'
				\|:silent! s/\%V_//g
				\|:execute 'normal `<i0x'
				\|:execute 'normal <args><A-a>`<2xt"'
				\|:let numUnderscores=(strlen(expand('<cword>'))-1)/4
				\|:execute 'normal l'
				\|while numUnderscores>0
					\|:execute 'normal 4hi_<Esc>'
					\|:let numUnderscores=numUnderscores-1
				\|:endwhile
				\|:execute 'normal , be'

	autocmd FileType vhdl :command! -buffer -nargs=? HexDecrement 
				\:execute 'normal vi"<Esc>'
				\|:silent! s/\%V_//g
				\|:execute 'normal `<i0x'
				\|:execute 'normal <args><A-x>`<2xt"'
				\|:let numUnderscores=(strlen(expand('<cword>'))-1)/4
				\|:execute 'normal l'
				\|while numUnderscores>0
					\|:execute 'normal 4hi_<Esc>'
					\|:let numUnderscores=numUnderscores-1
				\|:endwhile
				\|:execute 'normal , be'
" }}}
" Add underscores every 4th character to number contained within quotes ==== {{{
	autocmd FileType vhdl :command! -buffer InsertUnderscores 
			\:execute 'normal vi"<Esc>'
			\|:silent! s/\%V_//g
			\|:execute 'normal `<'
			\|:let numUnderscores=(strlen(expand('<cword>'))-1)/4
			\|:execute 'normal `>'
			\|while numUnderscores>0
				\|:execute 'normal 4hi_<Esc>'
				\|:let numUnderscores=numUnderscores-1
			\|:endwhile
			\|:execute 'normal , `<t"'
" }}}
" Format Entity, Component, or Instance ==================================== {{{
	" First Check whether it is an instance or an entity/component
	" Use vim's built in indent =
	" Append a , for instances or a ; for entity/component if not present
	" Remove , for instance or ; for entity/component in the last line if present
	" Align at = for instances or at : for entity/component - use tabs
	" Align at , for instance or at ; for entity/component - use tabs
	" Remove trailing white space
	" Commented lines are ignored, comments at end of line are preserved
	autocmd Filetype vhdl :command! -buffer FormatECI 
				\:execute 'normal va(<Esc>'
				\|:execute 'normal `<'
				\|:let InstanceCheck = search('map', 'bn', line("."))
				\|:if InstanceCheck == 0
				\|	:let EntityCheck = search('port', 'bn', line("."))
				\|:else
				\|	:let EntityCheck = 0
				\|:endif
				\|:if InstanceCheck != 0
				\|	:let EqualColumnMax = 0
				\|	:let CommaColumnMax = 0
				\|	:execute 'normal va(ok=<Esc>'
				\|	:execute 'normal 2jva(<Esc>'
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() == 1
				\|			:continue
				\|		:elseif LineContainsComment() == 2
				\|			:execute 'normal /--<CR>F,'
				\|			:noh
				\|			:if getline(".")[col(".")-1] != ','
				\|				:execute 'normal i,<Esc>'
				\|			:endif
				\|		:else
				\|			:execute 'normal g_'
				\|			:if getline(".")[col(".")-1] != ','
				\|				:execute 'normal a,<Esc>'
				\|			:endif
				\|		:endif
				\|		:execute 'normal ^f=h'	
				\|		:if getline(".")[col(".")-1] == ' ' || getline(".")[col(".")-1] == '	'
				\|			:execute 'normal diw'
				\|		:else
				\|			:execute 'normal l'
				\|		:endif
				\|		:let EqualColumnMax = max([EqualColumnMax,virtcol('.')-1])
				\|		:execute 'normal whdiwi<tab><esc>'
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>"))
				\|		:execute 'normal j'
				\|		:if LineContainsComment() != 1	
				\|			:execute 'normal 0f=20i<Tab>d' . (EqualColumnMax+4) . '|'
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() == 1
				\|			:continue
				\|		:else
				\|			:execute 'normal f,h'
				\|			:if getline(".")[col(".")-1] == ' ' || getline(".")[col(".")-1] == '	'
				\|				:execute 'normal diw'
				\|			:else
				\|				:execute 'normal l'
				\|			:endif
				\|			:let CommaColumnMax = max([CommaColumnMax,virtcol('.')-1])
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() != 1	
				\|			:execute 'normal 0f,20i<Tab>d' . (CommaColumnMax+4) . '|x'
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `>k'
				\|	:while LineContainsComment() == 1
				\|		:execute 'normal k'
				\|	:endwhile
				\|	:execute 'normal ^f,x`>'
				\|	:silent '<,'>s/\s*$//
				\|	:noh
				\|:elseif EntityCheck != 0
				\|	:let ColonColumnMax = 0
				\|	:let ScolonColumnMax = 0
				\|	:execute 'normal va(jok=<Esc>'
				\|	:execute 'normal 2jva(<Esc>'
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() == 1
				\|			:continue
				\|		:elseif LineContainsComment() == 2
				\|			:execute 'normal /--<CR>F;'
				\|			:noh
				\|			:if getline(".")[col(".")-1] != ';'
				\|				:execute 'normal i;<Esc>'
				\|			:endif
				\|		:else
				\|			:execute 'normal g_'
				\|			:if getline(".")[col(".")-1] != ';'
				\|				:execute 'normal a;<Esc>'
				\|			:endif
				\|		:endif
				\|		:execute 'normal ^f:h'
				\|		:if getline(".")[col(".")-1] == ' ' || getline(".")[col(".")-1] == '	'
				\|			:execute 'normal diw'
				\|		:else
				\|			:execute 'normal l'
				\|		:endif
				\|		:let ColonColumnMax = max([ColonColumnMax,virtcol('.')-1])
				\|		:execute 'normal l'
				\|		:if (getline(".")[col(".")-1] =~? '\s')
				\|			:execute 'normal diwi <Esc>'
				\|		:else
				\|			:execute 'normal i <Esc>'
				\|		:endif
				\|		:execute 'normal 2whdiwi<tab><esc>'
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>"))
				\|		:execute 'normal j'
				\|		:if LineContainsComment() != 1	
				\|			:execute 'normal 0f:20i<Tab>d' . (ColonColumnMax+4) . '|'
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() == 1
				\|			:continue
				\|		:else
				\|			:execute 'normal f;h'
				\|			:if getline(".")[col(".")-1] == ' ' || getline(".")[col(".")-1] == '	'
				\|				:execute 'normal diw'
				\|			:else
				\|				:execute 'normal l'
				\|			:endif
				\|			:let ScolonColumnMax = max([ScolonColumnMax,virtcol('.')-1])
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `<'
				\|	:while line(".") < (line("'>") - 1)
				\|		:execute 'normal j^'
				\|		:if LineContainsComment() != 1	
				\|			:execute 'normal 0f;20i<Tab>d' . (ScolonColumnMax+4) . '|x'
				\|		:endif
				\|	:endwhile
				\|	:execute 'normal `>k'
				\|	:while LineContainsComment() == 1
				\|		:execute 'normal k'
				\|	:endwhile
				\|	:execute 'normal ^f;x`>'
				\|	:silent '<,'>s/\s*$//
				\|	:noh
				\|:endif
" }}}
" Align signal declarations ================================================ {{{
autocmd Filetype vhdl :command! -buffer SignalFormat
			\|:silent execute 'normal mz/\CSIGNAL DECLARATION<CR>'
			\|:silent execute 'normal V]z=<Esc>'
			\|:execute 'normal `<j^'
			\|:let ColonColumnMax = 0
			\|:let ScolonColumnMax = 0
			\|:while line(".") <= (line("'>"))
			\|	:if (getline(".") =~? '^\s*signal') || (getline(".") =~? '^\s*constant')
			\|		:if LineContainsComment() == 2
			\|			:execute 'normal /--<CR>F;'
			\|			:noh
			\|			:if getline(".")[col(".")-1] != ';'
			\|				:execute 'normal i;<Esc>'
			\|			:endif
			\|		:else
			\|			:execute 'normal g_'
			\|			:if getline(".")[col(".")-1] != ';'
			\|				:execute 'normal a;<Esc>'
			\|			:endif
			\|		:endif
			\|		:execute 'normal ^eldiwi <esc>'
			\|		:execute 'normal eldt:'
			\|		:let ColonColumnMax = max([ColonColumnMax,virtcol('.')-1])
			\|		:execute 'normal l'
			\|		:if (getline(".")[col(".")-1] =~? '\s')
			\|			:execute 'normal diwi <Esc>'
			\|		:else
			\|			:execute 'normal i <Esc>'
			\|		:endif
			\|	:endif
			\|	:execute 'normal j^'
			\|:endwhile
			\|:execute 'normal `<j^'
			\|:while line(".") <= (line("'>"))
			\|	:if (getline(".") =~? '^\s*signal') || (getline(".") =~? '^\s*constant')
			\|		:execute 'normal 0f:20i<Tab>d' . (ColonColumnMax+4) . '|f;h'
			\|		:if getline(".")[col(".")-1] == ' ' || getline(".")[col(".")-1] == '	'
			\|			:execute 'normal diw'
			\|		:else
			\|			:execute 'normal l'
			\|		:endif
			\|		:let ScolonColumnMax = max([ScolonColumnMax,virtcol('.')-1]) 
			\|	:endif
			\|	:execute 'normal j^'
			\|:endwhile
			\|:execute 'normal `<^'
			\|:while line(".") <= (line("'>"))
			\|	:if (getline(".") =~? '^\s*signal') || (getline(".") =~? '^\s*constant')
			\|		:execute 'normal 0f;20i<Tab>d' . (ScolonColumnMax+4) . '|x'
			\|	:endif
			\|	:execute 'normal j^'
			\|:endwhile
			\|:silent '<,'>s/\s*$//
			\|:execute 'normal `z, '
" }}}
" Create signal declaration ================================================ {{{

" Yank word at cursor, check if signal declaration exists, if not add signal of
" user provided length.  if no length provided, use std_logic
	autocmd FileType vhdl :command! -buffer -nargs=? SignalDeclaration 
			\:let NewSignal = expand("<cword>")
			\|:silent execute 'normal mz/\CSIGNAL DECLARATION<CR>'
			\|:silent execute 'normal V]z<Esc>'
			\|:let SignalRegion=getline(line("'<"),line("'>"))
			\|:let SignalRange="<args>"
			\|:if match(SignalRegion, "^\\s*signal\\s*".NewSignal."\\s\+") > 0
			\|	:echo "signal already exists"
			\|:elseif match(SignalRange, "\\d$") >= 0
			\|	:silent execute 'normal `>Osignal '.NewSignal.'	:	std_logic_vector('.SignalRange.' downto 0);<Esc>'
			\|:elseif match(SignalRange, "\)$") >= 0
			\|	:silent execute 'normal `>Osignal '.NewSignal.'	:	std_logic_vector'.SignalRange.';<Esc>'
			\|:else
			\|	:silent execute 'normal `>Osignal '.NewSignal.'	:	std_logic;<Esc>'
			\|:endif
			\|:execute 'normal `z, '

" }}}
" Add fold with common formatting ========================================== {{{
	autocmd FileType vhdl :command! -buffer -nargs=1 -range Fold 
			\:let FoldName="<args>"
			\|:let FoldNameLength=strlen(FoldName)
			\|:let LeadingChars=(80 - FoldNameLength) / 2 - 1
			\|:let TrailingChars=(77 - FoldNameLength) / 2 - 2
			\|:execute 'normal '.<line2>.'Go<Esc>77i-<Esc>3a}<Esc>'
			\|:execute 'normal '.<line1>.'GO<Esc>'.LeadingChars.'i-<Esc>a <Esc>'
			\|:execute 'normal a'.FoldName.' <Esc>'.TrailingChars.'a-<Esc>3a{<Esc>'

" }}}
" Create testbench ========================================================= {{{
autocmd Filetype vhdl :command! -buffer -nargs=? Testbench 
			\:let vhd_filename = tolower(expand("%:t:r"))
			\|:let tb_filename = "tb_".vhd_filename
			\|:silent execute 'normal /\C^\s\=entity<CR>'
			\|:silent execute 'normal :Viy<CR>'
			\|:silent execute 'normal , '
			\|:if filereadable('tb/'.tb_filename."<args>".".vhd")
			\|	:echo "filename already exists"
			\|:else
			\|	:silent execute 'normal :vsplit tb/'.tb_filename."<args>".".vhd".'<CR>'
			\|	:silent execute 'normal gg/\C^\s\=entity<CR>'
			\|	:silent execute 'normal j0d/\s\=port<CR>'
			\|	:silent execute 'normal d%dd'
			\|	:silent execute 'normal /\CSIGNAL DECLARATION<CR>'
			\|	:silent execute 'normal j0d]z'
			\|	:silent execute "normal Oconstant ClkPeriod		: time	:= 10 ns;<CR><CR>signal	clk	:	std_logic	:=	'0';<Esc>"
			\|	:silent execute 'normal osignal reset	: std_logic;<CR><Esc>'
			\|	:silent execute 'normal /^\s\=begin<CR>'
			\|	:silent execute 'normal o<CR>clk <= not clk after ClkPeriod/2;<Esc>'
			\|	:silent execute "normal o<CR>testloop : process begin<CR>reset <= '1';<CR>reset <= '0' after ClkPeriod*4;<CR>--		assert reset = '1' report <Esc>"
			\|	:silent execute 'normal a"failure - reset = " & to_string(reset) severity failure;<CR>wait;<CR>end process;<Esc>'
			\|	:silent execute 'normal gg/^\s\=architecture<CR>'
			\|	:silent execute 'normal /^\s\=begin<CR>'
			\|	:silent execute 'normal j, '
			\|	:silent execute 'normal :Vii<CR>'
			\|	:silent execute 'normal /\Cport<CR>/(<CR>%,av'
			\|	:let Endofports = line(".")
			\|	:silent execute 'normal %'
			\|	:while line(".") < Endofports
			\|		:if match(getline("."),'=>') >= 0
			\|			:silent execute 'normal $'
			\|			:let SigLength = expand("<cword>")
			\|			:if SigLength == ')'
			\|				:silent execute 'normal "zya('
			\|			:endif
			\|			:silent execute 'normal H/=><CR>w'
			\|			:if SigLength == 'std_logic'
			\|				:silent execute 'normal <A-s><CR>'
			\|			:elseif SigLength == ')'
			\|				:silent execute 'normal <A-s><C-r>z<CR>'
			\|			:endif
			\|			:silent execute 'normal mxvi(<Esc>`>'
			\|			:let Endofports = line(".")
			\|			:silent execute 'normal `x'
			\|		:endif
			\|		:silent execute 'normal j'
			\|	:endwhile
			\|:endif
			\|:silent execute 'normal ,='
			\|:silent execute 'normal ,as'

" }}}
" Create run.do Modelsim Script ============================================ {{{
autocmd Filetype vhdl :command! -buffer -nargs=? ModelsimScript 
			\:let tb_filename = tolower(expand("%"))
			\|:let run_filename = tolower(expand("%:t:r"))
			\|:let source_path = escape('<args>', ' \')
			\|:if empty(source_path)
			\|	:let source_path = 'hdl'
			\|:endif
			\|:if filereadable('tb/'.run_filename.'_run.do')
			\|	:echo "file already exists"
			\|:else
			\|	:silent execute 'normal :vsplit tb/'.run_filename.'_run.do<CR>'
			\|	:if has('win32')
			\|		:read $VIM\vimfiles\ModelsimTemplate.do
			\|	:else
			\|		:read ~/.vim/ModelsimTemplate.do
			\|	:endif
			\|	:silent execute 'normal zRgg'
			\|	:silent execute 'normal /\C^# SIMULATION SOURCE<CR>j'
			\|	:if has('win32')
			\|		:silent execute 'normal !!dir '. source_path .' /S /B /A-D<CR>'
			\|	:else
			\|		:silent execute 'normal !!find '. getcwd() . '/' . source_path .' -type f<CR>'
			\|	:endif
			\|	:silent execute 'normal /\C^# SIMULATION SOURCE<CR>j'
			\|	:while (match(getline("."), "# }}") == -1)
			\|		:if (match(getline("."),"[.]vhd$") >= 0)
			\|			:silent execute 'normal 0d/source<CR>dwxivcom -work work -2008 -explicit		<Esc>j'
			\|		:elseif (match(getline("."),"[.]v$") >= 0)
			\|			:silent execute 'normal 0d/source<CR>dwxivlog -incr -work work -nologo		<Esc>j'
			\|		:elseif (match(getline("."),"[.]sv$") >= 0)
			\|			:silent execute 'normal 0d/source<CR>dwxivlog -incr -work work -nologo -sv	<Esc>j'
			\|		:else
			\|			:delete
			\|		:endif
			\|	:endwhile
			\|	:if (match(tb_filename,"[.]vhd$") >= 0)
			\|		:silent execute 'normal O<C-u>vcom -work work -2008 -explicit		'.tb_filename.'<CR><Esc>'
			\|	:elseif (match(tb_filename,"[.]v$") >= 0)
			\|		:silent execute 'normal O<C-u>vlog -incr -work work -nologo		'.tb_filename.'<CR><Esc>'
			\|	:elseif (match(tb_filename,"[.]sv$") >= 0)
			\|		:silent execute 'normal O<C-u>vlog -incr -work work -nologo -sv	'.tb_filename.'<CR><Esc>'
			\|	:endif
			\|	:silent execute 'normal /\C^# INITIATE SIMULATION<CR>j'
			\|	:while (match(getline("."), "# }}") == -1)
			\|		:if (match(getline("."),"vsim") > -1) && (match(getline("."),"vsim") < 2)
			\|			:silent execute 'normal A'.run_filename
			\|		:endif
			\|		:silent execute 'normal j'
			\|	:endwhile
			\|	:silent execute 'normal /\C^# SIMULATION SOURCE<CR>v]z:s/\\/\//g<CR>'
			\|:endif

" }}}
" Abbreviations ============================================================ {{{
	" NOTE: for multiline abbreviations, a space character is required after the
	" abbreviation name!
	autocmd FileType vhdl :iabbrev <buffer> new_process 
				\<CR>process_name : process (clk)
				\<CR>begin
				\<CR>if rising_edge (clk) then
				\<CR>if reset = '1' then
				\<CR>;
				\<CR>else
				\<CR>;
				\<CR>end if;
				\<CR>end if;
				\<CR>end process;
	autocmd FileType vhdl :iabbrev <buffer> new_instance 
				\<CR>instance_name : entity work.module_name
				\<CR>port map (
				\<CR><C-d><C-d>i_d			=>			,
				\<CR>i_clk		=>	clk		,
				\<CR>i_reset		=>	reset	,
				\<CR>o_q			=>
				\<CR><C-d>);
	autocmd FileType vhdl :iabbrev <buffer> new_sm 
				\<CR>---------------------------- STATE MACHINE ------------------------------{{{
				\<CR>current_state_process : process (clk, reset)
				\<CR>begin
				\<CR>if reset = '1' then
				\<CR>STATE <= IDLE;
				\<CR>elsif rising_edge (clk) then
				\<CR>STATE <= NEXT_STATE;
				\<CR>end if;
				\<CR>end process current_state_process;
				\<CR>
				\<CR>next_state_process : process (STATE)
				\<CR>begin
				\<CR>case STATE is
				\<CR>when IDLE =>
				\<CR>NEXT_STATE <= RUN;
				\<CR>when RUN =>
				\<CR>NEXT_STATE <= IDLE;
				\<CR>when others =>
				\<CR>null;
				\<CR>end case;
				\<CR>end process next_state_process;
				\<CR>
				\<CR>state_machine_output : process (clk, reset, STATE)
				\<CR>begin
				\<CR>if rising_edge (clk) then
				\<CR>if reset = '1' then
				\<CR>state_machine_output <= '0';
				\<CR>else
				\<CR>case STATE is
				\<CR>when IDLE =>
				\<CR>state_machine_output <= '0';
				\<CR>when RUN =>
				\<CR>state_machine_output <= '1';
				\<CR>when others =>
				\<CR>null;
				\<CR>end case;
				\<CR>end if;
				\<CR>end if;
				\<CR>end process state_machine_output;
				\<CR>-------------------------------------------------------------------------}}}

	autocmd FileType vhdl :iabbrev <buffer> slv std_logic_vector
	autocmd FileType vhdl :iabbrev <buffer> sl std_logic
	autocmd FileType vhdl :iabbrev <buffer> zoth (others => '0')

" }}}
" Highlight Tags =========================================================== {{{
	autocmd BufRead,BufNewFile *.vhd 
				\:if(filereadable("tags.vim"))
				\|	:silent source tags.vim
				\|:endif
" }}}
" Map commands ============================================================= {{{
	autocmd FileType vhdl :nnoremap <buffer> <A-H> :HexIncrement<CR>
	autocmd FileType vhdl :nnoremap <buffer> <A-h> :HexDecrement<CR>
	autocmd FileType vhdl :nnoremap <buffer> <A-_> :InsertUnderscores<CR>
	autocmd FileType vhdl :nnoremap <buffer> <leader>av :FormatECI<CR>
	autocmd FileType vhdl :nnoremap <buffer> <leader>as :SignalFormat<CR>
	autocmd FileType vhdl :nnoremap <buffer> <A-s> :SignalDeclaration 
" }}}

augroup END " }}}
" Verilog file specific ==================================================== {{{

augroup filetype_verilog
	autocmd!

" Increment/Decrement a hex number preceded by h =========================== {{{
" Insert underscores every 4 characters
" Vim only supports 8 hex characters
" This should probably be implemented as a function but I'm not a vim script
" wizard so I got frustrated and gave up.	
	autocmd FileType verilog_systemverilog :command! -buffer -nargs=? HexIncrement 
				\:execute 'normal viw<Esc>'
				\|:silent! s/\%V_//g
				\|:execute 'normal `<a0x'
				\|:execute 'normal <args><A-a>`<l2xe'
				\|:let numUnderscores=(strlen(expand('<cword>'))-2)/4
				\|:execute 'normal l'
				\|while numUnderscores>0
					\|:execute 'normal 4hi_<Esc>'
					\|:let numUnderscores=numUnderscores-1
				\|:endwhile
				\|:execute 'normal , be'

	autocmd FileType verilog_systemverilog :command! -buffer -nargs=? HexDecrement 
				\:execute 'normal viw<Esc>'
				\|:silent! s/\%V_//g
				\|:execute 'normal `<a0x'
				\|:execute 'normal <args><A-x>`<l2xe'
				\|:let numUnderscores=(strlen(expand('<cword>'))-2)/4
				\|:execute 'normal l'
				\|while numUnderscores>0
					\|:execute 'normal 4hi_<Esc>'
					\|:let numUnderscores=numUnderscores-1
				\|:endwhile
				\|:execute 'normal , be'
" }}}
" Add underscores every 4th character to number contained within quotes ==== {{{
	autocmd FileType verilog_systemverilog :command! -buffer InsertUnderscores 
			\:execute 'normal viw<Esc>'
			\|:silent! s/\%V_//g
			\|:execute 'normal `<'
			\|:let numUnderscores=(strlen(expand('<cword>'))-2)/4
			\|:execute 'normal el'
			\|while numUnderscores>0
				\|:execute 'normal 4hi_<Esc>'
				\|:let numUnderscores=numUnderscores-1
			\|:endwhile
			\|:execute 'normal , `<e'
" }}}
" Highlight Tags =========================================================== {{{
	autocmd BufRead,BufNewFile *.v 
				\:if(filereadable("tags.vim"))
				\|	:silent source tags.vim
				\|:endif
" }}}
" Map Commands ============================================================= {{{	
	autocmd FileType verilog_systemverilog :nnoremap <buffer> <A-H> :HexIncrement<CR>
	autocmd FileType verilog_systemverilog :nnoremap <buffer> <A-h> :HexDecrement<CR>
	autocmd FileType verilog_systemverilog :nnoremap <buffer> <A-_> :InsertUnderscores<CR>
" }}}

augroup END " }}}
" Quick Fix file specific ================================================== {{{
" Grep results are displayed in the quick fix window.
" Allow <ESC> to close window
augroup filetype_qf
	autocmd!
	autocmd FileType qf call s:quickfix_settings()
augroup END

function! s:quickfix_settings()
	nnoremap <buffer> <ESC> :q<CR>
endfunction " }}}
" Do files ================================================================= {{{
augroup filetype_tcl
	autocmd!
	autocmd BufEnter,BufWrite *.do setfiletype tcl
	autocmd BufEnter,BufWrite *.do set foldlevelstart=0
augroup END " }}}

" }}}
" SEARCH =================================================================== {{{

" Ignore search case
set ignorecase

" Enable search highlighting
set hlsearch

" Do incremental searching
set incsearch

" Don't move on * or #, use n or N instead
nnoremap * *<c-o>
nnoremap # #<c-o>

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Allow visual mode search
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>

" Use sane regexes
"nnoremap / /\v
"vnoremap / /\v

" Clear highlighting after search
noremap <silent> <leader><space> :noh<cr>

" Grep word under cursor - all files
" including subfolders in new split
nnoremap <leader>gW <C-W>v:execute "noautocmd lvimgrep/" . expand("<cword>") . "/gj **" <Bar> lw<CR>

" Grep word under cursor - only .vhd .v & .sv files
" including subfolders in new split
nnoremap <leader>gw <C-W>v:execute "noautocmd lvimgrep/" . expand("<cword>") . "/gj **/*.v **/*.sv **/*.vhd" <Bar> lw<CR>

" Grep an expression - search files including subfolders - all files
command! -nargs=1 GrepExpressionAll :execute "noautocmd lvimgrep/" . <args> ."/gj **" <Bar> lw <Bar>
nnoremap <leader>gE <C-W>v:GrepExpressionAll "

" Grep an expression - search files including subfolders - .v .vhd .sv only
command! -nargs=1 GrepExpressionHDL :execute "noautocmd lvimgrep/" . <args> ."/gj **/*.v **/*.sv **/*.vhd" <Bar> lw <Bar>
nnoremap <leader>ge <C-W>v:GrepExpressionHDL "

" Grep a selection - search files including subfolders - all files
vnoremap <leader>gS "vy<Esc><C-W>v:execute "noautocmd lvimgrep/<C-r>v/gj **" <Bar> lw <CR>

" Grep a selection - search files including subfolders - .v .vhd .sv only
vnoremap <leader>gs "vy<Esc><C-W>v:execute "noautocmd lvimgrep/<C-r>v/gj **/*.v **/*.sv **/*.vhd" <Bar> lw <CR>

" }}}
" AUTOCOMPLETE ============================================================= {{{

" setup autocomplete for command mode - Use Tab to initiate and navigate
set wildmenu
set wildchar=<Tab>

" do not include the following file types
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll
set wildignore+=*.sw?

" setup autocomplete for insert mode - only use current file
set complete=.

" autocomplete word
inoremap <C-Space> <C-n>
" autocomplete filename
inoremap <C-f> <C-x><C-f>
" autocomplete line
inoremap <C-l> <C-x><C-l>

" }}}
" COMMENTS ================================================================= {{{

" Comment and Uncomment selection
noremap <leader>c :call Visual_comment()<CR>
noremap <leader>x :call Visual_uncomment()<CR>

augroup comment_settings
	autocmd!
	" Generate comment string specific to the file type - used for folding markers
	autocmd BufReadPost,BufWritePost * call GenerateCommentString()
augroup END

" }}}
" QUICK EDITING ============================================================ {{{

" open vimrc and load vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" Source
vnoremap <leader>S y:execute @@<cr>:echo 'Sourced selection.'<cr>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" }}}
" NAVIGATION =============================================================== {{{

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L $
vnoremap L g_

" Tab related mappings
nnoremap <C-t> :tabnew<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-left> :tabmove -1<CR>
nnoremap <C-right> :tabmove +1<CR>

" Buffer related mappings
nnoremap <C-space> :bn<CR>

" Keep cursor in the middle of the window when jumping in TAG LIST
" when creating a new split, split vertically
nnoremap <C-w>] <C-w>]<C-w>Lzvzz15
nnoremap <C-]> <C-]>zvzz15
nnoremap <C-\> <C-T>zvzz15

" Keep cursor in the middle of the window when jumping in JUMP LIST
nnoremap <Tab> <C-I>zvzz15
nnoremap <S-Tab> <C-O>zvzz15

" Keep cursor in the middle of the window when jumping in CHANGE LIST
nnoremap g; g;zvzz15
nnoremap g, g,zvzz15

" Ctags file generation
" Modified to only tag vhdl entities and verilog modules
" To keep tags up to date, run :ctags<CR> whenever a new entity is created
" Be sure to set the path to the project root to get all files in the design
"cabbrev ctags silent !ctags -R --languages=vhdl,verilog --vhdl-kinds=e --verilog-kinds=m<CR>:redraw!<CR>
command! Ctags 
			\:execute 'normal :silent !ctags -R --languages=vhdl,verilog --vhdl-kinds=e --verilog-kinds=m<CR>'
			\|:redraw!
			\|:split tags
			\|:silent %s/^\([^	:]*:\)\=\([^	]*\).*/syntax keyword Tag \2/
			\|:silent wq! tags.vim
			\|:silent tabdo windo if((&filetype == 'vhdl') || (&filetype == 'verilog_systemverilog')) 
			\|	:silent source tags.vim
			\|:endif
			\|:noh

" Scroll inactive window
nnoremap <A-Y> <C-Y>
nnoremap <silent> <A-j> :call ScrollOtherWindow("down")<CR>
nnoremap <silent> <A-k> :call ScrollOtherWindow("up")<CR>
nnoremap <silent> <A-f> :call ScrollOtherWindow("pagedown")<CR>
nnoremap <silent> <A-b> :call ScrollOtherWindow("pageup")<CR>

" Open File Manager or Terminal at the current working directory or the location
" of the current file. I was using the vim-gtfo plugin; however, it does not
" work with konsole, so i've just duplicated the portion interesting to me here.
" If in the future, that plugin is updated, this section can be replaced.

if has('win32')
	nnoremap gof :silent exec '!start explorer '.expand("%:h")<CR>
	nnoremap goF :silent exec '!start explorer '.getcwd()<CR>
	nnoremap got :silent exec '!start '.$COMSPEC.' /k "cd "'.expand("%:h").'""'<CR>
	nnoremap goT :silent exec '!start '.$COMSPEC<CR>
elseif has('unix')
	if executable('xdg-open')
    	nnoremap gof :silent exec "!xdg-open '".expand("%:h")."' &"<CR>
    	nnoremap goF :silent exec "!xdg-open '".getcwd()."' &"<CR>
	endif
	if executable('konsole')
		nnoremap got :silent exec 'silent ! konsole --workdir '.expand("%:h")<CR>
		nnoremap goT :silent exec 'silent ! konsole'<CR>
	endif
endif

" }}}
" MISCELLANEOUS MAPPINGS =================================================== {{{

" make Y work like C and D
nnoremap Y y$

" copy and paste from system clipboard
nnoremap <leader>p "*p
vnoremap <leader>y "*y

" Load session via the gui
noremap <leader>ls :browse so<CR>

" Save session via the gui
noremap <leader>ss :browse mksession!<CR>

" Print a hardcopy
nnoremap <leader>P :hardcopy<CR>

" Map increment/decrement to alt-a and alt-x. <C-a> is select all in windows
nnoremap <A-a> <C-a>
nnoremap <A-x> <C-x>

" Set increment and decrement commands to work for decimal and hex only.
set nrformats=hex 

" Don't use Ex mode, use Q for formatting
noremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Move line or selection down
nnoremap <C-j> :m .+1<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv

" Move line or selection up
nnoremap <C-k> :m .-2<CR>==
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-k> :m '<-2<CR>gv=gv

" Reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

" Enable the normal mode repeat command . to operate on all lines of a selection
vnoremap . :norm.<CR>

" Quotes/Parenthesis around visual mode selection
vnoremap <leader>' <Esc>`<i'<Esc>`>a'<Esc>
vnoremap <leader>" <Esc>`<i"<Esc>`>a"<Esc>
vnoremap <leader>) <Esc>`<i(<Esc>`>a)<Esc>
vnoremap <leader>( <Esc>`<i(<Esc>`>a)<Esc>

" Vertical Split with Scroll Binding
noremap <leader>vs :vs<CR>
noremap <silent> <Leader>vS gg:<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" Eliminate dos format ^M characters in file
cabbrev dos2unix %s/\r//g

" Eliminate white space at the end of each line in file
cabbrev del_ws %s/\s*$//

" Eliminate blank lines for visual selection
" If no visual selection, operates on entire file
cabbrev del_bl g/^\s*$/d

" Change the current directory to the directory of the current file
cabbrev fcd cd %:h

" Change the current directory to the directory of the current file, then
" if there is a tags file found in a parent directory, change to that directory
cabbrev fcdt call FindRootDirectory()

" Open help in a new tab
cabbrev ht tab help

" Open help in a right vertical split
cabbrev hr vertical rightbelow help

nnoremap <leader><leader> :vertical rightbelow help cheat<CR>

" Disable default mappings ================================================= {{{

" Disable help key
noremap <F1> <nop>

" Disable arrow keys to force use of hjkl in normal mode
"noremap <up> <nop>
"noremap <down> <nop>
"noremap <left> <nop>
"noremap <right> <nop>

" Disable arrow keys to force use of hjkl in visual/select mode
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>

" Disable arrow keys in insert mode to force use of normal mode for navigation
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Modify arrow key functionality in normal mode to begin cycling through command
" line history for <up>.  Disable other arrow keys in normal mode
nnoremap <up> :<up>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" }}}

" Alignment ================================================================ {{{

" Alignment command for , : ; < ( ) = " '
" After <A-char>, type the column at which to align character then <CR>
command! -nargs=1 -range AlignComma		:<line1>,<line2>normal 0f,20i<Tab>d<args>|
command! -nargs=1 -range AlignColon		:<line1>,<line2>normal 0f:20i<Tab>d<args>|
command! -nargs=1 -range AlignScolon	:<line1>,<line2>normal 0f;20i<Tab>d<args>|
command! -nargs=1 -range AlignLt		:<line1>,<line2>normal 0f<20i<Tab>d<args>|
command! -nargs=1 -range AlignOpenp		:<line1>,<line2>normal 0f(20i<Tab>d<args>|
command! -nargs=1 -range AlignClosep	:<line1>,<line2>normal 0f)20i<Tab>d<args>|
command! -nargs=1 -range AlignEqual		:<line1>,<line2>normal 0f=20i<Tab>d<args>|
command! -nargs=1 -range AlignQuote		:<line1>,<line2>normal 0f"20i<Tab>d<args>|
command! -nargs=1 -range AlignApos		:<line1>,<line2>normal 0f'20i<Tab>d<args>|
vnoremap <A-,> :AlignComma 
vnoremap <A-;> :AlignScolon 
vnoremap <A-<> :AlignLt 
vnoremap <A-(> :AlignOpenp 
vnoremap <A-)> :AlignClosep 
vnoremap <A-=> :AlignEqual 
vnoremap <A-"> :AlignQuote 
vnoremap <A-'> :AlignApos 
vnoremap <A-:> :AlignColon 

" Format file/selection with proper indentation
nnoremap <leader>= mzgg=G`z<CR>
"vnoremap = =gv

" }}} 

" }}}
" TEMPLATE SETTINGS ======================================================== {{{

augroup template_settings
	autocmd!

	" Load Template when creating new vhdl file
	if has('win32')
		autocmd BufNewFile *.vhd 0r $VIM\vimfiles\skeleton.vhd
	elseif has('unix')
		autocmd BufNewFile *.vhd 0r ~/.vim/skeleton.vhd
	endif

	" Evaluate expressions in template
	autocmd BufNewFile * silent %substitute#\[:VIM_EVAL:\]\(.\{-\}\)\[:END_EVAL:\]#\=eval(submatch(1))#ge

	" Update Last Modified header field after each save
	autocmd BufWritePre *.vhd call LastModified()

	" Update module date after each save
	autocmd BufWritePre *.vhd call LastModifiedReg1()

	" Update module time after each save
	autocmd BufWritePre *.vhd call LastModifiedReg2()

	" Update last modified in vimrc
	autocmd BufWritePre $MYVIMRC call LastModified()

augroup END

" }}}
" PLUGIN SETTINGS ========================================================== {{{

" AIRLINE ================================================================== {{{

set laststatus=2
set noshowmode

" Display current line/total lines: current virtual column
let g:airline_section_z = "%3l/%L:%3v"

" Set colors for airline
let g:airline_theme = "bsbase16"

" Disable whitespace checking
let g:airline#extensions#whitespace#enabled = 0

" Add path to statusline - only include first 60 characters
let g:airline_section_b = "%{strpart(getcwd(),0,60)}"
let g:airline_section_c = "%t"

" Disable paste mode detection
let g:airline_detect_paste = 0

" Control when to truncate each section
let g:airline#extensions#default#section_truncate_width = {
      \ 'b': 120,
      \ 'x': 80,
      \ 'y': 80,
      \ 'z': 60,
      \ }

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" }}}
" AUTOCLOSE ================================================================ {{{

nmap <Leader>ac <Plug>ToggleAutoCloseMappings

" }}}
" CTRLP ==================================================================== {{{
"
" set the maximum height of the match window
let g:ctrlp_max_height = 20

" set root marker
let g:ctrlp_root_markers = ['tags']

" disable cache clear on session close
let g:ctrlp_clear_cache_on_exit = 0

" scan all files
let g:ctrlp_max_files = 0

" disable search history
let g:ctrlp_max_history = 0

" update match window after typing has stoped for 250ms
let g:ctrlp_lazy_update = 1

" don't remember recently opened files
let g:ctrlp_mruf_max = 0
let g:ctrlp_mruf_save_on_update = 0

" enable extensions
let g:ctrlp_extensions = ['tag']

nnoremap <leader>b :CtrlPBuffer<CR>

" }}}
" INDENT GUIDES ============================================================ {{{

" enable at startup
let g:indent_guides_enable_on_vim_startup = 1

" exclude help and startify files
let g:indent_guides_exclude_filetypes = ['help', 'startify', 'text']

" }}}
" STARTIFY ================================================================= {{{

let g:startify_list_order = ['files']
let g:startify_skiplist = [ 
			\ '_vimrc' ,
			\ 'vimrc' ,
			\ 'doc\.*' ]
let g:startify_files_number = 26
let g:startify_change_to_dir = 1
let g:startify_enable_special = 0
let g:startify_custom_footer = ' '

" Set colors
augroup filetype_startify
	autocmd!
	autocmd FileType startify highlight StartifyBracket	guifg=#6a9fb5 "blue
	autocmd FileType startify highlight StartifyFile	guifg=#f4bf75 "yellow
	autocmd FileType startify highlight StartifyHeader	guifg=#90a959 "green
	autocmd FileType startify highlight StartifyFooter	guifg=#90a959 "green
	autocmd FileType startify highlight StartifyNumber	guifg=#e0e0e0 "white
	autocmd FileType startify highlight StartifyPath	guifg=#6a9fb5 "blue
	autocmd FileType startify highlight StartifySlash	guifg=#f4bf75 "yellow
	autocmd FileType startify highlight StartifySpecial	guifg=#f4bf75 "yellow
augroup END
" Fun header images {{{
let g:startify_custom_header = [
			\ '               ,''``.._   ,''``.								',
			\ '              :,--._:)\,:,._,.:       All Glory to			',
			\ '              :`--,''''   :`...'';\      the HYPNO TOAD!		',
			\ '               `,''       `---''  `.							',
			\ '               /                 :							',
			\ '              /                   \							',
			\ '            ,''                     :\.___,-.				',
			\ '           `...,---''``````-..._    |:       \				',
			\ '             (                 )   ;:    )   \  _,-.			',
			\ '              `.              (   //          `''    \		',
			\ '               :               `.//  )      )     , ;		',
			\ '             ,-|`.            _,''/       )    ) ,'' ,''		',
			\ '            (  :`.`-..____..=:.-'':     .     _,'' ,''		',
			\ '             `,''\ ``--....-)=''    `._,  \  ,'') _ ''``._	',
			\ '          _.-/ _ `.       (_)      /     )'' ; / \ \`-.''	',
			\ '         `--(   `-:`.     `'' ___..''  _,-''   |/   `.)		',
			\ '             `-. `.`.``-----``--,  .''						',
			\ '               |/`.\`''        ,'',''); 						',
			\ '                   `         (/  (/							',
			\ ]

"let g:startify_custom_header = [
"			\ '               ,---. 						',
"			\ '            ,.''-.   \ 						',
"			\ '           ( ( ,''"""""-. 					',
"			\ '           `,X          `. 					',
"			\ '           /` `           `._ 				',
"			\ '          (            ,   ,_\ 				',
"			\ '          |          ,---.,''o `. 			',
"			\ '          |         / o   \     ) 			',
"			\ '           \ ,.    (      .____, 			',
"			\ '            \| \    \____,''     \ 			',
"			\ '          ''`''\  \        _,____,'' 		',
"			\ '          \  ,--      ,-''     \ 			',
"			\ '            ( C     ,''         \ 			',
"			\ '             `--''  .''           | 			',
"			\ '               |   |         .O | 			',
"			\ '             __|    \        ,-''_ 			',
"			\ '            / `L     `._  _,''  '' `. 		',
"			\ '           /    `--.._  `'',.   _\  ` 		',
"			\ '           `-.       /\  | `. ( ,\  \ 		',
"			\ '          _/  `-._  /  \ |--''  (     \ 		',
"			\ '         ''  `-.   `''    \/\`.   `.    ) 	',
"			\ '               \           \ `.  |    | 		',
"			\ ]

" }}}

" }}}

" }}}
" FUNCTIONS ================================================================ {{{

" Generate comment string for folding markers ============================== {{{
function! GenerateCommentString()
  let ext = tolower(expand('%:e'))
  let ext_vimrc = tolower(expand("%:t:r"))
  if ext == 'vhd'
	set commentstring=\-\-%s
  elseif ext == 'xdc' || ext == 'ucf' || ext == 'sdc' || ext == 'tcl' || ext == 'qsf' || ext == 'do'
	set commentstring=\ \#%s
  elseif ext == 'v' || ext == 'sv' || ext == 'c' || ext == 'h'
	set commentstring=\/\/%s
  elseif &filetype == 'vim'
	set commentstring=\ \"%s
  endif
endfunction " }}}
" Comment and Uncomment a block of text ==================================== {{{
function! Visual_comment()
  let ext = tolower(expand('%:e'))
  let ext_vimrc = tolower(expand("%:t:r"))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
	silent s/^/\#/
  elseif ext == 'js'
	silent s:^:\/\/:g
"  elseif ext == 'vim' || ext_vimrc == '_vimrc'
  elseif &filetype == 'vim'
	silent s:^:\":g
  elseif ext == 'vhd'
	silent s:^:\-\-:g
  elseif ext == 'xdc' || ext == 'ucf' || ext == 'sdc' || ext == 'tcl' || ext == 'qsf' || ext == 'do'
	silent s:^:\#:g
  elseif ext == 'v' || ext == 'sv' || ext == 'c' || ext == 'h'
	silent s:^:\/\/:g
  endif
endfunction

function! Visual_uncomment()
  let ext = tolower(expand('%:e'))
  let ext_vimrc = tolower(expand("%:t:r"))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
	silent! s/^\#//
  elseif ext == 'js'
	silent! s:^\/\/::g
  elseif &filetype == 'vim'
"  elseif ext == 'vim' || ext_vimrc == '_vimrc'
	silent! s:^\"::g
  elseif ext == 'vhd'
	silent! s:^\-\-::g
  elseif ext == 'xdc' || ext == 'ucf' || ext == 'sdc' || ext == 'tcl' || ext == 'qsf' || ext == 'do'
	silent! s:^\#::g
  elseif ext == 'v' || ext == 'sv' || ext == 'c' || ext == 'h'
	silent! s:^\/\/::g
  endif
endfunction " }}}
" Update module date after each save ======================================= {{{
function! LastModifiedReg1()
  if &modified
    let save_cursor = getpos(".")
    let n = min([80, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}module_date\s*:\s*out\s*std_logic_vector(31 downto 0) := x"\).*#\1' .
          \ strftime('%m%d_%Y"	;') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfunction " }}}
" Update module time after each save ======================================= {{{
function! LastModifiedReg2()
  if &modified
    let save_cursor = getpos(".")
    let n = min([80, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}module_time\s*:\s*out\s*std_logic_vector(31 downto 0) := x"\).*#\1' .
          \ strftime('%H%M_%S00"	;') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfunction " }}}
" Update Last Modified header field after each save ======================== {{{
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last Modified:\).*#\1' .
          \ strftime('\t%d %b %Y  %I:%M%p') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfunction " }}}
" Diff Functions =========================================================== {{{

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set diffopt=filler,vertical,context:0

" Diff split
nnoremap <leader>ds :diffthis<CR><C-w>w:diffthis<CR>

" Diff since last save
nnoremap <leader>do :DiffOrig<CR>

" Diff off
nnoremap <leader>D :diffoff!<CR>

" }}}
" Maximize or restore window size ========================================== {{{
let g:windowmaximized = 0
function! MaxRestoreWindow()
	if has('win32')
		if g:windowmaximized == 1
			let g:windowmaximized = 0
			" restore the window
			:simalt ~r
		else
			let g:windowmaximized = 1
			" maximize the window
			:simalt ~x
		endif
	elseif has('unix')
		if g:windowmaximized == 1
			let g:windowmaximized = 0
			" restore the window
			:call system('wmctrl -i -b remove,maximized_vert,maximized_horz -r '.v:windowid)
		else
			let g:windowmaximized = 1
			" maximize the window
			:call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid)
		endif
	endif
endfunction " }}}
" Scroll inactive window =================================================== {{{
function! ScrollOtherWindow(dir)
  exec "normal \<C-W>p"
  if a:dir == "down"
    let move = "\<C-E>"
  elseif a:dir == "up"
    let move = "\<A-Y>"
  elseif a:dir == "pagedown"
	  if line(".") < line("$")
		  let move = "\<C-D>"
	  else
		  let move = ""
	  endif
  elseif a:dir == "pageup"
	  if line(".") > 1
    	let move = "\<C-U>"
	  else
		let move = ""
	endif
  endif
  exec "normal " . move . "\<C-W>p"
endfunction " }}}
" Visual mode searching - handle special characters ======================== {{{
function! s:VSetSearch(cmdtype)
	let temp = @s
	norm! gv"sy
	let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
	let @s = temp
endfunction " }}}
" Toggle ColorColumn ======================================================= {{{
" if the textwidth is set to 0, alternate between off and lines at 80 & 120
" if the textwidth is not 0, alternate between off and a line at textwdith+1
function! ToggleCC()
	if &textwidth=="0"
		if &colorcolumn=="+1"
			set colorcolumn=80,120
		else
			set colorcolumn=+1
		endif
	else
		if &colorcolumn=="+1"
			set colorcolumn=""
		else
			set colorcolumn=+1
		endif
	endif
endfunction " }}}
" Toggle FoldColumn ======================================================== {{{
function! ToggleFoldColumn()
	if &foldcolumn==0
		set foldcolumn=4
	else
		set foldcolumn=0
	endif
endfunction "}}}
" Find Root Directory ====================================================== {{{
function! FindRootDirectory()
	cd %:h	
	if filereadable(findfile("tags",".;"))
		while filereadable("tags")==0
			cd..
		endwhile
	else
		cd %:h
	endif
	if filereadable("tags.vim")
		silent source tags.vim
	endif	
endfunction " }}}
" Check for commented line ================================================= {{{
" Return 0 = no comment
" Return 1 = comment at beginning of line
" Return 2 = comment not at beginning of line
function! LineContainsComment()
	let save_cursor = getpos(".")
	execute 'normal g_'
	let CommentCheck = search("--", 'bn', line("."))
	execute 'normal ^'
	if CommentCheck == 0
		let CommentOutput = 0
	elseif getline(".")[col(".")-1] == '-'
		let CommentOutput = 1
	else
		let CommentOutput = 2
	endif
	call setpos('.', save_cursor)
	return CommentOutput
endfunction "}}}
" }}}
