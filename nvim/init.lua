-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- [[ Setting options ]]
require('options')


-- [[ Installing Packages ]]
require('packages')


-- [[ Basic Keymaps ]]
require('keybinds')

