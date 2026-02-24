vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>gd", "<CMD>DiffviewOpen<CR>", { desc = "Open diff view" })
vim.keymap.set("n", "<leader>gq", "<CMD>DiffviewClose<CR>", { desc = "Close diff view" })
