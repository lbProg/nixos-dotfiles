local theme_file = "/home/lucien/.config/theming/current/theme/neovim.lua"

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = theme_file,
  callback = function()
    vim.cmd("luafile /home/lucien/.config/theming/current/theme/neovim.lua")
  end,
})
