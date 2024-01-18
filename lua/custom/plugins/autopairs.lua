function split (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function ()
    local npairs = require('nvim-autopairs')
    local Rule = require('nvim-autopairs.rule')
    local cond = require('nvim-autopairs.conds')

    npairs.setup {}

    npairs.add_rules({
      Rule("<[a-zA-Z]*>$", "", { 'react', 'typescriptreact' })
        :use_regex(true)
        -- :with_pair(cond.not_after_regex("("))
        :replace_endpair(function(opts)
          print(vim.inspect(opts))
          local prev_char_split = split(opts.prev_char, '<')
          print(vim.inspect(prev_char_split))
          return '</' .. prev_char_split[2]
        end)
    })
  end,
}

