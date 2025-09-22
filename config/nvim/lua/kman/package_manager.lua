-- mason is a package manager for lsp servers, formatters, linters, etc.

local mason = require "mason"

mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})
