-- Themes
return {
  {
    "rose-pine/nvim",
    name = "rose-pine",
    enabled = true,
    lazy = true,
    opts = {
      styles = {
        transparency = true,
      },
      before_highlight = function(_, highlight, _)
        highlight.undercurl = false
      end,
    },
  },
}
