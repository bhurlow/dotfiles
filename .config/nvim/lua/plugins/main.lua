return {
  { "nvim-lua/lsp-status.nvim" },
  { "arkav/lualine-lsp-progress" },
  { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter" },
  { "PaterJason/nvim-treesitter-sexp" },
  { "nvim-lua/lsp-status.nvim" },
  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
    -- init is called during startup. Configuration for vim plugins typically should be set in an init function
    init = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = false,
        --on_colors = function(colors)
          --	colors.bg = "#000000"
          --	colors.bg_dark = "#000000"
          --	colors.bg_float = "#000000"
          --	colors.bg_popup = "#000000"
          --	colors.bg_search = "#000000"
          --	colors.bg_sidebar = "#000000"
          --	colors.bg_statusline = "#000000"
          --end,
        })
        vim.cmd.colorscheme("tokyonight-moon")
      end,
    },
    { "nvim-tree/nvim-web-devicons" },
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({})
      end
    }
  }
