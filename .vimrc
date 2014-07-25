set nocompatible
filetype off

" Use Pathogen:
call pathogen#infect()
call pathogen#helptags()

" ========================================================================
" Vundle stuff
" ========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Let Vundle manage Vundle (required)!
Bundle 'gmarik/vundle'

" My bundles
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'groenewege/vim-less'
Bundle 'scrooloose/syntastic'
Bundle 'chriskempson/base16-vim'
Bundle 'bling/vim-airline'

syntax on                 " Enable syntax highlighting
filetype plugin indent on " Enable filetype-specific indenting and plugins

augroup myfiletypes
  " Clear old autocmds in group
  autocmd!
  " autoindent with two spaces, always expand tabs
  autocmd FileType ruby,eruby,yaml,coffee,less,python,php,html,js,css set ai sw=2 sts=2 et
augroup END

autocmd FileType rb,js,scss,css autocmd BufWritePre <buffer> call StripTrailingWhitespace()


set t_Co=256
set tw=80
set nocompatible
set nofoldenable
set hidden
set shiftround

set backspace=indent,eol,start

set backupdir=~/.tmp
set directory=~/.tmp " Don't clutter my dirs up with swp and tmp files

set background=dark

set laststatus=2
set stl=%{fugitive#statusline()}\ %f\ %m\ %r\ %=\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n
hi StatusLine ctermfg=black ctermbg=yellow
hi StatusLineNC ctermfg=black ctermbg=green

"colorscheme base16-default
"let base16colorspace=256  " Access colors present in 256 colorspace

" hi OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%81v.\+/

let mapleader = ","

map <Leader>t :NERDTreeToggle<CR>
map <Leader>T :NERDTreeFind<CR>
map <Leader>b :b#<CR>
map <Leader>db :e config/database.yml<CR>
map <Leader>s :Ack
map <Leader>d o<cr>debugger<cr><esc>:w<cr>
map <Leader>D O<cr>debugger<cr><esc>:w<cr>

nnoremap <leader><leader> <c-^>
nnoremap ; :
inoremap jj <esc>
" Control-s to save
nnoremap <C-s> :w<CR>
inoremap <C-s> <C-o>:w<CR>
" reselect visual block after indent
vnoremap < <gv
vnoremap > >gv
" hide annoying quit message
nnoremap <C-c> <C-c>:echo<cr>
" remap arrow keys
nnoremap <up> :tabnext<CR>
nnoremap <down> :tabprev<CR>

let g:ctrlp_custom_ignore = '\.git$\|\.bundle$\|coverage$\|log$\|tmp$'
let g:ackprg="ack-grep -H --nocolor --nogroup --column --ignore-dir .bundle --ignore-dir coverage --ignore-dir log --ignore-dir tmp"
let g:syntastic_ruby_checkers = ['mri', 'rubocop']
let g:syntastic_coffee_checkers = ['coffeelint']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_js_checkers = ['jslint']

nmap <leader>f$ :call StripTrailingWhitespace()<CR>

" Remove trailing whitespace on save for ruby files.
au BufWritePre * :%s/\s\+$//e

" Unbind the cursor keys in insert, normal and visual modes.
for prefix in ['i', 'n', 'v']
  for key in ['<up>', '<down>', '<left>', '<right>']
    exe prefix . "noremap " . key . " <nop>"
  endfor
endfor

"functions
function! Preserve(command)
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and
  cursor position
  let @/=_s
  call cursor(l, c)
endfunction

function! StripTrailingWhitespace()
  call Preserve("%s/\\s\\+$//e")
endfunction
