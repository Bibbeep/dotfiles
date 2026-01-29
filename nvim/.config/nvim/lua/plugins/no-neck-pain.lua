return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	cmd = "NoNeckPain",
	config = function()
		require("no-neck-pain").setup({
			mappings = {
				-- When `true`, creates all the mappings that are not set to `false`.
				---@type boolean
				enabled = true,
				-- Sets a global mapping to Neovim, which allows you to toggle the plugin.
				-- When `false`, the mapping is not created.
				---@type string
				toggle = "<leader>np",
				-- Sets a global mapping to Neovim, which allows you to toggle the left side buffer.
				-- When `false`, the mapping is not created.
				---@type string
				toggleLeftSide = "<leader>nql",
				-- Sets a global mapping to Neovim, which allows you to toggle the right side buffer.
				-- When `false`, the mapping is not created.
				---@type string
				toggleRightSide = "<leader>nqr",
				-- Sets a global mapping to Neovim, which allows you to increase the width (+5) of the main window.
				-- When `false`, the mapping is not created.
				---@type string | { mapping: string, value: a number }
				widthUp = "<leader>n=",
				-- Sets a global mapping to Neovim, which allows you to decrease the width (-5) of the main window.
				-- When `false`, the mapping is not created.
				---@type string | { mapping: string, value: a number }
				widthDown = "<leader>n-",
				-- Sets a global mapping to Neovim, which allows you to toggle the scratchPad feature.
				-- When `false`, the mapping is not created.
				---@type string
				scratchPad = "<leader>ns",
			},
		})
	end,
}
