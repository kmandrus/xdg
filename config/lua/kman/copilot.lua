require("CopilotChat").setup()

vim.keymap.set("i", "<C-CR>", 'copilot#Accept("")', {expr = true, replace_keycodes = false})
vim.g.copilot_no_tab_map=true
