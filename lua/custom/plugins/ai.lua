return {
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>"
          },
          layout = {
            position = "bottom", -- | top | left | right
            ratio = 0.4
          },
        },
        suggestion = {
          enabled = false,
          auto_trigger = false,
          debounce = 75,
          keymap = {
            accept = "<M-l>",
            accept_word = false,
            accept_line = false,
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = 'node', -- Node.js version must be > 18.x
        server_opts_overrides = {},
      })

      -- hide copilot suggestions when cmp menu is open
      -- to prevent odd behavior/garbled up suggestions
      -- local cmp_status_ok, cmp = pcall(require, "cmp")
      -- if cmp_status_ok then
      --   cmp.event:on("menu_opened", function()
      --     vim.b.copilot_suggestion_hidden = true
      --   end)
      --
      --   cmp.event:on("menu_closed", function()
      --     vim.b.copilot_suggestion_hidden = false
      --   end)
      -- end
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end
  }
  -- https://github.com/David-Kunz/gen.nvim
  -- {
  --   "David-Kunz/gen.nvim",
  --   opts = {
  --     model = "mistral",      -- The default model to use.
  --     display_mode = "float", -- The display mode. Can be "float" or "split".
  --     show_prompt = false,    -- Shows the Prompt submitted to Ollama.
  --     show_model = false,     -- Displays which model you are using at the beginning of your chat session.
  --     no_auto_close = false,  -- Never closes the window automatically.
  --     init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  --     -- Function to initialize Ollama
  --     command = "curl --silent --no-buffer -X POST http://localhost:11434/api/generate -d $body",
  --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  --     -- This can also be a lua function returning a command string, with options as the input parameter.
  --     -- The executed command must return a JSON object with { response, context }
  --     -- (context property is optional).
  --     list_models = '<omitted lua function>', -- Retrieves a list of model names
  --     debug = false                           -- Prints errors and the command which is run.
  --   }
  -- },
}
