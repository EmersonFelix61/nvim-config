local M = {}

local MIN_PYRIGHT_NODE_MAJOR = 14
local PREFERRED_NODE_MAJOR = 18

local function path_separator()
  return package.config:sub(1, 1) == '\\' and ';' or ':'
end

local function executable_name()
  return package.config:sub(1, 1) == '\\' and 'node.exe' or 'node'
end

local function add_candidate(candidates, seen, path)
  if not path or path == '' then
    return
  end

  path = vim.fs.normalize(path)
  if seen[path] or vim.fn.executable(path) ~= 1 then
    return
  end

  seen[path] = true
  table.insert(candidates, path)
end

local function add_glob(candidates, seen, pattern)
  for _, path in ipairs(vim.fn.glob(pattern, false, true)) do
    add_candidate(candidates, seen, path)
  end
end

local function parse_node_version(output)
  local major, minor, patch = tostring(output):match 'v?(%d+)%.(%d+)%.(%d+)'

  return tonumber(major), minor and string.format('v%s.%s.%s', major, minor, patch) or vim.trim(tostring(output))
end

local function path_entries()
  return vim.split(vim.env.PATH or '', path_separator(), { plain = true, trimempty = true })
end

local function contains_path(path)
  path = vim.fs.normalize(path)
  for _, entry in ipairs(path_entries()) do
    if vim.fs.normalize(entry) == path then
      return true
    end
  end

  return false
end

function M.info(path)
  path = path or vim.fn.exepath 'node'
  if path == '' then
    return nil
  end

  local output = vim.fn.system { path, '--version' }
  if vim.v.shell_error ~= 0 then
    return {
      path = path,
      version = vim.trim(output),
    }
  end

  local major, version = parse_node_version(output)
  return {
    path = path,
    version = version,
    major = major,
  }
end

function M.candidates()
  local candidates = {}
  local seen = {}
  local node_name = executable_name()

  add_candidate(candidates, seen, vim.fn.exepath 'node')

  for _, entry in ipairs(path_entries()) do
    add_candidate(candidates, seen, vim.fs.joinpath(entry, node_name))
  end

  local home = vim.fn.expand '$HOME'
  local user = vim.env.USER or vim.fn.fnamemodify(home, ':t')

  add_candidate(candidates, seen, vim.fs.joinpath(home, '.local', 'bin', node_name))
  add_glob(candidates, seen, vim.fs.joinpath(home, 'sgoinfre', 'node-*', 'bin', node_name))

  if user ~= '' then
    add_glob(candidates, seen, vim.fs.joinpath('/sgoinfre', user, 'node-*', 'bin', node_name))
  end

  return candidates
end

function M.find_modern()
  local fallback

  for _, path in ipairs(M.candidates()) do
    local info = M.info(path)
    if info and info.major then
      if info.major >= PREFERRED_NODE_MAJOR then
        return info
      end

      if info.major >= MIN_PYRIGHT_NODE_MAJOR and not fallback then
        fallback = info
      end
    end
  end

  return fallback
end

function M.ensure_modern_node()
  local info = M.find_modern()
  if not info then
    return M.info()
  end

  local bin_dir = vim.fn.fnamemodify(info.path, ':h')
  if not contains_path(bin_dir) then
    vim.env.PATH = bin_dir .. path_separator() .. (vim.env.PATH or '')
  end

  return info
end

function M.min_pyright_major()
  return MIN_PYRIGHT_NODE_MAJOR
end

function M.preferred_major()
  return PREFERRED_NODE_MAJOR
end

return M
