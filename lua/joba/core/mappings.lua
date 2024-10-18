vim.g.mapleader = " "
vim.g.maplocalleader = " "
local mp = vim.keymap

--NOTE: global mappings

mp.set("n", "-", vim.cmd.Ex, { desc = "Go to tree" })
mp.set({ "n", "v" }, "<leader>p", '"+p', { nowait = true, desc = "paste from os clipboard" })
mp.set({ "n", "v" }, "<leader>y", '"+y', { nowait = true, desc = "copy to os clipboard" })
mp.set({ "n", "v" }, "<leader>vd", '"_d', { nowait = true, desc = "delete to void" })
mp.set("n", "x", '"_x', { desc = "x always delets to void" })
mp.set("n", "<leader>q", ":bd<cr>", { desc = "close current buffer" })
mp.set("x", "<leader>vp", '"_dP', { desc = "paste over void old" })
mp.set("n", "<leader>m", "@m", { desc = "execute fast macro" })
mp.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection up" })
mp.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection down" })
mp.set("v", ">", ">gv", { desc = "indent and visual mode" })
mp.set("v", "<", "<gv", { desc = "indent and visual mode" })
mp.set("t", "<Esc>", "<C-\\><C-n>", { desc = "terminal normal mode" })

-- stylua: ignore start
--NOTE: plugin mappings
local pluginMaps = {
    todo_comments = { {
	    opts = {desc = "Go to next TODO",},
	    mode = "n", key = "]t",
	    map = function() require("todo-comments").jump_next({ keywords = { "TODO", "ERROR", "WARNING" } }) end
	}, {
	    opts = {desc = "Go to prev TODO",},
	    mode = "n", key = "[t",
	    map = function() require("todo-comments").jump_prev({ keywords = { "TODO", "ERROR", "WARNING" } }) end,
	}, },
    telescope = { {
	    opts = {desc = "Fuzzy find recent files" },
	    mode = "n", key = "<leader>ff",
	    map = "<cmd>Telescope find_files<cr>",
	}, {
	    opts = {desc = "Find string in cwd" },
	    mode = "n", key = "<leader>fs",
	    map = "<cmd>Telescope live_grep<cr>",
	}, {
	    opts = {desc = "Find string under cursor in cwd",},
	    mode = "n", key = "<leader>fc",
	    map = "<cmd>Telescope grep_string<cr>",
	}, {
	    opts = {desc = "Find todos",},
	    mode = "n", key = "<leader>ft",
	    map = "<cmd>TodoTelescope keywords=TODO,ERROR,WARNING<cr>",
	}, {
	    opts = {desc = "Fuzzy find help" },
	    mode = "n", key = "<leader>fh",
	    map = "<cmd>Telescope help_tags<cr>",
	}, },
    harpoon = { {
	    opts = {desc = "Mark Harpoon file",},
	    mode = "n", key = "<leader>ha",
	    map = function() require("harpoon.mark").add_file() end,
	}, {
	    opts = {desc = "Harpoon menu",},
	    mode = "n", key = "<C-h>",
	    map = function() require("harpoon.ui").toggle_quick_menu() end,
	}, {
	    opts = {desc = "Jump to next Harpoon file",},
	    mode = "n", key = "<C-j>",
	    map = function() require("harpoon.ui").nav_next() end,
	}, {
	    opts = {desc = "Jump to prev Harpoon file",},
	    mode = "n", key = "<C-k>",
	    map = function() require("harpoon.ui").nav_prev() end,
	}, {
	    opts = {desc = "Harpoon cmd menu",},
	    mode = "n", key = "<leader>ht",
	    map = function() require("harpoon.cmd-ui").toggle_quick_menu() end,
	}, {
	    opts = {desc = "Go to Terminal 1",},
	    mode = "n", key = "<leader>t1",
	    map = function() require("harpoon.term").gotoTerminal(1) end,
	}, {
	    opts = {desc = "Go to Terminal 2",},
	    mode = "n", key = "<leader>t2",
	    map = function() require("harpoon.term").gotoTerminal(2) end,
	}, {
	    opts = {desc = "Go to Terminal 3",},
	    mode = "n", key = "<leader>t3",
	    map = function() require("harpoon.term").gotoTerminal(3) end,
	}, },
    lspconfig = { {
	    opts = {desc = "Show LSP references",},
	    mode = "n", key = "gR",
	    map = "<cmd>Telescope lsp_references<CR>",
	}, {
	    opts = {desc = "Show LSP definitions",},
	    mode = "n", key = "gd",
	    map = "<cmd>Telescope lsp_definitions<CR>",
	}, {
	    opts = {desc = "Show LSP implementations",},
	    mode = "n", key = "gi",
	    map = "<cmd>Telescope lsp_implementations<CR>",
	}, {
	    opts = {desc = "Show LSP type definitions",},
	    mode = "n", key = "gt",
	    map = "<cmd>Telescope lsp_type_definitions<CR>",
	}, {
	    opts = {desc = "Go to declaration" },
	    mode = "n", key = "gD",
	    map = vim.lsp.buf.declaration,
	}, {
	    opts = {desc = "Smart rename" },
	    mode = "n", key = "<leader>rn",
	    map = vim.lsp.buf.rename,
	}, {
	    opts = {desc = "Show buffer diagnostics",},
	    mode = "n", key = "<leader>D",
	    map = "<cmd>Telescope diagnostics bufnr=0<CR>",
	}, {
	    opts = {desc = "Show line diagnostics" },
	    mode = "n", key = "<leader>d",
	    map = vim.diagnostic.open_float,
	}, {
	    opts = {desc = "Go to previous diagnostic",},
	    mode = "n", key = "[d",
	    map = function() vim.diagnostic.jump({ count = -1, float = true }) end,
	}, {
	    opts = {desc = "Go to next diagnostic",},
	    mode = "n", key = "]d",
	    map = function() vim.diagnostic.jump({ count = 1, float = true }) end,
	}, {
	    opts = {desc = "Show documentation for what is under cursor",},
	    mode = "n", key = "K",
	    map = vim.lsp.buf.hover,
	}, {
	    opts = {desc = "Restart LSP" },
	    mode = "n", key = "<leader>rs",
	    map = ":LspRestart<CR>",
	}, },
    autoformat = { {
	    opts = {desc = "Format file or range (in visual mode)",},
	    mode = { "n", "v" }, key = "<leader>F",
	    map = function() require("conform").format({ lsp_fallback = true, async = false, timeout_ms = 1000, }) end,
	}, },
    lint = { {
	    opts = {desc = "Trigger linting for current file",},
	    mode = "n", key = "<leader>l",
	    map = function() require("lint").try_lint() end,
        }, },
}
-- stylua: ignore end

--NOTE: from the plugin config require mappings and pass plugin name and options
return {
    setup = function(name, opts)
        opts = opts or {}
        local mappings = pluginMaps[name]
        if mappings == nil then
            vim.notify("No mapping configuration found for " .. name, vim.log.levels.WARN)
            return
        end
        for _, mapping in pairs(mappings) do
            for key, option in pairs(mapping["opts"]) do
                opts[key] = option
            end
            mp.set(mapping["mode"], mapping["key"], mapping["map"], opts)
        end
    end,
}
