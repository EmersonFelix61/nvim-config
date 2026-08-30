local M = {}

local i18n = require 'config.i18n'
local node = require 'kickoff42.node'

local function executable(name)
  return vim.fn.executable(name) == 1
end

local function report_executable(name, available)
  if available then
    vim.health.ok(string.format(i18n.t 'health.executable_found', name))
  else
    vim.health.warn(string.format(i18n.t 'health.executable_missing', name))
  end
end

local function first_line(text)
  return tostring(text):match '([^\r\n]+)' or ''
end

local function mason_executable(name)
  local executable_name = package.config:sub(1, 1) == '\\' and name .. '.cmd' or name
  local executable_path = vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', executable_name)

  return vim.fn.executable(executable_path) == 1
end

local function check_version()
  local version = vim.version()
  local version_string = tostring(version)

  if version.major == 0 and version.minor == 11 then
    vim.health.ok(string.format(i18n.t 'health.nvim_version', version_string))
  else
    vim.health.error(string.format(i18n.t 'health.nvim_outdated', version_string) .. ' (versão suportada: 0.11.x)')
  end

  local nvim_path = vim.fn.exepath 'nvim'
  if nvim_path == '' then
    return
  end

  local output = vim.fn.system { nvim_path, '--version' }
  if vim.v.shell_error ~= 0 then
    vim.health.warn(string.format(i18n.t 'health.nvim_path_unknown', nvim_path))
    return
  end

  local version_line = first_line(output)
  local major, minor = version_line:match 'NVIM v(%d+)%.(%d+)'
  if tonumber(major) == 0 and tonumber(minor) == 11 then
    vim.health.ok(string.format(i18n.t 'health.nvim_path', nvim_path, version_line))
  else
    vim.health.warn(string.format(i18n.t 'health.nvim_path_mismatch', nvim_path, version_line))
  end
end

local function check_node()
  local info = node.info()

  if not info then
    vim.health.error(i18n.t 'health.node_missing')
    return
  end

  if not info.major or info.major < node.min_pyright_major() then
    vim.health.error(string.format(i18n.t 'health.node_outdated', info.path, info.version, node.min_pyright_major(), node.preferred_major()))
    return
  end

  vim.health.ok(string.format(i18n.t 'health.node_version', info.path, info.version))
end

local function check_external_requirements()
  for _, name in ipairs { 'git', 'curl', 'tar', 'unzip', 'npm', 'make', 'python3', 'rg' } do
    report_executable(name, executable(name))
  end

  check_node()

  report_executable('fd/fdfind', executable 'fd' or executable 'fdfind')
  report_executable('C compiler', executable 'cc' or executable 'gcc' or executable 'clang' or executable 'cl')
  if executable 'c_formatter_42' then
    vim.health.ok(string.format(i18n.t 'health.executable_found', 'c_formatter_42'))
  else
    vim.health.warn(i18n.t 'health.c_formatter_missing')
  end
  report_executable('norminette', executable 'norminette')
  report_executable('flake8', executable 'flake8' or mason_executable 'flake8')
  report_executable('codelldb', executable 'codelldb' or mason_executable 'codelldb')
end

function M.check()
  vim.health.start 'kickoff42.nvim'
  vim.health.info(i18n.t 'health.info')

  local uv = vim.uv or vim.loop
  vim.health.info(i18n.t 'health.system_info' .. vim.inspect(uv.os_uname()))

  check_version()
  check_external_requirements()
end

return M
