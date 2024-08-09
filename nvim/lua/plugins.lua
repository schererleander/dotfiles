require("lazy").setup({
  {
    "EdenEast/nightfox.nvim",
		priority = 1000,
    options = {
      transparent = true,
			terminal_colors = true,
			dim_inactive = false,
			module_default = true,
			styles = {
				comments = "italic",
				keywords = "italic",
			},
			inverse = {
				match_paren = false,
				visual = false,
				search = false,
			},
		},
    config = function ()
      vim.cmd("colorscheme terafox")
    end
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
		},
		event = "InsertEnter",
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({ automatic_installation = true })

			local lspconfig = require("lspconfig")
			local signs = {
				Error = " ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, {
					text = icon,
					texthl = hl,
					numhl = hl,
				})
			end

			local servers = require('mason-lspconfig').get_installed_servers()
			for _, server in pairs(servers) do
				lspconfig[server].setup{}
			end

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})

			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					["<CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
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
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufRead",
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = true,
				ensure_installed = { "c", "lua", "vim" },
				highlight = { enable = true, use_languagetree = true },
				indent = { enable = true },
			})
		end,
	},

	{
		"nvim-tree/nvim-tree.lua",
		enabled = false,
		config = function()
			require("nvim-tree").setup({
				view = { width = 20, side = "left" },
				disable_netrw = true,
				hijack_cursor = true,
				update_cwd = true,
				hijack_directories = { auto_open = true },
				renderer = {
					root_folder_label = false,
					indent_markers = {
						enable = true,
						icons = { corner = "└ ", edge = "│ ", none = "  " },
					},
				},
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{"<C-s>", ":silent Telescope current_buffer_fuzzy_find<CR>", desc = "Open Telescope"}
		},
		config = function()
			require("telescope").setup({
				defaults = { mapping = {} },
				pickers = {},
				extensions = {},
			})
		end,
	},

	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
	},

	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
		end,
	},

	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")

			lint.linter_by_ft = {
				lua = { "luachecker" },
				python = { "pylint" },
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})
		end,
	},

	{
		"echasnovski/mini.nvim",
		version = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("mini.starter").setup({
				header = table.concat({
					"  ／l、     ",
					"（ﾟ､ ｡ ７    ",
					" l  ~ ヽ    ",
					" じしf_,)ノ ",
				}, "\n"),
				footer = "",
				content_hooks = {
					require("mini.starter").gen_hook.adding_bullet("» "),
					require("mini.starter").gen_hook.aligning("center", "center"),
				},
			})
		end,
	},

	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = function ()
			require("nvim-autopairs").setup{}
		end
	},

	{
		'tamton-aquib/staline.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require "staline".setup {
				sections = {
					left = { 'file_name', 'branch' },
					mid = { 'lsp' },
					right = { 'line_column' }
				},
				special_table = {
					NvimTree = { 'NvimTree', ' ' },
					packer = { 'Packer', ' ' },
					starter = { '', '' },
					lazy = { '', '' },
					mason = { '', '' }
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
					exclude_fts = { 'NvimTree' }
				}
			}
			vim.cmd('highlight Statusline guibg=none')
			vim.cmd('highlight StatuslineNC guibg=none')
		end,
	}
})

