local status, lspconfig = pcall(require, 'lspconfig')
if (not status) then return end



lspconfig.pyright.setup {}

lspconfig.sumneko_lua.setup {
  settings = {
    Lua = {
      diagnostics = {
	-- get the language server to recognize the  'vim' globals
	globals = { 'vim' }
      },

      workspace = {
	libary = vim.api.nvim_get_runtime_file("", true)
      }
    }
  }
}

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
