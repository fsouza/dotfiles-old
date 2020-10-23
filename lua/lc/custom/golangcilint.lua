local nvim_lsp = require('nvim_lsp')
local configs = require('nvim_lsp/configs')

local M = {}

local add_to_config = function()
  configs.golangci_lint_language_server = {
    default_config = {
      cmd = {'golangci-lint-langserver'};
      filetypes = {'go'};
      root_dir = nvim_lsp.util.root_pattern('.golangci.yaml', '.golangci.yml', '.golangci.toml',
                                            '.golangci.json');
      init_options = {command = {'golangci-lint'; 'run'; '--out-format'; 'json'}};
    };
  }
end

function M.setup(opts)
  add_to_config()
  nvim_lsp.golangci_lint_language_server.setup(opts)
end

return M
