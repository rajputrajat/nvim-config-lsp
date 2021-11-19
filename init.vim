let mapleader = "\<Space>"

call plug#begin('~/AppData/Local/nvim/plugged')

Plug 'thaerkh/vim-indentguides'           " Visual representation of indents
Plug 'rust-lang/rust.vim'
Plug 'tomtom/tcomment_vim'
Plug 'mtdl9/vim-log-highlighting'
Plug 'preservim/tagbar'
Plug 'ervandew/supertab'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sainnhe/sonokai'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow'
Plug 'hoob3rt/lualine.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'
Plug 'tikhomirov/vim-glsl'
Plug 'andys8/vscode-jest-snippets'

call plug#end()

nnoremap <Space> <Nop>
nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

nnoremap <leader><space>  <cmd>Telescope find_files<cr>
nnoremap <leader>ff       <cmd>Telescope live_grep<cr>
nnoremap <leader>g        <cmd>Telescope grep_string<cr>
nnoremap <leader>b        <cmd>Telescope buffers<cr>
nnoremap <leader>fh       <cmd>Telescope help_tags<cr>
nnoremap <leader>l        <cmd>Telescope current_buffer_fuzzy_find<cr>
nnoremap <leader>L        <cmd>Telescope loclist<cr>
nnoremap <leader>k        <cmd>Telescope keymaps<cr>
nnoremap <leader>r        <cmd>Telescope registers<cr>
nnoremap <leader>m        <cmd>Telescope marks<cr>
nnoremap <leader>c        <cmd>Telescope commands<cr>
nnoremap <leader>e        <cmd>NvimTreeToggle<cr>

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
" autocmd BufEnter *.py,*.rs,*.c*,*.h*,*.js,*.ts :call tagbar#autoopen(0)
" autocmd BufWinLeave * :TagbarClose
nnoremap <Leader>x :TagbarToggle<CR>

let g:python3_host_prog = 'C:/Users/rajput/AppData/Local/Programs/Python/Python39/python3.exe'

let g:ale_sign_column_always = 1
"let g:ale_linters = {'rust': ['analyzer']}

set foldmethod=manual
set foldlevel=0

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0

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

set background=dark

set re=0
set number
set relativenumber
set cursorline
set colorcolumn=100
" set mouse=nv
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
set updatetime=300
set numberwidth=8
set signcolumn=yes
set nowrap
set nobackup
set nowritebackup
set shortmess+=c

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

let g:nvim_tree_side = 'right'
let g:nvim_tree_width = 50
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache', '.vscode', '.svn' ]
let g:nvim_tree_indent_markers = 1

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
require('lualine').setup()
require'nvim-tree'.setup()
EOF

