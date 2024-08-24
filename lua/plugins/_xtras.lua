return {
  -- Open links in browser
  {
    'lalitmee/browse.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Inline markdown previewing
  {
    'OXY2DEV/markview.nvim',
    ft = 'markdown',

    dependencies = {
      -- You may not need this if you don't lazy load
      -- Or if the parsers are in your $RUNTIMEPATH
      'nvim-treesitter/nvim-treesitter',

      'nvim-tree/nvim-web-devicons',
    },
  },

  -- distraction-free ui
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

  -- obsidian note integration
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

  -- Navigate jumplist buffers
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

  -- "gc" and other comment keybinds
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    'LudoPinelli/comment-box.nvim',
    cmd = { 'CBccbox', 'CBllline', 'CBline', 'CBcabox', 'CBd' },
    opts = {},
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',
}
