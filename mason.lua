local status, mason = pcall(require, 'mason')
if (not status) then return end

local status2, masonlspconfig = pcall(require, 'mason-lspconfig')
if (not status2) then return end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

masonlspconfig.setup {
  
  ensure_installed = {},

  -- false: Servers are not automatically installed.
  -- true: All servers set up via lspconfig are automatically installed.
  automatic_installation = false,
}
