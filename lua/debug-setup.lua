local M = {}

function M.dap_setup(_, opts)
  local dap = require 'dap'
  local dapui = require 'dapui'

  require('mason-nvim-dap').setup {
    -- Makes a best effort to setup the various debuggers with
    -- reasonable debug configurations
    automatic_setup = true,

    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    handlers = {},

    ensure_installed = {
      'delve',
      'netcoredbg',
    },
  }

  -- Dap UI setup
  -- For more information, see |:help nvim-dap-ui|
  dapui.setup {
    -- Set icons to characters that are more likely to work in every terminal.
    --    Feel free to remove or use ones that you like more! :)
    --    Don't feel like these are good choices.
    icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    controls = {
      icons = {
        pause = '⏸',
        play = '▶',
        step_into = '⏎',
        step_over = '⏭',
        step_out = '⏮',
        step_back = 'b',
        run_last = '▶▶',
        terminate = '⏹',
        disconnect = '⏏',
      },
    },
  }

  -- Dap adapter setup
  dap.adapters.netcoredbg = {
    type = 'executable',
    command = '/usr/local/netcoredbg',
    args = { '--interpreter=vscode' },
  }

  -- Dap configuration setup
  dap.configurations.cs = {
    -- Used with test runner
    {
      type = 'netcoredbg',
      name = 'netcoredbg',
      request = 'attach',
    },
    -- Used to attach to process
    {
      type = 'netcoredbg',
      name = 'netcoredbg - pick',
      request = 'attach',
      processId = function()
        return require('dap.utils').pick_process { filter = 'Faithlife' }
      end,
    },
  }

  dap.listeners.after.event_initialized['dapui_config'] = dapui.open
  dap.listeners.before.event_terminated['dapui_config'] = dapui.close
  dap.listeners.before.event_exited['dapui_config'] = dapui.close

  -- Install golang specific config
  require('dap-go').setup()
end

return M

-- vim: ts=2 sts=2 sw=2 et
