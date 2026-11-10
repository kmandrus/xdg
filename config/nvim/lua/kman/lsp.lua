-- Defaults applied to every language server.
--
-- Most of the servers in kman.tools use the lsp/<name>.lua configs that
-- nvim-lspconfig ships, which know nothing about nvim-cmp. Registering the
-- capabilities against the '*' wildcard means every server picks them up,
-- including ones added to kman.tools later, without a per-server config file.
-- This repo's lsp/pyright.lua and lsp/lua_ls.lua set the same capabilities
-- explicitly; that's a harmless duplicate.
--
-- Must run before the vim.lsp.enable() call in init.lua.

local ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok then
  vim.notify("cmp_nvim_lsp not found; LSP completion capabilities not registered", vim.log.levels.WARN)
  return
end

vim.lsp.config("*", {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})
