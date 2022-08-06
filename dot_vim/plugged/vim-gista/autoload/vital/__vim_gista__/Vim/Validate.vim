function! s:_vital_loaded(V) abort
  let s:Prelude = a:V.import('Prelude')
  let s:Dict = a:V.import('Data.Dict')
endfunction
function! s:_vital_depends() abort
  return [
        \ 'Prelude',
        \ 'Data.Dict',
        \]
endfunction
function! s:_vital_created(module) abort
  if !exists('s:config')
    let s:config = {
          \ 'prefix': 'vital: Vim.Validate: ',
          \}
  endif
endfunction

function! s:_translate(text, table) abort
  let text = a:text
  for [key, value] in items(a:table)
    let text = substitute(
          \ text, key,
          \ s:Prelude.is_string(value) ? value : string(value),
          \ 'g')
    unlet value
  endfor
  return text
endfunction

function! s:get_config() abort
  return deepcopy(s:config)
endfunction
function! s:set_config(config) abort
  let s:config = extend(s:config, s:Dict.pick(a:config, [
        \ 'prefix',
        \]))
endfunction

function! s:throw(msg) abort
  throw printf('%sValidationError: %s', s:config.prefix, a:msg)
endfunction

function! s:true(value, ...) abort
  let msg = get(a:000, 0, 'A value "%value" requires to be True value')
  if !a:value
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \}))
  endif
endfunction
function! s:false(value, ...) abort
  let msg = get(a:000, 0, 'A value "%value" requires to be False value')
  if a:value
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \}))
  endif
endfunction

function! s:exists(value, list, ...) abort
  let msg = get(a:000, 0, 'A value "%value" reqiured to exist in %list')
  if index(a:list, a:value) == -1
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%list': a:list,
          \}))
  endif
endfunction
function! s:not_exists(value, list, ...) abort
  let msg = get(a:000, 0, 'A value "%value" reqiured to NOT exist in %list')
  if index(a:list, a:value) >= 0
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%list': a:list,
          \}))
  endif
endfunction

function! s:key_exists(value, dict, ...) abort
  let msg = get(a:000, 0, 'A key "%value" reqiured to exist in %dict')
  if !has_key(a:dict, a:value)
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%dict': a:dict,
          \}))
  endif
endfunction
function! s:key_not_exists(value, dict, ...) abort
  let msg = get(a:000, 0, 'A key "%value" reqiured to NOT exist in %dict')
  if has_key(a:dict, a:value)
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%dict': a:dict,
          \}))
  endif
endfunction

function! s:empty(value, ...) abort
  let msg = get(a:000, 0, 'Non empty value "%value" is not allowed')
  if !empty(a:value)
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \}))
  endif
endfunction
function! s:not_empty(value, ...) abort
  let msg = get(a:000, 0, 'An empty value is not allowed')
  if empty(a:value)
    call s:throw(s:_translate(msg, {}))
  endif
endfunction

function! s:pattern(value, pattern, ...) abort
  let msg = get(a:000, 0, '%value does not follow a valid pattern %pattern')
  if a:value !~# a:pattern
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%pattern': a:pattern,
          \}))
  endif
endfunction
function! s:not_pattern(value, pattern, ...) abort
  let msg = get(a:000, 0, '%value follow an invalid pattern %pattern')
  if a:value =~# a:pattern
    call s:throw(s:_translate(msg, {
          \ '%value': a:value,
          \ '%pattern': a:pattern,
          \}))
  endif
endfunction

function! s:call_silently(fn, ...) abort
  let args = get(a:000, 0, [])
  let dict = get(a:000, 1, {})
  let default = get(a:000, 2, '')
  try
    if empty(dict)
      return call(a:fn, args)
    else
      return call(a:fn, args, dict)
    endif
  catch /ValidationError:/
    if v:exception =~# printf('^%sValidationError:', s:config.prefix)
      return default
    else
      throw v:exception
    endif
  endtry
endfunction
