return {
   "nvim-telescope/telescope.nvim",
   branch = "0.1.x",
   dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
      "folke/todo-comments.nvim",
   },
   config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      require("joba.core.mappings").setup("telescope")
      telescope.setup({
	 defaults = {
	    path_display = { "smart" },
	    mappings = {
	       i = {
		  ["<C-k>"] = actions.move_selection_previous, -- move to prev result
		  ["<C-j>"] = actions.move_selection_next, -- move to next result
	       },
	    },
	 },
      })

      telescope.load_extension("fzf")

   end,
}
