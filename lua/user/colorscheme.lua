local colorscheme = 'onedarker'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

require'colorizer'.setup()
-- Lua
--[[ require('onedark').setup { ]]
--[[     style = 'dark' ]]
--[[ } ]]
--[[ require('onedark').load() ]]
