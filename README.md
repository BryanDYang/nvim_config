# 🌟 Neovim Configuration

This is my **custom Neovim configuration**, optimized for **PowerShell (Windows) and macOS**. It includes:
- **nvim-tree** (File Explorer)
- **telescope.nvim** (Fuzzy Finder)
- **catppuccin.nvim** (Beautiful Theme)
- **vim-plug** (Plugin Manager)

---

## 🚀 Installation
### **1. Install Neovim**
#### Windows (via Chocolatey)
```powershell
choco install neovim
```
#### macOS (via Homebrew)
```sh
brew install neovim
```

### **2. Clone This Repository**
```sh
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim
```

### **3. Install `vim-plug` (Plugin Manager)**
```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### **4. Install Plugins**
Open Neovim and run:
```vim
:PlugInstall
```

### **5. Install Additional Dependencies**
Some plugins require extra dependencies:
```sh
brew install ripgrep fd   # macOS
scoop install ripgrep fd  # Windows (if using scoop)
```

---

## 🎨 Features & Keybindings

### **📂 File Explorer (`nvim-tree`)**
| Action | Keybinding |
|--------|-----------|
| Open File Explorer | `<leader>e` (`Space + e` or `\ + e`) |
| Create File/Folder | `a` |
| Delete File | `d` |
| Rename File | `r` |
| Refresh | `R` |

### **🔍 Fuzzy Finder (`telescope.nvim`)**
| Action | Keybinding |
|--------|-----------|
| Find Files | `<leader>ff` (`Space + ff`) |
| Grep Search | `<leader>fg` (`Space + fg`) |
| List Buffers | `<leader>fb` (`Space + fb`) |
| Search Help Tags | `<leader>fh` (`Space + fh`) |

### **🎨 Colorscheme (`catppuccin`)**
To change the theme:
```vim
:colorscheme catppuccin-mocha
```

---

## ⚙️ Customization
Modify your `~/.config/nvim/init.lua` to:
- Add new plugins
- Change keybindings
- Customize appearance

Example: **Mapping `jj` to escape in insert mode**
```lua
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })
```

---

## 🔄 Syncing Config Across Devices
1. **Push updates to GitHub** (on your main machine):
   ```sh
   git add .
   git commit -m "Updated Neovim config"
   git push origin main
   ```
2. **Pull the latest config on another system:**
   ```sh
   cd ~/.config/nvim
   git pull origin main
   ```

---

## 🛠 Troubleshooting
### **Neovim Doesn’t Detect `nvim-tree` or `telescope.nvim`?**
Try:
```vim
:PlugInstall
:PlugUpdate
```

### **Check Plugin Installation Path**
```vim
:set runtimepath?
```

### **Reset Configuration (if needed)**
```sh
rm -rf ~/.config/nvim ~/.local/share/nvim
```
Then, clone the config again.

---

## 📜 License
This Neovim configuration is open-source. Feel free to modify and improve it!

🚀 Happy coding with Neovim! 🎉

