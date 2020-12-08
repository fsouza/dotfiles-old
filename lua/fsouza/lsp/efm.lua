local M = {}

local vfn = vim.fn
local loop = vim.loop

local default_root_markers = {'.git'}

local config_dir = vfn.stdpath('config')

local function setup_blackd_logs_dir()
  local cache_dir = vfn.stdpath('cache')
  local setenv = require('posix.stdlib').setenv
  local logs_dir = cache_dir .. '/blackd-logs'
  loop.fs_mkdir(logs_dir, 0755)
  setenv('BLACKD_LOGS_DIR', logs_dir)
end

local function get_python_bin(bin_name)
  local result = bin_name
  if os.getenv('VIRTUAL_ENV') then
    local venv_bin_name = os.getenv('VIRTUAL_ENV') .. '/bin/' .. bin_name
    if vfn.executable(venv_bin_name) == 1 then
      result = venv_bin_name
    end
  end
  return result
end

local function get_black()
  local bin = config_dir .. '/langservers/bin/blackd-format'
  return {formatCommand = bin; formatStdin = true; rootMarkers = {'.git'; ''}}
end

local function get_dmypy()
  return {
    lintCommand = string.format('%s run -- --show-column-numbers', get_python_bin('dmypy'));
    lintStdin = false;
    lintSource = 'mypy';
    lintFormats = {'%f:%l:%c: %m'};
    lintIgnoreExitCode = true;
  }
end

local function get_isort()
  return {
    formatCommand = string.format('%s -', get_python_bin('isort'));
    formatStdin = true;
    rootMarkers = {'.isort.cfg'; '.git'; ''};
  }
end

local function get_flake8()
  return {
    lintCommand = string.format(
      '%s --stdin-display-name ${INPUT} --format "%%(path)s:%%(row)d:%%(col)d: %%(code)s %%(text)s" -',
      get_python_bin('flake8'));
    lintStdin = true;
    lintSource = 'flake8';
    lintFormats = {'%f:%l:%c: %m'};
    rootMarkers = {'.flake8'; '.git'; ''};
  }
end

local function get_add_trailing_comma()
  return {
    formatCommand = string.format('%s --exit-zero-even-if-changed -',
                                  get_python_bin('add-trailing-comma'));
    formatStdin = true;
    rootMarkers = default_root_markers;
  }
end

local function get_reorder_python_imports()
  return {
    formatCommand = string.format('%s --exit-zero-even-if-changed -',
                                  get_python_bin('reorder-python-imports'));
    formatStdin = true;
    rootMarkers = default_root_markers;
  }
end

local function get_autopep8()
  return {
    formatCommand = string.format('%s -', get_python_bin('autopep8'));
    formatStdin = true;
    rootMarkers = default_root_markers;
  }
end

local function get_buildifier()
  local nvim_config_path = config_dir
  local bin = nvim_config_path .. '/langservers/bin/buildifierw'
  if vfn.executable('buildifier') == 1 then
    return {
      formatCommand = string.format('%s ${INPUT}', bin);
      formatStdin = true;
      rootMarkers = default_root_markers;
    }
  end
  return {}
end

local function get_dune()
  return {
    formatCommand = 'dune format-dune-file';
    formatStdin = true;
    rootMarkers = default_root_markers;
  }
end

local function get_shellcheck()
  return {
    lintCommand = 'shellcheck -f gcc -x -';
    lintStdin = true;
    lintSource = 'shellcheck';
    lintFormats = {'%f:%l:%c: %trror: %m'; '%f:%l:%c: %tarning: %m'; '%f:%l:%c: %tote: %m'};
    rootMarkers = default_root_markers;
  }
end

local function get_shfmt()
  return {formatCommand = 'shfmt -'; formatStdin = true; rootMarkers = default_root_markers}
end

local function get_luacheck()
  return {
    lintCommand = 'luacheck --formatter plain --filename ${INPUT} -';
    lintStdin = true;
    lintSource = 'luacheck';
    rootMarkers = default_root_markers;
    lintFormats = {'%f:%l:%c: %m'};
  }
end

local function get_luaformat()
  return {formatCommand = 'lua-format'; formatStdin = true; rootMarkers = {'.lua-format'; '.git'}}
end

local function read_precommit_config(file_path)
  local lyaml = require('lyaml')
  local f = io.open(file_path, 'r')
  local content = f:read('all*')
  f:close()
  return lyaml.load(content)
end

local function blackd_cleanup_if_needed(settings)
  local python_tools = settings.languages.python or {}
  for _, tool in ipairs(python_tools) do
    if vim.endswith(tool.formatCommand or '', '/blackd-format') then
      require('fsouza.lib.cleanup').register(function()
        local block = require('fsouza.lib.cmd').run('pkill', {args = {'-f'; 'blackd'}}, nil,
                                                    function()
        end)
        block(500)
      end)
      break
    end
  end
end

local function get_python_tools()
  local pre_commit_config_file_path = '.pre-commit-config.yaml'
  if not loop.fs_stat(pre_commit_config_file_path) then
    return {get_flake8(); get_black(); get_add_trailing_comma(); get_isort()}
  end

  local pc_repo_tools = {
    -- ['https://gitlab.com/pycqa/flake8'] = get_flake8;
    ['https://github.com/psf/black'] = get_black;
    ['https://github.com/asottile/add-trailing-comma'] = get_add_trailing_comma;
    ['https://github.com/asottile/reorder_python_imports'] = get_reorder_python_imports;
    ['https://github.com/pre-commit/mirrors-autopep8'] = get_autopep8;
    ['https://github.com/pre-commit/mirrors-isort'] = get_isort;
    ['https://github.com/pre-commit/mirrors-mypy'] = get_dmypy;
  }
  local local_repos_mapping = {['black'] = 'https://github.com/psf/black'}
  local pre_commit_config = read_precommit_config(pre_commit_config_file_path)
  local tools = {}
  for i = #pre_commit_config.repos, 1, -1 do
    local repo = pre_commit_config.repos[i]
    local repo_url = repo.repo
    if repo.repo == 'local' then
      if repo.hooks[1] then
        repo_url = local_repos_mapping[repo.hooks[1].id]
      end
    end
    local fn = pc_repo_tools[repo_url]
    if fn then
      table.insert(tools, fn())
    end
  end
  return tools
end

local function get_lua_tools()
  local tools = {}
  if loop.fs_stat('.luacheckrc') then
    table.insert(tools, get_luacheck())
  end
  if loop.fs_stat('.lua-format') then
    table.insert(tools, get_luaformat())
  end
  return tools
end

local function get_settings()
  local settings = {rootMarkers = default_root_markers; languages = {}}
  local function add_if_not_empty(language, tool)
    if tool.formatCommand or tool.lintCommand then
      local tools = settings.languages[language] or {}
      table.insert(tools, tool)
      settings.languages[language] = tools
    end
  end

  local tools_mapping = {python = get_python_tools; lua = get_lua_tools}
  for language, tools_fn in pairs(tools_mapping) do
    local tools = tools_fn()
    if #tools > 0 then
      settings.languages[language] = tools
    end
  end
  add_if_not_empty('sh', get_shellcheck())
  add_if_not_empty('sh', get_shfmt())
  add_if_not_empty('dune', get_dune())
  add_if_not_empty('bzl', get_buildifier())
  blackd_cleanup_if_needed(settings)
  return settings
end

local function get_init_options(settings)
  local init_options = {}
  for _, tools in pairs(settings.languages) do
    for _, tool in ipairs(tools) do
      if tool.formatCommand then
        init_options.documentFormatting = true;
        break
      end
    end
  end
  return init_options
end

function M.gen_config()
  setup_blackd_logs_dir()
  local settings = get_settings()
  local init_options = get_init_options(settings)
  return init_options, settings, vim.tbl_keys(settings.languages)
end

return M
