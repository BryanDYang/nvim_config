-- ========================================================================
-- 1. BASIC SETTINGS
-- ========================================================================
vim.o.termguicolors = true  -- Enable true color support
vim.o.background = "dark"   -- Set background to dark or light
vim.o.number = true         -- Show line numbers
vim.o.relativenumber = true -- Show relative line numbers

-- ------------------------------
-- Indentation Settings
-- ------------------------------
vim.o.tabstop = 4           -- Set tab width to 4 spaces
vim.o.shiftwidth = 4        -- Set indentation width to 4 spaces
vim.o.softtabstop = 4       -- Make tab key behave as 4 spaces
vim.o.expandtab = true      -- Convert tabs to spaces
vim.o.smartindent = true    -- Enable smart indentation
vim.o.autoindent = true     -- Maintain indentation from previous line
vim.o.shiftround = true     -- Round indent to nearest multiple of shiftwidth

-- Language-specific indentation
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "python", "lua", "javascript", "html", "css", "json" },
    command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab"
})

-- ========================================================================
-- 2. ENSURE VIM-PLUG IS INSTALLED
-- ========================================================================
local plug_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim"
if not vim.loop.fs_stat(plug_path) then
  vim.fn.system({
    "curl", "-fLo", plug_path,
    "--create-dirs", "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  })
end

-- ========================================================================
-- 3. LOAD PLUGINS USING VIM-PLUG
-- ========================================================================
vim.cmd [[
call plug#begin('~/.local/share/nvim/plugged')

" File Explorer
Plug 'nvim-tree/nvim-tree.lua'

" Aesthetic Theme
Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

" Fuzzy Finder
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'nvim-lua/plenary.nvim'

call plug#end()
]]

-- ========================================================================
-- 4. INSTALL PLUGINS IF NOT INSTALLED
-- ========================================================================
vim.cmd("autocmd VimEnter * PlugInstall --sync | source $MYVIMRC")

-- ========================================================================
-- 5. LOAD CONFIGURATION FOR PLUGINS
-- ========================================================================

-- ------------------------------
-- nvim-tree (File Explorer)
-- ------------------------------
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if status_ok then
  nvim_tree.setup({
    view = {
      width = 30,
      side = "left",
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = { git = true },
      },
    },
    actions = {
      open_file = { quit_on_open = true },
    },
  })
  -- Keybinding for opening file explorer
  vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
else
  print("nvim-tree is not installed")
end

-- ------------------------------
-- Telescope (Fuzzy Finder)
-- ------------------------------
local status_telescope, telescope = pcall(require, 'telescope')
if status_telescope then
  telescope.setup({
    defaults = {
      file_ignore_patterns = { "node_modules", ".git" },
      mappings = {
        i = {
          ["<C-u>"] = false, -- Clear input
          ["<C-d>"] = false, -- Scroll down
        },
      },
    },
  })
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
else
  print("Telescope is not installed")
end

-- ------------------------------
-- Colors and Theme (Catppuccin)
-- ------------------------------
local status_catppuccin, catppuccin = pcall(require, "catppuccin")
if status_catppuccin then
  catppuccin.setup({
    flavour = "mocha",
    transparent_background = false,
    integrations = {
      telescope = true,
      nvimtree = true,
    },
  })
  vim.cmd("colorscheme catppuccin-mocha")
else
  print("Catppuccin theme is not installed")
end

use 'numToStr/Comment.nvim'
require('Comment').setup()

