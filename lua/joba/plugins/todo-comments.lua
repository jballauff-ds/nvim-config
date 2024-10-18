return {
   "folke/todo-comments.nvim",
   event = { "BufReadPre", "BufNewFile" },
   dependencies = { "nvim-lua/plenary.nvim" },
   config = function()
      local todo_comments = require("todo-comments")
      require("joba.core.mappings").setup("todo_comments")    -- set keymaps
      todo_comments.setup()
   end,
}
