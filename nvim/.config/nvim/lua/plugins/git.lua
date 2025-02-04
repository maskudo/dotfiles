return {
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signs_staged_enable = true,
			attach_to_untracked = true,
			on_attach = function()
				local gs = package.loaded.gitsigns
				local map = require("helpers.keys").map

        -- stylua: ignore start
        map("n", "]h", ":Gitsigns next_hunk<CR>zz", "Next Hunk")
        map("n", "[h",":Gitsigns prev_hunk<CR>zz" , "Prev Hunk")
        map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>gh", gs.setqflist, "All hunks")
        map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>gd", gs.diffthis, "Diff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
        map("n", "<leader>ga", "<cmd>silent !git add %<cr><cmd>silent Gitsigns refresh<CR>", "Git Add This File")
			end,
		},
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			{
				"sindrets/diffview.nvim", -- optional - Diff integration
				cmd = {
					"DiffviewOpen",
				},
				opts = {
					keymaps = {
						file_panel = {
							{ "n", "q", "<cmd>DiffviewClose<CR>", desc = "Diffview Close" },
						},
					},
				},
			},
		},
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit" },
			{ "<leader>gG", "<cmd>DiffviewOpen<cr>", desc = "Diffview" },
		},
		cmd = {
			"Neogit",
		},
		opts = {
			integrations = {
				diffview = true,
			},
			mappings = {
				status = {
					["="] = "Toggle",
					["[h"] = "GoToPreviousHunkHeader",
					["]h"] = "GoToNextHunkHeader",
				},
			},
		},
	},
}
