local plugin_list = {
  'bluz71/vim-nightfly-colors',
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  -- TODO: add plugins to this list --
}

local function load_plugins()
  local result = {}
  for _, plugin in ipairs(plugin_list) do
    local plugin_file = '/plugins/' .. plugin .. '.lua'
    if vim.fn.filereadable(vim.fn.expand('~' .. plugin_file)) == 1 then
      table.insert(result, require(plugin_file))
    else
      table.insert(result, plugin)
    end
  end
  return result
end

return {
  plugin_list = load_plugins(),
}
