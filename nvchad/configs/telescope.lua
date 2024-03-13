return function(_, opts)
    opts.extensions = {
        aerial = {
            -- Display symbols as <root>.<parent>.<symbol>
            show_nesting = {
                ["_"] = true -- This key will be the default
            }
        },
        undo = {
            -- telescope-undo.nvim config, see below
            mappings = {
            i = {
                ["<cr>"] = require("telescope-undo.actions").restore,
            },
            n = {
                ["<cr>"] = require("telescope-undo.actions").restore,
            },
            },
        },
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            },
        -- other extensions:
        -- file_browser = { ... }
    }

  dofile(vim.g.base46_cache .. "telescope")
  local telescope = require "telescope"
  telescope.setup(opts)

  vim.cmd([[highlight TelescopeSelection guifg='#00ff00']])

  -- load extensions
  for _, ext in ipairs(opts.extensions_list) do
    telescope.load_extension(ext)
  end
end