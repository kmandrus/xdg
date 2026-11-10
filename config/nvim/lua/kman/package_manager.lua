-- mason is a package manager for lsp servers, formatters, linters, etc.
--
-- The set of packages mason is responsible for is declared in kman.tools, not
-- here. mason.setup() prepends its bin directory to $PATH, which is what lets
-- the lsp/ configs refer to bare binary names like `lua-language-server`.

local mason = require "mason"
local tools = require "kman.tools"

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- Install everything kman.tools declares. On Coder these run unattended from
-- .personalize.background; these commands are the manual equivalent, for a new
-- machine or after adding a tool to kman.tools.
vim.api.nvim_create_user_command("KmanInstallTools", function()
  tools.install_mason()
end, { desc = "Install every mason package declared in kman.tools" })

vim.api.nvim_create_user_command("KmanInstallParsers", function()
  tools.install_parsers()
end, { desc = "Install every treesitter parser declared in kman.tools" })
