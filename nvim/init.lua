-- =============================================================================
-- 1. PRE-CONFIGURATION (Clean Health Check)
-- =============================================================================
-- Disable unused providers to stop health check warnings on Bazzite
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- =============================================================================
-- 2. GENERAL SETTINGS
-- =============================================================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.o.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"

-- =============================================================================
-- 3. KEYMAPS
-- =============================================================================
vim.keymap.set('n', '<leader>o', ':update<CR>:source $MYVIMRC<CR>', { desc = "Save & Source" })
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set('n', '<leader>p', ':TypstPreview<CR>')
-- Markdown Preview Keymap (Leader + m)
vim.keymap.set('n', '<leader>m', ':MarkdownPreviewToggle<CR>', { desc = "Toggle Markdown" })

-- =============================================================================
-- 4. NATIVE PLUGIN LOADING (Nightly)
-- =============================================================================
vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/williamboman/mason.nvim" },
  { src = "https://github.com/williamboman/mason-lspconfig.nvim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/Exafunction/codeium.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/toppair/peek.nvim" },
  
  -- Markdown Preview
  { 
    src = "https://github.com/iamcco/markdown-preview.nvim", 
    name = "markdown-preview", 
  },
})

-- Force load Markdown Preview plugin immediately
vim.cmd("packadd markdown-preview")

-- =============================================================================
-- 5. VISUALS & THEME TOGGLE
-- =============================================================================

-- 1. Setup Vague with Transparency enabled by default
require("vague").setup({
    transparent = true, 
    style = {
        boolean = "bold",
        number = "none",
        float = "none",
        error = "bold",
        comments = "italic",
        conditionals = "none",
        functions = "bold",
        headings = "bold",
        operators = "none",
        strings = "italic",
        variables = "none",
        keywords = "bold",
        keyword_return = "italic",
        keywords_loop = "none",
        keywords_label = "none",
        keywords_exception = "none",
        builtin_constants = "bold",
        builtin_functions = "none",
        builtin_types = "bold",
        builtin_variables = "none",
    },
})

-- 2. Set Initial Colorscheme
vim.opt.termguicolors = true
vim.cmd.colorscheme("vague")
vim.cmd("hi statusline guibg=NONE")
vim.cmd("set laststatus=0")

-- 3. Create the Toggle Keymap (<leader>bg)
vim.keymap.set("n", "<leader>bg", function()
    if vim.g.colors_name == "vague" then
        -- SWITCH TO TERMINAL SCHEME
        vim.opt.termguicolors = false 
        vim.cmd.colorscheme("default")
        
        -- Force transparency on the default scheme
        vim.api.nvim_set_hl(0, "Normal", { bg = "none", ctermbg = "none" })
        vim.api.nvim_set_hl(0, "NonText", { bg = "none", ctermbg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none", ctermbg = "none" })
        
        print("Colors: Terminal")
    else
        -- SWITCH TO VAGUE
        vim.opt.termguicolors = true 
        vim.cmd.colorscheme("vague")
        print("Colors: Vague")
    end
end, { desc = "Toggle Vague/Terminal Theme" })

-- =============================================================================
-- 6. PLUGIN CONFIGURATION
-- =============================================================================

-- Mason Setup (Must run before LSP config)
require("mason").setup()
require("mason-lspconfig").setup({
    -- "pylsp" is the correct name for Mason to install python-lsp-server
    ensure_installed = { "lua_ls", "tinymist", "ruff", "pylsp" }, 
    automatic_installation = true,
})

-- File Picker & File Manager
require("mini.pick").setup()
require("oil").setup()

-- Peek (Typst Preview)
vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})

-- Markdown Preview Configuration (FIXED FOR BAZZITE/LINUX)
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_command_for_global = 1 
vim.g.mkdp_open_to_the_world = 0
vim.g.mkdp_echo_preview_url = 1   

-- FIX: Use a function to open the URL with xdg-open (Default System Browser)
-- This works better than hardcoding 'firefox' on Bazzite/Flatpak systems
vim.g.mkdp_browserfunc = 'MkdpBrowserFunc'

vim.cmd([[
function! MkdpBrowserFunc(url)
  execute 'silent !xdg-open ' . a:url
endfunction
]])

-- =============================================================================
-- 7. LSP & AUTOCOMPLETE
-- =============================================================================
local lspconfig = require('lspconfig')

-- Configure Languages
lspconfig.lua_ls.setup {}
lspconfig.tinymist.setup {}
lspconfig.ruff.setup {} 
lspconfig.pylsp.setup {} 

-- Codeium (AI Autocomplete)
require("codeium").setup({
    enable_cmp_source = false,
    virtual_text = {
        enabled = true,
        manual = false,
        virtual_text_priority = 65535,
        map_keys = true,
        key_bindings = {
            accept = "<Tab>",
            next = "<M-]>",
            prev = "<M-[>",
        }
    }
})


vim.lsp.enable({ "lua_ls", "tinymist", "pylsp", })

-- Add lsp autocomplete functionality
-- auto complete
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client.supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		end
	end,
})
vim.cmd("set completeopt+=noselect")


vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg = NONE")
