require("lazy").setup({
	spec = {
		{ "windwp/nvim-autopairs", config = true },
		{
			"romus204/tree-sitter-manager.nvim",
			config = function()
				require("tree-sitter-manager").setup({
					auto_install = true,
				})
			end,
		},

		{
			"nvim-telescope/telescope.nvim",
			tag = "v0.2.2",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
		{ "stevearc/conform.nvim", opts = {} },
		{ "mfussenegger/nvim-dap" },
		{
			"rcarriga/nvim-dap-ui",
			dependencies = {
				"mfussenegger/nvim-dap",
				"nvim-neotest/nvim-nio",
			},
		},
		{ "theHamsta/nvim-dap-virtual-text" },
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
		{
			"saghen/blink.cmp",
			version = "1.*",
			---@module 'blink.cmp'
			---@type blink.cmp.Config
			opts = {
				keymap = { preset = "enter" },
				completion = { documentation = { auto_show = true } },
				signature = { enabled = true },
				sources = {
					default = { "lsp", "path", "snippets", "buffer" },
				},
				fuzzy = { implementation = "prefer_rust_with_warning" },
			},
		},

		{ "neovim/nvim-lspconfig" },
		{
			"mason-org/mason-lspconfig.nvim",
			opts = {},
			dependencies = {
				{ "mason-org/mason.nvim", opts = {} },
				"neovim/nvim-lspconfig",
			},
		},
		{ "echasnovski/mini.files", version = false, setup = true },

		{
			"nvim-lualine/lualine.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
		},
		{ "mbbill/undotree" },
		{
			"rebelot/kanagawa.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd("colorscheme kanagawa")
			end,
		},
		{
			"kdheepak/lazygit.nvim",
			keys = {
				{ "<leader>lz", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			},
		},
		{
			"FabijanZulj/blame.nvim",
			lazy = false,
			config = function()
				require("blame").setup({
					merge_consecutive = true,
				})
			end,
		},
		{ "lewis6991/gitsigns.nvim" },
		{
			"MeanderingProgrammer/harpoon-core.nvim",
			config = function()
				require("harpoon-core").setup({})
			end,
		},
		{
			"seblyng/roslyn.nvim",
			---@module 'roslyn.config'
			---@type RoslynNvimConfig
			opts = {
				-- your configuration comes here; leave empty for default settings
			},
		},
		{
			"folke/which-key.nvim",
			event = "VeryLazy",
			opts = {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},
		{ "WhoIsSethDaniel/mason-tool-installer.nvim" },
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			---@module 'render-markdown'
			---@type render.md.UserConfig
			opts = {},
		},
		{ "smjonas/inc-rename.nvim", opts = {} },
		{ "mfussenegger/nvim-treehopper" },
		{
			"folke/todo-comments.nvim",
			opts = {
				highlight = { after = "", pattern = [[.*<(KEYWORDS)\s*]] },
				search = { pattern = [[\b(KEYWORDS)\b]] },
			},
		},
		{ "nvim-treesitter/nvim-treesitter-context", opts = {} },
		{
			"folke/trouble.nvim",
			opts = {}, -- for default options, refer to the configuration section for custom setup.
			cmd = "Trouble",
			keys = {
				{
					"<leader>xx",
					"<cmd>Trouble diagnostics toggle<cr>",
					desc = "Diagnostics (Trouble)",
				},
				{
					"<leader>xX",
					"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
					desc = "Buffer Diagnostics (Trouble)",
				},
				{
					"<leader>cs",
					"<cmd>Trouble symbols toggle focus=false<cr>",
					desc = "Symbols (Trouble)",
				},
				{
					"<leader>cl",
					"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
					desc = "LSP Definitions / references / ... (Trouble)",
				},
				{
					"<leader>xL",
					"<cmd>Trouble loclist toggle<cr>",
					desc = "Location List (Trouble)",
				},
				{
					"<leader>xQ",
					"<cmd>Trouble qflist toggle<cr>",
					desc = "Quickfix List (Trouble)",
				},
			},
		},
	},
	-- automatically check for plugin updates
	checker = {
		enabled = false, -- disabling auto check
		notify = false, --notify on update
	},
})
