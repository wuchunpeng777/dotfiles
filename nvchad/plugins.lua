local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  }, -- override plugin configs
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim",  "Hoffs/omnisharp-extended-lsp.nvim" },
    event = "User FilePost",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "bashls",
          "cmake",
          "cssls",
          "gradle_ls",
          "html",
          "jsonls",
          "tsserver",
          "omnisharp",
        },
        automatic_installation = true,
      }
      local rounded_border_handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          border = "rounded",
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "rounded",
        }),
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      local on_attach = function(_, bufnr)
        local opts = {
          noremap = true,
          silent = true,
          buffer = bufnr,
        }
        vim.keymap.set("n", "<F12>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      end

      require("mason-lspconfig").setup_handlers {
        function(server_name)
          require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            handlers = rounded_border_handlers,
          }
        end,
      ["omnisharp"] = function()
          require("lspconfig")["omnisharp"].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            root_dir = function(fname)
              local lspconfig = require "lspconfig"
              local primary = lspconfig.util.root_pattern "*.sln"(fname)
              local fallback = lspconfig.util.root_pattern "*.csproj"(fname)
              return primary or fallback
            end,
            analyze_open_documents_only = true,
            organize_imports_on_format = true,
            handlers = vim.tbl_extend("force", rounded_border_handlers, {
              ["textDocument/definition"] = require("omnisharp_extended").handler,
            }),
          }
        end,
      }
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },
  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  }, -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },
  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    config = function()
      require "custom.configs.conform"
    end,
  }, -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },
  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim", -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require "custom.configs.noice"
    end,
  },
  {
    "goolord/alpha-nvim",
    -- enabled = false,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },

    opts = overrides.alpha,
    config = require "custom.configs.alpha",
  },
  {
    "djoshea/vim-autoread",
    event = "User FilePost",
  },
  {
    "Pocco81/auto-save.nvim",
    event = "InsertEnter",
    config = function()
      require("auto-save").setup {
        -- your config goes here
        -- or just leave it empty :)
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "debugloop/telescope-undo.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    opts = overrides.telescope,
    config = require "custom.configs.telescope",
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n" },
        function()
          require("flash").jump {
            search = {
              mode = "search",
              max_length = 0,
            },
            label = {
              after = { 0, 0 },
            },
            pattern = "^",
          }
        end,
        desc = "Flash to line",
      },
    },
  },
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
  },
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle" },
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = overrides.cmp,
  },
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "User FilePost",
    opts = overrides.buffline,
    dependencies = "nvim-tree/nvim-web-devicons",
  },
  { "qpkorr/vim-bufkill" },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = require "custom.configs.copilot",
  },
  {
    "AndrewRadev/switch.vim",
    event = "User FilePost",
  },
  {
    "petertriho/nvim-scrollbar",
    config = function()
      local colors = require("tokyonight.colors").setup()
      require("scrollbar").setup {
        handle = {
          color = colors.bg_highlight,
        },
        marks = {
          Search = {
            color = colors.orange,
          },
          Error = {
            color = colors.error,
          },
          Warn = {
            color = colors.warning,
          },
          Info = {
            color = colors.info,
          },
          Hint = {
            color = colors.hint,
          },
          Misc = {
            color = colors.purple,
          },
        },
      }
    end,
  },
  {
    "aznhe21/actions-preview.nvim",
    config = function()
      require("actions-preview").setup {
        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
        diff = {
          ctxlen = 3,
        },
        -- priority list of preferred backend
        backend = { "telescope", "nui" },

        -- options related to telescope.nvim
        telescope = vim.tbl_extend(
          "force",
          -- telescope theme: https://github.com/nvim-telescope/telescope.nvim#themes
          require("telescope.themes").get_dropdown(), -- a table for customizing content
          {
            -- a function to make a table containing the values to be displayed.
            -- fun(action: Action): { title: string, client_name: string|nil }
            make_value = nil,

            -- a function to make a function to be used in `display` of a entry.
            -- see also `:h telescope.make_entry` and `:h telescope.pickers.entry_display`.
            -- fun(values: { index: integer, action: Action, title: string, client_name: string }[]): function
            make_make_display = nil,
          }
        ),

        -- options for nui.nvim components
        nui = {
          -- component direction. "col" or "row"
          dir = "col",
          -- keymap for selection component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu#keymap
          keymap = nil,
          -- options for nui Layout component: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/layout
          layout = {
            position = "50%",
            size = {
              width = "60%",
              height = "90%",
            },
            min_width = 40,
            min_height = 10,
            relative = "editor",
          },
          -- options for preview area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/popup
          preview = {
            size = "60%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
          -- options for selection area: https://github.com/MunifTanjim/nui.nvim/tree/main/lua/nui/menu
          select = {
            size = "40%",
            border = {
              style = "rounded",
              padding = { 0, 1 },
            },
          },
        },
      }
    end,
  },
  {
    "gbprod/yanky.nvim",
    event = "User FilePost",
    config = function()
      local utils = require "yanky.utils"
      local mapping = require "yanky.telescope.mapping"

      require("yanky").setup {
        picker = {
          telescope = {
            mappings = {
              default = mapping.put "p",
            },
          },
        },
      }
    end,
  },
  {
    "folke/todo-comments.nvim",
    event = "User FilePost",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      keywords = {
        WFIX = {
          icon = " ", -- icon used for the sign, and in search results
          color = "error", -- can be a hex color, or a named color (see below)
          alt = { "WFIX" }, -- a set of other keywords that all map to this FIX keywords
          -- signs = false, -- configure signs for some keywords individually
        },
        WTODO = {
          icon = " ",
          color = "info",
          alt = { "WTODO" },
        },
        WWARN = {
          icon = " ",
          color = "warning",
          alt = { "WWARNING" },
        },
        WPERF = {
          icon = " ",
          alt = { "WOPTIMIZE" },
        },
        WNOTE = {
          icon = " ",
          color = "hint",
        },
      },
      merge_keywords = false, -- when true, custom keywords will be merged with the defaults
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User FilePost",
    opts = {
      mode = "cursor",
      max_lines = 3,
      separator = "-",
    },
  },
  {
    "yamatsum/nvim-cursorline",
    lazy = false,
    config = function()
      require("nvim-cursorline").setup {
        cursorline = {
          enable = false,
          timeout = 100,
          number = false,
        },
        cursorword = {
          enable = true,
          min_length = 1,
          hl = {
            underline = true,
          },
        },
      }
    end,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
  },
  -- {
  --   "gelguy/wilder.nvim",
  --   lazy = false,
  --   config = function()
  --     -- config goes here
  --     local wilder = require "wilder"
  --     wilder.setup {
  --       modes = { ":" },
  --     }
  --     wilder.set_option(
  --       "renderer",
  --       wilder.popupmenu_renderer(wilder.popupmenu_palette_theme {
  --         -- 'single', 'double', 'rounded' or 'solid'
  --         -- can also be a list of 8 characters, see :h wilder#popupmenu_palette_theme() for more details
  --         border = "rounded",
  --         max_height = "75%", -- max height of the palette
  --         min_height = 0, -- set to the same as 'max_height' for a fixed height window
  --         prompt_position = "top", -- 'top' or 'bottom' to set the location of the prompt
  --         reverse = 0, -- set to 1 to reverse the order of the list, use in combination with 'prompt_position'
  --       })
  --     )
  --   end,
  -- },
  {
    "Shatur/neovim-session-manager",
    lazy = false,
    config = function()
      local Path = require "plenary.path"
      local config = require "session_manager.config"
      require("session_manager").setup {
        sessions_dir = Path:new(vim.fn.stdpath "data", "sessions"), -- The directory where the session files will be saved.
        session_filename_to_dir = session_filename_to_dir, -- Function that replaces symbols into separators and colons to transform filename into a session directory.
        dir_to_session_filename = dir_to_session_filename, -- Function that replaces separators and colons into special symbols to transform session directory into a filename. Should use `vim.loop.cwd()` if the passed `dir` is `nil`.
        autoload_mode = config.AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
          "gitrebase",
        },
        autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      }
    end,
  },
  {
    'petertriho/nvim-scrollbar',
    event = 'User FilePost',
    config = function ()
      require("scrollbar").setup()
    end
  },

--   {
--     'jmederosalvarado/roslyn.nvim',
--     lazy = false,
--     config = function ()
--       local capabilities = vim.lsp.protocol.make_client_capabilities()
--         capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

--         local on_attach = function(_, bufnr)
--             local opts = {
--                 noremap = true,
--                 silent = true,
--                 buffer = bufnr
--             }
--         end

--       require("roslyn").setup({
--     dotnet_cmd = "dotnet", -- this is the default
--     roslyn_version = "4.8.0-3.23475.7", -- this is the default
--     on_attach = on_attach,
--     capabilities = capabilities,
-- })
--     end
--   },

  -- Lua
{
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
}
}

return plugins
