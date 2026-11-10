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
require "kman.formatting"
require "kman.linting"
require "kman.lsp_diagnostics"
require "kman.lsp"

-- Enable every LSP declared in kman.tools. Add servers there, not here, so the
-- binary gets installed alongside the config being enabled.
vim.lsp.enable(require("kman.tools").lsp_names())
