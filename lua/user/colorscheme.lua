local colorscheme = 'tokyonight-moon'

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end

-- Lua
--[[ require('onedark').setup { ]]
--[[     style = 'dark' ]]
--[[ } ]]
--[[ require('onedark').load() ]]
require'colorizer'.setup()
