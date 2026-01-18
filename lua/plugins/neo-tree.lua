return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	lazy = false,
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,
			sources = { "filesystem", "git_status" },
			default_component_configs = {
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
				},
				git_status = {
					symbols = {
						added = "✚",
						modified = "●",
						deleted = "✖",
						renamed = "",
						untracked = "★",
						ignored = "◌",
						-- unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = true, -- опционально: оставлять ли открытыми родительские папки
				},
				use_libuv_file_watcher = true,
			},

			window = {
				width = 40,
				position = "left",
				mappings = {
					["h"] = "close_node",
					["l"] = "open_with_window_picker",
					["<CR>"] = "open",
					["o"] = "open",
					["H"] = "close_all_nodes",
					["L"] = "expand_all_nodes",
					["<space>"] = "toggle_node",
				},
			},
		})

		vim.keymap.set("n", "<F12>n", function()
			require("neo-tree.command").execute({ action = "focus", source = "filesystem" })
		end, { noremap = true, silent = true })
	end,
}
