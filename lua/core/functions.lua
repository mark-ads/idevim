local M = {}

--------------------------------------
-- Безопасное открытие neo-tree
--------------------------------------
-- focus = true/false
function M.open_neo_tree(focus)
  vim.schedule(function()
    local ok, neo_tree = pcall(require, "neo-tree.command")
    if ok then
      neo_tree.execute({ toggle = true, focus = focus or false })
    end
  end)
end

--------------------------------------
-- Путь к сессии по имени текущей директории
--------------------------------------

local function url_encode(str)
  return str:gsub("([^%w])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
end

function M.get_auto_session_file(dir, session_root)
  local encoded = url_encode(dir)
  return session_root .. encoded .. ".vim"
end

return M
