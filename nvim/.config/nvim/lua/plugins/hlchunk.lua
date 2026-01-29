return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		chunk = {
			enable = true,
			delay = 0,
		},
		-- blank = {
		-- 	enable = true,
		-- 	chars = {
		-- 		" ",
		-- 	},
		-- 	style = {
		-- 		{ bg = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID("cursorline")), "bg", "gui") },
		-- 		{ bg = "", fg = "" },
		-- 	},
		-- },
	},
	config = function(_, opts)
		require("hlchunk").setup(opts)
	end,
}
