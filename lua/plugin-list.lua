---------- INSTALL PLUGINS ----------
--  Configure plugins using the `config` key.
--  or configure plugins after the setup call
--  as they will be available in your neovim runtime.
--  TODO: replace with plugin-loader --
require('lazy').setup({
  -- Color scheme
  {
    'bluz71/vim-nightfly-colors',
    name = 'nightfly',
    lazy = false,
    priority = 1000,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- LSP configuration & plugins
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional LuaLS configuration for editing Neovim config
      {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = 'luvit-meta/library', words = { 'vim%.uv' } },
          },
        },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true }, -- optional `vim.uv` typings

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
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
      { 'nvim-telescope/telescope-github.nvim' },
      -- { 'nvim-telescope/telescope-dap.nvim' },
    },
  },

  -- Highlight, edit, and navigate code
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    opts = {
      enable = false,           -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
      min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
      line_numbers = true,
      multiline_threshold = 20, -- Maximum number of lines to show for a single context
      trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
      -- Separator between context and content. Should be a single character string, like '-'.
      -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
      separator = nil,
      zindex = 20, -- The Z-index of the context window
      indent = {
        enable = true,
      },
      on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    },
  },

  {
    'Mofiqul/vscode.nvim',
    priority = 1000,
    config = function()
      local c = require('vscode.colors').get_colors()
      require('vscode').setup {
        style = 'dark',
        transparent = false,
        italic_comments = true,
        disable_nvimtree_bg = true,
        group_overrides = {
          NormalFloat = { fg = c.vscFront, bg = 'NONE' },
          Comment = { fg = c.vscGray, bg = 'NONE', italic = true },
          SpecialComment = { fg = c.vscGray, bg = 'NONE', italic = true },
          ['@comment'] = { fg = c.vscGray, bg = 'NONE', italic = true },
        },
      }
      require('vscode').load()
    end,
  },

  -- Set lualine as statusline
  -- See `:help lualine.txt`
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',             opts = {} },

  -- Open links in browser
  {
    'lalitmee/browse.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  {
    'zbirenbaum/copilot.lua',
    enabled = true,
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      show_help = 'yes',         -- Show help text for CopilotChatInPlace, default: yes
      debug = false,             -- Enable or disable debug mode, the log file will be in ~/.local/state/nvim/CopilotChat.nvim.log
      disable_extra_info = 'no', -- Disable extra information (e.g: system prompt) in the response.
      language = 'English',      -- Copilot answer language settings when using default prompts. Default language is English.
      -- proxy = "socks5://127.0.0.1:3000", -- Proxies requests via https or socks.
      -- temperature = 0.1,
    },
    build = function()
      vim.notify "Please update the remote plugins by running ':UpdateRemotePlugins', then restart Neovim."
    end,
    event = 'VeryLazy',
    keys = {
      { '<leader>ccb', ':CopilotChatBuffer ',         desc = 'CopilotChat - Chat with current buffer' },
      { '<leader>cce', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - Explain code' },
      { '<leader>cct', '<cmd>CopilotChatTests<cr>',   desc = 'CopilotChat - Generate tests' },
      {

        '<cmd>CopilotChatVsplitToggle<cr>',
        desc = 'CopilotChat - Toggle Vsplit', -- Toggle vertical split
      },
      {
        '<leader>ccv',
        ':CopilotChatVisual ',
        mode = 'x',
        desc = 'CopilotChat - Open in vertical split',
      },
      {
        '<leader>ccx',
        ':CopilotChatInPlace<cr>',
        mode = 'x',
        desc = 'CopilotChat - Run in-place code',
      },
      {
        '<leader>ccf',
        '<cmd>CopilotChatFixDiagnostic<cr>', -- Get a fix for the diagnostic message under the cursor.
        desc = 'CopilotChat - Fix diagnostic',
      },
      {
        '<leader>ccr',
        '<cmd>CopilotChatReset<cr>', -- Reset chat history and clear buffer.
        desc = 'CopilotChat - Reset chat history and clear buffer',
      },
    },
  },

  {
    'kwkarlwang/bufjump.nvim',
    config = function()
      require('bufjump').setup {
        forward = '<C-n>',
        backward = '<C-p>',
        on_success = nil,
      }
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      -- 'rafamadriz/friendly-snippets',
    },
  },

  {
    'Pocco81/true-zen.nvim',
    config = function()
      require('true-zen').setup {
        modes = {
          options = {
            number = true,
            relativenumber = true,
            ruler = true,
          },
          ataraxis = {
            minimum_writing_area = { -- minimum size of main window
              width = 90,
              height = 44,
            },
            padding = { -- padding windows
              left = 20,
              right = 20,
              top = 0,
              bottom = 0,
            },
          },
        },
      }
    end,
  },

  {
    'mfussenegger/nvim-dap',
    dependencies = {
      -- Creates a beautiful debugger UI
      'rcarriga/nvim-dap-ui',

      -- Installs the debug adapters for you
      'williamboman/mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',

      -- Add your own debuggers here
      'leoluz/nvim-dap-go',
    },
    config = (require 'debug-setup').dap_setup,
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- TODO: add configuration
    },
  },

  -- Folding
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
  },

  -- Notes
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = 'markdown',
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    dependencies = {
      -- Required.
      'nvim-lua/plenary.nvim',

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = 'general',
          path = '~/Sync/Obsidian',
        },
      },

      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = '30-39 Career/31 Faithlife/(S) Scratchpad',
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = '%Y-%m-%d',
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = '%B %-d, %Y',
        -- Optional, default tags to add to each new daily note created.
        default_tags = { 'daily-notes' },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = nil,
      },
    },
  },

  -- Markdown previewing
  {
    'toppair/peek.nvim',
    event = { 'VeryLazy' },
    build = 'deno task --quiet build:fast',
    config = function()
      require('peek').setup {
        theme = 'light',
      }
      vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
      vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
    end,
  },

  -- Improved C# LSP support
  { 'Hoffs/omnisharp-extended-lsp.nvim', lazy = true },

  { import = 'plugins' },
}, {})

-- vim: ts=2 sts=2 sw=2 et

-- vim: ts=2 sts=2 sw=2 et
