" work folder
set path=**

" view
set guifont=courier\ new:h18
syntax on
color elflord

" file format
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
filetype plugin indent on

set laststatus=2 
if has("statusline")
 set statusline=%<%f\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%k\ %-14.(%l,%c%V%)\ %P
endif

" search & file navagation shortcuts
set hlsearch
set incsearch

function! g:ChangeLineEndings()
    silent !dos2unix %
    update %
endfunction

nnoremap t :tabf 
nnoremap <S-f> :grep --text -n -r --include=*.xml --include=*.lua --include=*.cpp --include=*.h "\<<C-R><C-W>\>" *
nnoremap <silent> <F3> :copen <cr>:cnext<CR>
nnoremap <silent> <F4> :copen <cr>:cpre<CR>
nnoremap <silent> <F2> :Vex<CR>
nnoremap <silent> <C-n> :tabn<CR>
nnoremap <silent> <C-p> :tabp<CR>

" toolkit
nmap cp :let @* = expand("%:p")<CR>

function! g:ChmodOnWrite()
    if v:cmdbang
        silent !chmod u+w %
    endif
endfunction

" auto overwrite file ready only attribute
autocmd BufWrite * call g:ChmodOnWrite()
autocmd! bufwritepost vimrc source %

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

execute pathogen#infect()

" ------------------------------------
" plugins
" ------------------------------------
" Syntastic
" cd ~/.vim/bundle && \
" git clone https://github.com/scrooloose/syntastic.git
" set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" ctrlp
" cd ~/.vim/bundle && \
" git clone https://github.com/kien/ctrlp.vim.git
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'
"let g:ctrlp_working_path_mode = 'ra'
"
"" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
"let g:ctrlp_user_command = 'find %s -type f'
"
"let g:airline#extensions#tabline#enabled = 1


" cd ~/.vim/bundle
" git clone https://github.com/Lokaltog/vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Bi-directional find motion
" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-s)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-s2)

" Turn on case sensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff buftype=nofile<CR>gg
