if exists('g:loaded_cursorword') | finish | endif

if !has('nvim')
    echohl Error
    echom "Sorry this plugin only works with versions of neovim that support lua"
    echohl clear
    finish
endif

let g:loaded_cursorword = 1

function FunctionDef
  :call coc#float#create_dialog([lua require('nvim-cursorword').echo() ,'Sert à implémenter I'], #{close: 1})
endfunction
function FunctionUnDef
  :call coc#float#close_all(1)
endfunction

augroup CursorWord
  autocmd!
  autocmd VimEnter,ColorScheme * lua require('nvim-cursorword').highlight()
  autocmd VimEnter :exec FunctionDef()
  autocmd CursorMoved,CursorMovedI * lua require('nvim-cursorword').matchadd()
  autocmd WinLeave * lua require('nvim-cursorword').matchdelete()
  autocmd CursorMoved,CursorMovedI,WinLeave :exec FunctionUnDef()
augroup END
