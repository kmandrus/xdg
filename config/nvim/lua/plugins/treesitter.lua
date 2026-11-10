-- Parser installation differs by platform.
--
-- macOS: handled by the `ts-install` script in this repo
-- (config/zsh/scripts/ts-install). CommandLineTools 27 ships libxcrun.dylib
-- as arm64-only, which breaks tree-sitter-cli's build path for our
-- x86_64-Rosetta nvim. Drop the branch below once we're off Rosetta.
--
-- Linux (Coder): that bug doesn't apply, so use nvim-treesitter's own
-- installer. The parser list lives in kman.tools and is installed up front by
-- the dotfiles repo's .personalize.background, or on demand via
-- :KmanInstallParsers -- not on every startup.
local is_mac = vim.fn.has("mac") == 1

return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    -- :TSUpdate needs the tree-sitter CLI, which mason provides on Linux only.
    build = (not is_mac) and ":TSUpdate" or nil,
    config = function()
      require("nvim-treesitter").setup()
    end,
  },
}
