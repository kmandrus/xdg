local root_files = {
  '.luarc.json',
  '.luarc.jsonc',
  '.luacheckrc',
  '.stylua.toml',
  'stylua.toml',
  'selene.toml',
  'selene.yml',
  '.git',
}

-- nvim-cmp has a wider set up capabilities than the default LSP client.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
  capabilities = capabilities,
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = root_files,
  single_file_support = true,
  log_level = vim.lsp.protocol.MessageType.Warning,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        },
      },
    }
  },
  docs = {
    description = [[
https://github.com/luals/lua-language-server

Lua language server.

`lua-language-server` can be installed by following the instructions [here](https://luals.github.io/#neovim-install).

The default `cmd` assumes that the `lua-language-server` binary can be found in `$PATH`.

See `lua-language-server`'s [documentation](https://luals.github.io/wiki/settings/) for an explanation of the above fields:
* [Lua.runtime.path](https://luals.github.io/wiki/settings/#runtimepath)
* [Lua.workspace.library](https://luals.github.io/wiki/settings/#workspacelibrary)

]],
  },
}
