" view
set wildmenu
set guifont=courier\ new:h18
syntax on

"color blue
set background=dark

set complete-=i

" file format
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
filetype plugin indent on
set colorcolumn=80

" Note, perl automatically sets foldmethod in the syntax file
"autocmd Syntax c,cpp,vim,xml,html,xhtml,lua setlocal foldmethod=syntax
"autocmd Syntax c,cpp,vim,xml,html,xhtml,perl,lua normal zR

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

" nnoremap t :find 
" nnoremap <S-f> :Ag -f -w --ignore-dir aos_v1 --ignore-dir v3quick --ignore-dir v3quick_aos --ignore-dir aos_tag_quick_3.2 --lua <C-R><C-W>
nnoremap <S-f> :Ag -s -f -w <C-R><C-W>
" nnoremap <S-c> :Ag -f -w --ignore-dir aos_v1 --ignore-dir v3quick --ignore-dir v3quick_aos --cpp <C-R><C-W>
" nnoremap <S-f> :grep -R <C-R><C-W> **/*.lua
nnoremap <silent> <F3> :copen <cr>:cnext<CR>
nnoremap <silent> <F4> :copen <cr>:cpre<CR>
nnoremap <silent> <F5> :cclose <cr>
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <C-j> :tabp<CR>
nnoremap <silent> <C-k> :tabn<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap <silent> <C-x> :tabc<CR>
nnoremap <silent> <C-h> <C-w><c-h>
nnoremap <silent> <C-l> <C-w><c-l>
nnoremap <CR> :noh<CR><CR>

" toolkit
nmap cp :let @* = expand("%:p")<CR>

function! g:ChmodOnWrite()
    if v:cmdbang
        silent !chmod u+w %
    endif
endfunction

" auto overwrite file ready only attribute
"autocmd BufWrite * call g:ChmodOnWrite()
autocmd! bufwritepost vimrc source %
"autocmd InsertLeave * write
"set autowriteall

" auto save for every second
" set autosave=1

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif

" find files and populate the quickfix list
fun! FindFiles(filename)
    let error_file = tempname()
    silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
    set errorformat=%f:%l:%m
    exe "cfile ". error_file
    copen
    call delete(error_file)
endfun
command! -nargs=1 FindFile call FindFiles(<q-args>)
imap jj <Esc>

execute pathogen#infect()

" ------------------------------------
" plugins
" ------------------------------------
" .vimrc
let g:auto_save = 1  " enable AutoSave on Vim startup
" ctrlp
" cd ~/.vim/bundle && \
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_map = '<C-p>'
let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
"
"" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
"let g:airline#extensions#tabline#enabled = 1
"
" let g:ctrlp_user_command = 'find %s -type f'
" let g:ctrlp_map = ''
" let g:ctrlp_working_path_mode = ''
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/.svn/,*.bak,*/aos_v1/*,*/v3quick/*,*/v3quick_aos/*
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"   \ 'file': '\v\.(exe|so|dll|bak|swp)$',
"   \ 'link': 'some_bad_symbolic_links',
"   \ }
" let g:ctrlp_regexp = 1

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

map <F9> :new<CR>:read !svn diff <CR>:set syntax=diff buftype=nofile<CR>gg

