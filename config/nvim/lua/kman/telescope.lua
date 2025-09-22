local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  vim.notify("unable to load telescope module!")
  return
end

local actions = require "telescope.actions"

telescope.setup{
  defaults = {
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", },
    preview = { treesitter = true },
    border = true,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        -- ["<C-h>"] = "which_key"
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["C-h"] = actions.select_horizontal,
        ["C-s"] = actions.select_vertical,
      },
      n = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["C-h"] = actions.select_horizontal,
        ["C-s"] = actions.select_vertical,
      },
    }
  },
  pickers = {
    find_files = { theme = "ivy" },
    live_grep = { theme = "ivy" },
    grep_string = { theme = "ivy" },
    buffers = { theme = "ivy" },
    help_tags = { theme = "ivy" },
    commands = { theme = "ivy" },
    search_history = { theme = "ivy" },
    spell_suggest = { theme = "ivy" },
    lsp_references = { theme = "ivy" },
    marks = { theme = "ivy" },
    registers = { theme = "ivy" },
    git_commits = { theme = "ivy" },
    git_bcommits = { theme = "ivy" },
    git_branches = { theme = "ivy" },
    git_status = { theme = "ivy" },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
        -- width = 0.5,
        -- previewer = false,
        -- border = true,
        -- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      }
    }
  },
}
telescope.load_extension('fzf')
telescope.load_extension('ui-select')
