return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        float = {
            enable = true,
            quit_on_focus_loss = false,
            open_win_config = function()
                local screen_w = vim.opt.columns:get()
                local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()

                local width = math.floor(screen_w * 0.6)
                local height = math.floor(screen_h * 0.6)

                local col = math.floor((screen_w - width) / 2)
                local row = math.floor((screen_h - height) / 2)

                return {
                  border = "rounded",
                  relative = "editor",
                  row = row,
                  col = col,
                  width = width,
                  height = height,
                }
            end,
        },
        width = 35,
      },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)

        local function opts(desc)
          return {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
          }
        end
        -- press q to close
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))

        -- optional: Esc to close (very Telescope-like)
        vim.keymap.set("n", "<Esc>", api.tree.close, opts("Close"))
    end,
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = ">", -- arrow when folder is closed
              arrow_open = "v", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          quit_on_open = true,
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })
    -- global
    vim.api.nvim_set_keymap("n", "<leader>ft", ":NvimTreeToggle<cr>", {silent = true, noremap = true})
  end, 
}
