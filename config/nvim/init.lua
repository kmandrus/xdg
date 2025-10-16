require "kman.options"
require "kman.keymaps"
require "kman.plugin_manager"
require "kman.file_explorer"
require "kman.treesitter"
require "kman.telescope"
require "kman.lualine"
require "kman.terminal"
require "kman.copilot"
require "kman.package_manager"
require "kman.completion"
require "kman.lsp_diagnostics"

-- Enable default LSPs 
vim.lsp.enable({'pyright', 'lua_ls'})
