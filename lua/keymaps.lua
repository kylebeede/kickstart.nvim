-- See `:help vim.keymap.set()`

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Faster panel movement
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Focus panel to the left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Focus panel to the right' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Focus panel below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Focus panel above' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

-- local keymap = vim.keymap -- for conciseness
-- https://github.com/nvim-tree/nvim-tree.lua/issues/2520#issuecomment-1801342927
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'TelescopePrompt' then
    require('telescope.actions').close(vim.api.nvim_get_current_buf())
  end
  vim.cmd 'NvimTreeToggle'
end, { desc = '[E]xplorer' }) -- toggle file explorer

