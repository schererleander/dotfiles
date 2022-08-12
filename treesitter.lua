local status, ts = pcall(require, 'treesitter')
if (not status) then return end

ts.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = true,
    disable = {}
  },
  ensure_installed = {
    'lua',
    'python',
    "css",
    "html",
    "json",
  },
  autotag = {
    enable = true,
  },
}
