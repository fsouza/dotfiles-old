local M = {}

local vfn = vim.fn

local get_dmypy = function()
  return {
    ['lint-command'] = 'dmypy run';
    ['lint-formats'] = {'%f:%l: %trror: %m'; '%f:%l: %tarning: %m'; '%f:%l: %tote: %m'};
  }
end

local get_black = function()
  return {['format-command'] = 'black --fast --quiet -'; ['format-stdin'] = true}
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
      black = get_black();
      sort = get_isort();
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
  local config_file = vfn.stdpath('cache') .. '/efm-langserver.yaml'
  local h = io.open(config_file, 'w')
  h:write(get_config_str())
  h:close()
  return config_file
end

return M
