local M = {}

local loop = vim.loop
local vfn = vim.fn

local get_dmypy = function()
  return {
    ['lint-command'] = 'dmypy run';
    ['lint-formats'] = {'%f:%l: %trror: %m'; '%f:%l: %tarning: %m'; '%f:%l: %tote: %m'};
  }
end

local setup_blackd_logs_dir = function(base_dir)
  local logs_dir = base_dir .. '/blackd-logs'
  vfn.mkdir(logs_dir, 'p')
  loop.os_setenv('BLACKD_LOGS_DIR', logs_dir)
end

local get_black = function()
  local nvim_config_path = vfn.stdpath('config')
  local bin = nvim_config_path .. '/langservers/bin/blackd-format'
  return {['format-command'] = bin; ['format-stdin'] = true}
end

local get_isort = function()
  return {['format-command'] = 'isort -'; ['format-stdin'] = true}
end

local get_dune = function()
  return {['format-command'] = 'dune format-dune-file'; ['format-stdin'] = true}
end

local get_shellcheck = function()
  return {
    ['lint-command'] = 'shellcheck -f gcc -x';
    ['lint-formats'] = {'%f:%l:%c: %trror: %m'; '%f:%l:%c: %tarning: %m'; '%f:%l:%c: %tote: %m'};
  }
end

local get_config_str = function()
  local cfg = {
    version = 2;
    tools = {
      dmypy = get_dmypy();
      sort = get_isort();
      black = get_black();
      dune = get_dune();
      shellcheck = get_shellcheck();
    };
    languages = {
      python = {get_dmypy(); get_black(); get_isort()};
      dune = {get_dune()};
      sh = {get_shellcheck()};
    };
  }
  return require('lyaml').dump({cfg})
end

function M.config_file()
  local cache_dir = vfn.stdpath('cache')
  setup_blackd_logs_dir(cache_dir)
  local config_file = cache_dir .. '/efm-langserver.yaml'
  local h = io.open(config_file, 'w')
  h:write(get_config_str())
  h:close()
  return config_file
end

return M
