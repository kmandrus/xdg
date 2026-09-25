  return {
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      branch = "main",
      -- The :TSUpdate build and require('nvim-treesitter').install below are
      -- disabled: CommandLineTools 27 ships libxcrun.dylib as arm64-only,
      -- which breaks tree-sitter-cli's build path for our x86_64-Rosetta nvim.
      -- Parsers and queries under ~/.local/share/nvim/site/ are managed by
      -- the `ts-install` shell script (config/zsh/scripts/ts-install in this
      -- repo). Re-enable the block below once we're off Rosetta.
      -- build = ":TSUpdate",
      -- config = function()
      --   local ts = require("nvim-treesitter")
      --   ts.setup()
      --   ts.install({
      --     "bash", "c", "cpp", "css", "diff", "dockerfile",
      --     "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      --     "go", "html", "javascript", "json", "lua", "luadoc", "luap",
      --     "make", "markdown", "markdown_inline",
      --     "python", "query", "regex", "rst", "ruby", "rust",
      --     "sql", "terraform", "toml", "tsx", "typescript",
      --     "vim", "vimdoc", "yaml",
      --   })
      -- end,
    },
  }
