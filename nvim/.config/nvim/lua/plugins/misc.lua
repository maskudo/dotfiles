return {
	{
		"echasnovski/mini.ai", -- {a,i} movements for text objects
		event = "VeryLazy",
		config = function()
			require("mini.ai").setup()
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "BufEnter",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},

	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "BufEnter",
		config = function()
			require("mini.pairs").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		version = "*",
		event = "BufEnter",
		config = function()
			require("mini.surround").setup()
		end,
	},

	{
		"NvChad/nvim-colorizer.lua",
		event = "BufEnter",
		config = function()
			require("colorizer").setup({
				user_default_options = {
					css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
					tailwind = true, -- Enable tailwind colors
				},
			})
		end,
	},

	{
		"barrett-ruth/live-server.nvim",
		build = "pnpm i --global live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
		lazy = true,
	},

	{
		"BartSte/nvim-project-marks",
		lazy = false,
		config = function()
			-- Get the name of the current working directory.
			local function cwd_name()
				return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
			end

			require("projectmarks").setup({
				shadafile = "~/.local/share/nvim/shadas/" .. cwd_name() .. ".shada",
			})
		end,
	},
	{
		"luckasRanarison/nvim-devdocs",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		cmd = {
			"DevdocsInstall",
			"DevdocsOpen",
		},
		opts = {
			previewer_cmd = "glow",
		},
		keys = {
			{
				"<leader>ho",
				mode = { "n" },
				":DevdocsOpen<CR>",
				desc = "DevDocs Open",
			},
			{
				"<leader>hi",
				mode = { "n" },
				":DevdocsInstall<CR>",
				desc = "DevDocs Install",
			},
		},
	},
}
