let mapleader = "\<Space>"

call plug#begin('~/AppData/Local/nvim/plugged')
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'junegunn/rainbow_parentheses.vim'       " Rainbow Parentheses
Plug 'rust-lang/rust.vim'
Plug 'tomtom/tcomment_vim'
Plug 'ryanoasis/vim-devicons'
Plug 'jremmen/vim-ripgrep'
Plug 'mtdl9/vim-log-highlighting'
Plug 'preservim/tagbar'
Plug 'ervandew/supertab'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'sainnhe/sonokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'

call plug#end()

nnoremap <Space> <Nop>
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

colorscheme sonokai
let g:sonokai_style = 'default'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1

let g:SuperTabDefaultCompletionType = "<c-n>"
set completeopt=menuone,noinsert,noselect

"=====================================================
"" TagBar settings
"=====================================================
let g:tagbar_autofocus=0
let g:tagbar_width=50
let g:tagbar_position="left"
autocmd BufEnter *.py,*.rs,*.c*,*.h* :call tagbar#autoopen(0)
autocmd BufWinLeave *.py,*.rs,*.c*,*.h* :TagbarClose
nnoremap <Leader>x :TagbarToggle<CR>

let g:python3_host_prog = 'C:/Users/rajput/AppData/Local/Programs/Python/Python39/python3.exe'

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'
let g:airline_powerline_fonts=1
let g:airline_theme='sonokai'

let g:ale_sign_column_always = 1
"let g:ale_linters = {'rust': ['analyzer']}

"=====================================================
"" Rainbow Parentheses Autoload
"=====================================================
au VimEnter * RainbowParentheses

set foldmethod=manual
set foldlevel=0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

"=====================================================
"" fzf
"=====================================================
let g:fzf_preview_window = ''
let g:fzf_preview_window = 'right:60%'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_tags_command = 'ctags -R'
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

let g:easytags_syntax_keyword = 'always'

no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

noremap <Leader>ff :Rg -w
noremap <silent><Leader>fc :Rg -tcpp -w <cword><cr>
noremap <silent><Leader>fp :Rg -tpy -w <cword><cr>

set background=dark
let g:fzf_tags_command = 'ctags -R'

" Open hotkeys
nmap <Leader><space> :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>t :BTags<CR>
" nmap <Leader>E :Lexplore<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>m :Marks<CR>
nmap <Leader>c :Commands<CR>

set number
set relativenumber
set cursorline
set colorcolumn=100
set mouse=nv
set modeline
set report=2
set list
set showcmd
set cmdheight=2
set encoding=utf-8
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
set laststatus=2
set termguicolors
set guifont=Hack\ NF:h9
set linespace=5
set updatetime=800
set numberwidth=6
set signcolumn=yes
set nowrap
filetype plugin indent on

source c:/Users/rajput/AppData/Local/nvim/coc.vim

highlight comment gui=italic
highlight string gui=italic
"highlight number gui=bold
highlight operator gui=bold
highlight keyword gui=bold
"highlight function gui=bold

hi LineNr ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212

augroup NrHighlight
    autocmd!
    autocmd WinEnter * set cul
    autocmd WinLeave * set nocul
augroup END

hi ActiveWindow ctermbg=None ctermfg=None guibg=#272727
hi InactiveWindow guibg=#616161
set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "c", "c_sharp", "cmake", "comment", "cpp", "go", "html", "java", "javascript",
        "json", "kotlin", "lua", "python", "php", "ruby", "rust", "perl", "toml", "typescript",
        "vim", "yaml", "zig"
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000,
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
    autotag = {
        enable = true,
  }
}
EOF

