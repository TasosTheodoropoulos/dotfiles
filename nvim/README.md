# 🌌 Neovim Nightly Config (Native Pack)

A lightweight, high-performance Neovim configuration built for **Neovim Nightly (v0.11+)**. 

This setup eschews complex package managers in favor of Neovim's native `vim.pack.add` system, making it incredibly fast and stable on immutable Linux systems like **Bazzite** or Fedora Silverblue.

## ✨ Features

* **⚡ Native Performance:** Uses Neovim's built-in package handling (no `lazy.nvim` or `packer` required).
* **🧠 AI Powered:** Integrated **Codeium** for ultra-fast AI autocompletion.
* **🐍 Python Ready:** Full LSP support with `pylsp` and `ruff` (via Mason).
* **🌗 Theme Toggle:** Switch between the transparent **Vague** theme and your **Terminal** colors with `<leader>bg`.
* **📝 Live Previews:**
    * **Markdown:** Instant browser preview with `<leader>m`.
    * **Typst:** Live compilation and preview with `<leader>p`.

## 🛠️ Prerequisites

Since this config is optimized for Linux (specifically Bazzite), ensure you have these system tools installed:

1.  **Neovim Nightly:** (v0.11 or newer)
2.  **Ripgrep:** Required for file searching.
3.  **Node.js & npm:** Required for Markdown preview and Mason LSPs.
4.  **Python Provider:** Required for Neovim python plugins.

```bash
# Bazzite / Homebrew
brew install ripgrep node

# Python Provider
pip install --user pynvim
```

## 🚀 Installation

1.  **Back up your old config:**
    ```bash
    mv ~/.config/nvim ~/.config/nvim.bak
    mv ~/.local/share/nvim ~/.local/share/nvim.bak
    ```

2.  **Clone this repository:**
    ```bash
    git clone [https://github.com/YOUR_USERNAME/dotfiles-nvim.git](https://github.com/YOUR_USERNAME/dotfiles-nvim.git) ~/.config/nvim
    ```

3.  **First Launch Setup:**
    Open Neovim. You will see errors on the first startup because plugins are downloading.
    * Wait 1 minute for **Mason** to install language servers (`pylsp`, `lua_ls`, etc.).
    * Restart Neovim.

## ⌨️ Keymappings

**Leader Key:** `<Space>`

| Key | Action |
| :--- | :--- |
| `<Space>f` | **Find Files** (Fuzzy search) |
| `<Space>e` | **Explorer** (Oil.nvim) |
| `<Space>m` | **Markdown Preview** (Toggle) |
| `<Space>p` | **Typst Preview** (Toggle) |
| `<Space>bg` | **Toggle Theme** (Vague / Terminal) |
| `<Space>lf` | **LSP Format** current buffer |
| `<Space>h` | **Help** tags search |
| `<Space>y` | **Copy** to system clipboard |
| `<Space>d` | **Cut** to system clipboard |
| `<Space>o` | **Reload** config (`source $MYVIMRC`) |

## 🔧 Troubleshooting

### Markdown Preview Error (`ENOTDIR`)
If you see an `ENOTDIR` error or the preview doesn't open on Linux/Bazzite, it is due to a broken pre-compiled binary in the plugin. Run this command to force it to use the system Node.js:

```bash
rm -rf ~/.local/share/nvim/site/pack/*/opt/markdown-preview/app/bin
```

### Python LSP Warnings
If `:checkhealth` complains about python providers, ensure you have installed the neovim python client:
```bash
pip install --user pynvim
```

## 📦 Plugin List

* **Theme:** `vague.nvim`
* **LSP/Mason:** `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig`
* **Completion:** `nvim-cmp`, `codeium.nvim`
* **Utils:** `oil.nvim` (File manager), `mini.pick` (Fuzzy finder)
* **Lang:** `typst-preview.nvim`, `markdown-preview.nvim`
