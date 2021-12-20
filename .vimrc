" Configuration file for vim
set modelines=0		" CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible	" Use Vim defaults instead of 100% vi compatibility
set backspace=2		" more powerful backspacing
set updatetime=100
set foldmethod=manual
" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup nobackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup nobackup

let skip_defaults_vim=1

" ===
" === basic
" ===
syntax enable
syntax on
set number
set autoindent
set cindent
set smartindent
autocmd InsertLeave * se nocul
set ruler
set cursorline
set wrap
set showcmd
set wildmenu
let g:airline#extensions#tabline#enabled = 1
let mapleader = "\<space>"
set relativenumber
set clipboard=unnamedplus
" set ignorecase
set hidden
set autoread
set shellcmdflag=-ic

" add & sub
nnoremap <C-s> <C-x>

" tabs
map <M-1> 1gt
map <M-2> 2gt
map <M-3> 3gt
map <M-4> 4gt
map <M-5> 5gt
map <M-6> 6gt
map <M-7> 7gt
map <M-8> 8gt
map <M-9> 9gt

" windows
noremap <leader> <C-w>
noremap <C-[> <C-t>
noremap <C-t> <C-[>
nnoremap <BS> :noh<CR>
nnoremap > >>
nnoremap < <<

" keyboard layout
let layout = 'qwerty'
if layout == 'colemak'
    noremap j n
    noremap n j
    noremap k e 
    noremap e k
    noremap l i
    noremap i l
    noremap J N
    noremap N J
    noremap K E 
    noremap E K
    noremap L I
    noremap I L
endif

" indent
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab

au VimLeave * set guicursor=a:ver1
" ===
" === Plug-in
" ===
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'dense-analysis/ale'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'mhartington/oceanic-next'
Plug 'sbdchd/neoformat'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'liuchengxu/vista.vim'
" Plug 'sickill/vim-monokai'
" Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'morhetz/gruvbox'
Plug 'ludovicchabant/vim-gutentags'
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'preservim/nerdcommenter'
Plug 'mattn/emmet-vim', { 'for': ['html','htmldjango','css'] }
Plug 'posva/vim-vue', { 'for': ['html'] }
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for':'markdown' }
" Plug 'xuhdev/vim-latex-live-preview',{ 'for': 'tex' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'junegunn/vim-peekaboo'
Plug 'skywind3000/asyncrun.vim'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Plug 'mhinz/vim-startify'
Plug 'tpope/vim-surround'
Plug 'ryanoasis/vim-devicons'
Plug 'glepnir/dashboard-nvim'
Plug 'liuchengxu/vim-clap'
Plug 'puremourning/vimspector'
Plug 'ajmwagar/vim-deus'
Plug 'gcmt/wildfire.vim'
Plug 'mg979/vim-visual-multi'
" Plug 'Yggdroot/indentLine'

call plug#end()


" ===
" === theme
" ===
set termguicolors
colorscheme deus
" hi lineNr ctermbg=None guibg=None
" hi Normal ctermbg=None guibg=None
" hi EndOfBuffer ctermbg=None guibg=None
" hi SignColumn ctermbg=None guibg=None
let g:airline_theme='deus'
" hi airline_tabfill ctermbg=NONE guibg=None

" ===
" === hexokinase
" ===
let g:Hexoinase_highlighters = ['virtual']

" ===
" === coc.nvim
" ===
let g:coc_global_extensions = [ 
\       'coc-json', 
\       'coc-vimlsp',
\       'coc-python',
\       'coc-clangd',
\       'coc-pyright',
\       'coc-marketplace',
\       'coc-bibtex',
\       'coc-explorer',
\       'coc-snippets',
\       'coc-prettier'
\   ]
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" coc-snippets
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
let g:snips_author = 'Weikang Qiu'

" coc-explorer
nmap <space>e :CocCommand explorer<CR>

" coc-prettier
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ===
" === dashboard-nvim
" ===
let g:airline_powerline_fonts = 1
let g:dashboard_custom_header = [
            \ '███████╗███╗   ███╗ █████╗  ██████╗███████╗',
            \ '██╔════╝████╗ ████║██╔══██╗██╔════╝██╔════╝',
            \ '█████╗  ██╔████╔██║███████║██║     ███████╗',
            \ '██╔══╝  ██║╚██╔╝██║██╔══██║██║     ╚════██║',
            \ '███████╗██║ ╚═╝ ██║██║  ██║╚██████╗███████║',
            \ '╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚══════╝'
            \ ]
                                           
" ===
" === vista
" ===
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

set statusline+=%{NearestMethodOrFunction()}

" By default vista.vim never run if you don't call it explicitly.
"
" If you want to show the nearest function in your statusline automatically,
" you can add the following line to your vimrc
autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1
" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }
let g:vista_default_executive = "coc"
noremap <leader>s :Vista!!<CR>

" ===
" === NERDTree
" === I use coc-explorer instead
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" autocmd VimEnter * NERDTree | wincmd p
" noremap <F12> :NERDTreeToggle<CR>
" let g:airline#extensions#nerdtree_status = 1

" ===
" === Emmet
" ===
let g:user_emmet_leader_key='<C-Y>'

" ===
" === Latex
" === vimtex use latexmk, you should write a latexmk configuration.
let g:tex_flavor='latex'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_view_method = 'skim'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" ===
" === Markdown
" ===
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1
" the function below needs a script, in linux, just use chromium or other
" browsers instead
function! g:Open_md_browser(url)
    silent execute 'Safari ' . a:url 
endfunction
let g:mkdp_browserfunc = 'g:Open_md_browser'
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" ===
" === NerdComment
" ===
let g:NERDSpaceDelims = 1
map <leader>/ <plug>NERDCommenterToggle

" ===
" === AsyncRun
" ===
let g:asyncrun_open = 6
let g:asyncrun_bell = 1
" nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>
" nnoremap <silent> <F4> :AsyncRun clang -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>
" nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <CR>

function! Run()
    exec "w"
    if &filetype == 'c'
        exec "AsyncRun"
    endif
endfunction

" ===
" === snippets
" === I use coc-snippets instead

" let g:UltiSnipsExpandTrigger="<TAB>"
" let g:UltiSnipsJumpForwardTrigger="<TAB>"
" let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
" let g:UltiSnipsSnippetDirectories=["~/.config/nvim/UtilSnips"]

" ===
" === auto-pairs
" ===
au FileType tex,markdown let b:AutoPairs = AutoPairsDefine({'$':'$','$$':'$$'})
au FileType htmldjango let b:AutoPairs = AutoPairsDefine({'{%':'%}'})

" === 
" === vimspector
" ===
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'

" ===
" === indentLine
" ===
let g:indentLine_setColors = 0

" ===
" === gutentags
" ===
let g:gutentags_trace = 1
let g:gutentags_ctags_executable = "/usr/local/Cellar/ctags/5.8_1/bin/ctags"
