local utils = require('utils')

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local indent = 4

cmd 'filetype plugin indent on'
utils.opt('o', 'background', 'dark')
utils.opt('o', 're', 0)
utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'cursorline', true)
utils.opt('w', 'colorcolumn', '100')
utils.opt('b', 'modeline', true)
utils.opt('o', 'report', 2)
utils.opt('w', 'list', true)
utils.opt('o', 'showcmd', true)
utils.opt('o', 'cmdheight', 2)
utils.opt('o', 'encoding', "utf-8")
utils.opt('b', 'expandtab', true)
utils.opt('b', 'smartindent', true)
utils.opt('o', 'hidden', true)
utils.opt('b', 'tabstop', indent)
utils.opt('o', 'shiftwidth', indent)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'splitright', true)
utils.opt('o', 'autoindent', true)
utils.opt('o', 'ignorecase', true)
utils.opt('o', 'scrolloff', 4 )
utils.opt('o', 'shiftround', true)
utils.opt('o', 'smartcase', true)
utils.opt('o', 'wildmode', 'list:longest')
utils.opt('o', 'clipboard','unnamed,unnamedplus')
utils.opt('o', 'termguicolors', true)
utils.opt('o', 'laststatus', 2)
utils.opt('o', 'linespace', 5)
utils.opt('w', 'wrap', false)
utils.opt('w', 'numberwidth', 8)
utils.opt('w', 'signcolumn', 'yes')
utils.opt('o', 'updatetime', 300)
utils.opt('w', 'foldmethod', 'manual')
utils.opt('w', 'foldlevel', 0)

if fn.has('win32') == 1 then
    g.python3_host_prog = '$HOME/AppData/Local/Programs/Python/Python39/python3.exe'
else
    g.python3_host_prog = '/usr/bin/python3'
end

g.ale_sign_column_always = 1

cmd 'au TextYankPost * lua vim.highlight.on_yank {on_visual = false}'
