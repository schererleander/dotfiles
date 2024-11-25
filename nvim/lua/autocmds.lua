vim.cmd('highlight WinSeparator guibg=None ctermbg=None')
vim.cmd('highlight VertSplit guibg=NONE ctermbg=NONE')
-- hide background lsp coloum
vim.cmd('highlight SignColumn guibg=NONE ctermbg=None')

-- transparent background
vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
vim.cmd('highlight NormalNC guibg=NONE ctermbg=NONE')

-- set linebreak for tex files
vim.cmd('autocmd FileType tex setlocal wrap linebreak')

-- convert tex file into pdf using pdflatex on save
vim.cmd('autocmd BufWritePost *.tex silent !pdflatex %<CR>')

-- remove space
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

