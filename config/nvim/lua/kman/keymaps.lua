-- shorten function name 
local keymap = vim.keymap.set
-- silent keymap option
local opts = { silent = true, noremap = true }

-- Leader Keys
keymap("", "<Space>", "<Nop>", opts)
keymap("", "<return>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = "<return>"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   operator_pending_mode = "o"
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Window Navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("i", "<C-h>", "<C-w>h", opts)
keymap("i", "<C-j>", "<C-w>j", opts)
keymap("i", "<C-k>", "<C-w>k", opts)
keymap("i", "<C-l>", "<C-w>l", opts)
keymap("t", "<C-h>", "<C-w>h", opts)
keymap("t", "<C-j>", "<C-w>j", opts)
keymap("t", "<C-k>", "<C-w>k", opts)
keymap("t", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "}", ":bnext<CR>", opts)
keymap("n", "{", ":bprevious<CR>", opts)

-- Open buffers
keymap("n", "<leader>h", ":split<CR>", opts)
keymap("n", "<leader>v", ":vsplit<CR>", opts)

-- Movement 
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("n", "K", "{", opts)
keymap("n", "J", "}", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)
keymap("v", "K", "{", opts)
keymap("v", "J", "}", opts)
keymap("o", "H", "^", opts)
keymap("o", "L", "$", opts)
keymap("o", "K", "{", opts)
keymap("o", "J", "}", opts)
keymap("o", "<C-d>", "<C-d>zz", opts)
keymap("o", "<C-u>", "<C-u>zz", opts)

-- Quickfix Menu
keymap("n", "<)>", ":cnext<CR>", opts)
keymap("n", "<(>", ":cprevious<CR>", opts)

-- uppercase a word in normal and insert mode
keymap("i", "<c-u>", "<esc>viwUea", opts)
keymap("n", "<leader>u", "viwUe", opts)

-- 'in' and 'around' next and last parenthesis
keymap("o", "in(", ":<c-u>normal! f(vi(<cr>", opts)
keymap("o", "il(", ":<c-u>normal! F(vi(<cr>", opts)
keymap("o", "an(", ":<c-u>normal! f(va(<cr>", opts)
keymap("o", "al(", ":<c-u>normal! F(va(<cr>", opts)

-- quote a word
keymap("n", "<leader>\"", "viw<esc>a\"<esc>bi\"<esc>lel", opts)
keymap("n", "<leader>'", "viw<esc>a'<esc>bi'<esc>lel", opts)

-- surroud a visual mode selection
keymap("v", "<leader>\"", "<esc>`>a\"<esc>`<i\"<esc>lel", opts)
keymap("v", "<leader>'", "<esc>`>a'<esc>`<i'<esc>lel", opts)
keymap("v", "<leader>[", "<esc>`>a]<esc>`<i[<esc>lel", opts)
keymap("v", "<leader>]", "<esc>`>a]<esc>`<i[<esc>lel", opts)
keymap("v", "<leader>(", "<esc>`>a)<esc>`<i(<esc>lel", opts)
keymap("v", "<leader>)", "<esc>`>a)<esc>`<i(<esc>lel", opts)
keymap("v", "<leader>{", "<esc>`>a}<esc>`<i{<esc>lel", opts)
keymap("v", "<leader>}", "<esc>`>a}<esc>`<i{<esc>lel", opts)

-- source the active lua file
keymap("n", "<leader>s", ":luafile %<cr>", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Don't replace what's in the " register when pasting in visual mode
keymap("v", "p", '"_dP', opts)

-- Telescope

-- Open current buffer in gitlab
keymap("n", "<leader>o", ":execute '!open_in_gitlab ' . expand('%:p')<cr>", opts) 

-- Fix issue where <S-Space> clears the line in Terminaml Mode
keymap("t", "<S-space>", "<space>", opts)

-- LSP
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buf_keymap = vim.api.nvim_buf_set_keymap
    local buf = event.buf
    buf_keymap(buf, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_keymap(buf, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_keymap(buf, "n", "gk", "<cmd>lua vim.lsp.buf.hover({border = 'rounded'})<CR>", opts)
    buf_keymap(buf, "n", "gK", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    buf_keymap(buf, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_keymap(buf, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_keymap(buf, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_keymap(buf, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
    buf_keymap(buf, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    buf_keymap(buf, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
    buf_keymap(buf, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
    buf_keymap(buf, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    buf_keymap(buf, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_keymap(buf, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  end
})
