require("core.options")
require("core.keymaps")
require("core.layout")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.loop or vim.uv).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  require("plugins.nord"),
  -- require("plugins.catppuccin"),
  require("plugins.window-picker"),
  require("plugins.neo-tree"),
  require("plugins.auto-session"),
  require("plugins.lualine"),
  require("plugins.treesitter"),
  require("plugins.lsp"),
  require("plugins.telescope"),
  require("plugins.cmp"),
  require("plugins.none-ls"), -- автоформаттер, линтеры, ruff
  require("plugins.gitsigns"),
  require("plugins.neogit"),
  require("plugins.indent-blankline"),
  require("plugins.bufferline"),
  require("plugins.toggleterm"),
  require("plugins.langmapper"),
  require("plugins.sql"),
  require("plugins.autopairs"),
})
