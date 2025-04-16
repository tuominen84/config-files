
return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
}
