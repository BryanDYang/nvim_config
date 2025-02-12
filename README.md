🌟 Neovim Configuration

This is my custom Neovim configuration, optimized for PowerShell (Windows) and macOS. It includes:

nvim-tree (File Explorer)

telescope.nvim (Fuzzy Finder)

catppuccin.nvim (Beautiful Theme)

vim-plug (Plugin Manager)

🚀 Installation

1. Install Neovim

Windows (via Chocolatey)

choco install neovim

macOS (via Homebrew)

brew install neovim

2. Clone This Repository

git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

3. Install vim-plug (Plugin Manager)

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

4. Install Plugins

Open Neovim and run:

:PlugInstall

5. Install Additional Dependencies

Some plugins require extra dependencies:

brew install ripgrep fd   # macOS
scoop install ripgrep fd  # Windows (if using scoop)

🎨 Features & Keybindings

📂 File Explorer (nvim-tree)

Action

Keybinding

Open File Explorer

<leader>e (Space + e or \ + e)

Create File/Folder

a

Delete File

d

Rename File

r

Refresh

R

🔍 Fuzzy Finder (telescope.nvim)

Action

Keybinding

Find Files

<leader>ff (Space + ff)

Grep Search

<leader>fg (Space + fg)

List Buffers

<leader>fb (Space + fb)

Search Help Tags

<leader>fh (Space + fh)

🎨 Colorscheme (catppuccin)

To change the theme:

:colorscheme catppuccin-mocha

⚙️ Customization

Modify your ~/.config/nvim/init.lua to:

Add new plugins

Change keybindings

Customize appearance

Example: Mapping jj to escape in insert mode

vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

🔄 Syncing Config Across Devices

Push updates to GitHub (on your main machine):

git add .
git commit -m "Updated Neovim config"
git push origin main

Pull the latest config on another system:

cd ~/.config/nvim
git pull origin main

🛠 Troubleshooting

Neovim Doesn’t Detect nvim-tree or telescope.nvim?

Try:

:PlugInstall
:PlugUpdate

Check Plugin Installation Path

:set runtimepath?

Reset Configuration (if needed)

rm -rf ~/.config/nvim ~/.local/share/nvim

Then, clone the config again.

📜 License

This Neovim configuration is open-source. Feel free to modify and improve it!

🚀 Happy coding with Neovim! 🎉

