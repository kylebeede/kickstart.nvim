---@diagnostic disable-next-line: unused-local
local function custom_path_display(opts, path)
  local cwd = vim.loop.cwd()

  ---@diagnostic disable-next-line: need-check-nil
  if not cwd:match("AcademicServices") then
    return path
  end

  local segments = vim.split(path, "/")

  if #segments < 2 then
    return path
  end

  local display_name = ""
  if path ~= nil then
    if string.find(path, "Faithlife.AcademicDesk.Client") then
      display_name = "[Desk.C]"
    elseif string.find(path, "Faithlife.AcademicDesk.Server") then
      display_name = "[Desk.S]"
    elseif string.find(path, "Faithlife.AcademicPortal.Client") then
      display_name = "[Portal.C]"
    elseif string.find(path, "Faithlife.AcademicPortal.Server") then
      display_name = "[Portal.S]"
    elseif string.find(path, "Faithlife.AcademicServices.AcademicApi.v1.WebApi") then
      display_name = "[WebApi]"
    elseif string.find(path, "Faithlife.AcademicServices.Subscriber") then
      display_name = "[Subscriber]"
    elseif string.find(path, "Faithlife.AcademicServices.Services") then
      display_name = "[Services]"
    elseif string.find(path, "Faithlife.AcademicServices.Scheduler") then
      display_name = "[Scheduler]"
    elseif string.find(path, "Faithlife.AcademicServices.JobConsole") then
      display_name = "[JobConsole]"
    elseif string.find(path, "Faithlife.AcademicServices.Data.Entities") then
      display_name = "[Entities]"
    elseif string.find(path, "Faithlife.AcademicServices.Data") then
      display_name = "[Data]"
    elseif string.find(path, "Faithlife.AcademicServices.IntegrationTests") then
      display_name = "[IntegrationTests]"
    elseif string.find(path, "Faithlife.AcademicServices.AcademicApi.Tests") then
      display_name = "[AcademicApi.Tests]"
    elseif string.find(path, "Faithlife.AcademicServices.LtiProvider.v1.Web.Tests") then
      display_name = "[LtiProvider.Tests]"
    elseif string.find(path, "Faithlife.AcademicServices.LtiProvider.v1.Web") then
      display_name = "[LtiProvider]"
    end
  end
  if display_name == "" then
    return path
  end

  -- Get the remaining path after the segment
  local lastPart = string.match(path, "/([^/]+)$")

  -- Return the formatted path
  return display_name .. " " .. lastPart
end

local function remove_reference_line(opts, path)
  local segments = vim.split(path, " | ")

  if #segments > 1 then
    return segments[1]
  end

  return path
end

local _actions = require 'telescope.actions'
require('telescope').setup {
  defaults = {
    show_dotfiles = true,
    file_ignore_patterns = { "%.g%.cs$", "%.png$" },
    path_display = custom_path_display,
    shorten_path = true,
    mappings = {
      i = {
        ['<C-x>'] = _actions.delete_buffer
      },
    },
  },
  pickers = {
    jumplist = {
      path_display = { "tail" },
      previewer = true,
      theme = 'ivy'
    },
    lsp_references = {
      fname_width = 100,
      previewer = true
    }
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Enable telescope dap
pcall(require('telescope').load_extension, 'dap')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
vim.keymap.set('n', '<leader>sj', require('telescope.builtin').jumplist, { desc = '[S]earch [J]umplist' })

-- vim: ts=2 sts=2 sw=2 et
