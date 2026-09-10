local M = {}

local autocmd_group = vim.api.nvim_create_augroup('kickoff42-flake8', { clear = true })
local flake8_autocheck = false
local check_generation = 0

local function mason_flake8_path()
  local executable_name = package.config:sub(1, 1) == '\\' and 'flake8.cmd' or 'flake8'
  return vim.fs.joinpath(vim.fn.stdpath 'data', 'mason', 'bin', executable_name)
end

local function flake8_command()
  if vim.fn.executable 'flake8' == 1 then
    return 'flake8'
  end

  local mason_flake8 = mason_flake8_path()
  if vim.fn.executable(mason_flake8) == 1 then
    return mason_flake8
  end

  return nil
end

local function current_buffer()
  return vim.api.nvim_get_current_buf()
end

local function is_python_buffer(bufnr)
  return vim.bo[bufnr].filetype == 'python'
end

local function has_name(bufnr)
  return vim.api.nvim_buf_get_name(bufnr) ~= ''
end

local function flake8_namespace()
  local ok, lint = pcall(require, 'lint')
  if not ok then
    return nil
  end

  return lint.get_namespace 'flake8'
end

local function configure_flake8_command(lint, command)
  local flake8 = lint.linters.flake8
  if flake8 then
    flake8.cmd = command
  end
end

function M.check()
  local bufnr = current_buffer()

  if not is_python_buffer(bufnr) or not has_name(bufnr) then
    return
  end

  local command = flake8_command()
  if not command then
    vim.notify('flake8 not found', vim.log.levels.WARN)
    return
  end

  local ok, lint = pcall(require, 'lint')
  if not ok then
    vim.notify('nvim-lint not found', vim.log.levels.WARN)
    return
  end

  configure_flake8_command(lint, command)

  local generation = check_generation
  local lint_ok, err = pcall(lint.try_lint, 'flake8', {
    wrap_linter = function(linter)
      local parse = linter.parser
      linter.parser = function(...)
        -- A check may finish after Flake8 was disabled and its diagnostics cleared.
        if generation ~= check_generation then
          return {}
        end
        return parse(...)
      end
      return linter
    end,
  })
  if not lint_ok then
    vim.notify(err, vim.log.levels.WARN)
  end
end

function M.enable()
  flake8_autocheck = true
  vim.notify 'Flake8AutoCheck enable'

  M.check()
end

function M.disable()
  flake8_autocheck = false
  check_generation = check_generation + 1
  vim.notify 'Flake8AutoCheck disable'

  local namespace = flake8_namespace()
  if namespace then
    vim.diagnostic.reset(namespace)
  end
end

function M.toggle()
  if flake8_autocheck then
    M.disable()
  else
    M.enable()
  end
end

function M.setup()
  vim.keymap.set('n', '<leader>8', M.toggle, { desc = 'Flake8AutoCheck toggle' })

  vim.api.nvim_create_user_command('Flake8Check', M.check, {
    desc = 'Run flake8 on the current Python buffer',
    force = true,
  })

  vim.api.nvim_create_user_command('Flake8Toggle', M.toggle, {
    desc = 'Toggle Flake8AutoCheck',
    force = true,
  })

  vim.api.nvim_clear_autocmds { group = autocmd_group }
  vim.api.nvim_create_autocmd({ 'BufReadPost', 'BufWritePost', 'InsertLeave' }, {
    group = autocmd_group,
    callback = function()
      if flake8_autocheck then
        M.check()
      end
    end,
  })
end

return M
