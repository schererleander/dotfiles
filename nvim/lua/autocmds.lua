vim.cmd([[
augroup TexToPDF
    autocmd!
    autocmd BufWritePost *.tex silent !pdflatex "%"
augroup END
]])

vim.cmd([[
augroup MarkdownToPDF
  autocmd!
  autocmd BufWritePost *.md silent !pandoc "%:p" -o "%:p:r.pdf"
augroup END
]])

-- Set Up Spellchecking for German
vim.opt.spelllang = 'de'
vim.opt.spell = true

-- Enable Spellchecking and Highlighting
vim.opt.spell = true
vim.cmd('highlight SpellBad cterm=underline gui=underline')
vim.cmd('highlight SpellCap cterm=underline gui=underline')
vim.cmd('highlight SpellRare cterm=underline gui=underline')
vim.cmd('highlight SpellLocal cterm=underline gui=underline')