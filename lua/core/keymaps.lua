local opts = { noremap = true, silent = true }

-- Отменить отмену
vim.keymap.set("n", "<S-U>", "<C-r>", { desc = "Undo" })

-- Tab control
vim.keymap.set("n", "<F12>t", ":tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<F12>L", ":tabnext<CR>", { desc = "Open next tab" })
vim.keymap.set("n", "<F12>K", ":tabprevious<CR>", { desc = "Open prev tab" })

-- SQL keyamapping
vim.keymap.set("n", "<F12>d", ":DBUI<CR>", { desc = "Open new tab" })

-- Быстрый выход из вставки
vim.keymap.set("i", "<F12>", "<Esc>", { noremap = true, silent = true, desc = "Return to Normal mode" })
vim.keymap.set("c", "<F12>", "<Esc>", { noremap = true, silent = true, desc = "Return to Normal mode" })
vim.keymap.set("v", "<F12>", "<Esc>", { noremap = true, silent = true, desc = "Return to Normal mode" })

-- vim.keymap.set("i", "jk", "<ESC>", opts)
-- vim.keymap.set("i", "kj", "<ESC>", opts)

-- Copy to buffer
vim.keymap.set("v", "<C-C>", '"+y', { desc = "Copy to system buffer" })

-- vim.keymap.set("n", "<F12>g", function()
-- 	require("neo-tree.command").execute({ action = "focus", source = "git_status" })
-- end, { noremap = true, silent = true })

-- For conciseness

-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Diagnostics keymapping
vim.keymap.set("n", "<leader>dd", function()
  vim.diagnostic.open_float({
    focus = false,
    scope = "line",
    border = "rounded",
    source = "if_many",
    focusable = true,
  })
end, { desc = "Diagnostics line (focus)" })

vim.keymap.set("n", "<leader>da", function()
  vim.diagnostic.open_float({
    focus = false,
    scope = "buffer",
    border = "rounded",
    source = "if_many",
    focusable = true,
  })
end, { desc = "Diagnostics buffer (focus)" })

vim.keymap.set("n", "<leader>dk", function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = "Prev diagnostic" })

vim.keymap.set("n", "<leader>dr", ":LspRestart<CR>", { desc = "Restart LSP" })

vim.keymap.set("n", "<leader>dj", function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "<leader>dc", function()
  local diags = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
  if #diags == 0 then
    print("No diagnostics on this line")
    return
  end
  local lines = {}
  for _, d in ipairs(diags) do
    table.insert(lines, string.format("[%s] %s", d.source or "LSP", d.message))
  end
  local text = table.concat(lines, "\n")
  vim.fn.setreg("+", text) -- копирует в системный буфер
  print("Diagnostics copied to clipboard")
end, { desc = "Copy line diagnostics" })


vim.keymap.set("n", "<leader>dC", function()
  local diags = vim.diagnostic.get(0)
  if #diags == 0 then
    print("No diagnostics in buffer")
    return
  end
  local lines = {}
  for _, d in ipairs(diags) do
    local lnum = d.lnum + 1
    table.insert(lines, string.format("[%s] %d:%d: %s", d.source or "LSP", lnum, d.col + 1, d.message))
  end
  local text = table.concat(lines, "\n")
  vim.fn.setreg("+", text)
  print("All buffer diagnostics copied to clipboard")
end, { desc = "Copy buffer diagnostics" })
-- Allow moving the cursor through wrapped lines with j, k
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- save file
vim.keymap.set("n", "<leader>s", "<cmd> w <CR>", { noremap = true, silent = true, desc = "Save file" })

-- save file without auto-formatting
-- vim.keymap.set("n", "<F12>sn", "<cmd>noautocmd w <CR>", opts)

-- quit file
vim.keymap.set("n", "<leader>q", "<cmd> q <CR>", { noremap = true, silent = true, desc = "Close file" })

-- delete single character without copying into register
vim.keymap.set("n", "x", '"_x', opts)

-- Clear highlights on search when pressing <F12> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<F12>", "<cmd>nohlsearch<CR>", { desc = "Clear highlights on search in Normal mode" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open [D]iagnostic [Q]uickfix list" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set("t", "<F12>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<F12>=", ":vsplit<CR>", { desc = "Вертикальное разделение" })
vim.keymap.set("n", "<F12>-", ":split<CR>", { desc = "Горизонтальное разделение" })

-- Keybinds to make split navigation easier.
--  Use F12+<hjkl> to switch between windows
vim.keymap.set("n", "<F12>h", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<F12>l", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<F12>j", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<F12>k", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Resize with arrows
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize +2<CR>", opts)

vim.keymap.set("n", "<leader>j", "ciw", { noremap = true, silent = true, desc = "Edit word under cursor" })

-- Save and load session
--vim.keymap.set('n', '<leader>w', ':mksession! .session.vim<CR>', { noremap = true, silent = false })
--vim.keymap.set('n', '<leader>sl', ':source .session.vim<CR>', { noremap = true, silent = false })

-- Закрыть все и выйти из Neovim
vim.keymap.set("n", "<F12>q", ":qa!<CR>", { noremap = true, silent = true, desc = "Закрыть Neovim" })

-- Закрыть текущее окно
vim.keymap.set("n", "<F12>w", ":close<CR>", { noremap = true, silent = true, desc = "Закрыть окно" })

vim.keymap.set("n", "<F12>o", "yy p", { desc = "Clone current line down" })
vim.keymap.set("v", "<F12>o", "y`>p", { desc = "Duplicate selection" })
vim.keymap.set("n", "<leader>o", ":put =''<CR>", { silent = true, desc = "Add line w/o intering Insert mode" })
vim.keymap.set("n", "<leader>O", ":put! =''<CR>", { silent = true, desc = "Add line below w/o intering Insert mode" })
vim.keymap.set("v", "<leader>o", ":put =''<CR>", { silent = true, desc = "Add line w/o intering Insert mode" })
vim.keymap.set("v", "<leader>O", ":put! =''<CR>", { silent = true, desc = "Add line below w/o intering Insert mode" })

-------------------------------------------------------
-- Move line down/up: Alt + j / Alt + k (normal mode)
-------------------------------------------------------
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })

vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })

-------------------------------------------------------
-- Move selected block: Alt + j / Alt + k (visual mode)
-------------------------------------------------------
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selected block down" })

vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selected block up" })

-------------------------------------------------------
-- Move line in insert mode
-------------------------------------------------------
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

vim.keymap.set("n", "<leader>pf", function()
  require("core.python_run").run_current_file()
end, { desc = "Run current Python file" })

vim.keymap.set("n", "<leader>pp", function()
  require("core.python_run").run_main_file()
end, { desc = "Run main Python file" })

vim.keymap.set("n", "<leader>pa", function()
  require("core.python_term").activate_current()
end, { desc = "Activate Python virtual env in current term or in main" })

vim.keymap.set("n", "<leader>pd", function()
  require("core.python_term").deactivate_current()
end, { desc = "Deactivate Python virtual env in current term" })

vim.keymap.set("n", "<leader>pt", function()
  require("core.python_run").run_pytest()
end, { desc = "Run Pytest with venv" })

vim.keymap.set("n", "<leader>nt", function()
  require("core.layout").new_side_terminal()
end, { desc = "Open new side terminal" })
