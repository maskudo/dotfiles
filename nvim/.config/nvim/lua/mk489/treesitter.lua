local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end
configs.setup {
  ensure_installed = { "c", "cpp", "javascript", "html", "css", "rust", "lua", "bash", "typescript", "tsx" },
  sync_install = false,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,

  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  indent = { enable = true, disable = { "yaml" } },
  autotag = {
    enable = true,
  },
}
vim.api.nvim_create_augroup("rainbow", {
  clear = true,
})
vim.api.nvim_create_autocmd({ "Filetype" }, {
  pattern = "*",
  callback = function()
    vim.api.nvim_set_hl(0, "rainbowcol1", {
      bold = true,
      fg = "#c5c6d0",
    })
  end,
  group = "rainbow",
})
