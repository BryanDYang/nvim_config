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

" Commenting Plugin
Plug 'numToStr/Comment.nvim'

" Auto Pairs (Bracket Completion)
Plug 'windwp/nvim-autopairs'

" Auto-completion Plugin
Plug 'hrsh7th/nvim-cmp'           " Main completion plugin
Plug 'hrsh7th/cmp-nvim-lsp'       " LSP completion source
Plug 'hrsh7th/cmp-buffer'         " Buffer completion source
Plug 'hrsh7th/cmp-path'           " Path completion source
Plug 'hrsh7th/cmp-cmdline'        " Command-line completion
Plug 'L3MON4D3/LuaSnip'           " Snippet engine
Plug 'saadparwaiz1/cmp_luasnip'   " Snippet completion source
Plug 'windwp/nvim-autopairs'      " Bracket auto-completion (already added)

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

-- ------------------------------
-- Comment.nvim Plugin
-- ------------------------------
local status_comment, comment = pcall(require, "Comment")
if status_comment then
  comment.setup()
else
  print("Comment.nvim is not installed")
end

-- ========================================================================
-- 6. AUTO PAIRS (Bracket Completion)
-- ========================================================================
local status_autopairs, autopairs = pcall(require, "nvim-autopairs")
if status_autopairs then
  autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" }, -- Disable in certain file types
    check_ts = true, -- Use treesitter integration
    map_cr = true,   -- Auto insert closing bracket after Enter
    fast_wrap = {},  -- Enables fast wrap feature (Alt-E by default)
  })
else
  print("nvim-autopairs is not installed")
end

-- If using nvim-cmp (autocompletion), integrate it with autopairs
local cmp_autopairs_status, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if cmp_autopairs_status then
  local cmp_status, cmp = pcall(require, "cmp")
  if cmp_status then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end
end

-- ========================================================================
-- 7. AUTOCOMPLETE CONFIGURATION (nvim-cmp)
-- ========================================================================
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  print("nvim-cmp is not installed")
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  print("LuaSnip is not installed")
  return
end

require("luasnip.loaders.from_vscode").lazy_load() -- Load friendly snippets

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- Use LuaSnip as the snippet engine
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion
    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Confirm selection
    ["<Tab>"] = cmp.mapping.select_next_item(), -- Navigate down
    ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- Navigate up
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" }, -- LSP-based completion
    { name = "luasnip" }, -- Snippet completion
    { name = "buffer" }, -- Buffer words
    { name = "path" }, -- File path completion
  }),
})

-- Command-line completion
cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
    { name = "cmdline" },
  }),
})

-- Integrate with nvim-autopairs
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
