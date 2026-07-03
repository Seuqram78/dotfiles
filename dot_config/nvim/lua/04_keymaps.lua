-- Keybinds optimized for Colemak DH layout
-- Harpoon bindings (hz/hx/hc/hd) use home row keys for ergonomic access

-- Telescope
local builtin = require("telescope.builtin")
local input = vim.fn.input

vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy Find Files" })

vim.keymap.set("n", "<leader>ts", function()
	-- Prompt user for extensions
	local extensions = input("Enter file extension: ")

	-- If blank, search all files
	if extensions == "" then
		builtin.live_grep()
		return
	else
		-- Build ripgrep --glob arguments
		local args = {}
		for extension in string.gmatch(extensions, "[^,]+") do
			table.insert(args, "--glob=*" .. extension)
		end

		-- Run live_grep with extension filter
		builtin.live_grep({ additional_args = args })
	end
end, { desc = "Fuzzy Search" })

vim.keymap.set("n", "<leader>tr", "<cmd>Telescope buffers<CR>", { desc = "List Buffers" })
vim.keymap.set("n", "<leader>nei", function()
	require("telescope.builtin").lsp_references()
end, { desc = "Find usages" })

--Harpoon
local harpoon = require("harpoon-core")
vim.keymap.set("n", "<leader>hv", function()
	harpoon.add_file()
end, { desc = "Harpoon add" })
vim.keymap.set("n", "<leader>hk", function()
	harpoon.toggle_quick_menu()
end, { desc = "Harpoon toggle" })
vim.keymap.set("n", "<leader>hz", function()
	harpoon.nav_file(1)
end, { desc = "Harpoon 1" })
vim.keymap.set("n", "<leader>hx", function()
	harpoon.nav_file(2)
end, { desc = "Harpoon 2" })
vim.keymap.set("n", "<leader>hc", function()
	harpoon.nav_file(3)
end, { desc = "Harpoon 3" })
vim.keymap.set("n", "<leader>hd", function()
	harpoon.nav_file(4)
end, { desc = "Harpoon 4" })
vim.keymap.set("n", "<leader>h,", function()
	harpoon.nav_prev()
end, { desc = "Harpoon prev" })
vim.keymap.set("n", "<leader>h.", function()
	harpoon.nav_next()
end, { desc = "Harpoon next" })

-- mini files
vim.keymap.set("n", "<leader>pv", function()
	local MiniFiles = require("mini.files")
	local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
	vim.defer_fn(function()
		MiniFiles.reveal_cwd()
	end, 30)
end)

-- DAP
local dap = require("dap")
vim.keymap.set("n", "<F5>", function()
	dap.continue()
end, { desc = "DAP: Continue" })

vim.keymap.set("n", "<F6>", function()
	dap.terminate()
end, { desc = "DAP: Terminate" })

vim.keymap.set("n", "<F11>", function()
	dap.step_into()
end, { desc = "DAP: Step Into" })

vim.keymap.set("n", "<F10>", function()
	dap.step_over()
end, { desc = "DAP: Step Over" })

vim.keymap.set("n", "<F8>", function()
	dap.continue()
end, { desc = "DAP: Resume" })

vim.keymap.set("n", "<leader>bb", function()
	dap.toggle_breakpoint()
end, { desc = "DAP: Toggle Breakpoint" })

vim.keymap.set("n", "<F56>", function()
	local width = vim.o.columns
	local height = vim.o.lines - 2
	require("dapui").float_element("repl", { width = width, height = height, enter = true })
end, { desc = "DAP: Open evaluate window" })

-- DAP UI
local dapui = require("dapui")

vim.keymap.set("n", "<leader>dd", function()
	dapui.open()
end, { desc = "DAP UI Open" })
vim.keymap.set("n", "<leader>dc", function()
	dapui.close()
end, { desc = "DAP UI Close" })

-- Toggleterm
vim.keymap.set("n", "<leader>hh", "<cmd>ToggleTerm direction=float<CR>", { desc = "Open/close floating terminal" })

vim.keymap.set("n", "<leader>rn", ":IncRename ", { desc = "IncRename" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: Code action" })

-- Treehopper (select AST nodes with hints)
vim.keymap.set("o", "m", ":<C-U>lua require('tsht').nodes()<CR>", { silent = true, desc = "Treehopper select" })
vim.keymap.set("x", "m", ":lua require('tsht').nodes()<CR>", { silent = true, desc = "Treehopper select" })
