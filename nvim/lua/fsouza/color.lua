local api = vim.api
local helpers = require('fsouza.lib.nvim_helpers')
local themes = require('fsouza.themes')

local M = {}

local state = {
  enabled = false;
  default_theme = nil;
  themes = {};
  popup_cb = nil;
  ns = nil;
  timer = nil;
}

local augroup_name = 'fsouza__colors_auto_disable'

local gc_interval_ms = 5000

-- Should we support more than one cb?
function M.add_popup_cb(cb)
  state.popup_cb = cb
end

function M.set_popup_winid(winid)
  if not state.enabled then
    return
  end
  if winid then
    state.themes[winid] = themes.popup
  end
end

function M.set_default_theme(theme_ns)
  state.default_theme = theme_ns
end

local function gc()
  for winid in pairs(state.themes) do
    if not api.nvim_win_is_valid(winid) then
      state.themes[winid] = nil
    end
  end
end

local function find_theme(curr_winid)
  if state.popup_cb then
    local winid = state.popup_cb()
    if winid == curr_winid then
      return themes.popup
    end
  end
  return state.default_theme
end

local function start_gc_timer()
  if not state.timer then
    state.timer = vim.loop.new_timer()
  end
  state.timer:start(gc_interval_ms, gc_interval_ms, vim.schedule_wrap(gc))
end

local function stop_gc_timer()
  if state.timer then
    state.timer:close()
  end
end

local function setup_autocmd()
  helpers.augroup(augroup_name, {
    {
      events = {'ColorScheme'};
      targets = {'*'};
      modifiers = {'++once'};
      command = [[lua require('fsouza.color').disable()]];
    };
  })
end

local function disable_autocmd()
  helpers.augroup(augroup_name, {})
end

function M.enable()
  vim.o.background = 'light'
  state.enabled = true
  M.set_default_theme(themes.none)
  local function cb(_, winid)
    if not state.enabled then
      return
    end
    local theme = state.themes[winid]
    if not theme then
      theme = find_theme(winid)
    end
    api.nvim_set_hl_ns(theme)
  end
  if not state.ns then
    state.ns = api.nvim_create_namespace('fsouza__color')
    api.nvim_set_decoration_provider(state.ns, {on_win = cb; on_line = cb})
  end
  start_gc_timer()
  setup_autocmd()
end

function M.disable()
  state.enabled = false
  state.themes = {}
  stop_gc_timer()
  api.nvim_set_hl_ns(0)
  disable_autocmd()
end

return M
