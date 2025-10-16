return {
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    build = "brew install ripgrep",
    config = function()
      local t = require("telescope.builtin")
      local opts = { silent = true, noremap = true }
      vim.keymap.set("n", "<leader>ff", t.find_files)
      vim.keymap.set("n", "<leader>fg", t.live_grep, opts)
      vim.keymap.set("n", "<leader>fG", t.grep_string, opts)
      vim.keymap.set("n", "<leader>fb", t.buffers, opts)
      vim.keymap.set("n", "<leader>fh", t.help_tags, opts)
      vim.keymap.set("n", "<leader>fc", t.commands, opts)
      vim.keymap.set("n", "<leader>fs", t.search_history, opts)
      vim.keymap.set("n", "<leader>fS", t.spell_suggest, opts)
      vim.keymap.set("n", "<leader>fm", t.marks, opts)
      vim.keymap.set("n", "<leader>fr", t.registers, opts)
      vim.keymap.set("n", "<leader>fl", t.resume, opts)
      vim.keymap.set("n", "<leader>fp", t.builtin, opts)
      vim.keymap.set("n", "<leader>gc", t.git_commits, opts)
      vim.keymap.set("n", "<leader>gC", t.git_bcommits, opts)
      vim.keymap.set("n", "<leader>gb", t.git_branches, opts)
      vim.keymap.set("n", "<leader>gs", t.git_status, opts)
      vim.keymap.set("n", "gr", t.lsp_references, opts)
      -- edit neovim config
      vim.keymap.set("n", "<leader>en", function()
        t.find_files {cwd = vim.fn.stdpath("config")}
      end)
      -- edit doftiles
      vim.keymap.set("n", "<leader>ed", function()
        t.find_files {cwd = "~/code/dotfiles"}
      end)
    end,
  },
  { "nvim-telescope/telescope-ui-select.nvim" },
}
