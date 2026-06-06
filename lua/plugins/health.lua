--[[
--
-- This file is not required for your own configuration,
-- but helps people determine if their system is setup correctly.
--
--]]

local i18n = require 'config.i18n'

local check_version = function()
  local verstr = tostring(vim.version())
  if not vim.version.ge then
    vim.health.error(string.format(i18n.t 'health.nvim_outdated', verstr))
    return
  end

  if vim.version.ge(vim.version(), '0.10-dev') then
    vim.health.ok(string.format(i18n.t 'health.nvim_version', verstr))
  else
    vim.health.error(string.format(i18n.t 'health.nvim_outdated', verstr))
  end
end

local check_external_reqs = function()
  -- Basic utils: `git`, `make`, `unzip`
  for _, exe in ipairs { 'git', 'make', 'unzip', 'rg' } do
    local is_executable = vim.fn.executable(exe) == 1
    if is_executable then
      vim.health.ok(string.format(i18n.t 'health.executable_found', exe))
    else
      vim.health.warn(string.format(i18n.t 'health.executable_missing', exe))
    end
  end

  return true
end

return {
  check = function()
    vim.health.start 'kickoff42.nvim'

    vim.health.info(i18n.t 'health.info')

    local uv = vim.uv or vim.loop
    vim.health.info(i18n.t('health.system_info') .. vim.inspect(uv.os_uname()))

    check_version()
    check_external_reqs()
  end,
}
