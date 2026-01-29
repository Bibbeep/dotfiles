return {
	"stevearc/dressing.nvim",
	opts = {
		enabled = false,
	},
	config = function(_, opts)
		require("dressing").setup(opts)
	end,
}
