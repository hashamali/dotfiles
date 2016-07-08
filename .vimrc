set nocompatible
filetype off


" vundle configuration
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/Vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'szw/vim-maximizer'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
Plugin 'OrangeT/vim-csharp'


call vundle#end()
filetype plugin indent on


" enable syntax processing and set color scheme
syntax enable
set background=dark
colorscheme solarized


" set tabs to 4 spaces
set tabstop=4
set softtabstop=4
set expandtab


" show line number
set number


" show current command
set showcmd


" highlight current line
set cursorline


" enable wild menu
set wildmenu


" don't redraw unnecessarily
set lazyredraw


" highlight matches
set showmatch


" search while typing and highlight matches in the process
set incsearch
set hlsearch


" disable last search highlighted result with <space>
nnoremap <leader><backspace> :nohlsearch<CR>


" configure folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za


" setup up movement
nnoremap j gj
nnoremap k gk
nnoremap B ^
nnoremap E $
nnoremap ^ <nop>
nnoremap $ <nop>


" select last inserted text
nnoremap gV `[v`]


" remap leader to ,
let mapleader=","


" remap escape to jk
inoremap jk <esc>


" pane splitting
nnoremap <leader>pv :vsp<CR>
nnoremap <leader>ph :sp<CR>
nnoremap LL <C-W><right>
nnoremap HH <C-W><left>
nnoremap JJ <C-W><down>
nnoremap KK <C-W><up>
nnoremap <leader>z :MaximizerToggle<CR>


" gundo map
nnoremap <leader>u :GundoToggle<CR>


" shortcut for editing .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>


" shortcut for editing .tmux.conf
nnoremap <leader>et :vsp ~/.tmux.comf<CR>
nnoremap <leader>st :source ~/.tmux.conf<CR>


" shortcut for editing .bash_profile
nnoremap <leader>eb :vsp ~/.bash_profile<CR>
nnoremap <leader>sb :source ~/.bash_profile<CR>


" remap insert mode to a
nnoremap a i


" silver surfer integration, map to ,s
nnoremap <leader>s :Ag


" ctrlp settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'


" nerdtree settings and autoclose it if it's the only pane open
nnoremap t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'


" in tmux, use vertical cursor
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" lang specific
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd BufWritePre *.php,*.py,*.js,*.txt,*.hs,*.java,*.md :call <SID>StripTrailingWhitespaces()
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal softtabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
augroup END


" omnisharp
let g:OmniSharp_selector_ui = 'ctrlp'
set completeopt=longest,menuone,preview
set splitbelow
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
augroup omnisharp_commands
    autocmd!
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
    autocmd FileType cs nnoremap <leader>ob :wa!<cr>:OmniSharpBuildAsync<cr>
    autocmd BufEnter,InsertLeave *.cs SyntasticCheck
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()
    autocmd FileType cs nnoremap od :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap oi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap ot :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap os :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap ou :OmniSharpFindUsages<cr>
    autocmd FileType cs nnoremap om :OmniSharpFindMembers<cr>
    autocmd FileType cs nnoremap ok :OmniSharpNavigateUp<cr>
    autocmd FileType cs nnoremap oj :OmniSharpNavigateDown<cr>
augroup END
let g:OmniSharp_want_snippet=1


" auto backup
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backupskip=/tmp/*,/private/tmp/*
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set writebackup


" custom methods
function! <SID>StripTrailingWhitespaces()
    let _s=@/
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    let @/=_s
    call cursor(l, c)
endfunction

