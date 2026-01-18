local funcs = require("core.functions")
local layout = require("core.layout")
local session_root = vim.fn.stdpath("data") .. "/sessions/"

-- создаём папку для сессий, если её нет
if vim.fn.isdirectory(session_root) == 0 then
	vim.fn.mkdir(session_root, "p")
end

return {
	"rmagatti/auto-session",
	lazy = false,
	config = function()
		local auto_session = require("auto-session")

		auto_session.setup({
			log_level = "info",
			auto_session_enable_last_session = false,
			auto_session_root_dir = session_root,
			auto_session_suppress_dirs = { "~/" },
			auto_session_enable = true,
			-- pre_save_cmds = {
			-- 	function()
			-- 		funcs.open_neo_tree(false)
			-- 	end,
			-- },
			post_restore_cmds = {
				-- function()
				-- 	funcs.open_neo_tree(false)
				-- end,
				--
				function()
					layout.set_layout()
				end,
			},
		})

		--     -- Автозагрузка сессии на VimEnter
		--     vim.api.nvim_create_autocmd("VimEnter", {
		--         callback = function()
		--             local cwd = vim.fn.getcwd()
		-- local session_file = funcs.get_auto_session_file(cwd, session_root)
		--
		--             if vim.fn.filereadable(session_file) == 1 then
		-- 	require("auto-session").restore_session(session_file)
		--                 print("Сессия автоматически загружена: " .. session_file)
		--                 return
		--             end
		--
		--             -- если сессии нет — предлагаем создать
		--             local sessions = vim.fn.globpath(session_root, "*.vim", false, true)
		--             if #sessions == 0 then
		--                 local choice = vim.fn.input("Сессия не найдена. Создать новую? (y/n): ")
		--                 if choice:lower() == "y" then
		--                     -- auto_session.CreateSession(session_file)
		--                     print("Создана новая сессия: " .. session_file)
		--                 end
		--                 return
		--             end
		--
		--             -- выбор из существующих сессий
		--             local choices = {}
		--             for idx, f in ipairs(sessions) do
		--                 table.insert(choices, idx .. ". " .. vim.fn.fnamemodify(f, ":t"))
		--             end
		--             table.insert(choices, (#choices + 1) .. ". Создать новую сессию здесь")
		--
		--             local choice = vim.fn.inputlist(choices)
		--             if choice > 0 and choice <= #sessions then
		-- 	require("auto-session").restore_session(sessions[choice])
		--                 print("Сессия загружена: " .. sessions[choice])
		--             elseif choice == #choices then
		--                 -- auto_session.CreateSession(session_file)
		--                 print("Создана новая сессия: " .. session_file)
		--             end
		--         end
		-- })
	end,
}
