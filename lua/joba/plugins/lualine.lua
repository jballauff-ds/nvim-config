return {
   'nvim-lualine/lualine.nvim',
   dependencies = { 'nvim-tree/nvim-web-devicons' },
   config = function()
      local theme = require('lualine.themes.rose-pine')
      local theme_c_bg = theme.normal.c.bg -- store the desired color for sections c and x
      local theme_c_fg = theme.normal.c.fg
      local rosepine_red = theme.command.a.bg
      local left_sec_seperator = '\u{e0b4}'
      local right_sec_seperator = '\u{e0b6}'
      for _,mode in pairs(theme) do mode.c.bg = "00ffffff" end

      local get_main_color = function()
	 local mode = string.lower(vim.api.nvim_get_mode().mode)
	 if mode == 'v' or mode == 's' or mode == '\22'  then return theme.visual.a.bg
	 elseif mode == 'r' then return theme.replace.a.bg
	 elseif mode == 'c' then return theme.command.a.bg
	 elseif mode == 'i' then return theme.insert.a.bg
	 else return theme.normal.a.bg end
      end

      local get_buffers = function()
	 local buffers = vim.fn.getbufinfo({buflisted=1})
	 local count = 0
	 local mod = 0
	 local term = 0
	 for _,b in ipairs(buffers) do
	    count = count + 1
	    mod = mod + b.changed
	    if b.variables and b.variables.term_title then
	       term = term + 1
	    end
	 end
	 local term_str = term > 0 and "\u{f489} " .. term .. " " or ""
	 local mod_str = mod > 0 and " \u{f444} " .. mod or ""
	 return term_str .. "\u{ef96} " .. count .. mod_str
      end

      local get_local_lsp_clients = function ()
	 local bufnr = vim.api.nvim_get_current_buf()
	 local clients = vim.lsp.get_clients({bufnr = bufnr})
	 if next(clients) == nil then return "" end
	 local c = {}
	 for _, client in pairs(clients) do
	    table.insert(c, client.name)
	 end
	 return " " .. table.concat(c, '|')
      end

      require('lualine').setup({
	 options = {
	    icons_enabled = true,
	    theme = theme,
	    fmt = string.lower,
	    section_separators = { left = left_sec_seperator, right = right_sec_seperator},
	    component_separators = { left = '', right = ''},
	    disabled_filetypes = {
	       statusline = {},
	       winbar = {},
	    },
	    ignore_focus = {},
	    always_divide_middle = true,
	    globalstatus = true,
	    refresh = {
	       statusline = 1000,
	       tabline = 1000,
	       winbar = 1000,
	    }
	 },
	 sections = {
	    lualine_a = {
	       {
		  function() return right_sec_seperator end,
		  padding = {left = 0, right = 0},
		  color = function() return {fg = get_main_color() or "00ffffff", bg = "00ffffff"} end
	       },
	       {'mode', fmt = string.upper}
	    },
	    lualine_b = {
	       {get_buffers}
	    },
	    lualine_c = {
	       {
		  function() return "\u{f085}"..get_local_lsp_clients() end,
		  color = function()
		     return {fg = get_local_lsp_clients() == "" and rosepine_red or theme_c_fg, bg = theme_c_bg}
		  end,
	       },
	       {'diagnostics', color = {bg = theme_c_bg} },
	       {function() return left_sec_seperator end, padding = {left = 0, right = 1}, color = {fg = theme_c_bg}}
	    },
	    lualine_x = {
	       {function() return right_sec_seperator end, padding = {left = 1, right = 0}, color = {fg = theme_c_bg}},
	       {'fileformat', color = {bg = theme_c_bg}, padding = {left = 1, right = 0}},
	       {'encoding', color = {bg = theme_c_bg}},
	       {'filetype', color = {bg = theme_c_bg}},
	       {'filename',
		  color = function()
		     return { fg = vim.bo.modified and rosepine_red or theme_c_fg, bg = theme_c_bg }
		  end,
		  newfile_status = true,
		  symbols = {readonly= ' \u{f1030} ', modified = ' \u{f040} ', unnamed = ' \u{f086f} ', newfile = ' \u{e676} '},
	       }
	    },
	    lualine_y = {
	       {'branch'},
	       {'diff'}
	    },
	    lualine_z = {
	       {'location'},
	       {'progress'},
	       {
		  function() return left_sec_seperator end,
		  padding = {left = 0, right = 0},
		  color = function() return {fg = get_main_color() or "00ffffff", bg = "00ffffff"} end
	       }
	    },
	 },
	 inactive_sections = {
	    lualine_a = {},
	    lualine_b = {},
	    lualine_c = {'filename'},
	    lualine_x = {'location'},
	    lualine_y = {},
	    lualine_z = {}
	 },
	 tabline = {},
	 winbar = {},
	 inactive_winbar = {},
	 extensions = {}
      })
   end,
}
