return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme rose-pine-moon")

      -- Enable transparency for common highlight groups
      local groups = {
        "Normal",
        "NormalNC",
        "NormalFloat",
        "EndOfBuffer",
        "SignColumn",
        "MsgArea",
        "MsgSeparator",
        "FloatBorder",
        "StatusLine",
        "StatusLineNC",
        "VertSplit",
        "WinSeparator",
      }
      for _, group in ipairs(groups) do
        vim.api.nvim_set_hl(0, group, { bg = "none" })
      end
    end,
  },
}
