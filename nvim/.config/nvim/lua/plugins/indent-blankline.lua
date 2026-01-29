return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = false,
	main = "ibl",
	---@module "ibl"
	---@type ibl.config
	opts = {
		indent = {
			char = "▏",
			highlight = { "IblGray" },
		},
	},
	config = function(_, opts)
		-- Define a custom highlight group for a gray color
		vim.api.nvim_set_hl(0, "IblGray", {
			fg = "#717C7C",
			nocombine = true,
			blend = 0,
		})
		require("ibl").setup(opts)
	end,
	-- #494645 #3b4252 #2c323c #717C7C
}
