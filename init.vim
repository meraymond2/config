" To reload config file, run :so ~/.config/nvim/init.vim

"-------------------------------"
"-------- PLUGINS --------------"
"-------------------------------"
" To install, run :PlugInstall

"Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Prettier status bar
Plug 'itchyny/lightline.vim'

" Linting
Plug 'w0rp/ale'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Autocomplete
Plug 'ncm2/ncm2'
" Requires installation of pip3, and then `pip3 install pynvim`
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'autozimu/LanguageClient-neovim', {
\ 'branch': 'next',
\ 'do': 'bash install.sh',
\ }

" Initialize plugin system
call plug#end()

" Lightline Config
let g:lightline = {  'colorscheme': 'wombat',  }

" Make SignColumn transparent
highlight clear SignColumn
" Turn on line numbers
set number

"Ale Config
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'rust': ['rustfmt']
\}

"ncm2 Config for autocomplete
let g:python3_host_prog="/usr/bin/python3.7"
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

set hidden
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
" " Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
" Disable diagnostic in favour of ALE
let g:LanguageClient_diagnosticsEnable=0
