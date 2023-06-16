if exists('loaded_buflist')
    finish
endif

let loaded_buflist = 1

command! BufList call buflist#ShowBufferList()
