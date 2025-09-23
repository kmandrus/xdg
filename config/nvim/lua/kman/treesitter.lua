local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("unable to load nvim-treesitter!.configs")
    return
end

configs.setup({
    ensure_installed = {
      "awk",
      "bash",
      "bazelrc",
      "c",
      "c_sharp",
      "cmake",
      "commonlisp",
      "cpp",
      "css",
      "csv",
      "desktop",
      "diff",
      "dockerfile",
      "gitcommit",
      "git_config",
      "git_ignore",
      "git_rebase",
      "go",
      "groovy",
      "helm",
      "html",
      "http",
      "java",
      "jq",
      "jsdoc",
      "json",
      "json5",
      "json_schema",
      "jsonnet",
      "kcl",
      "kconfig",
      "kotlin",
      "latex",
      "lua",
      "luadoc",
      "make",
      "markdown",
      "markdown_inline",
      "nginx",
      "nix",
      "powershell",
      "prolog",
      "psv",
      "python",
      "query",
      "r",
      "readline",
      "regex",
      "ruby",
      "rust",
      "scala",
      "scheme",
      "sql",
      "sqlite",
      "ssh_client_config",
      "ssh_config",
      "terraform",
      "tmux",
      "toml",
      "tsv",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
    }, -- one of "all" or a list of languages
    ignore_install = { "ipkg" }, -- List of parsers to ignore installing
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    autopairs = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = { "" } -- list of languages to disable indentation for
    },
})

