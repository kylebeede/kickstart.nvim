require 'options'

require 'lazy-setup'

require 'plugin-list'

require 'telescope-setup'

require 'treesitter-setup'

require 'lsp-setup'

require 'copilot-setup'

require 'cmp-setup'

require 'autoformat'

-- Configure keymaps & whichkey
require 'keymaps'

-- Enable colorscheme
vim.cmd [[colorscheme nightfly]]

-- Configure vim-rhubarb
vim.g.github_enterprise_urls = { 'git.faithlife.dev' }

-- Because netrw is disabled, :GBrowse requires a custom :Browse implementation. Mac specific
vim.cmd [[
  command! -nargs=* -complete=file Browse execute '!open ' .. shellescape(<q-args>)
]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
