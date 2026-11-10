-- Canonical declaration of the external tooling this nvim config expects.
--
-- This is the single source of truth, consumed from two places:
--   * kman.package_manager -- mason setup and the :KmanInstall* commands
--   * the dotfiles repo's .personalize.background, which calls the install_*
--     functions below from headless nvim when a Coder workspace is created
--
-- This list platform-neutral. OS-level packages (ripgrep, fd, bat, the
-- python CLI tools, ...) are defined in platform-specific setup scripts.

local M = {}

-- LSP servers, as `mason package name = vim.lsp.enable() name`.
M.servers = {
  ["pyright"] = "pyright",
  ["lua-language-server"] = "lua_ls",
  ["gopls"] = "gopls",
  ["yaml-language-server"] = "yamlls",
  ["json-lsp"] = "jsonls",
  ["terraform-ls"] = "terraformls",
  ["bash-language-server"] = "bashls",
  ["sqls"] = "sqls",
  ["marksman"] = "marksman",
}

-- Formatters, linters and build tools fetched through mason.
--
-- Tools the OS layer already provides are omitted.
--
-- Keep python-based tools out of this list. mason installs them into a venv
-- built with the system python3, and the Coder image has no ensurepip, so they
-- fail. pipx (see .personalize.background) is the path for those.
M.tools = {
  "stylua", -- lua formatter
  "shfmt", -- shell formatter
  "prettier", -- yaml/json/markdown formatter
  "goimports", -- go formatter + import fixer
  "tree-sitter-cli", -- REQUIRED by nvim-treesitter's main branch
}

-- Treesitter parsers to install. 
M.parsers = {
  "bash",
  "c",
  "cpp",
  "css",
  "diff",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "luadoc",
  "luap",
  "make",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "regex",
  "rst",
  "ruby",
  "rust",
  "sql",
  "terraform",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

--- Every mason package name, servers and tools together.
---@return string[]
function M.mason_packages()
  local packages = {}
  for package_name, _ in pairs(M.servers) do
    table.insert(packages, package_name)
  end
  vim.list_extend(packages, M.tools)
  table.sort(packages)
  return packages
end

--- The vim.lsp.enable() names for every configured server.
---@return string[]
function M.lsp_names()
  local names = {}
  for _, lsp_name in pairs(M.servers) do
    table.insert(names, lsp_name)
  end
  table.sort(names)
  return names
end

--- Install any mason package that isn't present yet, blocking until done.
---
--- Intended for `nvim --headless`, where mason's :MasonInstall runs
--- synchronously. Two mason behaviours are worked around here:
---
---   * :MasonInstall throws if asked for a package that is already installed,
---     so only the missing ones are passed. This also makes the function cheap
---     to re-run, which matters because .personalize.background runs on every
---     workspace start, not just creation.
---   * When a package resolves but its installer fails, mason logs the error
---     and still exits 0. So the results are re-checked below and we exit
---     non-zero ourselves, otherwise an unattended run reports success while
---     quietly missing a tool.
function M.install_mason()
  local registry = require("mason-registry")
  registry.refresh()

  local packages = M.mason_packages()
  local missing, unresolved = {}, {}

  for _, name in ipairs(packages) do
    local ok, package = pcall(registry.get_package, name)
    if not ok then
      table.insert(unresolved, name)
    elseif not package:is_installed() then
      table.insert(missing, name)
    end
  end

  if #missing > 0 then
    print("Installing " .. #missing .. " mason package(s): " .. table.concat(missing, " "))
    vim.cmd("MasonInstall " .. table.concat(missing, " "))
  else
    print("All " .. #packages .. " mason packages already installed.")
  end

  -- Re-check, since mason swallows installer failures.
  local failed = vim.list_extend({}, unresolved)
  for _, name in ipairs(missing) do
    local ok, package = pcall(registry.get_package, name)
    if not ok or not package:is_installed() then
      table.insert(failed, name)
    end
  end

  if #failed > 0 then
    io.stderr:write("mason failed to install: " .. table.concat(failed, ", ") .. "\n")
    vim.cmd("1cq") -- exit non-zero so the caller notices
  end
end

--- Install every treesitter parser, blocking until done.
---
--- Must run after install_mason(): nvim-treesitter's main branch shells out to
--- the tree-sitter CLI, which mason provides.
---@param timeout? integer milliseconds to wait (default 10 minutes)
function M.install_parsers(timeout)
  require("nvim-treesitter").install(M.parsers):wait(timeout or 600000)
end

return M
