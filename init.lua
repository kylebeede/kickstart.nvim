require 'config.options'

require 'config.lazy-setup'

require 'config.lsp-setup'

require 'config.cmp-setup'

require 'config.autoformat'

require 'config.autocmd'

require 'config.keymaps'

-- Enable colorscheme
vim.cmd [[colorscheme nightfly]]

-- Configure vim-rhubarb
vim.g.github_enterprise_urls = { 'git.faithlife.dev' }

-- Because netrw is disabled, :GBrowse requires a custom :Browse implementation. Mac specific
vim.cmd [[
  command! -nargs=* -complete=file Browse execute '!open ' .. shellescape(<q-args>)
]]

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
