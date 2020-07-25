if &completefunc || exists('g:loaded_accent')
  finish
endif
let g:loaded_accent = 1

set completefunc=accent#AccentCompletion

" Capture character under cursor in a way that works with multi-byte
" characters.  Credit to http://stackoverflow.com/a/23323958/151007.
nnoremap <silent> <Plug>(accent)
      \ :call <SID>accent#Cycle(matchstr(getline('.'), '\%'.col('.').'c.'))<CR>

" TODO FIXME Command does not work!
command! AccentCycle call accent#Cycle(matchstr(getline('.'), '\%'.col('.').'c.'))

