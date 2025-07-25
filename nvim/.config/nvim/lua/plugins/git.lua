return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      current_line_blame = true,
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "▎" },
        topdelete = { text = "▎" },
        changedelete = { text = "▎" },
        untracked = { text = "┆" },
      },
      signs_staged_enable = true,
      attach_to_untracked = true,
      on_attach = function()
        local gs = package.loaded.gitsigns
        local map = require("helpers.keys").map

	       -- stylua: ignore start
	       map("n", "]h", ":Gitsigns next_hunk<CR>", "Next Hunk")
	       map("n", "[h",":Gitsigns prev_hunk<CR>" , "Prev Hunk")
	       map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
	       map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
	       map("n", "<leader>gS", gs.stage_buffer, "Stage Buffer")
	       map("n", "<leader>gu", gs.undo_stage_hunk, "Undo Stage Hunk")
	       map("n", "<leader>gq", ":Gitsigns setqflist all<CR>", "All hunks to qflist")
	       map("n", "<leader>gR", gs.reset_buffer, "Reset Buffer")
	       map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
	       map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
	       map("n", "<leader>gd", gs.diffthis, "Diff This")
	       map("n", "<leader>gD", function() gs.diffthis("~") end, "Diff This ~")
	       map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	       map({ "o", "x" }, "ah", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	       map("n", "<leader>ga", "<cmd>silent !git add %<cr><cmd>silent Gitsigns refresh<CR>", "Git Add This File")
	       map({'o', 'x'}, 'ih', '<Cmd>Gitsigns select_hunk<CR>', "Hunk object")
      end,
    },
  },
}
