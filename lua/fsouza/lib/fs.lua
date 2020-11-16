local M = {}

local loop = vim.loop

-- checks if path is a directory and calls cb with the result (true/false).
function M.check_directory(path, cb)
  loop.fs_stat(path, function(err, stat)
    if err then
      return cb(false)
    end
    cb(stat.type == 'directory')
  end)
end

-- executes cb if path is a directory.
--
-- cb will run in the event loop, so it needs to be wrapped accordingly to
-- execute nvim commands.
function M.if_directory(path, cb)
  M.check_directory(path, function(is_dir)
    if is_dir then
      cb()
    end
  end)
end

return M
