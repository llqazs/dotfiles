set nocompatible
"to the bottom window of current one
let mapleader=","

set nocp
execute pathogen#infect()
filetype plugin indent on
" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()

" switch between vim windows
"nnoremap <C-J> <C-W>j "go to the bottom window of current one
"nnoremap <C-K> <C-W>k "go to the upper
"nnoremap <C-L> <C-W>l "go to the right
"nnoremap <C-H> <C-W>h "go to the left

" Quickly edit/reload the vimrc file
nnoremap <silent> <leader>ev :e $MYVIMRC<CR>
nnoremap <silent> <leader>sv :so $MYVIMRC<CR>

" Add space without entering insert mode
nnoremap <space> i<space><esc>

" Insert a new line without entering insert mode
nnoremap oo o<esc>
nnoremap OO O<esc>

" Underline the line where cursor is at
set cursorline

set hlsearch "highlight search
"ignore case
set ic
"show number
set number

if &t_Co > 2 || has("gui_running")
   syntax on
endif

"statusline
hi StatusLine term=bold cterm=bold ctermfg=White ctermbg=235
hi StatusHostname term=bold cterm=bold ctermfg=107 ctermbg=235 guifg=#799d6a
hi StatusGitBranch term=bold cterm=bold ctermfg=215 ctermbg=235 guifg=#ffb964

function! MyGitBranchStyle()
    let branch = GitBranch()
    if branch == ''
        let branchStyle = ''
    else
        let branchStyle = 'git:' . branch
    end
    return branchStyle
endfunction

function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction

set laststatus=2
set statusline=%#StatusLine#%F%h%m%r\ %h%w%y\ col:%c\ lin:%l\,%L\ buf:%n\ win:%{WindowNumber()}\ reg:%{v:register}\ %#StatusGitBranch#%{MyGitBranchStyle()}\ \%=%#StatusLine#%{strftime(\"%d/%m/%Y-%H:%M\")}\ %#StatusHostname#%{hostname()}

"switch between windows
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" Highlight trailing white spaces
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/

" Delete trailing spaces or tab in the file with <leader>dw
nnoremap <silent> <leader>dw :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" Redirect matching of last search to a new window
nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" Redirect last searching result to a file
nnoremap <silent> <F4> :redir >>matches.tmp<CR>:g//<CR>:redir END<CR>:new matches.tmp<CR>

" Filter last search
command! -nargs=? Filter let @a='' | execute 'g/<args>/y A' | new | setlocal bt=nofile | put! a
