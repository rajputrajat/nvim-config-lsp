local cmd = vim.cmd
local g = vim.g
local fn = vim.fn

g.mapleader = ' '

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim' }
    use { 'thaerkh/vim-indentguides'}
    use { 'rust-lang/rust.vim' }
    use { 'tomtom/tcomment_vim' }
    use { 'mtdl9/vim-log-highlighting' }
    use { 'neoclide/coc.nvim', branch = 'release' }
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
    use {
        'saecki/crates.nvim',
        event = { "BufRead Cargo.toml" },
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require('crates').setup()
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

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash", "c", "c_sharp", "cmake", "comment", "cpp", "go", "html", "java", "javascript",
        "json", "kotlin", "lua", "python", "php", "ruby", "rust", "toml", "typescript",
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

local utils = { }

local scopes = {o = vim.o, b = vim.bo, w = vim.wo} 

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}
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
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('o', 'clipboard','unnamed,unnamedplus')
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

    " Use <c-space> to trigger completion.
    if has('nvim')
        inoremap <silent><expr> <c-space> coc#refresh()
    else
        inoremap <silent><expr> <c-@> coc#refresh()
    endif

    " Make <CR> auto-select the first completion item and notify coc.nvim to
    " format on enter, <cr> could be remapped by other vim plugin
    " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
    "                             \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction

    " Insert <tab> when previous text is space, refresh completion if not.
    inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#pum#next(1):
        \ <SID>check_back_space() ? "\<Tab>" :
        \ coc#refresh()
    inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

    " Use `[g` and `]g` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call ShowDocumentation()<CR>

    function! ShowDocumentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        elseif (coc#rpc#ready())
            call CocActionAsync('doHover')
        else
            execute '!' . &keywordprg . " " . expand('<cword>')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')

    " Symbol renaming.
    nmap <leader>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <leader>f  <Plug>(coc-format-selected)
    nmap <leader>f  <Plug>(coc-format-selected)

    augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder.
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `<leader>aap` for current paragraph
    xmap <leader>a  <Plug>(coc-codeaction-selected)
    nmap <leader>a  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap <leader>ac  <Plug>(coc-codeaction)
    " Apply AutoFix to problem on the current line.
    nmap <leader>qf  <Plug>(coc-fix-current)

    " Map function and class text objects
    " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
    xmap if <Plug>(coc-funcobj-i)
    omap if <Plug>(coc-funcobj-i)
    xmap af <Plug>(coc-funcobj-a)
    omap af <Plug>(coc-funcobj-a)
    xmap ic <Plug>(coc-classobj-i)
    omap ic <Plug>(coc-classobj-i)
    xmap ac <Plug>(coc-classobj-a)
    omap ac <Plug>(coc-classobj-a)

    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

    " Use CTRL-S for selections ranges.
    " Requires 'textDocument/selectionRange' support of language server.
    nmap <silent> <C-s> <Plug>(coc-range-select)
    xmap <silent> <C-s> <Plug>(coc-range-select)

    " Add `:Format` command to format current buffer.
    command! -nargs=0 Format :call CocAction('format')

    " Add `:Fold` command to fold current buffer.
    command! -nargs=? Fold :call     CocAction('fold', <f-args>)

    " Add `:OR` command for organize imports of the current buffer.
    command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

    " Add (Neo)Vim's native statusline support.
    " NOTE: Please see `:h coc-status` for integrations with external plugins that
    " provide custom statusline: lightline.vim, vim-airline.
    set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

    " Mappings for CoCList
    " Show all diagnostics.
    nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
    " Manage extensions.
    nnoremap <silent><nowait> <space>E  :<C-u>CocList extensions<cr>
    " open explorer
    "nnoremap <silent><nowait> <space>e  :<C-u>CocCommand explorer --position right --no-focus --width 50<cr>
    " Show commands.
    nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
    " Find symbol of current document.
    " nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
    " Search workspace symbols.
    nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
    " Do default action for next item.
    nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
    " Do default action for previous item.
    nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
    " Resume latest coc list.
    nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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

    nnoremap <leader>o        <cmd>CocOutline<cr>
    nnoremap <leader>gb       <cmd>CocCommand git.showBlameDoc<cr>
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

    " toggle coc diagnostics
    command DiagToggle :call CocAction('diagnosticToggle')
]]
