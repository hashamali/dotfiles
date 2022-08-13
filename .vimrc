set nocompatible
filetype off


" vundle configuration
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'sjl/gundo.vim'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'szw/vim-maximizer'
Plugin 'tpope/vim-dispatch'
Plugin 'scrooloose/syntastic'
Plugin 'OrangeT/vim-csharp'
Plugin 'leafgarland/typescript-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'cocopon/iceberg.vim'

call vundle#end()
filetype plugin indent on


" enable syntax processing and set color scheme
set background=dark
colorscheme iceberg 
syntax enable

" set no sticky escape
set ttimeoutlen=5

" set tabs to 2 spaces
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 smarttab

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


" configure folding
set foldenable
set foldlevelstart=10
set foldnestmax=10
set foldmethod=indent
nnoremap <space> za


" setup up movement
nnoremap j gj
nnoremap k gk
nnoremap <C-j> <C-f> 
nnoremap <C-k> <C-b>
noremap <C-h> ^
nnoremap ^ <nop>
nnoremap <C-l> $
nnoremap $ <nop>
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>


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


" shortcut for editing .bash_profile nnoremap <leader>eb :vsp ~/.bash_profile<CR>
nnoremap <leader>sb :source ~/.bash_profile<CR>


" remap insert mode to a
nnoremap a i


" silver surfer integration, map to ,s
nnoremap <leader>s :Ag


" ctrlp settings
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.png
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -p ~/.ignore -l --nocolor --hidden -g ""'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(env|git|hg|svn|node_module|atom)$',
  \ 'file': '\v\.(exe|so|dll|png|meta|log|pyc)$',
  \ }
let g:ctrlp_split_window = 0

" nerdtree settings and autoclose it if it's the only pane open
nnoremap t :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▼'
let NERDTreeIgnore = ['\.pyc$']


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
