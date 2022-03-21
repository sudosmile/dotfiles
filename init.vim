scriptencoding utf-8
setlocal encoding=UTF-8

set runtimepath^=~/.config/nvim
let &packpath = &runtimepath

let mapleader = ','

if !exists('g:vimpager')
    let g:vimpager = {}
endif

if !exists('g:less')
    let g:less     = {}
endif

let g:less.enabled = 0
let g:vimpager.passthrough = 0

" currently testing this
set inccommand=nosplit

set relativenumber
set number
set autochdir
set tags=tags;
set noerrorbells
set hidden
set scrolloff=10
set textwidth=0
set hlsearch
set colorcolumn=80
set undofile
set undodir=$HOME/.config/nvim/undo
set path+=../include
set ignorecase
set smartcase

set tabstop=4
set softtabstop=0 expandtab
set shiftwidth=4

setlocal foldmethod=syntax

au FileType sh let g:sh_fold_enabled=5
au FileType sh let g:is_bash=1
au FileType sh set foldmethod=syntax

set foldenable

2match none

syntax on
filetype plugin indent on

let g:polyglot_disabled = ['ada', 'autoindent']

augroup c_norm
    autocmd Filetype c setlocal cindent
augroup END

augroup remember_folds
	autocmd!
	autocmd BufWinLeave * mkview
	autocmd BufWinEnter * silent! loadview
augroup END

set backspace=indent,eol,start

let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
"set omnifunc=ale#completion#OmniFunc

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-accent'
Plug 'dense-analysis/ale'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'machakann/vim-highlightedyank'
Plug 'adelarsq/vim-matchit'
Plug 'ghifarit53/tokyonight-vim'
Plug 'junegunn/goyo.vim'
Plug 'preservim/nerdtree'
Plug 'haya14busa/incsearch.vim'
Plug 'craigemery/vim-autotag'
Plug 'jiangmiao/auto-pairs'
Plug 'dylanaraps/wal.vim'
Plug 'chrisbra/Colorizer'
Plug 'machakann/vim-sandwich'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'godlygeek/tabular'
Plug 'sudosmile/vim-epitech'
Plug 'preservim/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'ryanoasis/vim-devicons'
Plug 'mileszs/ack.vim'

"nvim completion + rust stuff
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-buffer'

" See hrsh7th's other plugins for more completion sources!

" To enable more of the features of rust-analyzer, such as inlay hints and more!
Plug 'simrat39/rust-tools.nvim'

" Snippet engine
Plug 'hrsh7th/vim-vsnip'
call plug#end()

" Nerdtree options
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:NERDDefaultAlign = 'left'

let g:highlightedyank_highlight_duration = 500

" disable arrow keys to get used to vim hjkl (for beginners)
for prefix in ['n', 'v']
	for key in ['<Up>', '<Down>', '<Left>', '<Right>']
		exe prefix . 'noremap ' . key . ' <Nop>'
	endfor
endfor

"========================ale===============================

let g:ale_fixers = {
\	'*': ['remove_trailing_lines', 'trim_whitespace'],
\	'ocaml': ['ocamlformat', 'ocp-indent'],
\}

"\	'rust': ['rustfmt'],

let g:ale_fix_on_save = 1

let g:ale_linters = {
\   'python':['flake8'],
\   'ocaml':['merlin'],
\   'sh':['shellcheck'],
\}

let g:ale_linters_ignore = {
\   'c': ['cquery'],
\}

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠'
let g:ale_sign_info = 'ℹ'
let g:ale_virtualtext_cursor = 1
let g:ale_virtualtext_prefix = '🔥'
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 1

augroup syntax
  autocmd BufNew,BufRead *.asm set ft=nasm
  let g:ale_nasm_nasm_options='-felf64'
augroup END

let g:ale_hover_cursor = 0

"==========================================================

"=========================airline==========================
let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1

augroup onsave
	autocmd BufWritePost * AirlineRefresh
augroup END
"==========================================================

vnoremap <silent> <C-o> "-y:echo 'length' strlen(@-)<CR>"
vnoremap <Leader>a :ALECodeAction<CR>

cnoreabbrev Ack Ack!
nnoremap <Leader>f :Ack!<Space>

inoremap <S-Tab> <C-V><Tab>

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <silent> <C-n> :ALEDetail<CR>
nnoremap <silent> <Leader>b :bn<CR>
nnoremap <silent> <Leader>B :bN<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap S :%s//g<Left><Left>
nnoremap <Leader>rn :ALERename<Return>
nnoremap <Leader>gd :ALEGoToDefinition<Return>
nnoremap <Leader>gs :ALESymbolSearch<space>
nnoremap <Leader>gr :ALEFindReferences<CR>
nnoremap J :ALEHover<CR>
nnoremap <Leader>a :ALECodeAction<CR>

map <C-e> <esc>:2match none
map Q <Nop>
map q: <Nop>
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" `<leader><Tab>` - next buffer;
nnoremap <silent> <leader><S-l> :bnext<CR>

" `<leader><S-Tab>` - previous buffer;
nnoremap <silent> <S-h>  :bprevious<CR>
map <leader>o :setlocal spell! spelllang=en_us<CR>

noremap <C-y> "+y<CR>
noremap <C-p> "+p<CR>
noremap <silent> H :ALEPrevious<CR>
noremap <silent> L :ALENext<CR>
noremap <C-g> :Goyo<CR>

augroup stdin_or_no_file
	autocmd StdinReadPre * let s:std_in=1
	autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
augroup END

augroup neomutt
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>
augroup END

" colorscheme
set termguicolors
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 0
let g:tokyonight_disable_italic_comment = 1
let g:airline_theme = 'tokyonight'
"let g:lightline = {'colorscheme' : 'tokyonight'}
let g:tokyonight_transparent_background = 0
let g:tokyonight_current_word = 'underline'
silent! colorscheme tokyonight
let g:airline_theme = 'tokyonight'

let g:ackprg = 'ag --vimgrep'


"colorscheme wal

"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

let g:python3_host_prog='/home/sudosmile/.pyenv/versions/nvim/bin/python'
let g:python_host_prog='/home/sudosmile/.pyenv/versions/nvim2/bin/python'

" MANPAGING
let $PAGER=''

" lsp settings
" set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP through rust-tools.nvim plugin.
" rust-tools will configure and enable certain LSP features for us.
" See https://github.com/simrat39/rust-tools.nvim#configuration
lua <<EOF
local nvim_lsp = require'lspconfig'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)
EOF

" Setup Completion
" See https://github.com/hrsh7th/nvim-cmp#basic-configuration
lua <<EOF
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})
EOF

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.diagnostic.goto_next()<CR>

" have a fixed column for the diagnostics to appear in
" this removes the jitter when warnings/errors flow in
set signcolumn=yes

autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 200)
