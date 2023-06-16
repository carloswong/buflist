function! s:format_buffer(b)
    let name = bufname(a:b)
    let number = bufnr(a:b)
    let fname = empty(name) ? '[No Name]' : fnamemodify(name, ":t")
    let modified = getbufvar(a:b, '&modified') ? ' [+]' : ''
    let readonly = getbufvar(a:b, '&modifiable') ? '' : ' [RO]'
    let extra = join(filter([modified, readonly], '!empty(v:val)'), '')
    return printf("%3d %-15s\t%s", number, fname . extra, name)
endfunction

function! s:filter_buffer(b)
    if getbufvar(a:b, "&buflisted") == 0
        return 0
    endif 

    let type = getbufvar(a:b, "&buftype")
    if  type == 'qf' || type == 'terminal'
        return 0
    endif

    return 1
endfunction

function! buflist#ShowBufferList()
    let buffers = filter(range(1, bufnr('$')), 's:filter_buffer(v:val)')
    let buflist = map(buffers, 's:format_buffer(v:val)')
    for buf in buflist
        echo buf
    endfor
    call feedkeys(":b", 'n')
endfunction
