-- Telescope fuzzy finding (all the things)
return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "make",
				cond = vim.fn.executable("make") == 1,
				event = "VeryLazy",
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					mappings = {
						i = {
							["<C-u>"] = false,
							["<C-d>"] = false,
						},
					},
				},
			})

			-- Enable telescope fzf native, if installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "git_worktree")

			local map = require("helpers.keys").map
			map("n", "<leader>fr", require("telescope.builtin").oldfiles, "Recently opened")
			map("n", "<leader>/", function()
				-- You can pass additional configuration to telescope to change theme, layout, etc.
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, "Search in current buffer")

			map("n", "<leader>ff", require("telescope.builtin").find_files, "Files")
			map("n", "<leader><space>", require("telescope.builtin").buffers, "Buffers")
			map("n", "<leader>.", require("telescope.builtin").git_files, "Git Files")
			map("n", "<leader>fh", require("telescope.builtin").help_tags, "Help")
			map("n", "<leader>fc", require("telescope.builtin").git_commits, "Git Commits")
			map("n", "<leader>fg", require("telescope.builtin").git_files, "Git Files")
			map("n", "<leader>fs", require("telescope.builtin").git_status, "Git Status")
			-- map("n", "<C-f>", require("telescope.builtin").git_files, "Git Files")
			map("n", "<leader>f/", require("telescope.builtin").live_grep, "Grep")
			map("n", "<leader>/", require("telescope.builtin").live_grep, "Grep")
			map("n", "<leader>fb", require("telescope.builtin").buffers, "Buffers")
			map("n", "<leader>fd", require("telescope.builtin").diagnostics, "Diagnostics")
			map("n", "<leader>fk", require("telescope.builtin").keymaps, "Search keymaps")
		end,
	},
}
