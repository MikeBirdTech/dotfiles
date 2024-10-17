return {
	"ggandor/leap.nvim",
	config = function()
		local leap = require("leap")

		-- Set up bidirectional search with 'gs'
		vim.keymap.set({ "n", "x", "o" }, "gs", function()
			leap.leap({ target_windows = { vim.fn.win_getid() } })
		end, { desc = "Leap in current window" })

		-- Keep 'S' for searching in all windows
		vim.keymap.set({ "n", "x", "o" }, "gS", function()
			leap.leap({
				target_windows = vim.tbl_filter(function(win)
					return vim.api.nvim_win_get_config(win).focusable
				end, vim.api.nvim_tabpage_list_wins(0)),
			})
		end, { desc = "Leap in all windows" })

		-- Optional: make highlights subtle
		vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		vim.api.nvim_set_hl(0, "LeapMatch", {
			fg = "grey",
			bold = true,
			nocombine = true,
		})
	end,
}
