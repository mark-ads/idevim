local M = {}
local term = require("core.python_term")

function M.run_current_file()
  local file = vim.fn.expand("%:p")
  if file == "" then
    return
  end

  local t = term.get_main_term()
  local python = term.get_python(t)
  term.send_main(python .. " " .. vim.fn.fnameescape(file))
end

function M.run_main_file()
  local root = vim.fn.getcwd()
  local t = term.get_main_term()
  local python = term.get_python(t)

  -- Кандидаты на запуск: { путь на диске, как запускать }
  local candidates = {
    { path = "src/main.py", cmd = "-m src.main" },
    { path = "src/app.py", cmd = "-m src.app" },
    { path = "src/run.py", cmd = "-m src.run" },
    { path = "main.py", cmd = "main.py" },
    { path = "app.py", cmd = "app.py" },
    { path = "run.py", cmd = "run.py" },
  }

  for _, c in ipairs(candidates) do
    local full_path = root .. "/" .. c.path
    if vim.fn.filereadable(full_path) == 1 then
      -- Если cmd начинается с -m → модульный запуск
      if c.cmd:sub(1, 2) == "-m" then
        term.send_main(python .. " " .. c.cmd)
      else
        term.send_main(python .. " " .. vim.fn.fnameescape(full_path))
      end
      return
    end
  end

  vim.notify("Main file not found", vim.log.levels.ERROR)
end

function M.run_pytest()
  local t = term.get_side_term()
  local python = term.get_python(t)
  term.send_side(python .. " -m pytest")
end

return M
