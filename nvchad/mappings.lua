---@type MappingsTable
local M = {}

M.disabled = {
    n = {
        ["<C-h>"] = '',
        ["<C-l>"] = '',
        ["<C-j>"] = '',
        ["<C-k>"] = '',
        ["<A-l>"] = '',
        ["<A-j>"] = '',
        ["<A-k>"] = '',
        ["<leader>n"] = '',
        ["<leader>h"] = '',
        ["<leader>v"] = '',
        ["<leader>x"] = '',
        ["<A-i>"] = '',
        ["<A-h>"] = '',
        ["<A-v>"] = '',
        ['<leader>b'] = '',
        ['<leader>bb'] = '',
        ['<leader>ca'] = '',
        ['<leader>e'] = '',
    },
    v={
        ['<leader>ca'] = '',
    }
}

M.general = {
    n = {
        [";"] = {
            ":",
            "enter command mode",
            opts = {
                nowait = true
            }
        },
        -- general
        ['j'] = {
            'v:count ? "j" : "gj"',
            'MoveDown',
            opts = {
                expr = true,
                noremap = true
            }
        },
        ['k'] = {
            'v:count ? "k" : "gk"',
            'MoveUp',
            opts = {
                expr = true,
                noremap = true
            }
        },

        --session manager
        ['<leader>Sl'] = {
            '<cmd>SessionManager load_last_session<cr>',
            'LoadLastSession'
        },
        ['<leader>Ss'] = {
            '<cmd>SessionManager save_current_session<cr>',
            'SaveCurrentSession'
        },
        ['<leader>Sd'] = {
            '<cmd>SessionManager delete_session<cr>',
            'DeleteSession'
        },
        ['<leader>So'] = {
            '<cmd>SessionManager load_session<cr>',
            'LoadSession'
        },

        -- new file
        ["<leader>n"] = {'<cmd>enew<cr>', 'NewFile'},

        ['<leader>q'] = {'<cmd>confirm q<cr>', 'Quit'},
        ['<leader>Q'] = {'<cmd>confirm qall<cr>', 'QuitAll'},

        -- smart-splits
        ['<C-h>'] = {function()
            require('smart-splits').move_cursor_left()
        end, 'MoveCursorLeft'},
        ['<C-l>'] = {function()
            require('smart-splits').move_cursor_right()
        end, 'MoveCursorRight'},
        ['<C-j>'] = {function()
            require('smart-splits').move_cursor_down()
        end, 'MoveCursorDown'},
        ['<C-k>'] = {function()
            require('smart-splits').move_cursor_up()
        end, 'MoveCursorUp'},
        ['<C-Left>'] = {function()
            require('smart-splits').resize_left()
        end, 'ResizeWindowLeft'},
        ['<C-Right>'] = {function()
            require('smart-splits').resize_right()
        end, 'ResizeWindowRight'},
        ['<C-Down>'] = {function()
            require('smart-splits').resize_down()
        end, 'ResizeWindowDown'},

        ['<C-Up>'] = {function()
            require('smart-splits').resize_up()
        end, 'ResizeWindowUp'},

        -- aerial
        ['<leader>lS'] = {'<cmd>AerialToggle<cr>', 'ToggleOutline'},

        -- telescope
        ['<leader>ls'] = {'<cmd>Telescope aerial<cr>', 'DocumentSymbols'},
        ['<leader>lG'] = {'<cmd>lsp_workspace_symbols<cr>', 'WorkspaceSymbols'},

        -- split
        ['|'] = {'<cmd>vsplit<cr>', 'SplitVertical'},
        ['\\'] = {'<cmd>split<cr>', 'SplitHorizontal'},

        -- buffer
        [']b'] = {
          '<cmd>BufferLineCycleNext<cr>',
      "Goto next buffer",},
        ['[b'] = {
          '<cmd>BufferLineCyclePrev<cr>',
      "Goto prev buffer",},

        ["<leader>bd"] = {
          '<cmd>bdelete<cr>',
      "Close buffer",},

      ["<leader>bp"] = {
        '<cmd>BufferLinePick<cr>',
        "Select buffer to go to",
      },

        ['<leader>bc'] = {
          '<cmd>BufferLinePickClose<cr>',
            "Select buffer to close",
        },
        ['<leader>bo'] = {
'<cmd>BufferLineCloseOthers<cr>',
      "Close other buffer",},

      ['<leader>pp'] = {
'<cmd>BufferLineTogglePin<cr>',
'Toggle Pin Buffer'
      },

        -- lsp
        ['gd'] = {
            function()
                vim.lsp.buf.definition()
            end,
            "Show the definition of current symbol"
        },
        ['gu'] = {
            function()
                vim.lsp.buf.references()
            end,
            "References of current symbol"
        },
        ['<leader>lr'] = {
            function()
                vim.lsp.buf.rename()
            end,
            "Rename current symbol"
        },
        ["<leader>lf"] = {
            "<cmd>Format<cr>",
            "Format current file"
        },
        ['K'] = {
            function()
                vim.lsp.buf.hover()
            end,
             "Hover symbol details"
        },

        -- comment
        ["<leader>/"] = {
            function()
                require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
            end,
            "Toggle comment line"
        },

        --switch
        ['<C-s>'] = {
            '<cmd>Switch<cr>',
            "Switch"
        },
        
        --code action
        ['<leader>la'] = {
            function ()
                require("actions-preview").code_actions()
            end,
            'CodeAction'
        },

        --yanky
        ['<leader>yy'] = {
            '<cmd>Telescope yank_history<cr>',
            'YankHistory'
        },

        --todo
        ['<leader>ft'] = {
            '<cmd>TodoTelescope<cr>',
            'Todo'
        },

        --undo
        ['<leader>u'] = {
            '<cmd>Telescope undo<cr>',
            'Undo History'
        },

        --context
        ['[c'] = {
            function ()
                require("treesitter-context").go_to_context() 
            end,
            'Goto Context'
        },

        --nvim tree
        ["<leader>e"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
    },
    v = {
        [">"] = {">gv", "indent"},
        ["<leader>/"] = {
            "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
             "Toggle comment for selection"
        },

        --code action
        ['<leader>ca'] = {
            function ()
                require("actions-preview").code_actions()
            end,
            'CodeAction'
        }
    }
}

-- more keybinds!

return M
