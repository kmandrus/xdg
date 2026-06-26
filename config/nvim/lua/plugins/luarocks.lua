return {
  "vhyrro/luarocks.nvim",
  priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
  config = true,
  -- vhyrro/luarocks.nvim's build.lua compiles luarocks but never installs dkjson,
  -- which luarocks itself requires at runtime (core/persist.lua). Without this,
  -- startup fails with "module 'dkjson' not found". The plugin is unmaintained,
  -- so we install the rock ourselves after the upstream build runs.
  build = function()
    require("luarocks-nvim.build").build()
    vim.fn.system({
      vim.fn.stdpath("data") .. "/lazy/luarocks.nvim/.rocks/bin/luarocks",
      "--lua-version=5.1",
      "--tree", vim.fn.stdpath("data") .. "/lazy/luarocks.nvim/.rocks",
      "install", "dkjson",
    })
  end,
}
