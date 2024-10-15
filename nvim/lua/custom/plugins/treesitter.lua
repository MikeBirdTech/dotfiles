return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs",
	opts = {
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"go",
			"html",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"vim",
			"vimdoc",
			"javascript",
			"typescript",
			"tsx",
			"json",
			"yaml",
		},
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
			-- Python is not disabled here, allowing Treesitter to handle its indentation
		},
		-- Enable incremental selection
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn", -- start the selection
				node_incremental = "grn", -- increment to the upper named parent
				scope_incremental = "grc", -- increment to the upper scope
				node_decremental = "grm", -- decrement to the previous node
			},
		},
		-- Enable syntax aware text-objects
		textobjects = {
			select = {
				enable = true,
				lookahead = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
		},
	},
	-- Add these plugins for enhanced functionality
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-context",
	},
}
