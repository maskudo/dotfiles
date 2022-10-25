-- nvim-tree: disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("mk489.set")
require("mk489.remap")
require("mk489.telescope")
require("mk489.treesitter")
require("mk489.indent-blankline")
require("mk489.gitsigns")
require("mk489.nvim-tree")
require("mk489.toggleterm")
require("mk489.lualine")
require("mk489.wilder")
require("mk489.lsp-zero")
require("mk489.impatient")
require("mk489.comment")
require("mk489.leap")
require("mk489.barbar")
