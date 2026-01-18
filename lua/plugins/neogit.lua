return {
  "NeogitOrg/neogit",
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim", -- required
    "sindrets/diffview.nvim", -- optional - Diff integration

    -- Only one of these is needed.
    "nvim-telescope/telescope.nvim", -- optional
    -- "ibhagwan/fzf-lua", -- optional
    -- "nvim-mini/mini.pick", -- optional
    -- "folke/snacks.nvim", -- optional
  },
  cmd = "Neogit",
  keys = {
    { "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
  },
  -- vim.keymap.set("n", "<leader>ngn", function()
  -- 	local Neogit = require("neogit")
  -- 	-- создаём новый контекст с уникальным названием
  -- 	Neogit.open({
  -- 		kind = "float",
  -- 		context_name = "new_session_" .. tostring(os.time()),
  -- 	})
  -- end, { noremap = true, silent = true }),
}
