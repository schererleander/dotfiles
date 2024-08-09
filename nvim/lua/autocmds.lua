-- transparent background
--vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
--vim.cmd('highlight LineNr guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE')
--vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')
--vim.cmd('highlight CursorLine guibg=NONE ctermbg=NONE')
-- completion menu transparent
--vim.cmd('highlight Pmenu guibg=NONE ctermbg=NONE')
--vim.cmd('highlight PmenuSel guibg=NONE ctermbg=NONE')
-- vertical lines transparent
vim.cmd('highlight WinSeparator guibg=None ctermbg=None')
vim.cmd('highlight VertSplit guibg=NONE ctermbg=NONE')
-- hide background lsp coloum
vim.cmd('highlight SignColumn guibg=NONE ctermbg=None')

vim.cmd('autocmd FileType tex setlocal wrap linebreak')

vim.cmd('autocmd BufWritePost *.tex silent !pdflatex %<CR>')

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- enable spellchecking
vim.opt.spelllang = 'de'
vim.opt.spell = true

-- set up spellchecking highlighting
vim.cmd('highlight SpellBad cterm=underline gui=underline')
vim.cmd('highlight SpellCap cterm=underline gui=underline')
vim.cmd('highlight SpellRare cterm=underline gui=underline')
vim.cmd('highlight SpellLocal cterm=underline gui=underline')
