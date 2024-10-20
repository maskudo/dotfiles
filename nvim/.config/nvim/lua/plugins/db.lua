return {
	"kristijanhusak/vim-dadbod-ui",
	lazy = true,
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{
			"kristijanhusak/vim-dadbod-completion",
			ft = { "sql", "mysql", "plsql" },
			lazy = true,
		},
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>do", "<cmd>tabnew<cr><cmd>DBUI<cr>", desc = "Open DB UI" },
		{ "<leader>dt", "<cmd>DBUIToggle<cr>", "Toggle DB UI" },
		{ "<leader>da", "<cmd>DBUIAddConnection<cr>", desc = "Add Connection" },
		{ "<leader>df", "<cmd>DBUIFindBuffer<cr>", desc = "Find Buffer" },
	},
	init = function()
		-- Your DBUI configuration
		vim.g.db_ui_use_nerd_fonts = 1
		vim.g.db_ui_force_echo_notifications = 1
	end,
}
