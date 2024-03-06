require('lazy').setup({
  -- Portable package manager to install and manage LSP servers, DAP servers, linters, and formatters.
  {
    'williamboman/mason.nvim',
    dependencies = { 'williamboman/mason-lspconfig.nvim' },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup({ automatic_installation = true })
    end
  }, -- A completion engine plugin for neovim written in Lua.
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
      {
        'neovim/nvim-lspconfig',
        config = function()
          local signs = {
            Error = " ",
            Warn = " ",
            Hint = " ",
            Info = " "
          }
          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, {
              text = icon,
              texthl = hl,
              numhl = hl
            })
          end

          local lsp = require('lspconfig')
          local capabilities =
              require('cmp_nvim_lsp').default_capabilities()
          lsp.pyright.setup {
            capabilities = capabilities,
            settings = { update_in_insert = true }
          }
          lsp.ltex.setup({
            settings = {
              ltex = {
                language = "de-DE"
              }
            }
          })
          lsp.texlab.setup {
            capabilities = capabilities
          }
          lsp.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  -- Get the language server to recognize the 'vim' global
                  globals = { 'vim' }
                },
                workspace = {
                  -- make the server aware of the neovim runtime files
                  libary = vim.api.nvim_get_runtime_file('',
                    true)
                },
                telemetry = {
                  -- do not send telemetry data containing a randomized but unique identifier
                  enable = false
                }
              }
            }
          }
        end
      }, 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', 'L3MON4D3/LuaSnip'
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
          },
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" })
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' }
        }
      })
    end
  }, -- A super powerful autopair plugin for Neovim that supports multiple characters.
  {
    'windwp/nvim-autopairs',
    config = function()
      require("nvim-autopairs").setup()
      -- inserts `(` after selecting a function or method item
      require('cmp').event:on('confirm_done', require(
        'nvim-autopairs.completion.cmp').on_confirm_done())
    end
  }, -- Adds indentation guides to all lines.
  {
    'lukas-reineke/indent-blankline.nvim',
    main = "ibl",
    opt = { filetypes = { "help", "terminal", "alpha", "lazy", "NvimTree" } }
  }, --
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        auto_install = true,
        ensure_installed = { 'c', 'lua', 'vim' },
        highlight = { enable = true, use_languagetree = true },
        indent = { enable = true }
      })
    end
  }, -- A File Explorer for Neovim written in Lua
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      -- disable netrw (inbuild file explorer)
      require('nvim-tree').setup({
        view = { width = 20, side = 'left' },
        --disable_netrw = true,
        hijack_cursor = true,
        update_cwd = true,
        hijack_directories = { auto_open = true },
        renderer = {
          root_folder_label = false,
          indent_markers = {
            enable = true,
            icons = { corner = "└ ", edge = "│ ", none = "  " }
          }
        }
      })
    end
  }, --
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = { mapping = {} },
        pickers = {},
        extensions = {}
      })
      vim.api.nvim_set_keymap('n', '<C-s>',
        ':Telescope current_buffer_fuzzy_find<CR>',
        { noremap = true, silent = true })
    end
  }, -- formatting
  {
    'stevearc/conform.nvim',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require('conform').setup({
        format_on_save = {
          timeout_ms = 500,
          lsp_fallback = true
        },
        lua = { "stylua" },
      })
    end
  }, --
  {
    'mfussenegger/nvim-lint',
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require('lint')
      lint.linters_by_ft = {

      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end
  }, -- Customize start up screen
  {
    'goolord/alpha-nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local mew = {
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠞⢳⠀⠀⠀⠀⠀',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡔⠋⠀⢰⠎⠀⠀⠀⠀⠀',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢆⣤⡞⠃⠀⠀⠀⠀⠀⠀',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⢠⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀',
        '⠀⠀⠀⠀⢀⣀⣾⢳⠀⠀⠀⠀⢸⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀',
        '⣀⡤⠴⠊⠉⠀⠀⠈⠳⡀⠀⠀⠘⢎⠢⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀',
        '⠳⣄⠀⠀⡠⡤⡀⠀⠘⣇⡀⠀⠀⠀⠉⠓⠒⠺⠭⢵⣦⡀⠀⠀⠀',
        '⠀⢹⡆⠀⢷⡇⠁⠀⠀⣸⠇⠀⠀⠀⠀⠀⢠⢤⠀⠀⠘⢷⣆⡀⠀',
        '⠀⠀⠘⠒⢤⡄⠖⢾⣭⣤⣄⠀⡔⢢⠀⡀⠎⣸⠀⠀⠀⠀⠹⣿⡀',
        '⠀⠀⢀⡤⠜⠃⠀⠀⠘⠛⣿⢸⠀⡼⢠⠃⣤⡟⠀⠀⠀⠀⠀⣿⡇',
        '⠀⠀⠸⠶⠖⢏⠀⠀⢀⡤⠤⠇⣴⠏⡾⢱⡏⠁⠀⠀⠀⠀⢠⣿⠃',
        '⠀⠀⠀⠀⠀⠈⣇⡀⠿⠀⠀⠀⡽⣰⢶⡼⠇⠀⠀⠀⠀⣠⣿⠟⠀',
        '⠀⠀⠀⠀⠀⠀⠈⠳⢤⣀⡶⠤⣷⣅⡀⠀⠀⠀⣀⡠⢔⠕⠁⠀⠀',
        '⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠫⠿⠿⠿⠛⠋⠁⠀⠀⠀⠀',
        ''
      }
      local alpha = require('alpha')
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = mew
      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find Files',
          ':Telescope find_files <CR>'),
        dashboard.button('r', '󱔗  Recent Files',
          ':Telescope oldfiles <CR>'),
        dashboard.button('u', '  Update Plugins', ':Lazy update <CR>'),
        dashboard.button('q', '  Quit Neovim', ':q! <CR>')
      }
      dashboard.section.buttons.opts.spacing = 1
      dashboard.section.footer.val = 'Never knows best'
      dashboard.opts.opts.noautocmd = true
      alpha.setup(dashboard.opts)
    end
  }, --
  {
    'tamton-aquib/staline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require "staline".setup {
        sections = {
          left = { ' ' },
          mid = { 'lsp' },
          right = { 'line_column' }
        },
        lsp_symbols = {
          Error = " ",
          Info = " ",
          Warn = " ",
          Hint = ""
        },
        defaults = {
          true_colors = true,
          line_column = ' ☰ %l/%L %c',
          branch_symbol = " ",
          exclude_fts = { 'NvimTree', 'Alpha' }
        }
      }
      -- remove background color
      vim.cmd('highlight Statusline guibg=none')
      vim.cmd('highlight StatuslineNC guibg=none')
    end
  }
})
