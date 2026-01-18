local M = {}

local venv_names = { ".venv", "venv", "env" }

-- активированные терминалы и python команду для каждого
local activated = {}
local python_cmds = {}

--------------------------------------------------
-- Терминалы
--------------------------------------------------
function M.get_main_term()
  local layout = require("core.layout")
  local term = layout.get_terminal()
  if not term:is_open() then
    term:open()
  end
  return term
end

function M.get_side_term()
  local layout = require("core.layout")
  local term = layout.get_side_terminal()
  if not term:is_open() then
    term:open()
  end
  return term
end

--------------------------------------------------
-- Utils
--------------------------------------------------
local function exists(path)
  return vim.fn.filereadable(path) == 1
end

--------------------------------------------------
-- Поиск venv
--------------------------------------------------
function M.find_activate()
  local dir = vim.fn.getcwd()
  local prev = nil

  while dir and dir ~= "" and dir ~= prev do
    for _, name in ipairs(venv_names) do
      if vim.fn.has("win32") == 1 then
        local p = dir .. "\\" .. name .. "\\Scripts\\activate.bat"
        if exists(p) then
          return 'call "' .. p .. '"'
        end
      else
        local p = dir .. "/" .. name .. "/bin/activate"
        if exists(p) then
          return "source " .. p
        end
      end
    end
    prev = dir
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  return nil
end

--------------------------------------------------
-- Определение python
--------------------------------------------------
local function detect_python()
  if vim.fn.has("win32") == 1 then
    return "python"
  end
  return vim.fn.executable("python3") == 1 and "python3" or "python"
end

--------------------------------------------------
-- Получение безопасного ID терминала
--------------------------------------------------
local function term_id(term)
  -- используем либо .count, либо метатаблицу _count
  return term.count or term._count or tostring(term)
end

--------------------------------------------------
-- Активация окружения для конкретного терминала
--------------------------------------------------
function M.activate_for(term)
  local id = term_id(term)
  if activated[id] then
    return
  end

  local activate_cmd = M.find_activate()
  if activate_cmd then
    term:send(activate_cmd, true)
    python_cmds[id] = "python"
  else
    python_cmds[id] = detect_python()
  end

  activated[id] = true
end

--------------------------------------------------
-- Деактивация текущего терминала (по фокусу)
--------------------------------------------------
function M.deactivate_current()
  -- фокус должен быть на терминале
  if vim.bo.buftype ~= "terminal" or not vim.b.toggle_number then
    return
  end

  local term
  if vim.b.toggle_number == 98 then
    term = M.get_side_term()
  else
    term = M.get_main_term()
  end

  local id = term_id(term)

  -- Если терминал активирован, отправляем deactivate
  if activated[id] then
    term:send("deactivate", true)
  end

  -- Удаляем локальные данные
  activated[id] = nil
  python_cmds[id] = nil

  vim.notify("Python venv deactivated for terminal " .. vim.b.toggle_number, vim.log.levels.INFO)
end
--------------------------------------------------
-- Определение python для конкретного терминала
--------------------------------------------------
function M.get_python(term)
  local id = term_id(term)
  if not activated[id] then
    M.activate_for(term)
  end
  return python_cmds[id] or detect_python()
end

--------------------------------------------------
-- Отправка команды
--------------------------------------------------
function M.send_main(cmd)
  local term = M.get_main_term()
  if not activated[term_id(term)] then
    M.activate_for(term)
  end
  term:send(cmd, true)
end

function M.send_side(cmd)
  local term = M.get_side_term()
  if not activated[term_id(term)] then
    M.activate_for(term)
  end
  term:send(cmd, true)
end

--------------------------------------------------
-- Активировать для буфера (по фокусу)
--------------------------------------------------
function M.activate_current()
  local focused_term

  -- Проверяем буфер toggleterm, если есть b:toggle_number
  if vim.bo.buftype == "terminal" and vim.b.toggle_number then
    if vim.b.toggle_number == 98 then
      focused_term = M.get_side_term()
    else
      focused_term = M.get_main_term()
    end
  else
    focused_term = M.get_main_term()
  end

  M.activate_for(focused_term)
end

return M
