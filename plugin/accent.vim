scriptencoding utf-8

if exists('g:loaded_accent') || &compatible
  finish
endif
let g:loaded_accent = 1

let s:lists = [
  \ ['a','ä','à','â'],
  \ ['A','Ä','À','Â'],
  \ ['e','é','è','ê'],
  \ ['E','É','Ê','È'],
  \ ['i','î'],
  \ ['I','Î'],
  \ ['o','ö','ô'],
  \ ['O','Ö','Ô'],
  \ ['s','ß'],
  \ ['u','ü','û','ù'],
  \ ['U','Ü','Û','Ù'],
\ ]

function! s:cycle(char)
  for l:list in s:lists
    let l:index = index(l:list, a:char)
    if l:index != -1
      let l:replacement = l:list[ (l:index + 1) % len(l:list) ]
      silent execute 'normal! r' . l:replacement
      break
    endif
  endfor
endfunction

function! AccentCompletion(findstart, base)
  if a:findstart
    let l:char = getline('.')[col('.') - 2]
    for l:list in s:lists
      let l:index = index(l:list, l:char)
      if l:index != -1
        return col('.') - 2
      endif
    endfor
    return -3
  elseif empty(a:base)
    " cargo culted
    return []
  else
    for l:list in s:lists
      let l:index = index(l:list, a:base)
      if l:index != -1
        return l:list
      endif
    endfor
    return []
  endif
endfunction

set completefunc=AccentCompletion

" Capture character under cursor in a way that works with multi-byte
" characters.  Credit to http://stackoverflow.com/a/23323958/151007.
nnoremap <silent> <script> <Plug>(accent) :call <SID>cycle(matchstr(getline('.'), '\%'.col('.').'c.'))<CR>
