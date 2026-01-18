return {
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1000, -- нужен высокий приоритет при автомаппинге
		config = function()
			local lm = require("langmapper")

			lm.setup({
				map_all_ctrl = false,
				ctrl_map_modes = { "n", "o", "i", "c", "t", "v" },
				hack_keymap = false,
				disable_hack_modes = { "i" },
			})

			lm.automapping({
				global = true,
				buffer = true,
				automapping_modes = { "n", "v", "x" },
			})
		end,
	},
}
