local fun = require('lib.fun_wrapper')

local wanted_parsers = {
  'bash';
  'c';
  'cpp';
  'css';
  'go';
  'javascript';
  'json';
  'lua';
  'ocaml';
  'ocaml_interface';
  'python';
  'query';
  'rust';
  'tsx';
  'typescript';
};

local set_folding = function()
  local parsers = require('nvim-treesitter.parsers')
  local helpers = require('lib.nvim_helpers')

  local file_types = fun.flatten(fun.safe_iter(wanted_parsers):map(parsers.lang_to_ft):map(fun.iter))
  local foldexpr = 'nvim_treesitter#foldexpr()'
  file_types:each(function(ft)
    if ft == vim.bo.filetype then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = foldexpr
    end
  end)

  helpers.augroup('folding_config', {
    {
      events = {'FileType'};
      targets = file_types:totable();
      command = [[setlocal foldmethod=expr foldexpr=]] .. foldexpr;
    };
  })
end

do
  vim.cmd([[
    packadd nvim-treesitter
    packadd nvim-treesitter-textobjects
  ]])
  local configs = require('nvim-treesitter.configs')
  configs.setup({
    highlight = {enable = true};
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = 'gnn';
        node_incremental = '<tab>';
        scope_incremental = 'grc';
        node_decremental = '<s-tab>';
      };
    };
    playground = {enable = true; updatetime = 30};
    textobjects = {
      select = {
        enable = true;
        keymaps = {
          am = '@function.outer';
          ['im'] = '@function.inner';
          al = '@block.outer';
          il = '@block.inner';
          ac = '@class.outer';
          ic = '@class.inner';
        };
      };
      swap = {
        enable = true;
        swap_next = {['<leader>a'] = '@parameter.inner'};
        swap_previous = {['<leader>A'] = '@parameter.inner'};
      };
    };
    ensure_installed = wanted_parsers;
  })
  set_folding()
end
