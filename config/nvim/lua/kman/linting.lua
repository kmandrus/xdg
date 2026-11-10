-- nvim-lint: diagnostics from standalone linters, alongside the LSP ones.
--
-- Where each binary comes from:
--   flake8    -- pipx on Coder (.personalize.background), pip on macOS
--   shellcheck, yamllint -- apt/base image on Coder, brew on macOS
--   sqlfluff  -- pipx on Coder, pip on macOS
--
-- flake8 rather than pyflakes + pycodestyle: nvim-lint ships no pyflakes
-- definition, and flake8 is a wrapper over exactly those two checkers.
--
-- Entries are filtered by is_available() below, so a linter that this platform
-- lacks is skipped rather than erroring on every write. Results surface
-- through the vim.diagnostic config in kman.lsp_diagnostics.

local ok, lint = pcall(require, "lint")
if not ok then
  vim.notify("nvim-lint plugin not found!")
  return
end

local wanted = {
  python = { "flake8" },
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  yaml = { "yamllint" },
  sql = { "sqlfluff" },
}

--- A linter is usable only if nvim-lint defines it AND its binary is present.
--- Checking only the binary isn't enough: lint.try_lint() asserts on a name it
--- has no definition for, which would error on every BufReadPost.
---@param name string
---@return boolean
local function is_available(name)
  local defined, config = pcall(function()
    return lint.linters[name]
  end)
  if not defined or type(config) ~= "table" then
    return false
  end

  local cmd = config.cmd
  -- cmd may be a function resolved at runtime; fall back to the linter name.
  if type(cmd) ~= "string" then
    cmd = name
  end
  return vim.fn.executable(cmd) == 1
end

local by_ft = {}
for filetype, linters in pairs(wanted) do
  local available = vim.tbl_filter(is_available, linters)
  if #available > 0 then
    by_ft[filetype] = available
  end
end

lint.linters_by_ft = by_ft

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("kman_lint", { clear = true }),
  callback = function()
    if by_ft[vim.bo.filetype] then
      lint.try_lint()
    end
  end,
})

vim.api.nvim_create_user_command("Lint", function()
  lint.try_lint()
end, { desc = "Run the linters for this buffer" })
