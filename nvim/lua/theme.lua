local ok, onedark = pcall(require, 'onedark')
if not ok then return end

onedark.setup {
  style = 'deep',
  -- transparent = true,
  code_style = {
    comments = 'italic'
  },

term_colors = true,
}

onedark.load()

-- local ok, tokyonight = pcall(require, 'tokyonight')
-- if not ok then return end
-- 
-- tokyonight.setup {
--   style = "night",
--   styles = {
--     comments = { italic = false },
--     keywords = { italic = false },
--     sidebars = "dark",
--     float = "dark",
--   },
--   lualine_bold = true,
--   transparent = true
-- }

-- vim.cmd("colorscheme tokyonight")

-- local ok, gt = pcall(require, 'github-theme')
-- if not ok then return end
-- 
-- gt.setup {
--   theme_style = "dark",
--   comment_style = "none",
--   keyword_style = "none",
--   dark_sidebar = true,
--   colors = { error = '#ff0000' },
--   transparent = true
-- }
