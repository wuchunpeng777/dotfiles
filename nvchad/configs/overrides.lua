local M = {}

require'nvim-treesitter.install'.compilers = {'zig'}

M.treesitter = {
    ensure_installed = {"vim", "lua", "html", "css", "javascript", "typescript", "tsx", "c", "markdown",
                        "markdown_inline", "c_sharp", "cpp", "csv"},
    indent = {
        enable = true
        -- disable = {
        --   "python"
        -- },
    }
}


-- git support in nvimtree
M.nvimtree = {
    git = {
        enable = true
    },

    renderer = {
        highlight_git = true,
        icons = {
            show = {
                git = true
            }
        }
    }
}

M.telescope = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 80,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
        i = {
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous
        }
      },
    },
  
    extensions_list = { "themes", "terms",'ui-select', 'aerial','yank_history','undo','fzf' },
  }


M.cmp = {
    mapping = {
        ["<C-k>"] = require('cmp').mapping.select_prev_item(),
        ["<C-j>"] = require('cmp').mapping.select_next_item(),
    }
}

M.alpha = function()
        local dashboard = require "alpha.themes.dashboard"

        dashboard.section.header.opts.hl = "DashboardHeader"
        dashboard.section.footer.opts.hl = "DashboardFooter"

        local button, get_icon = require("custom.configs.utils").alpha_button, require("custom.configs.utils").get_icon
        dashboard.section.buttons.val = {button("LDR n  ", get_icon("FileNew", 2, true) .. "New File  "),
                                         button("LDR f f", get_icon("Search", 2, true) .. "Find File  "),
                                         button("LDR f o", get_icon("DefaultFile", 2, true) .. "Recents  "),
                                         button("LDR f w", get_icon("WordFile", 2, true) .. "Find Word  "),
                                         button("LDR f '", get_icon("Bookmarks", 2, true) .. "Bookmarks  "),
                                         button("LDR S l", get_icon("Refresh", 2, true) .. "Last Session  ")}

        dashboard.config.layout = {{
            type = "padding",
            val = vim.fn.max {2, vim.fn.floor(vim.fn.winheight(0) * 0.2)}
        }, dashboard.section.header, {
            type = "padding",
            val = 5
        }, dashboard.section.buttons, {
            type = "padding",
            val = 3
        }, dashboard.section.footer}
        dashboard.config.opts.noautocmd = true
        return dashboard
    end

M.buffline = {
    options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            close_command = "bdelete! %d",       -- can be a string | function, | false see "Mouse actions"
            left_mouse_command = "buffer %d",    -- can be a string | function, | false see "Mouse actions"
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            indicator = {
                icon = '▎', -- this should be omitted if indicator style is not 'icon'
                style = 'underline'
            },
            -- 左侧让出 nvim-tree 的位置
            offsets = {{
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left"
            }},
            show_buffer_icons = true,
            show_close_icon = true,
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local s = " "
                for e, n in pairs(diagnostics_dict) do
                    local sym = e == "error" and " "
                            or (e == "warning" and " " or "" )
                    s = s .. n .. sym
                end
                return s
            end,
        }
    }



return M
