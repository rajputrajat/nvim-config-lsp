vim.cmd [[
    nnoremap <Space> <Nop>
    nnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>
    vnoremap <silent> <leader> :LeaderMapper "<Space>"<CR>

    let g:SuperTabDefaultCompletionType = "<c-n>"
    set completeopt=menuone,noinsert,noselect

"    nnoremap <leader><space>  <cmd>Telescope find_files<cr>
"    nnoremap <leader>ff       <cmd>Telescope live_grep<cr>
"    nnoremap <leader>g        <cmd>Telescope grep_string<cr>
"    nnoremap <leader>b        <cmd>Telescope buffers<cr>
"    nnoremap <leader>fh       <cmd>Telescope help_tags<cr>
"    nnoremap <leader>l        <cmd>Telescope current_buffer_fuzzy_find<cr>
"    nnoremap <leader>L        <cmd>Telescope loclist<cr>
"    nnoremap <leader>k        <cmd>Telescope keymaps<cr>
"    nnoremap <leader>r        <cmd>Telescope registers<cr>
"    nnoremap <leader>m        <cmd>Telescope marks<cr>
"    nnoremap <leader>c        <cmd>Telescope commands<cr>
"    nnoremap <leader>o        <cmd>CocOutline<cr>
"
"    nnoremap <leader>;u       <cmd>Telescope coc mru<cr>
"    nnoremap <leader>;c       <cmd>Telescope coc commands<cr>
"    nnoremap <leader>;l       <cmd>Telescope coc locations<cr>
"    nnoremap <leader>;r       <cmd>Telescope coc references<cr>
"    nnoremap <leader>;d       <cmd>Telescope coc definitions<cr>
"    nnoremap <leader>;s       <cmd>Telescope coc workspace_symbols<cr>

    nnoremap <c-j>            <cmd>cn<cr>
    nnoremap <c-k>            <cmd>cp<cr>
    nnoremap <leader>e        <cmd>e %:h<cr>
"    nnoremap <leader>f        <cmd>grep! <cword> -w && call OpenQuickFixList()<cr>
]]
