-- load plugin setup ? 

require('maciej.plugins_setup')

-- load core config.

require('maciej.core.options')
require('maciej.core.keymap')
require('maciej.core.colorscheme')

-- load plugin configs

require('maciej.plugins.luasnip')
require('maciej.plugins.nvim_lsp')
require('maciej.plugins.lualine')
