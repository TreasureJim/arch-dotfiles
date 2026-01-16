-- File: ~/.config/nvim/lua/manim_interactive.lua
--
-- Minimal Neovim plugin to launch ManimGL in interactive mode,
-- then send checkpoint_paste(...) commands from visual selections.

local M = {}

-- We'll keep track of the terminal buffer number and channel ID here:
--   M.term_bufnr  → the buffer number of the terminal split
--   M.term_chanid → the job/channel ID for sending keystrokes
M.term_bufnr = nil
M.term_chanid = nil

-- Utility: given a (vim) buffer, window, and a start/end visual range,
-- return the text that was visually selected. We'll use this to grab the scene name.
local function get_visual_selection()
  local pos1 = vim.fn.getpos("v")
  local pos2 = vim.fn.getpos(".")
  local mode = vim.fn.visualmode()
  local region = vim.fn.getregion(pos1, pos2)
  -- print(table.concat(region, ', '))
  local text = table.concat(region, "\n")
  return text:match("^%s*(.-)%s*$")
end

-- Open a new horizontal split with a terminal running ManimGL in interactive mode.
-- Expects:
--   file_path  = absolute path to the current file (lua.fn.expand("%:p"))
--   scene_name = name of the scene (as a string, no quotes)—grabbed from visual selection
--   line_num   = line number at which the scene definition begins
local function open_manim_term(file_path, scene_name, line_num)
  -- Build the full manimgl command:
  --   manimgl <file> <scene> -se <line_num>
  local cmd = string.format("manimgl %s %s -se %d", file_path, scene_name, line_num)

  -- If there's already a terminal buffer open for Manim, wipe it out first
  if M.term_bufnr and vim.api.nvim_buf_is_valid(M.term_bufnr) then
    -- Close that window if it exists
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == M.term_bufnr then
        vim.api.nvim_win_close(win, true)
        break
      end
    end
    -- (Optionally) wipe the buffer so a fresh one gets created
    pcall(vim.api.nvim_buf_delete, M.term_bufnr, { force = true })
    M.term_bufnr = nil
    M.term_chanid = nil
  end

  -- Open a new split and start a terminal with our manimgl command
  -- Use a horizontal split at the bottom 1/3 of the screen
  vim.cmd("botright 15split")              -- 15 lines tall; adjust if you want
  vim.cmd("terminal " .. cmd)             -- open terminal + run the command
  local bufnr = vim.api.nvim_get_current_buf()
  local chan = vim.b.terminal_job_id        -- channel/job ID of the terminal

  M.term_bufnr = bufnr
  M.term_chanid = chan

  -- Optional: enter Terminal mode immediately so that manim output is visible
  vim.cmd("startinsert")
end

-- Called when user presses ⇧⌘R in Visual mode.
-- We grab the visually selected text (scene name), find the line number, and call open_manim_term.
function M.manim_run_scene()
  -- 1) Grab the text of the selection: that's our scene name
  local scene_text = get_visual_selection():gsub("^%s*(.-)%s*$", "%1")  -- trim whitespace

  if scene_text == "" then
    vim.notify("[manim] No scene name selected. Please highlight the class name or scene identifier and try again.", vim.log.levels.ERROR)
    return
  end

  -- 2) Get the start line of the visual selection (for -se)
  local start_pos = vim.fn.getpos("'<")
  local line_num = start_pos[2]

  -- 3) Get the absolute path of the current file
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("[manim] Could not determine current file path.", vim.log.levels.ERROR)
    return
  end

  -- 4) Open the terminal and start ManimGL in interactive mode
  open_manim_term(file_path, scene_text, line_num)
end

-- Helper: send a string (ending in newline) to the Manim terminal, if it's open.
--   If not open, notify the user to run ⇧⌘R first.
local function send_to_manim_term(text)
  if not M.term_chanid or not vim.fn.jobwait({ M.term_chanid }, 0)[1] == -1 then
    vim.notify("[manim] Interactive Manim terminal not running. Press ⇧⌘R on a scene first.", vim.log.levels.ERROR)
    return
  end

  -- Append newline if missing
  if not text:match("\n$") then
    text = text .. "\n"
  end

  -- Send it:
  vim.api.nvim_chan_send(M.term_chanid, text)
end

-- The following functions all send different variants of checkpoint_paste(...):

--- Pressing ⌘ R (super+R) does a normal checkpoint_paste()
function M.manim_checkpoint_paste()
  send_to_manim_term("checkpoint_paste()")
end

--- Pressing ⌘ ⌥ R (super+alt+R) does checkpoint_paste("record")
function M.manim_recorded_checkpoint_paste()
  send_to_manim_term("checkpoint_paste('record')")
end

--- Pressing ⌘ ⌃ R (super+ctrl+R) does checkpoint_paste("skip")
function M.manim_skipped_checkpoint_paste()
  send_to_manim_term("checkpoint_paste('skip')")
end

--- Pressing ⌘ E (super+E) sends an exit() to IPython to quit
function M.manim_exit()
  send_to_manim_term("exit()")
  -- (You may also want to close the split after a short delay. Here’s one way:)
  vim.defer_fn(function()
    if M.term_bufnr and vim.api.nvim_buf_is_valid(M.term_bufnr) then
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_buf(win) == M.term_bufnr then
          vim.api.nvim_win_close(win, true)
          break
        end
      end
      pcall(vim.api.nvim_buf_delete, M.term_bufnr, { force = true })
      M.term_bufnr = nil
      M.term_chanid = nil
    end
  end, 200)  -- 200 ms delay so IPython has time to cleanly exit
end

return M
