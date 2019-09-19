nnoremap <F11> :<C-u>source $MYVIMRC<CR>
let FLAG_USE_PACKAGE = "False"
let FLAG_COMMON = "True"
let BACKGROUND_COLOR = "none" "none or black or light
let COLORSCHEME = "False"
let FLAG_CURSORLINE = "False"

if hostname() == "workingtower" || hostname() == "mba-win"
	let FLAG_USE_PACKAGE = "False"
	let COLORSCHEME = "railscasts"

elseif hostname() == "backuptower"
	let FLAG_USE_PACKAGE = "True"
	let COLORSCHEME = "railscasts"
	let FLAG_CURSORLINE = "False"

elseif hostname() == "macos.local"
	let FLAG_USE_PACKAGE = "False"
	let COLORSCHEME = "twilight"

elseif hostname() == "www2271.sakura.ne.jp"
	let FLAG_USE_PACKAGE = "False"
	let COLORSCHEME = "railscasts"

endif
"default base16-railscasts.vim  hybrid  jellybeans  lucius  molokai  railscasts  twilight








if FLAG_USE_PACKAGE == "True"
	set runtimepath+=$HOME/.vim
	runtime! $HOME/.vim/conf/*.vim
endif

if COLORSCHEME != "False"
	syntax enable
	execute "autocmd ColorScheme * highlight Normal ctermbg=".BACKGROUND_COLOR
	execute "colorscheme ".COLORSCHEME
	if COLORSCHEME == "molokai"
		hi Comment ctermfg=102
		hi Visual  ctermbg=236
	endif
endif

if FLAG_COMMON == "True"
	set number
	set tabstop=2
	set autoindent
	set backspace=indent,eol,start
	set title
	set showmatch
endif

if FLAG_CURSORLINE == "True"
	set cursorline
	hi LineNr ctermbg=none ctermfg=blue
	hi CursorLine cterm=underline ctermfg=none ctermbg=none
	hi CursorLineNr ctermbg=4 ctermfg=0
	"hi clear CursorLine
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
