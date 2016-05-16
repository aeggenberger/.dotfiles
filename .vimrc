set nocompatible
syntax enable
filetype plugin indent on

" set runtimepath for fzf
set rtp+=/usr/local/opt/fzf

execute pathogen#infect()
execute pathogen#helptags()


" allow editing of crontab files in place
autocmd filetype crontab setlocal nobackup nowritebackup

" search for tags file
set tags=./tags,./TAGS,tags;~,TAGS;~

au BufNewFile,BufRead *.txt map j gj
au BufNewFile,BufRead *.txt map k gk
au BufNewFile,BufRead *.txt set backspace=2

au BufNewFile,BufRead *.js set shiftwidth=4
au BufNewFile,BufRead *.js set tabstop=4
au BufNewFile,BufRead *.js set expandtab

" add spaces instead of tabs to scheme files
" to prevent problems when using Racket as REPL
au Filetype scheme set shiftwidth=8
au Filetype scheme set expandtab

au Filetype gitcommit setlocal spell textwidth=72

source ~/.pyvimrc

function! GetPythonTextWidth()
    if !exists('g:python_normal_text_width')
        let normal_text_width = 79
    else
        let normal_text_width = g:python_normal_text_width
    endif

    if !exists('g:python_comment_text_width')
        let comment_text_width = 72
    else
        let comment_text_width = g:python_comment_text_width
    endif

    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    if cur_syntax == "Comment"
        return comment_text_width
    elseif cur_syntax == "String"
        " Check to see if we're in a docstring
        let lnum = line(".")
        while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
            if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                " Assume that any longstring is a docstring
                return comment_text_width
            endif
            let lnum -= 1
        endwhile
    endif

    return normal_text_width
endfunction

augroup pep8
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END

colorscheme desert

map <C-n> :NERDTreeToggle<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" Prompt for a command to run map
" ViMux plugin
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vm :VimuxPromptCommand("make ")<CR>
map <Leader>vcd :VimuxRunCommand("cd ".'"'.expand('%:p:h').'"')<CR>

" https://github.com/ds26gte/scmindent
" scheme indent setting
autocmd bufread,bufnewfile *.lisp,*.scm setlocal equalprg=scmindent.rkt

" tslime mapping    
" https://github.com/sjl/tslime.vim
let g:tslime_normal_mapping = '<leader>t'
let g:tslime_visual_mapping = '<leader>t'
let g:tslime_vars_mapping = '<leader>T'
let g:tslime_ensure_trailing_newlines = 1
au BufNewFile,BufRead *.py let g:tslime_ensure_trailing_newlines = 2

