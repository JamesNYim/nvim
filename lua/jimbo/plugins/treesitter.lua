return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "css",
                "javascript",
                "lua",
                "typescript",
                "c",
                "vim",
                "vimdoc",
                "query",
                "markdown",
                "markdown_inline",
                "python",
                "go",
			},
            highlight = {
                enable = true,
            },
        })
    end
}

