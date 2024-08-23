-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Prints the line diagnostic
local diagnostic_group = vim.api.nvim_create_augroup('DiagnosticEcho', { clear = true })
vim.api.nvim_create_autocmd('CursorHold', {
  callback = function()
    require('echo_diagnostic').echo_diagnostic()
  end,
  group = diagnostic_group,
  pattern = '*',
})
