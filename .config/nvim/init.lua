
vim.g.mapleader = ' '

-- bootstrap Lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- load plugins
require("lazy").setup("plugins")

vim.cmd('source ~/.config/nvim/init-orig.vim')

vim.o.signcolumn = 'yes'

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
})

-- Show diagnostics in a floating window for the current line
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- Navigate to next/previous diagnostic
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })

-- Show all diagnostics in quickfix list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setqflist, { desc = 'List all diagnostics' })
