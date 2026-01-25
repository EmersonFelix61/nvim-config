-- Função que vai determinar se tem os comandos e checar se é executável
local function has(cmd)
  return vim.fn.executable(cmd) == 1
end

local M = {}

-- Detecta se estamos em ambiente restrito, testando se tem as permissoes e programas necessarios
M.restricted = not (has("git") and has("make") and has("rg") and has("fd"))

-- Exportando os comandos individualmente, se eles existirem na outra máquina.
M.has_git = has("git")
M.has_make = has("make")
M.has_rg = has("rg")
M.has_fd = has("fd")
M.has_node = has("node")
M.has_npm = has("npm")

return M
