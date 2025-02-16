return {
	{
		dir = "~/dev/lua/devdocs.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
		opts = {
			ensure_installed = {
				"go",
				"html",
			},
		},
	},

	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "BufEnter",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},

	{
		"MagicDuck/grug-far.nvim",
		lazy = true,
		cmd = { "GrugFar" },
		keys = {
			{
				"<leader>fr",
				mode = { "n", "x", "o" },
				"<cmd>GrugFar<cr>",
				desc = "Flash",
			},
		},
		opts = {},
	},

	{
		"folke/flash.nvim",
		event = "VeryLazy",
		enabled = false,
		---@type Flash.Config
		opts = {
			modes = {
				char = {
					enabled = false, -- Disable character motions (like `f`, `t`, `F`, `T`)
				},
				search = {
					enabled = false, -- Disable search motions (`/`, `?`)
				},
			},
		},
    -- stylua: ignore
    keys = {
      { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		enabled = false,
		opts = {
			views = {
				cmdline_input = {
					view = "cmdline_popup",
					relative = "cursor",
					anchor = "auto",
					size = { min_width = 30, width = "auto", height = "auto" },
				},
			},
			presets = {
				command_palette = {
					views = {
						cmdline_popup = {
							position = {
								row = 10,
							},
						},
						cmdline_popupmenu = {
							position = {
								row = 10,
							},
						},
					},
				},
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
	},
}
