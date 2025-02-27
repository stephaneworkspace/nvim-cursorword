if exists('g:loaded_cursorword') | finish | endif

if !has('nvim')
    echohl Error
    echom "Sorry this plugin only works with versions of neovim that support lua"
    echohl clear
    finish
endif

let g:loaded_cursorword = 1

"function FunctionDef
  ":call coc#float#create_dialog(['w.cursorword' ,'Sert à implémenter I'], #{close: 0})
"endfunction
"function FunctionUnDef
 " :call coc#float#close_all(#{all: 1})
"endfunction

augroup CursorWord
  autocmd!
  autocmd VimEnter,ColorScheme * lua require('nvim-cursorword').highlight()
  autocmd CursorMoved,CursorMovedI * lua require('nvim-cursorword').matchadd()
  autocmd WinLeave * lua require('nvim-cursorword').matchdelete()
augroup END
