return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Fallback quotes if fortune/cowsay aren't available
    local fallback_quotes = {
      "Ship small, learn fast.",
      "Make it work, then make it right, then make it fast.",
      "One test is worth a thousand opinions.",
      "You don't rise to the level of your goals; you fall to the level of your systems.",
      "Do the simplest thing that could possibly work.",
      "Debugging is twice as hard as writing the code in the first place.",
    }

    local function split_lines(s)
      local t = {}
      for line in (s or ""):gmatch("[^\r\n]+") do
        table.insert(t, line)
      end
      return t
    end

    local function has_exec(cmd)
      return vim.fn.executable(cmd) == 1
    end

    local function get_cowsay_lines()
      -- Best: fortune | cowsay
      if has_exec("cowsay") and has_exec("fortune") then
        -- Using shell because it's a pipeline
        local out = vim.fn.system({ "sh", "-lc", "fortune -s | cowsay" })
        if vim.v.shell_error == 0 and out and #out > 0 then
          return split_lines(out)
        end
      end

      -- OK: cowsay with a random local quote
      if has_exec("cowsay") then
        math.randomseed(os.time() + vim.loop.hrtime())
        local quote = fallback_quotes[math.random(#fallback_quotes)]
        local out = vim.fn.system({ "cowsay", quote })
        if vim.v.shell_error == 0 and out and #out > 0 then
          return split_lines(out)
        end
      end

      -- Fallback: just show a quote
      math.randomseed(os.time() + vim.loop.hrtime())
      local quote = fallback_quotes[math.random(#fallback_quotes)]
      return {
        "┌─────────────────────────────┐",
        "│ " .. quote,
        "└─────────────────────────────┘",
      }
    end

    -- Buttons (keep yours)
    dashboard.section.buttons.val = {
      dashboard.button("f", "  > New File", "<cmd>ene<CR>"),
      dashboard.button("ft", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
      dashboard.button("ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("fw", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
    }

    -- Set dynamic cowsay header
    dashboard.section.header.val = get_cowsay_lines()
    dashboard.section.header.opts.hl = "AlphaHeader"
    dashboard.section.buttons.opts.hl = "AlphaButtons"
    dashboard.section.buttons.opts.hl_shortcut = "AlphaShortcut"

    -- Optional: colors
    vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7" })
    vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#9ece6a" })
    vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#e0af68", bold = true })

    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}

