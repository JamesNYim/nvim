return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "eslint",
          "ts_ls",   -- consider changing to "tsserver" if this was intended
          "pyright",
          "gopls",
          "clangd",
        },
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Server configs (Neovim 0.11+)
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })

      vim.lsp.config("ts_ls", {})
      vim.lsp.config("pyright", {})
      vim.lsp.config("eslint", {})
      vim.lsp.config("gopls", {})
      vim.lsp.config("clangd", {})

      -- Enable servers
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("pyright")
      vim.lsp.enable("eslint")
      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}

