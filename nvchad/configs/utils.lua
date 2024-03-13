--- ### AstroNvim Utilities
--
-- Various utility functions to use within AstroNvim and user configurations.
--
-- This module can be loaded with `local utils = require "astronvim.utils"`
--
-- @module astronvim.utils
-- @copyright 2022
-- @license GNU General Public License v3.0

local M = {}

M["icons"] = {
 ActiveLSP = "",
  ActiveTS = "",
  ArrowLeft = "",
  ArrowRight = "",
  Bookmarks = "",
  BufferClose = "󰅖",
  DapBreakpoint = "",
  DapBreakpointCondition = "",
  DapBreakpointRejected = "",
  DapLogPoint = ".>",
  DapStopped = "󰁕",
  Debugger = "",
  DefaultFile = "󰈙",
  Diagnostic = "󰒡",
  DiagnosticError = "",
  DiagnosticHint = "󰌵",
  DiagnosticInfo = "󰋼",
  DiagnosticWarn = "",
  Ellipsis = "…",
  FileNew = "",
  FileModified = "",
  FileReadOnly = "",
  FoldClosed = "",
  FoldOpened = "",
  FoldSeparator = " ",
  FolderClosed = "",
  FolderEmpty = "",
  FolderOpen = "",
  Git = "󰊢",
  GitAdd = "",
  GitBranch = "",
  GitChange = "",
  GitConflict = "",
  GitDelete = "",
  GitIgnored = "◌",
  GitRenamed = "➜",
  GitSign = "▎",
  GitStaged = "✓",
  GitUnstaged = "✗",
  GitUntracked = "★",
  LSPLoaded = "", -- TODO: Remove unused icon in AstroNvim v4
  LSPLoading1 = "",
  LSPLoading2 = "󰀚",
  LSPLoading3 = "",
  MacroRecording = "",
  Package = "󰏖",
  Paste = "󰅌",
  Refresh = "",
  Search = "",
  Selected = "❯",
  Session = "󱂬",
  Sort = "󰒺",
  Spellcheck = "󰓆",
  Tab = "󰓩",
  TabClose = "󰅙",
  Terminal = "",
  Window = "",
  WordFile = "󰈭",
}

--- Create a button entity to use with the alpha dashboard
---@param sc string The keybinding string to convert to a button
---@param txt string The explanation text of what the keybinding does
---@return table # A button entity table for an alpha configuration
function M.alpha_button(sc, txt)
  -- replace <leader> in shortcut text with LDR for nicer printing
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<Leader>")
  -- if the leader is set, replace the text with the actual leader key for nicer printing
  if vim.g.mapleader then sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader) end
  -- return the button entity to display the correct text and send the correct keybinding on press
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = -2,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

--- Get an icon from the AstroNvim internal icons if it is available and return it
---@param kind string The kind of icon in astronvim.icons to retrieve
---@param padding? integer Padding to add to the end of the icon
---@param no_fallback? boolean Whether or not to disable fallback to text icon
---@return string icon
function M.get_icon(kind, padding, no_fallback)
  local icon = M["icons"] and M["icons"][kind]
  return icon and icon .. string.rep(" ", padding or 0) or ""
end

--- Navigate left and right by n places in the bufferline
-- @param n number The number of tabs to navigate to (positive = right, negative = left)
function M.nav(n)
  local current = vim.api.nvim_get_current_buf()
  for i, v in ipairs(vim.t.bufs) do
    if current == v then
      vim.cmd.b(vim.t.bufs[(i + n - 1) % #vim.t.bufs + 1])
      break
    end
  end
end

return M
