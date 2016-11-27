" Split navigation
" ----------------------------------------------------------------------------------------------------
nmap <C-c> <C-W>c<CR>
nmap <C-K> <C-W><C-K>
nmap <C-J> <C-W><C-J>

" Because 'CTRL-T' is easier to type on a canadian keyboard
" ----------------------------------------------------------------------------------------------------
noremap <C-T> <C-]>

" Easy buffer navigation
" ----------------------------------------------------------------------------------------------------
nmap > :bnext<CR>
nmap < :bprevious<CR>


" Easy indentation in visual mode
" ----------------------------------------------------------------------------------------------------
vnoremap < <gv
vnoremap > >gv|
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap  <C-i>
nnoremap <Tab> mzV>`zl
nnoremap <S-Tab> mzV<`zh

" Clear search-highlighted terms
" ----------------------------------------------------------------------------------------------------
nmap <silent> <Space> :silent noh<Bar>echo<CR>

" Prevent accidental uses of <F1>
" ----------------------------------------------------------------------------------------------------
map <F1> <ESC>

" Change the working directory to the current file directory
" ----------------------------------------------------------------------------------------------------
nmap èè :lcd %:p:h<CR>

" Execute the current file
" ----------------------------------------------------------------------------------------------------
nmap <Leader>r :call CallInterpreter()<CR>

" Clear trailing whitespace
" ----------------------------------------------------------------------------------------------------
nmap <C-L> :call g:ClearTrailingWhitespace()<cr>

" Disable ex mode, damnit
" ----------------------------------------------------------------------------------------------------
nmap Q :echo "BOOYA! Ex mode is disabled."<cr>

" Toggle Ruby code file and spec file
" ----------------------------------------------------------------------------------------------------
nmap <Leader>l :call SpecToggle()<cr>

" Show highlight group under the cursor
" ----------------------------------------------------------------------------------------------------
map <Leader>a :call ShowHighlightGroup()<CR>
