return {
	"Pocco81/true-zen.nvim",
	config = function()
		 require("true-zen").setup {
			modes = {
				options = {
					number = true,
					relativenumber = true,
					ruler = true,
				},
			},
		 }
	end,
}

