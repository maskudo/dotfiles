return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	event = "VeryLazy",
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"ansiblels",
				"clangd",
				"cssls",
				"dockerls",
				"emmet_ls",
				"eslint",
				"gopls",
				"lua_ls",
				"pyright",
				"rust_analyzer",
				"tailwindcss",
				"tsserver",
				"terraformls",
				"nil_ls",
				"markdown_oxide",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"black", -- python formatter
				"pylint",
				"eslint_d",
				"ansible-lint",
				"flake8",
				"gofumpt",
				"mypy",
				"pyright",
				"ruff",
				"shellcheck",
				"shfmt",
				"tflint",
				-- debuggers
				"js-debug-adapter",
			},
		})
	end,
}
