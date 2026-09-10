local M = {}

local function path_exists(path)
  return vim.uv.fs_stat(path) ~= nil
end

local function unique_insert(list, seen, value)
  if value and value ~= '' and not seen[value] then
    seen[value] = true
    table.insert(list, value)
  end
end

function M.fallback_flags(root_dir)
  local flags = { '-Wall', '-Wextra', '-Werror' }
  local seen = {}

  local function add_include(path)
    if vim.fn.isabsolutepath(path) == 0 then
      path = vim.fs.normalize(root_dir .. '/' .. path)
    end
    if path_exists(path) then
      unique_insert(flags, seen, '-I' .. path)
    end
  end

  for _, dir in ipairs {
    'includes',
    'include',
    'inc',
    'headers',
    'src',
    'libft',
    'libft/includes',
    'libft/include',
  } do
    add_include(dir)
  end

  local makefile = root_dir .. '/Makefile'
  if path_exists(makefile) then
    local make_vars = {}
    for line in io.lines(makefile) do
      local name, value = line:match '^%s*([%w_]+)%s*:?=%s*(.-)%s*$'
      if name and value then
        make_vars[name] = value:gsub('#.*$', ''):gsub('%s+$', '')
      end
    end

    for line in io.lines(makefile) do
      for include in line:gmatch '%-I%s*([^%s\\]+)' do
        include = include:gsub('%$%(([%w_]+)%)', make_vars):gsub('%${([%w_]+)}', make_vars)
        add_include(include)
      end
      for define in line:gmatch '%-D%s*([^%s\\]+)' do
        define = define:gsub('%$%(([%w_]+)%)', make_vars):gsub('%${([%w_]+)}', make_vars)
        unique_insert(flags, seen, '-D' .. define)
      end
      for std in line:gmatch '%-std=([^%s\\]+)' do
        unique_insert(flags, seen, '-std=' .. std)
      end
    end
  end

  return flags
end

function M.root_dir(bufnr_or_fname, on_dir)
  local fname = type(bufnr_or_fname) == 'number' and vim.api.nvim_buf_get_name(bufnr_or_fname) or bufnr_or_fname
  local root_dir = vim.fs.root(fname, { 'compile_commands.json', 'compile_flags.txt', '.clangd', 'Makefile', '.git' })

  if on_dir then
    on_dir(root_dir)
  end

  return root_dir
end

function M.server_config()
  return {
    cmd = {
      'clangd',
      '--background-index',
      '--log=error', -- clangd logs normal protocol traffic to stderr, inflating lsp.log.
      '--clang-tidy',
      '--completion-style=detailed',
      '--header-insertion=iwyu',
    },
    root_dir = M.root_dir,
    root_markers = { 'compile_commands.json', 'compile_flags.txt', '.clangd', 'Makefile', '.git' },
    before_init = function(params, config)
      params.initializationOptions = vim.tbl_deep_extend('force', config.init_options or {}, {
        fallbackFlags = M.fallback_flags(config.root_dir or vim.uv.cwd()),
      })
    end,
    on_new_config = function(new_config, root_dir)
      new_config.init_options = vim.tbl_deep_extend('force', new_config.init_options or {}, {
        fallbackFlags = M.fallback_flags(root_dir),
      })
    end,
  }
end

return M
