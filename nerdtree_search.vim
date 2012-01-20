if exists("g:loaded_nerdtree_search_menuitem")
    finish
endif
let g:loaded_nerdtree_search_menuitem = 1

call NERDTreeAddMenuItem({
            \ 'text': '(s)earch',
            \ 'shortcut': 's',
            \ 'callback': 'NERDTreeSearchFile',
            \ 'isActiveCallback': 'NERDTreeSearchFileActive' })

function! NERDTreeSearchFileActive()
    let node = g:NERDTreeFileNode.GetSelected()
    return node.path.isDirectory
endfunction

function! NERDTreeSearchFile()
        "exec ':vimgrep ' . cmd . ' ' . item . '/**/*.*'
    let treenode = g:NERDTreeFileNode.GetSelected()
    echo "==========================================================\n"
    let cwd = treenode.path.str({'escape': 0})
    let cmd = input('Grep Regex: ', '')
    if cmd != ''
        "VIMGREP METHOD:
        "let to_run = "noautocmd vimgrep /" . cmd . "/j " . cwd . "/**/*.*"

        " GREP METHOD:
        " jum``p to the previous window, as grep will attempt to open the first match in the current window
        exec "wincmd p"                     
        let to_run = "grep -r " . cmd . " \"" . cwd . "\""
        exec to_run
        " open the quicklist 
        exec "cw"
    else
        echo "Aborted"
    endif
endfunction
