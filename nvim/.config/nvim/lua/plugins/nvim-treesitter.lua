return {
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "master",
		branch = "main",
		lazy = false,
		-- build = ":TSUpdate",
		build = function()
			-- require("nvim-treesitter.install").update({ with_sync = true })
			require("nvim-treesitter").install({
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"javascript",
				"html",
				"yaml",
				"json",
				"typescript",
				"tsx",
				"css",
			})
		end,
		-- config = function()
		-- 	require("nvim-treesitter.configs").setup({
		-- 		ensure_installed = {
		-- 			"c",
		-- 			"lua",
		-- 			"vim",
		-- 			"vimdoc",
		-- 			"query",
		-- 			"markdown",
		-- 			"markdown_inline",
		-- 			"javascript",
		-- 			"html",
		-- 			"yaml",
		-- 			"json",
		-- 			"typescript",
		-- 			"tsx",
		-- 			"css",
		-- 		},
		-- 		sync_install = false,
		-- 		auto_install = true,
		-- 		highlight = {
		-- 			enable = true,
		-- 			disable = function(lang, buf)
		-- 				local max_filesize = 100 * 1024 -- 100 KB
		-- 				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
		-- 				if ok and stats and stats.size > max_filesize then
		-- 					return true
		-- 				end
		-- 			end,
		-- 			additional_vim_regex_highlighting = false,
		-- 		},
		-- 		incremental_selection = {
		-- 			enable = true,
		-- 			keymaps = {
		-- 				init_selection = "<Enter>",
		-- 				node_incremental = "<Enter>",
		-- 				scope_incremental = false,
		-- 				node_decremental = "<Backspace>",
		-- 			},
		-- 		},
		-- 	})
		-- end,
		config = function()
			local configs = require("nvim-treesitter.install")

			configs.update({
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"markdown",
					"markdown_inline",
					"javascript",
					"html",
					"yaml",
					"json",
					"typescript",
					"tsx",
					"css",
				},
				auto_install = true,
			})

			--- Setup Highlighting
			vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
				callback = function()
					local buf = vim.api.nvim_get_current_buf()
					local lang = vim.bo.filetype

					-- Max filesize check (100KB)
					local max_filesize = 100 * 1024
					local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stats and stats.size > max_filesize then
						return
					end

					-- Start Treesitter highlighting
					pcall(vim.treesitter.start, buf)
				end,
			})

			--- Setup Incremental Selection
			-- Note: The new branch may require manual keymaps for this
			-- vim.keymap.set("n", "<Enter>", function()
			-- 	require("nvim-treesitter.incremental_selection").init_selection()
			-- end, { desc = "Init Selection" })
			--
			-- vim.keymap.set("x", "<Enter>", function()
			-- 	require("nvim-treesitter.incremental_selection").node_incremental()
			-- end, { desc = "Increment Selection" })
			--
			-- vim.keymap.set("x", "<Backspace>", function()
			-- 	require("nvim-treesitter.incremental_selection").node_decremental()
			-- end, { desc = "Decrement Selection" })
		end,
	},
}
