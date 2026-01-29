return {
	"ahmedkhalf/project.nvim",
	cmd = "Project",
	init = function()
		require("project_nvim").setup({
			-- your configuration comes here
			-- or leave it empty
			-- refer to the configuration section below
		})
	end,
}
