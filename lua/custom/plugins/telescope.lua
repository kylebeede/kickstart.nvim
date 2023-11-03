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

  local segment = segments[2]

  local display_name = ""
  if segment ~= nil then
    if string.find(segment, "Faithlife.AcademicDesk.Client") then
      display_name = "[Desk.C]"
    elseif string.find(segment, "Faithlife.AcademicDesk.Server") then
      display_name = "[Desk.S]"
    elseif string.find(segment, "Faithlife.AcademicPortal.Client") then
      display_name = "[Portal.C]"
    elseif string.find(segment, "Faithlife.AcademicPortal.Server") then
      display_name = "[Portal.S]"
    elseif string.find(segment, "Faithlife.AcademicServices.AcademicApi.v1.WebApi") then
      display_name = "[WebApi]"
    elseif string.find(segment, "Faithlife.AcademicServices.Subscriber") then
      display_name = "[Subscriber]"
    elseif string.find(segment, "Faithlife.AcademicServices.Services") then
      display_name = "[Services]"
    elseif string.find(segment, "Faithlife.AcademicServices.Scheduler") then
      display_name = "[Scheduler]"
    elseif string.find(segment, "Faithlife.AcademicServices.JobConsole") then
      display_name = "[JobConsole]"
    elseif string.find(segment, "Faithlife.AcademicServices.Data.Entities") then
      display_name = "[Entities]"
    elseif string.find(segment, "Faithlife.AcademicServices.Data") then
      display_name = "[Data]"
    elseif string.find(segment, "Faithlife.AcademicServices.IntegrationTests") then
      display_name = "[IntegrationTests]"
    elseif string.find(segment, "Faithlife.AcademicServices.AcademicApi.Tests") then
      display_name = "[AcademicApi.Tests]"
    elseif string.find(segment, "Faithlife.AcademicServices.LtiProvider.v1.Web.Tests") then
      display_name = "[LtiProvider.Tests]"
    end
  end
  if display_name == "" or segment == nil then
    return path
  end

  -- Get the remaining path after the segment
  local index = string.find(path, segment) + #segment + 1
  local sub_path = string.sub(path, index)

  -- Get path past "/src" if possible
  sub_path = vim.fn.substitute(sub_path, "^src", "", "")

  -- Return the formatted path
  return display_name .. " " .. sub_path
end

return {
  -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      defaults = {
        show_dotfiles = true,
        file_ignore_patterns = { "%.g%.cs$", "%.png$" },
        path_display = custom_path_display,
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
    }

    -- Enable telescope fzf native, if installed
    pcall(require('telescope').load_extension, 'fzf')

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
  end
}
