" Configuration
" ---------------------------------------
  set encoding=UTF-8
  set fileencoding=UTF-8

  syntax on
  set number
  set notitle
  set autoindent
  set nobackup
  set laststatus=2
  set ignorecase
  set smarttab
  set breakindent
  set shiftwidth=2
  set showcmd
  set ai
  set si
  set nowrap
  set clipboard^=unnamed,unnamedplus
  set termguicolors

" Plugins
" ---------------------------------------

  call plug#begin()

    " Themes
    " 🏙️ TokyoNight
    " A clean, dark Neovim theme written in Lua
    Plug 'folke/tokyonight.nvim'
    
    " 🌟 NeoSolarized
    " A fixed solarized colorscheme for better truecolor support.
    Plug 'overcache/NeoSolarized'

    " Plugin
    " 😄 DevIcons 
    " Adds file type icons to Vim plugins
    Plug 'kyazdani42/nvim-web-devicons'
    
    " 📏 Lualine
    " Customizable status line
    Plug 'nvim-lualine/lualine.nvim'

    " 📄 lspconfig
    " Language Server Protocol Configuration
    Plug 'neovim/nvim-lspconfig'
    
    " 📦 Mason
    "
    Plug 'williamboman/mason.nvim' 
    Plug 'williamboman/mason-lspconfig'

    " ⚡ lspsaga
    " A light-weight lsp plugin based on neovim's built-in lsp with a highly performant UI.
    Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

    " 💻 CMP
    " A completion engine plugin written in Lua
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'

    " 🏷️ Autotag/pairs
    " 
    Plug 'windwp/nvim-autopairs'
    Plug 'windwp/nvim-ts-autotag'

    " ✨ LuaSnip
    " Snippet Engine for Neovim written in Lua
    Plug 'L3MON4D3/LuaSnip'

    " 📦 lspkind
    " Adds symbol next to the autocompletion
    Plug 'onsails/lspkind.nvim'

    " 🌳 Treesitter
    " Better highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    " 🔭 Telescopec
    " Find, Filter, Preview, Pick Files
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
    Plug 'nvim-telescope/telescope-file-browser.nvim'

    " 🚦 Trouble
    " A pretty list for showing diagnostics, references, telescope results, quickfix and location lists
    " Plug 'folke/trouble.nvim'

    " 🎨 Colorizer
    " A high-performance color highlighter for Neovim
    Plug 'norcalli/nvim-colorizer.lua'
    
    " 🧘 Zen Mode
    " Distraction-free coding for Neovim
    Plug 'folke/zen-mode.nvim'

    " 🎛️ Dashboard
    " Customizable NeoVim start screen
    Plug 'glepnir/dashboard-nvim'

  call plug#end()

" Theme
" ---------------------------------------

  " 🏙️ Tokyo Night Configuration
  let g:tokyonight_style = "storm"
  let g:tokyonight_transparent = 1
  let g:tokyonight_transparent_sidebar = 1
    
  colorscheme tokyonight
