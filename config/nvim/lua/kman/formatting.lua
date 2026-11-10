-- conform.nvim: formatting.
--
-- Where each binary comes from:
--   stylua, shfmt, prettier, goimports, sqlfluff -- mason, via kman.tools
--   black                                       -- apt/pipx on Coder, pip on macOS
--   gofmt, terraform fmt                        -- bundled with go / terraform
--
-- Format-on-save is deliberately off. Formatting is explicit, via <leader>F or
-- :Format, so running the config on an unfamiliar repo can't rewrite files.

local ok, conform = pcall(require, "conform")
if not ok then
  vim.notify("conform plugin not found!")
  return
end

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    sh = { "shfmt" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
    yaml = { "prettier" },
    json = { "prettier" },
    jsonc = { "prettier" },
    markdown = { "prettier" },
    go = { "goimports", "gofmt" },
    terraform = { "terraform_fmt" },
    hcl = { "terraform_fmt" },
    sql = { "sqlfluff" },
  },
  default_format_opts = {
    lsp_format = "fallback", -- let the LSP format filetypes with no formatter above
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    -- :'<,'>Format -- format just the selected lines
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format({ async = true, lsp_format = "fallback", range = range })
end, { desc = "Format the buffer or the selected range", range = true })

vim.keymap.set({ "n", "v" }, "<leader>F", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer or selection" })
