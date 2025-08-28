vim.opt.number = true
vim.opt.relativenumber = true
vim.o.signcolumn = "yes"

vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.g.mapleader = " "
vim.o.winborder = "rounded"


vim.keymap.set('n', '<leader>o', ':update<CR>:source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')
vim.keymap.set('n', '<leader>h', ':Pick help<CR>')
vim.keymap.set('n', '<leader>e', ':Oil<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
vim.keymap.set('n', '<leader>p', ':TypstPreview<CR>')

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/Exafunction/windsurf.nvim.git" },
	{ src = "https://github.com/nvim-lua/plenary.nvim.git" },
	{ src = "https://github.com/hrsh7th/nvim-cmp.git" },
})

require "mini.pick".setup()
require "oil".setup()
require 'lspconfig'.lua_ls.setup {}
require 'lspconfig'.pyright.setup {}
require 'lspconfig'.tinymist.setup {}
require 'cmp'.setup({
	-- ...
	sources = {
		-- ...
		{ name = "codeium" }
	}
})
require 'plenary'
require("codeium").setup({
    -- Optionally disable cmp source if using virtual text only
    enable_cmp_source = false,
    virtual_text = {
        enabled = true,

        -- These are the defaults

        -- Set to true if you never want completions to be shown automatically.
        manual = false,
        -- A mapping of filetype to true or false, to enable virtual text.
        filetypes = {},
        -- Whether to enable virtual text of not for filetypes not specifically listed above.
        default_filetype_enabled = true,
        -- How long to wait (in ms) before requesting completions after typing stops.
        idle_delay = 55,
        -- Priority of the virtual text. This usually ensures that the completions appear on top of
        -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
        -- desired.
        virtual_text_priority = 65535,
        -- Set to false to disable all key bindings for managing completions.
        map_keys = true,
        -- The key to press when hitting the accept keybinding but no completion is showing.
        -- Defaults to \t normally or <c-n> when a popup is showing. 
        accept_fallback = nil,
        -- Key bindings for managing completions in virtual text mode.
        key_bindings = {
            -- Accept the current completion.
            accept = "<Tab>",
            -- Accept the next word.
            accept_word = false,
            -- Accept the next line.
            accept_line = false,
            -- Clear the virtual text.
            clear = false,
            -- Cycle to the next completion.
            next = "<M-]>",
            -- Cycle to the previous completion.
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

-- 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
