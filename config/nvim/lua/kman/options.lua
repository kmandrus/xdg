vim.opt.syntax = "on"
vim.opt.shortmess:append "I" 		-- disable the default Vim startup message
vim.opt.shortmess:append "c"
vim.opt.clipboard = "unnamedplus" 	-- allow vim to access the system clipboard
vim.opt.number = true
vim.opt.relativenumber = true 
vim.opt.hidden = true 			-- allow hidden unsaved buffers
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 10
vim.opt.hls = true 			-- enable highlighting
vim.opt.hlsearch = true                 -- highlight all matches on previous search pattern
-- vim.opt.laststatus = 2               -- allow lualine to set this
vim.opt.mouse:append "a" 		-- enable mouse support
vim.opt.tabstop = 8
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.cursorline = false
vim.opt.statusline = "%f%=%r[%l/%L]"
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.cmdheight = 1
vim.opt.conceallevel = 0                -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.timeoutlen = 1000               -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = false                 -- enable persistent undo file
vim.opt.showcmd = false
vim.opt.ruler = false
vim.opt.signcolumn = "auto"
vim.opt.completeopt = { "menuone", "popup", "noselect", "fuzzy", "preview" }
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.fillchars.eob=" "
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.filetype = 'on'
-- vim.opt.winborder = 'solid'
