--" for normal mode - the word under the cursor
vim.keymap.set("n", "<leader>di", "<Plug>VimspectorBalloonEval", { silent = true })
--" for visual mode, the visually selected text
vim.keymap.set("x", "<leader>di", "<Plug>VimspectorBalloonEval", { silent = true })


