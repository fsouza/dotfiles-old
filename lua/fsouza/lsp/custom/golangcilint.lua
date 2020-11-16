local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')

local M = {}

local add_to_config = function()
  configs.golangci_lint_language_server = {
    default_config = {
      cmd = {'golangci-lint-langserver'};
      filetypes = {'go'};
      root_dir = lspconfig.util.root_pattern('.golangci.yaml', '.golangci.yml', '.golangci.toml',
                                             '.golangci.json');
      init_options = {command = {'golangci-lint'; 'run'; '--out-format'; 'json'}};
    };
  }
end

function M.setup(opts)
  add_to_config()
  lspconfig.golangci_lint_language_server.setup(opts)
end

return M
