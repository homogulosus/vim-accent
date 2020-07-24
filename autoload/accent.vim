let s:lists = [
  \ ['a','á','æ','ä','à','â'],
  \ ['A','Á','Æ','Ä','À','Â'],
  \ ['e','é','è','ê'],
  \ ['E','É','Ê','È'],
  \ ['i','í','î'],
  \ ['I','Í','Î'],
  \ ['o','ó','ö','ô','ø'],
  \ ['O','Ó','Ö','Ô','Œ','Ø'],
  \ ['s','ß'],
  \ ['u','ú','ü','û','ù'],
  \ ['U','Ú','Ü','Û','Ù'],
  \ ['N','Ñ'],
  \ ['n','ñ'],
  \ ['c','ç'],
  \ ['C','Ç'],
\ ]

function! accent#Cycle(char) abort
  for l:list in s:lists
    let l:index = index(l:list, a:char)
    if l:index != -1
      let l:replacement = l:list[ (l:index + 1) % len(l:list) ]
      silent execute 'normal! r' . l:replacement
      break
    endif
  endfor
endfunction

function! accent#AccentCompletion(findstart, base) abort
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
