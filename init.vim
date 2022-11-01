call plug#begin()
" Vim-airline and vim-airline-themes
Plug 'nvim-lualine/lualine.nvim'
" VScode theme
Plug 'Mofiqul/vscode.nvim'
Plug 'savq/melange'
" LuaSnip
Plug 'L3MON4D3/LuaSnip'
" friendly-snippets
Plug 'rafamadriz/friendly-snippets'
" nvim-cmp
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
" devicons
Plug 'kyazdani42/nvim-web-devicons'
" jdtls
Plug 'mfussenegger/nvim-jdtls'
" telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" nvim-treesitter
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

let g:airline_theme = "raven"
let g:vscode_style = "dark"
let g:vscode_transparent = 1
let g:vscode_italic_comment = 1
let g:vscode_disable_nvimtree_bg = v:true
colorscheme vscode 

set relativenumber
set tabstop=2 softtabstop=2 shiftwidth=2
set cursorcolumn
set cursorline
set mouse=a
set clipboard=unnamed
highlight LineNr ctermfg=darkgrey

lua require("luasnip.loaders.from_vscode").lazy_load()

nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-t> :tabnew<CR>
nnoremap <C-x> :bw<CR>

let mapleader = ","
" Telescope mappings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" JDTLS Binds
nnoremap <A-o> <Cmd>lua require'jdtls'.organize_imports()<CR>
nnoremap crv <Cmd>lua require('jdtls').extract_variable()<CR>
vnoremap crv <Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>
nnoremap crc <Cmd>lua require('jdtls').extract_constant()<CR>
vnoremap crc <Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>
vnoremap crm <Esc><Cmd>lua require('jdtls').extract_method(true)<CR>

lua <<EOF
	
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local luasnip = require("luasnip")
  -- Setup nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
	    ["<Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_next_item()
	      elseif luasnip.expand_or_jumpable() then
	        luasnip.expand_or_jump()
	      elseif has_words_before() then
	        cmp.complete()
	      else
	        fallback()
	      end
	    end, { "i", "s" }),
	    ["<S-Tab>"] = cmp.mapping(function(fallback)
	      if cmp.visible() then
	        cmp.select_prev_item()
	      elseif luasnip.jumpable(-1) then
	        luasnip.jump(-1)
	      else
	        fallback()
	      end
	    end, { "i", "s" }),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
	require('lspconfig').tsserver.setup{} 
	require('lspconfig').jdtls.setup{}
	require('lspconfig').rust_analyzer.setup{}
	require('lspconfig').html.setup{
		capabilities = capabilities,
	}

	-- Treesitter stuff
	require'nvim-treesitter.configs'.setup {
		highlight = {
			enable = true
		},
		indent = {
			enable = true
		}
	}

	-- lualine
	-- Eviline config for lualine
	-- Author: shadmansaleh
	-- Credit: glepnir
	local lualine = require('lualine')
	
	-- Color table for highlights
	-- stylua: ignore
	local colors = {
	  bg       = '#202328',
	  fg       = '#bbc2cf',
	  yellow   = '#ECBE7B',
	  cyan     = '#008080',
	  darkblue = '#081633',
	  green    = '#98be65',
	  orange   = '#FF8800',
	  violet   = '#a9a1e1',
	  magenta  = '#c678dd',
	  blue     = '#51afef',
	  red      = '#ec5f67',
	}
	
	local conditions = {
	  buffer_not_empty = function()
	    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	  end,
	  hide_in_width = function()
	    return vim.fn.winwidth(0) > 80
	  end,
	  check_git_workspace = function()
	    local filepath = vim.fn.expand('%:p:h')
	    local gitdir = vim.fn.finddir('.git', filepath .. ';')
	    return gitdir and #gitdir > 0 and #gitdir < #filepath
	  end,
	}
	
	-- Config
	local config = {
	  options = {
	    -- Disable sections and component separators
	    component_separators = '',
	    section_separators = '',
	    theme = {
	      -- We are going to use lualine_c an lualine_x as left and
	      -- right section. Both are highlighted by c theme .  So we
	      -- are just setting default looks o statusline
	      normal = { c = { fg = colors.fg, bg = colors.bg } },
	      inactive = { c = { fg = colors.fg, bg = colors.bg } },
	    },
	  },
	  sections = {
	    -- these are to remove the defaults
	    lualine_a = {},
	    lualine_b = {},
	    lualine_y = {},
	    lualine_z = {},
	    -- These will be filled later
	    lualine_c = {},
	    lualine_x = {},
	  },
	  inactive_sections = {
	    -- these are to remove the defaults
	    lualine_a = {},
	    lualine_b = {},
	    lualine_y = {},
	    lualine_z = {},
	    lualine_c = {},
	    lualine_x = {},
	  },
	}
	
	-- Inserts a component in lualine_c at left section
	local function ins_left(component)
	  table.insert(config.sections.lualine_c, component)
	end
	
	-- Inserts a component in lualine_x ot right section
	local function ins_right(component)
	  table.insert(config.sections.lualine_x, component)
	end
	
	ins_left {
	  function()
	    return '▊'
	  end,
	  color = { fg = colors.blue }, -- Sets highlighting of component
	  padding = { left = 0, right = 1 }, -- We don't need space before this
	}
	
	ins_left {
	  -- mode component
	  function()
	    return ''
	  end,
	  color = function()
	    -- auto change color according to neovims mode
	    local mode_color = {
	      n = colors.red,
	      i = colors.green,
	      v = colors.blue,
	      [''] = colors.blue,
	      V = colors.blue,
	      c = colors.magenta,
	      no = colors.red,
	      s = colors.orange,
	      S = colors.orange,
	      [''] = colors.orange,
	      ic = colors.yellow,
	      R = colors.violet,
	      Rv = colors.violet,
	      cv = colors.red,
	      ce = colors.red,
	      r = colors.cyan,
	      rm = colors.cyan,
	      ['r?'] = colors.cyan,
	      ['!'] = colors.red,
	      t = colors.red,
	    }
	    return { fg = mode_color[vim.fn.mode()] }
	  end,
	  padding = { right = 1 },
	}
	
	ins_left {
	  -- filesize component
	  'filesize',
	  cond = conditions.buffer_not_empty,
	}
	
	ins_left {
	  'filename',
	  cond = conditions.buffer_not_empty,
	  color = { fg = colors.magenta, gui = 'bold' },
	}
	
	ins_left { 'location' }
	
	ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }
	
	ins_left {
	  'diagnostics',
	  sources = { 'nvim_diagnostic' },
	  symbols = { error = ' ', warn = ' ', info = ' ' },
	  diagnostics_color = {
	    color_error = { fg = colors.red },
	    color_warn = { fg = colors.yellow },
	    color_info = { fg = colors.cyan },
	  },
	}
	
	-- Insert mid section. You can make any number of sections in neovim :)
	-- for lualine it's any number greater then 2
	ins_left {
	  function()
	    return '%='
	  end,
	}
	
	ins_left {
	  -- Lsp server name .
	  function()
	    local msg = 'No Active Lsp'
	    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
	    local clients = vim.lsp.get_active_clients()
	    if next(clients) == nil then
	      return msg
	    end
	    for _, client in ipairs(clients) do
	      local filetypes = client.config.filetypes
	      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
	        return client.name
	      end
	    end
	    return msg
	  end,
	  icon = ' LSP:',
	  color = { fg = '#ffffff', gui = 'bold' },
	}
	
	-- Add components to right sections
	ins_right {
	  'o:encoding', -- option component same as &encoding in viml
	  fmt = string.upper, -- I'm not sure why it's upper case either ;)
	  cond = conditions.hide_in_width,
	  color = { fg = colors.green, gui = 'bold' },
	}
	
	ins_right {
	  'fileformat',
	  fmt = string.upper,
	  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
	  color = { fg = colors.green, gui = 'bold' },
	}
	
	ins_right {
	  'branch',
	  icon = '',
	  color = { fg = colors.violet, gui = 'bold' },
	}
	
	ins_right {
	  'diff',
	  -- Is it me or the symbol for modified us really weird
	  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
	  diff_color = {
	    added = { fg = colors.green },
	    modified = { fg = colors.orange },
	    removed = { fg = colors.red },
	  },
	  cond = conditions.hide_in_width,
	}
	
	ins_right {
	  function()
	    return '▊'
	  end,
	  color = { fg = colors.blue },
	  padding = { left = 1 },
	}
	
	-- Now don't forget to initialize lualine
	lualine.setup(config)
EOF
