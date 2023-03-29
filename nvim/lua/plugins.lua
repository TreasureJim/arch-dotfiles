local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

vim.opt.runtimepath:prepend(lazypath)

local ok, lazy = pcall(require, "lazy")
if not ok then return end

lazy.setup({

	-- colorscheme
  { "navarasu/onedark.nvim" },
	{ "folke/tokyonight.nvim"},

	-- LSP
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/nvim-cmp",
    }
  },
  {
    "glepnir/lspsaga.nvim",
    branch = "main",
    event = "BufRead",
  },

	-- Bottom status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "kyazdani42/nvim-web-devicons"
    }
  },


	-- Status line for each buffer at top
  "akinsho/bufferline.nvim",

	-- File browser
  { "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    }
  },

	-- Adds indentation to new lines
  { "lukas-reineke/indent-blankline.nvim", event = "BufEnter" },

	-- Parses files for lsp
		-- Automatically installs lsps for you
  "nvim-treesitter/nvim-treesitter",

	-- Automatically closes html tags
  -- "windwp/nvim-ts-autotag",

	-- Finishes pair for eg. (), "", '', etc.
  { "windwp/nvim-autopairs", config = true, event = "InsertEnter" },

	-- telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
  },
  "nvim-telescope/telescope-ui-select.nvim",


	-- For easier commenting
  -- { "numToStr/Comment.nvim", config = true, event = "BufEnter" },
	{"preservim/nerdcommenter"},

  { "phaazon/hop.nvim", branch = "v2", config = true, event = "BufEnter" },
  { "lewis6991/gitsigns.nvim", config = true, event = "BufEnter" },
  { "iamcco/markdown-preview.nvim", ft = "markdown" },

  {
    "karb94/neoscroll.nvim",
    event = "BufEnter",
    enabled = false
  },

  "goolord/alpha-nvim",
  "David-Kunz/markid",
  "nvim-treesitter/nvim-treesitter-textobjects",
  {
    "kylechui/nvim-surround",
    config = true
  },
})
