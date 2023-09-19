return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        hls = {},
        astro = {},
        tsserver = {},
      },
      inlay_hints = { enabled = true },
    }
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        config = true,
      }
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, {
        { name = "emoji" },
        { name = "crates" },
        { name = "nvim_lua" },
        { name = "nvim_lsp_signature_help" },
      }))
    end,
  },
}
