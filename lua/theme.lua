vim.cmd [[
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

    hi ActiveWindow ctermbg=None ctermfg=None guibg=#272727
    hi InactiveWindow guibg=#616161
    set winhighlight=Normal:ActiveWindow,NormalNC:InactiveWindow
]]
