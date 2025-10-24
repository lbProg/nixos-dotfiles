vim.api.nvim_create_user_command("ReloadTheme", function()
  local theme_spec = dofile("/home/lucien/.config/nvim/lua/plugins/neovim.lua")
  print(vim.inspect(theme_spec))
  for _, spec in ipairs(theme_spec) do
    if spec.opts and spec.opts.colorscheme then
      vim.cmd.colorscheme(spec.opts.colorscheme)
      break
    end
  end
end, {})
