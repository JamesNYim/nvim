return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local tmuxline = {
          normal = {
            a = { fg = '#3a3a3a', bg = '#fad091', gui = 'bold' },
            b = { fg = '#3a3a3a', bg = '#ffaa4f' },
            c = { fg = '#3a3a3a', bg = '#fad091' },
          },
          insert = {
            a = { fg = '#3a3a3a', bg = '#fad091', gui = 'bold' },
            b = { fg = '#3a3a3a', bg = '#ffaa4f' },
            c = { fg = '#3a3a3a', bg = '#fad091' },
          },
          visual = {
            a = { fg = '#3a3a3a', bg = '#fad091', gui = 'bold' },
            b = { fg = '#3a3a3a', bg = '#ffaa4f' },
            c = { fg = '#3a3a3a', bg = '#fad091' },
          },
        }

        require('lualine').setup {
          options = {
            theme = tmuxline,
            icons_enabled = true,
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
              statusline = {
                  "TelescopePrompt",
                  "NvimTree"
              },
              winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
              statusline = 1000,
              tabline = 1000,
              winbar = 1000,
            }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
          },
          inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
          },
          tabline = {},
          winbar = {},
          inactive_winbar = {},
          extensions = {}
        }
    end
}
