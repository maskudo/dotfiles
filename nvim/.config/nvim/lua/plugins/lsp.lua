return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "antosha417/nvim-lsp-file-operations", config = true },
			{
				"williamboman/mason-lspconfig.nvim",
				dependencies = {
					"williamboman/mason.nvim",
				},
			},
		},
		config = function(_, opts)
			-- import lspconfig plugin
			local lspconfig = require("lspconfig")

			-- import mason_lspconfig plugin
			local mason_lspconfig = require("mason-lspconfig")

			local keymap = vim.keymap -- for conciseness

			local border = "single"

			vim.lsp.handlers["textDocument/hover"] =
				vim.lsp.with(vim.lsp.handlers.hover, {
					border = border,
				})

			vim.lsp.handlers["textDocument/signatureHelp"] =
				vim.lsp.with(vim.lsp.handlers.signature_help, {
					border = border,
				})

			vim.diagnostic.config({
				float = { border = border },
			})

			lspconfig.nixd.setup({
				cmd = { "nixd" },
				filetypes = { "nix" },
				root_dir = lspconfig.util.root_pattern(
					"default.nix",
					"shell.nix",
					"flake.nix",
					".git"
				),
				settings = {},
			})

			for server, config in pairs(opts.servers or {}) do
				config.capabilities =
					require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end
			--
			lspconfig.racket_langserver.setup({})

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf, silent = true }

					-- set keybinds

					opts.desc = "LSP Rename"
					keymap.set("n", "gR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)

					opts.desc = "Go to declaration"
					keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

					opts.desc = "Show LSP Signature"
					keymap.set({ "i", "v" }, "<C-k>", vim.lsp.buf.signature_help, opts) -- show lsp function signature

					opts.desc = "See available code actions"
					keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

					opts.desc = "Show line diagnostics"
					keymap.set("n", "<leader>xd", vim.diagnostic.open_float, opts) -- show diagnostics for line

					opts.desc = "Go to previous diagnostic"
					keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

					opts.desc = "Go to next diagnostic"
					keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

					opts.desc = "Show documentation for what is under cursor"
					keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

					opts.desc = "Restart LSP"
					keymap.set("n", "<leader>lr", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

					opts.desc = "LSP Info"
					keymap.set("n", "<leader>li", ":LspInfo<CR>", opts) -- mapping to restart lsp if necessary
				end,
			})

			-- Change the Diagnostic symbols in the sign column (gutter)
			local signs =
				{ Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
			end

			-- local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			mason_lspconfig.setup_handlers({
				-- default handler for installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					-- configure lua server (with special settings)
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								-- make the language server recognize "vim" global
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
				["vtsls"] = function()
					lspconfig["vtsls"].setup({
						capabilities = capabilities,
						settings = {
							vtsls = {
								experimental = {
									completion = {
										enableServerSideFuzzyMatch = true,
										entriesLimit = 10,
									},
								},
							},
						},
					})
				end,
				["markdown_oxide"] = function()
					lspconfig["markdown_oxide"].setup({
						capabilities = vim.tbl_deep_extend("force", capabilities, {
							workspace = {
								didChangeWatchedFiles = {
									dynamicRegistration = true,
								},
							},
						}),
					})
				end,
				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						root_dir = function(fname)
							local root_pattern = require("lspconfig").util.root_pattern(
								"tailwind.config.cjs",
								"tailwind.config.js",
								"postcss.config.js"
							)
							return root_pattern(fname)
						end,
					})
				end,
			})
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
		dependencies = {
			{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
		},
	},
}
