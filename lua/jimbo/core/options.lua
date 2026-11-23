vim.g.mapleader = " "
vim.opt.nu = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.incsearch = true


vim.keymap.set("n", "<leader>rn", ":set number! relativenumber!<CR>", {silent = true, noremap = true})
vim.keymap.set("v", "<leader>y", '"+y', { desc = 'Yank to clipboard', silent = false})
vim.keymap.set("n", "<leader>w", "<C-w>w", { desc = "Cycle windows"})
vim.keymap.set("n", "<leader>sv", function()
  for k in pairs(package.loaded) do
    if k:match("^jimbo") then
      package.loaded[k] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
end, { desc = "Reload config" })
vim.keymap.set("n", "<leader>fc", function()
  require("nvim-tree.api").tree.open({ path = vim.fn.expand("~/.config") })
end, { desc = "Open ~/.config in nvim-tree", silent = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
