vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Open diff view" })
vim.keymap.set("n", "<leader>gq", "<CMD>DiffviewClose<CR>", { desc = "Close diff view" })
vim.keymap.set("n", "<leader>gD", ":DiffviewOpen ", { desc = "Diff against branch" })
vim.keymap.set("n", "<leader>gh", "<CMD>DiffviewFileHistory %<CR>", { desc = "File git history" })
vim.keymap.set("n", "<leader>gH", "<CMD>DiffviewFileHistory<CR>", { desc = "Branch git log" })
vim.keymap.set("n", "<leader>gr", function()
  vim.cmd("!git add -A && GIT_EDITOR=true git rebase --continue")
  vim.cmd("DiffviewClose")
end, { desc = "Stage all + continue rebase" })

-- Resolve conflict markers in a buffer by keeping "theirs"
local function accept_theirs_in_buffer(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local result = {}
  local in_conflict = false
  local in_theirs = false

  for _, line in ipairs(lines) do
    if line:match("^<<<<<<<") then
      in_conflict = true
      in_theirs = false
    elseif line:match("^=======") and in_conflict then
      in_theirs = true
    elseif line:match("^>>>>>>>") and in_conflict then
      in_conflict = false
      in_theirs = false
    elseif in_conflict and in_theirs then
      table.insert(result, line)
    elseif not in_conflict then
      table.insert(result, line)
    end
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, result)
end

-- Accept theirs in current buffer
vim.api.nvim_create_user_command("ConflictAcceptTheirs", function()
  accept_theirs_in_buffer(0)
  vim.cmd("write")
end, { desc = "Accept theirs for all conflicts in current file" })

-- Accept theirs in all conflicted files
vim.api.nvim_create_user_command("ConflictAcceptAllTheirs", function()
  local files = vim.fn.systemlist("git diff --name-only --diff-filter=U")
  if #files == 0 then
    vim.notify("No conflicted files found", vim.log.levels.INFO)
    return
  end
  for _, file in ipairs(files) do
    local path = vim.fn.fnamemodify(file, ":p")
    vim.cmd("edit " .. vim.fn.fnameescape(path))
    accept_theirs_in_buffer(0)
    vim.cmd("write")
  end
  vim.cmd("Git add .")
  vim.notify("Accepted theirs in " .. #files .. " file(s)", vim.log.levels.INFO)
end, { desc = "Accept theirs for all conflicts in all files" })
