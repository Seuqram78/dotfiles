vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<ESC><ESC>", function()
  vim.cmd("close")
end, { desc = "Close floating window with double Escape" })
vim.keymap.set("n", "<C-b>", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic" })
