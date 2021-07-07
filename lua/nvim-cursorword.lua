_G.vim = vim

local M = {}

local fn = vim.fn
local api = vim.api

function M.echo()
    return vim.w.cursorword
end

function M.highlight()
  if fn.hlexists("CursorWord") == 0 then
    vim.cmd("highlight CursorWord term=underline cterm=underline gui=underline")
  end
end

function M.matchadd()
  local column = api.nvim_win_get_cursor(0)[2]
  local line = api.nvim_get_current_line()
  local cursorword = fn.matchstr(line:sub(1, column + 1), [[\k*$]])
    .. fn.matchstr(line:sub(column + 1), [[^\k*]]):sub(2)

  if cursorword ~= vim.w.cursorword then
    vim.w.cursorword = cursorword

    if vim.w.cursorword_match_id then
      fn.matchdelete(vim.w.cursorword_match_id)
      vim.w.cursorword_match_id = nil
    end

    if #cursorword < 3 or #cursorword > 100 or cursorword:find("[\192-\255]+") then
      return
    end

    local pattern = [[\<]] .. cursorword .. [[\>]]
    vim.w.cursorword_match_id = fn.matchadd("CursorWord", pattern)
  end
end

function M.matchdelete()
  vim.w.cursorword = nil
  if vim.w.cursorword_match_id then
    fn.matchdelete(vim.w.cursorword_match_id)
    vim.w.cursorword_match_id = nil
  end
end

return M
