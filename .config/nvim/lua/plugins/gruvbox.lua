return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000, -- load before all other UI plugins
  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      contrast = "hard", -- #1d2021 background for sharper text contrast
      transparent_mode = false, -- blocks pywal terminal background bleed
      overrides = {
        -- Boost visibility of comments and line numbers
        Comment = { fg = "#a89984", italic = true },
        LineNr = { fg = "#7c6f64" },
        CursorLineNr = { fg = "#fabd2f", bold = true },
      },
    })

    vim.o.background = "dark"
    vim.cmd.colorscheme("gruvbox")
  end,
}
