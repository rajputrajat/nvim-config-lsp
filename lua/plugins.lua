local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
local packer_bootstrap = nil
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)

    use { 'wbthomason/packer.nvim' }
    use { 'thaerkh/vim-indentguides'}
    use { 'rust-lang/rust.vim' }
    use { 'tomtom/tcomment_vim' }
    use { 'mtdl9/vim-log-highlighting' }
    use { 'ervandew/supertab' }
    use { 'neoclide/coc.nvim', branch = 'release' }
    use { 'sainnhe/sonokai' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- use {
    --     'nvim-telescope/telescope.nvim',
    --     requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    -- }
    -- use { 'nvim-treesitter/nvim-treesitter-refactor' }
    -- use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'p00f/nvim-ts-rainbow' }
    use { 'hoob3rt/lualine.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    -- use { 'kyazdani42/nvim-tree.lua' }
    use { 'tikhomirov/vim-glsl' }
    use { 'andys8/vscode-jest-snippets' }
    -- use { 'fannheyward/telescope-coc.nvim' }

    if packer_bootstrap then
        require('packer').sync()
    end

end)
