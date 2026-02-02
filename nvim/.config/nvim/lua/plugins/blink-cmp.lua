return {
	{
		"saghen/blink.compat",
		-- use v2.* for blink.cmp v1.*
		version = "2.*",
		-- lazy.nvim will automatically load the plugin when it's required by blink.cmp
		lazy = true,
		-- make sure to set opts so that lazy.nvim calls blink.compat's setup
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"moyiz/blink-emoji.nvim",
			"ray-x/cmp-sql",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			-- keymap = { preset = "default" },
			keymap = {
				preset = "super-tab",
				["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
				-- ["<C-m>"] = { "scroll_signature_up", "fallback" },
				-- ["<C-o>"] = { "scroll_signature_down", "fallback" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			-- completion = { documentation = { auto_show = false } },
			completion = {
				-- accept = {
				-- 	auto_brackets = {
				-- 		enabled = true,
				-- 	},
				-- },
				trigger = {
					show_on_trigger_character = true, -- Shows after typing a trigger character, defined by the sources.
					show_on_keyword = true, -- Shows after typing a keyword, typically an alphanumeric character, - or _
					show_on_insert_on_trigger_character = true, -- Shows after entering insert mode on top of a trigger character.
					show_on_accept_on_trigger_character = true, -- Shows after accepting a completion item, where the cursor ends up on top of a trigger character.
				},
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{
								"kind_icon",
								"label",
								"label_description",
								gap = 1,
							},
							{
								"kind",
							},
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
									return kind_icon
								end,
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
							kind = {
								-- (optional) use highlights from mini.icons
								highlight = function(ctx)
									local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
									return hl
								end,
							},
						},
					},
				},
				documentation = {
					auto_show = false,
					auto_show_delay_ms = 500,
					window = {
						max_width = 50,
						winblend = 100,
						border = "rounded",
					},
				},
				ghost_text = { -- Ghost text shows a preview of the currently selected item as virtual text inline.
					enabled = false,
					-- show_with_menu = false, -- only show when menu is closed
				},
			},
			signature = {
				enabled = true,
				trigger = {
					enabled = true,
					show_on_keyword = false, -- Optional: Adjust behavior
					show_on_trigger_character = true, -- Shows on characters like '(' or ','
					show_on_insert = true, -- Optional: Adjust behavior
					show_on_insert_on_trigger_character = true,
				},
				window = {
					-- winblend = 100,
					max_width = 80,
					border = "rounded", -- Optional: customize appearance
					-- treesitter_highlighting = true, -- Optional: use treesitter for highlighting
					show_documentation = false, -- Optional: set to true to show associated docs
					-- auto_show = true, -- This is the key setting
					-- auto_show_delay_ms = 200, -- Optional: add a short delay
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer", "emoji" },
				providers = {
					lsp = {
						score_offset = 90,
					},
					path = {
						score_offset = 30,
					},
					snippets = {
						score_offset = 20,
					},
					buffer = {
						score_offset = 9,
					},
					emoji = {
						module = "blink-emoji",
						name = "Emoji",
						score_offset = 15, -- Tune by preference
						opts = {
							insert = true, -- Insert emoji (default) or complete its name
							---@type string|table|fun():table
							trigger = function()
								return { ":" }
							end,
						},
						should_show_items = function()
							return vim.tbl_contains(
								-- Enable emoji completion only for git commits and markdown.
								-- By default, enabled for all file-types.
								{ "gitcommit", "markdown" },
								vim.o.filetype
							)
						end,
					},
					sql = {
						-- IMPORTANT: use the same name as you would for nvim-cmp
						name = "sql",
						module = "blink.compat.source",

						-- all blink.cmp source config options work as normal:
						score_offset = -3,

						-- this table is passed directly to the proxied completion source
						-- as the `option` field in nvim-cmp's source config
						--
						-- this is NOT the same as the opts in a plugin's lazy.nvim spec
						opts = {},
						should_show_items = function()
							return vim.tbl_contains(
								-- By default, enabled for all file-types.
								{ "sql" },
								vim.o.filetype
							)
						end,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
