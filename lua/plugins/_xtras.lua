return {
    -- Open links in browser
    {
        'lalitmee/browse.nvim',
        cmd = 'GBrowse',
        dependencies = { 'nvim-telescope/telescope.nvim' },
    },

    -- Inline markdown previewing
    {
        'OXY2DEV/markview.nvim',
        -- NOTE: If markview fails to load or does not work it could be an issue with failing to load a treesitter parser
        -- Use :checkhealth to check for errors and/or temporarily disable lazy loading
        ft = 'markdown',

        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
    },

    -- distraction-free ui
    {
        'Pocco81/true-zen.nvim',
        cmd = { 'TZNarrow', 'TZFocus', 'TZMinimalist', 'TZAtaraxis' },
        config = function()
            require('true-zen').setup({
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
            })
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
        event = 'VeryLazy',
        config = function()
            require('bufjump').setup({
                forward = '<C-n>',
                backward = '<C-p>',
                on_success = nil,
            })
        end,
    },

    -- "gc" and other comment keybinds
    {
        'numToStr/Comment.nvim',
        event = 'VeryLazy',
        opts = {},
    },

    -- Adds comment format varieties
    {
        'LudoPinelli/comment-box.nvim',
        cmd = { 'CBccbox', 'CBllline', 'CBline', 'CBcabox', 'CBd' },
        opts = {},
    },

    -- Colorize hex, rgb, hsl, etc
    { 'norcalli/nvim-colorizer.lua', cmd = 'ColorizerToggle' },

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- fzf integration
    {
        'ibhagwan/fzf-lua',
        -- optional for icon support
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            -- calling `setup` is optional for customization
            -- require('fzf-lua').setup {}
        end,
    },
}
