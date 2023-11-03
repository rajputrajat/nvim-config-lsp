local cmd = vim.cmd
local g = vim.g
local fn = vim.fn

g.mapleader = ' '

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path })
end

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { { 'nvim-lua/plenary.nvim' } } }
    use {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lsp'
    }
    use {
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',     -- LSP source for nvim-cmp
        'saadparwaiz1/cmp_luasnip', -- Snippets source for nvim-cmp
        'L3MON4D3/LuaSnip'          -- Snippets plugin
    }
    use { 'thaerkh/vim-indentguides' }
    use { 'rust-lang/rust.vim' }
    use { 'simrat39/rust-tools.nvim' }
    use { 'tomtom/tcomment_vim' }
    use { 'mtdl9/vim-log-highlighting' }
    use { 'sainnhe/sonokai' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'hoob3rt/lualine.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'tikhomirov/vim-glsl' }
    use { 'embear/vim-localvimrc' }
    use { 'rhysd/vim-clang-format' }
    use { 'ziglang/zig.vim' }
    use { 'elmcast/elm-vim' }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'DingDean/wgsl.vim' }
    use {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        config = function()
            require("fidget").setup {
                -- options
            }
        end,
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end)

g.rustfmt_autosave = 1
g.rustfmt_emit_files = 1
g.rustfmt_fail_silently = 0
g.elm_format_autosave = 1

require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "c", "c_sharp", "cmake", "comment", "cpp", "go", "html", "java", "javascript",
        "json", "kotlin", "lua", "python", "rust", "toml", "typescript",
        "vim", "yaml", "zig", "glsl", "wgsl"
    },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = 1000
    },
    highlight = {
        enable = true
    },
    autotag = {
        enable = true
    },
    indent = {
        enable = true
    }
}

require('lualine').setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "bashls", "asm_lsp", "omnisharp", "cmake", "diagnosticls",
        "dockerls", "gopls", "html", "biome", "tsserver", "lemminx", "taplo" },
}

local lspconfig = require('lspconfig')
local luasnip = require 'luasnip'

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local border = 'rounded'

local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { "lua_ls", "rust_analyzer", "bashls", "asm_lsp", "omnisharp", "cmake", "diagnosticls", "dockerls",
    "gopls", "html", "biome", "tsserver", "lemminx", "taplo" }
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
        handlers = handlers,
    }
end

lspconfig.lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}

vim.diagnostic.config {
    virtual_text = {
        source = 'always',
    },
    signs = true,
    underline = true,
    virtual_lines = false,
    update_in_insert = true,
    severity_sort = true,

    float = {
        -- UI.
        header = false,
        source = 'always',
        style = 'minimal',
        border = border,
        focusable = true,
    },
}

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
    },
}

local rust_tools_opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(rust_tools_opts)

require("fidget").setup {
    -- options
}

require('lspconfig.ui.windows').default_options.border = border

local utils = {}

local scopes = { o = vim.o, b = vim.bo, w = vim.wo }

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local indent = 4

utils.opt('b', 'smartindent', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'shiftwidth', indent)
utils.opt('o', 'autoindent', true)
utils.opt('b', 'expandtab', true)
utils.opt('o', 'background', 'dark')
utils.opt('o', 're', 0)
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'cursorline', true)
utils.opt('w', 'colorcolumn', '100')
utils.opt('b', 'modeline', true)
utils.opt('o', 'report', 2)
utils.opt('o', 'showcmd', true)
utils.opt('o', 'list', false)
utils.opt('o', 'cmdheight', 2)
utils.opt('o', 'encoding', "utf-8")
utils.opt('o', 'hidden', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 4)
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('o', 'clipboard', 'unnamed,unnamedplus')
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'laststatus', 3)
utils.opt('o', 'linespace', 5)
utils.opt('w', 'wrap', false)
utils.opt('w', 'numberwidth', 6)
utils.opt('w', 'signcolumn', 'yes')
utils.opt('o', 'updatetime', 200)
utils.opt('w', 'foldmethod', 'manual')
utils.opt('w', 'foldlevel', 5)
utils.opt('w', 'foldexpr', 'nvim_treesitter#foldexpr()')
utils.opt('o', 'grepprg', 'rg --vimgrep --no-heading --smart-case')
utils.opt('o', 'cscopequickfix', 's-,c-,d-,i-,t-,e-')
--utils.opt('o', 'listchars', 'eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣')

if fn.has('win32') == 1 then
    g.python3_host_prog = '$HOME/AppData/Local/Programs/Python/Python39/python3.exe'
elseif fn.has('mac') == 1 then
    g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.10/bin/python3'
else
    g.python3_host_prog = '/usr/bin/python3'
end

g.localvimrc_name = ".vim/lvimrc"
g.localvimrc_ask = 0
g.localvimrc_sandbox = 0

cmd [[
    au TextYankPost * lua vim.highlight.on_yank {on_visual = false}

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    colorscheme sonokai
    let g:sonokai_style = 'espresso'
    let g:sonokai_enable_italic = 1
    let g:sonokai_disable_italic_comment = 1

    highlight comment gui=italic
    highlight string gui=italic
    highlight operator gui=bold
    highlight keyword gui=bold

    hi LineNr ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212

    augroup NrHighlight
        autocmd!
        autocmd WinEnter * set cul
        autocmd WinLeave * set nocul
    augroup END

    hi ActiveWindow ctermbg=None ctermfg=None guibg=#2B2B2B
    hi InactiveWindow guibg=#313131
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow

    nnoremap <Space> <Nop>
    nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
    vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

    set completeopt=menuone,noinsert,noselect

    nnoremap <c-j>            <cmd>cn<cr>
    nnoremap <c-k>            <cmd>cp<cr>
    nnoremap <leader>e        <cmd>e %:h<cr>

    fu! CreateSess()
        execute 'call mkdir(getcwd() . "/.vim", "p")'
        execute 'mksession! %:p:h/.vim/session.vim'
    endfunction

    " add custom Mks command
    command Mks :call CreateSess()

    fu! SaveSess()
        if filereadable(getcwd() . '/.vim/session.vim')
            execute 'mksession! ' . getcwd() . '/.vim/session.vim'
        endif
    endfunction

    fu! RestoreSess()
        if filereadable(getcwd() . '/.vim/session.vim')
            execute 'so ' . getcwd() . '/.vim/session.vim'
        endif
    endfunction

    autocmd VimLeave * call SaveSess()
    autocmd VimEnter * nested call RestoreSess()
]]

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Global mappings.
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})
