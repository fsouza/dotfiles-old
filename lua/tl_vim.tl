-- globals that are available in all tl modules.

local type VimAPI = record
    nvim_input: function(string)
end

local type VimFn = record
    expand: function(string): string
end

local type Vim = record
    api: VimAPI
    fn: VimFn
end

global vim: Vim
