local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
    vim.notify("unable to load nvim-treesitter!.configs")
    return
end

configs.setup({
    ensure_installed = "all", -- one of "all" or a list of languages
    ignore_install = { "ipkg" }, -- List of parsers to ignore installing
    sync_install = false,
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

