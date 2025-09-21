return {
  "nvim-treesitter/nvim-treesitter",
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    -- Tell Treesitter to use the markdown parser for mdx files
    vim.treesitter.language.register("markdown", "mdx")
  end,
}
