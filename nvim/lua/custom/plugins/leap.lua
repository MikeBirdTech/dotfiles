return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")

		-- Set up bidirectional search with 's'
		vim.keymap.set({ "n", "x", "o" }, "s", function()
			leap.leap({ target_windows = { vim.fn.win_getid() } })
		end)

		-- Keep 'S' for searching in all windows
		vim.keymap.set({ "n", "x", "o" }, "S", function()
			leap.leap({
				target_windows = vim.tbl_filter(function(win)
					return vim.api.nvim_win_get_config(win).focusable
				end, vim.api.nvim_tabpage_list_wins(0)),
			})
		end)

		-- Optional: make highlights subtle
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "grey",
			bold = true,
			nocombine = true,
		})
	end,
}
