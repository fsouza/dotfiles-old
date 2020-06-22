local vfn = vim.fn
local loop = vim.loop
local lc_opts = require('lc/opts')

local config_dir = vfn.stdpath('config')

local get_local_cmd = function(cmd)
  return string.format('%s/langservers/bin/%s', config_dir, cmd)
end

local python_interpreter_props = function(virtual_env)
  local int_path = virtual_env .. 'bin/python'
  local props = {InterpreterPath = virtual_env .. 'bin/python'; UseDefaultDatabase = true}
  local cb = function(r)
    if r.exit_status ~= 0 then
      print(string.format('failed to detect python version in the virtualenv $%s: %s', virtual_env,
                          r.stderr))
      return
    end
    props.Version = r.stdout
  end
  require('lib/cmd').run(props.InterpreterPath, {
    '-c'; 'import sys; print("f{sys.version_info.major}.{sys.version_info.minor}"), end="")';
  }, nil, cb)
  vim.wait(200, function()
    return props.Version ~= nil
  end, 25)
  return props
end

local get_pyls_ms_options = function()
  local opts = {cmd = {get_local_cmd('ms-python-lsp')}; root_dir = lc_opts.project_root_pattern}
  local virtual_env = loop.os_getenv('VIRTUAL_ENV')
  if virtual_env then
    local props = python_interpreter_props(virtual_env)
    if props.Version then
      opts.init_options = {interpreter = {properties = props}}
    end
  end
  return opts
end

do
  local if_executable = function(name, cb)
    if vfn.executable(name) == 1 then
      cb()
    end
  end

  local status, err = pcall(function()
    local lsp = require('nvim_lsp')
    local vim_node_ls = get_local_cmd('node-lsp')

    if_executable('npx', function()
      lsp.bashls.setup(lc_opts.with_default_opts({
        cmd = {vim_node_ls; 'bash-language-server'; 'start'};
      }))

      lsp.cssls.setup(lc_opts.with_default_opts({
        cmd = {vim_node_ls; 'css-laguageserver'; '--stdio'};
      }))

      lsp.html
        .setup(lc_opts.with_default_opts({cmd = {vim_node_ls; 'html-langserver'; '--stdio'}}))

      lsp.jsonls.setup(lc_opts.with_default_opts({
        cmd = {vim_node_ls; 'vscode-json-languageserver'; '--stdio'};
      }))

      lsp.tsserver.setup(lc_opts.with_default_opts(
                           {cmd = {vim_node_ls; 'typescript-language-server'; '--stdio'}}))

      lsp.vimls.setup(lc_opts.with_default_opts({
        cmd = {vim_node_ls; 'vim-language-server'; '--stdio'};
      }))

      lsp.yamlls.setup(lc_opts.with_default_opts({
        cmd = {vim_node_ls; 'yaml-language-server'; '--stdio'};
      }))
    end)

    if_executable(get_local_cmd('gopls'), function()
      lsp.gopls.setup(lc_opts.with_default_opts({
        cmd = {get_local_cmd('go-lsp')};
        init_options = {
          deepCompletion = false;
          staticcheck = true;
          analyses = {unusedparams = true; ST1000 = false};
        };
        capabilities = {textDocument = {completion = {completionItem = {snippetSupport = false}}}};
      }))
    end)

    if_executable('dune', function()
      lsp.ocamllsp.setup(lc_opts.with_default_opts({cmd = {get_local_cmd('ocaml-lsp')}}))
    end)

    if_executable('pyls', function()
      lsp.pyls.setup(lc_opts.with_default_opts({
        cmd = {'python'; '-m'; 'pyls'};
        root_dir = function(fname)
          local ancestor = lc_opts.project_root_pattern(fname)
          if not ancestor then
            return vfn.getcwd()
          end
          return ancestor
        end;
        settings = {
          pyls = {
            enable = true;
            plugins = {
              jedi_completion = {enabled = false};
              jedi_hover = {enabled = false};
              jedi_rename = {enabled = false};
              jedi_references = {enabled = false};
              jedi_signature_help = {enabled = false};
              jedi_symbols = {enabled = false};
            };
          };
        };
      }))
    end)

    if_executable('dotnet', function()
      lsp.pyls_ms.setup(lc_opts.with_default_opts(get_pyls_ms_options()))
    end)

    local ra = get_local_cmd('rust-analyzer')
    if_executable('ra', function()
      lsp.rust_analyzer.setup(lc_opts.with_default_opts({cmd = {ra}}))
    end)

    local efm = get_local_cmd('efm-langserver')
    if_executable(efm, function()
      lsp.efm.setup(lc_opts.with_default_opts({
        cmd = {efm; '-c'; string.format('%s/langservers/efm-langserver.yaml', config_dir)};
        filetypes = {'python'};
        root_pattern = lc_opts.project_root_pattern;
      }))
    end)
  end)

  if loop.os_getenv('NVIM_DEBUG') and not status then
    print('failed to setup lc: ' .. err)
  end
end
