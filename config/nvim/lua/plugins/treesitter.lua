  return {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      branch = "main",
      config = function()
        local ts = require("nvim-treesitter")
        ts.setup()
        ts.install({
          "bash", "c", "zsh", "json", "lua", "markdown", "markdown_inline",
          "python", "query", "sql", "toml", "vim", "vimdoc", "yaml",
        })
      end,
    },
  }
