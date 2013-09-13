" Set encoding
set encoding=utf-8
set fileencoding=utf-8

" Automatic reload of .vimrc
autocmd! bufwritepost .vimrc source %

" Rebind <Leader> key
let mapleader = ","

" General options
set wildmode=list:longest "make TAB behave like in a shell
set autoread " reload file when changes happen in other editor
set tags=./tags

set mouse=a  " keep Shift pressed during copy text operation
set bs=2     " make backspace behave like normal again

set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
set nobackup	" disable backup
set nowritebackup
set noswapfile	" disable swap

set clipboard=unnamed " make yank copy to the global system clipboard
"set pastetoggle=<F2> " paste with F2 change inster mode
set showtabline=2 " make tabs always visible

set history=700
set undolevels=700

set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

set hlsearch " case insentive search
set incsearch
set ignorecase
set smartcase

set number  " show line number
set nowrap " don't automatically wrap on load
set tw=79 " width of document (used by gd)
set fo-=t " don't automatically wrap text when typing

" Enable syntax highlighting                                                    
filetype off                                                                 
filetype plugin indent on                                                    
syntax on 

" Alternative save 
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>

" Alternative quit
noremap <Leader>e :quit<CR>  " Quit current window
noremap <Leader>E :qa!<CR>   " Quit all windows

" Bind nohl
noremap <Leader>h :nohl<CR>

" Bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Easey moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" Easy new tab
noremap <Leader>t :tabnew<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" center the cursor vertically
nnoremap <Leader>zz :let &scrolloff=999-&scrolloff<CR>

" easier formatting of paragraphs                                               
vmap Q gq                                                                    
nmap Q gqap 

"==================================================                             
" Functions                                                                       
                                                                                
" Better navigating through omnicomplete option list                            
" http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone                                              
function! OmniPopup(action)                                                  
     if pumvisible()                                                          
         if a:action == 'j'                                                   
             return "\<C-N>"                                                  
         elseif a:action == 'k'                                               
             return "\<C-P>"                                                  
         endif                                                                
     endif                                                                    
     return a:action                                                          
endfunction                                                                  
                                                                                

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>                              
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>                              
                                                   
"==================================================                             

"==================================================
" Plugins

" Setup Pathogen to manage your plugins                                         
" mkdir -p ~/.vim/autoload ~/.vim/bundle                                        
" curl -so ~/.vim/autoload/pathogen.vim
" https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
call pathogen#infect()       

" Setup NERD Tree
" cd ~/.vim/bundle
" git clone https://github.com/scrooloose/nerdtree.git
map <F2> :NERDTreeToggle<CR>

" Settings for powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2
let g:Powerline_symbols = 'unicode'

" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
" sudo pip install jedi
let g:jedi#usages_command = "<leader>z"
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Settings for flake8 (pep8,pyflakes,mccabe)
" cd ~/.vim/bundle
" git clone git://github.com/nvie/vim-flake8
" sudo pip install flake8
autocmd BufWritePost *.py call Flake8()

" Settings for syntatic
" cd ~/.vim/bundle
" git clone git://github.com/scrooloose/syntastic.git
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
"let g:syntastic_python_checkers="flake8"

" Settings for Tcomments
" cd ~/.vim/bundle
" git clone git://github.com/tomtom/tcomment_vim.git

" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

" Settings for SnipMate
" cd ~/.vim/bundle
" git clone https://github.com/tomtom/tlib_vim.git
" git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
" git clone https://github.com/garbas/vim-snipmate
" git clone https://github.com/honza/vim-snippets

"==================================================              


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
"" let g:ctrlp_max_height = 30
"" set wildignore+=*.pyc
"" set wildignore+=*_build/*
"" set wildignore+=*/coverage/*

" Fixing the copy & paste madness
vmap <C-y> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p
imap <C-v> <Esc><C-v>a

" Show trailing whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/
map <Leader>x :%s/\s\+$//

" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" wget -O https://raw.github.com/evaryont/dotfiles/master/vim/colors/skittles_berry.vim
set t_Co=256
color wombat256mod
"color skittles_berry

set colorcolumn=80
highlight ColorColumn ctermbg=233
map <Leader>v :source ~/.vimrc



