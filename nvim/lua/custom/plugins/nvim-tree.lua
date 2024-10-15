return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("nvim-tree").setup({
			view = {
				width = {
					min = 30,
					max = 50,
				},
				relativenumber = true,
			},
			renderer = {
				group_empty = true,
				highlight_git = true,
				icons = {
					show = {
						git = true,
					},
				},
			},
			filters = {
				dotfiles = false,
			},
			git = {
				ignore = false,
			},
			actions = {
				open_file = {
					quit_on_open = false,
				},
			},
		})

		-- Custom highlights
		vim.cmd([[highlight NvimTreeGitIgnored guifg=#808080 ctermfg=grey]])

		-- Keymaps
		vim.keymap.set(
			"n",
			"<leader>ft",
			":NvimTreeToggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle file explorer" }
		)
		vim.keymap.set(
			"n",
			"<leader>ff",
			":NvimTreeFindFile<CR>",
			{ noremap = true, silent = true, desc = "Find current file in explorer" }
		)
	end,
}
