return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        size = 15,
        open_mapping = [[<A-t>]],
        direction = "horizontal",
        close_on_exit = false,
        shade_terminals = true,
        start_in_insert = false,
      })
    end,
  },
}

