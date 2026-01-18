local M = {}
-----------------------------------------------------
-- Терминалы (toggleterm)
-----------------------------------------------------
local term_main -- 99
local term_side -- 98

local function Terminal()
  return require("toggleterm.terminal").Terminal
end

-----------------------------------------------------
-- Основной терминал (99)
-----------------------------------------------------
function M.get_terminal()
  if not term_main then
    term_main = Terminal():new({
      cmd = "cmd.exe",
      direction = "horizontal",
      count = 99,
      size = 10,
      start_in_insert = false,
      close_on_exit = false,
    })
  end
  return term_main
end

-----------------------------------------------------
-- Второй терминал (98)
-----------------------------------------------------
function M.get_side_terminal()
  if not term_side then
    term_side = Terminal():new({
      cmd = "cmd.exe",
      direction = "horizontal",
      count = 98,
      size = 60,
      start_in_insert = false,
      close_on_exit = false,
    })
  end
  return term_side
end

function M.new_side_terminal()
  local term = M.get_side_terminal()
  if not term:is_open() then
    term:open()
  end
end
-----------------------------------------------------
-- Локальная функция: безопасное открытие Neo-tree
-----------------------------------------------------
local function safe_open_neo_tree(focus)
  local ok, neo_tree = pcall(require, "neo-tree.command")
  if ok then
    neo_tree.execute({
      toggle = true,
      focus = focus or false,
      source = "filesystem",
    })
  end
end

-----------------------------------------------------
-- Проверка: git-репозиторий
-----------------------------------------------------
local function in_git_repo()
  local result = vim.system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true }):wait()

  return result.code == 0
end

-----------------------------------------------------
-- Основная функция раскладки
-----------------------------------------------------
function M.set_layout()
  local cur_win = vim.api.nvim_get_current_win()
  local ok_neogit, neogit = pcall(require, "neogit")

  -- 1. Терминал 99
  vim.defer_fn(function()
    local term = M.get_terminal()
    if not term:is_open() then
      term:open()
    end

    vim.schedule(function()
      if term.window and vim.api.nvim_win_is_valid(term.window) then
        vim.api.nvim_win_set_height(term.window, 10)
      end
    end)
  end, 50)

  -- 2. Neo-tree
  vim.defer_fn(function()
    safe_open_neo_tree(false)
  end, 100)

  -- 3. Neogit
  if ok_neogit and type(neogit.open) == "function" and in_git_repo() then
    vim.defer_fn(function()
      pcall(function()
        neogit.open({ kind = "split" })
      end)

      local ok_win, win = pcall(vim.api.nvim_get_current_win)
      if ok_win and win then
        local h = vim.api.nvim_win_get_height(win)
        local new_h = math.max(6, h - 10)
        pcall(vim.api.nvim_win_set_height, win, new_h)
      end
    end, 150)
  end

  -- 4. Возврат фокуса + normal mode
  vim.defer_fn(function()
    if vim.api.nvim_win_is_valid(cur_win) then
      vim.api.nvim_set_current_win(cur_win)
    end
    vim.schedule(function()
      vim.cmd("stopinsert")
    end)
  end, 200)
end

-----------------------------------------------------
-- Маппинги
-----------------------------------------------------
vim.keymap.set("n", "<F12>z", function()
  require("core.layout").set_layout()
end, { desc = "Set Git/UI Layout" })

return M
