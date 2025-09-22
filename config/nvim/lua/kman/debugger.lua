local dap = require 'dap'
local dapui = require 'dapui'
local dap_virtual_text = require 'nvim-dap-virtual-text'
local dap_python = require 'dap-python'

dapui.setup({
  layouts = { {
      elements = { {
          id = "scopes",
          size = 0.25
        }, {
          id = "breakpoints",
          size = 0.25
        }, {
          id = "stacks",
          size = 0.25
        }, {
          id = "watches",
          size = 0.25
        } },
      position = "left",
      size = 40
    },
    {
    -- Remove the console. I only debug in python right now and its debug adapter sends all output to the repl.
      elements = { {
          id = "repl",
          size = .9
        }
      },
      position = "bottom",
      size = 20
    } },
})
dap_virtual_text.setup()
dap_python.setup('~/.virtualenvs/debugpy/bin/python')

-- launch configurations
-- insert into the python configurations table because dap-python adds default configs
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "cg postlink - prod spotlight process files",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/cg/wario/postlink/task_runner.py",
  args = {"publish_spotlight_msa_tables", "prod", "cg_nsclc_metex14", "fmi-flatironhealth-linked-data", "wario/cg/postlink/prod/2025_q1/process_msa_files", "wario/cg/postlink/prod/2025_q1/archive", "flatironhealth-pharma-internal", "cg/published-deliverables/prod/msa/2025_q1/cg_nsclc_metex14.zip"},
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "cg postlink - dev process files",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/cg/wario/postlink/task_runner.py",
  args = {"process_msa_files", "fmi-flatironhealth-linked-data", "wario/cg/postlink/dev/2025_q1/load_from_msa", "wario/cg/postlink/dev/2025_q1/process_msa_files", "False"},
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "snowcut - validate test run - stork",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/stork/task_runner.py",
  args = {"snowcut_validate_test_run_task", "cg_postlink_ci", "CG_POSTLINK_TEST", "fmi-flatironhealth-linked-data", "stork/snowcut/test/snowcut_test_deliverable.zip"},
  env = {PYDEVD_WARN_EVALUATION_TIMEOUT = "500"},
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "snowcut - upload test inputs - stork",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/stork/task_runner.py",
  args = {"snowcut_upload_test_input_task", "CG_POSTLINK_TEST", "cg_postlink_ci", "fmi-flatironhealth-linked-data", "stork/snowcut/test/cg_postlink/inputs"},
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "snowcut - shape snowflake deliverable - stork",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/stork/task_runner.py",
  args = {"shape_snowflake_deliverable_task", "test_shape_deliverable", "CG_POSTLINK_TEST", "fmi-flatironhealth-linked-data", "data_cut/test/cg_postlink/inputs/config.csv", "cg_postlink_dev", "test_shape_deliverable_final", "fmi-flatironhealth-linked-data", "data_cut/test/cg_postlink/inputs/subcohort.csv"},
})
table.insert(dap.configurations.python, {
  type = 'python',
  request = 'launch',
  name = "create cg data dictionary - stork",
  program = "/Users/kevin.andrus/code/flatiron/rwe_services/rwe_services/stork/task_runner.py",
  args = {"cg_data_dictionary_creation_per_project_task", "cg_postlink", "flatiron_internal", "cg_breast/post_link/flatiron_internal", "2024-09-30", "rwe_api", "False", "fmi-flatironhealth-linked-data", "data_dictionaries/test/data_dictionary.xlsx"},
})

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  dapui.eval(nil, { enter = true })
end)

-- debug mappings
vim.keymap.set("n", "<F1>", dap.continue) -- entrypoint that selects the program to run
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F6>", dapui.toggle)
vim.keymap.set("n", "<F10>", dap.run_last)
vim.keymap.set("n", "<F12>", dap.restart)

-- debug python tests
vim.keymap.set("n", "<leader>dm", dap_python.test_method)
vim.keymap.set("n", "<leader>dc", dap_python.test_class)
vim.keymap.set("v", "<leader>ds", dap_python.debug_selection)

-- dap-ui auto open and close
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end
