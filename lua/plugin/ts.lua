local parsers = require('nvim-treesitter.parsers')

local wanted_parsers = {
  'bash'; 'css'; 'go'; 'html'; 'javascript'; 'json'; 'ocaml'; 'rust'; 'tsx'; 'typescript'; 'cpp';
  'c'; 'yaml'; 'lua'; 'python';
};

local set_folding = function()
  local helpers = require('lib.nvim_helpers')
  local file_types = {}
  for i, lang in ipairs(wanted_parsers) do
    file_types[i] = parsers.lang_to_ft(lang)
  end

  local foldexpr = 'nvim_treesitter#foldexpr()'

  for _, ft in pairs(file_types) do
    if ft == vim.bo.filetype then
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = foldexpr
    end
  end

  helpers.augroup('folding_config', {
    {
      events = {'FileType'};
      targets = vim.tbl_flatten(file_types);
      command = [[setlocal foldmethod=expr foldexpr=]] .. foldexpr;
    };
  })
end

do
  local configs = require('nvim-treesitter.configs')
  configs.setup({
    highlight = {enable = false};
    incremental_selection = {
      enable = true;
      keymaps = {
        init_selection = 'gnn';
        node_incremental = '<tab>';
        scope_incremental = 'grc';
        node_decremental = '<s-tab>';
      };
    };
    refactor = {smart_rename = {enable = false}; navigation = {enable = false}};
    textobjects = {enable = false};
    ensure_installed = wanted_parsers;
  })
  set_folding()
  configs.commands.TSEnableAll.run('incremental_selection')
end
