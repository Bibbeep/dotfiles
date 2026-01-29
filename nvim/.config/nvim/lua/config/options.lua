vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab
vim.opt.colorcolumn = "80" -- Enable vertical wrap line

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show line under cursor
vim.opt.cursorline = true

-- Store undos between sessions
vim.opt.undofile = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
vim.opt.listchars = {
	tab = "» ",
	trail = "·",
	nbsp = "␣",
}

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Verify "GUI" Support in Terminal
vim.opt.termguicolors = true

-- Add these for undercurl support in tmux/Windows Terminal
vim.cmd([[let &t_Cs = "\ePtmux;\e\e[4:3m\e\\"]])
vim.cmd([[let &t_Ce = "\ePtmux;\e\e[4:0m\e\\"]])

-- Filetypes
vim.filetype.add({
	extension = {
		["http"] = "http",
	},
})

-- Configure uniform colorscheme across all UI components
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Sets the border of the floating window
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none", fg = "#565f89" })
		-- Sets the border of the floating blink completion menu window
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { bg = "none", fg = "#565f89" })

		local groups = {
			-- Standard
			"NormalFloat",
			"FloatBorder",

			-- Noice
			"NoiceLspProgressWindow",
			"NoiceLspProgressClient",
			"NoiceLspProgressSpinner",
			"NoiceLspProgressTitle",
			"NoiceMini",
			"NoiceMiniBorder",

			-- Lazy
			"LazyNormal",
			"LazyBorder",

			-- Mason
			"MasonNormal",
			"MasonBorder",

			-- Blink.cmp
			"BlinkCmpMenu",
			"BlinkCmpDoc",
			"BlinkCmpDocBorder",
			"BlinkCmpSignatureHelp",
			"BlinkCmpSignatureHelpBorder",
		}

		for _, group in ipairs(groups) do
			-- This makes the background match your editor and keeps the border line visible
			vim.api.nvim_set_hl(0, group, { bg = "none" })
		end
	end,
})

-- Direct opening browser to Windows's default browser
if vim.fn.has("wsl") == 1 then
	vim.g.browse_command = "wslview"
end
