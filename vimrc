nnoremap <F11> :<C-u>source $MYVIMRC<CR>
let FLAG_USE_PACKAGE = "False"
let FLAG_COMMON = "True"
let BACKGROUND_COLOR = "NONE"
let COLORSCHEME = "False"


if hostname() == "workingtower"
	let FLAG_USE_PACKAGE = "True"

elseif hostname() == "backuptower"
	let FLAG_USE_PACKAGE = "True"
	let COLORSCHEME = "default"
	let BACKGROUND_COLOR = "none"
endif
"default base16-railscasts.vim  hybrid.vim  jellybeans.vim  lucius.vim  molokai  railscasts.vim  twilight.vim

if FLAG_USE_PACKAGE == "True"
	set runtimepath+=$HOME/.vim
	runtime! $HOME/.vim/conf/*.vim
endif

if COLORSCHEME != "False"
	syntax enable
	autocmd ColorScheme * highlight Normal ctermbg=black guibg=black guifg=black
	execute "colorscheme ".COLORSCHEME
	set background=light
endif

if FLAG_COMMON == "True"
	set number

	""cursor
	set cursorline
	hi LineNr ctermbg=none ctermfg=blue
	hi CursorLine cterm=underline ctermfg=none ctermbg=none
	hi CursorLineNr ctermbg=4 ctermfg=0
	"hi clear CursorLine
	let &t_SI = "\<Esc>]50;CursorShape=1\x7"
	let &t_EI = "\<Esc>]50;CursorShape=0\x7"

endif