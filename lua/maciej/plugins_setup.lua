local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins_setup.lua source <afile> | PackerCompile
  augroup end
]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)
	-- plugins to install
	use("wbthomason/packer.nvim")
	-- lualine
	use("nvim-lualine/lualine.nvim")
	-- gruvbox
	use("ellisonleao/gruvbox.nvim")
	-- luasnip & friendly snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	-- telescope
	use("nvim-lua/plenary.nvim")
	use("nvim-telescope/telescope.nvim")
	-- nvim-cmp
	use('neovim/nvim-lspconfig')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/cmp-path')
	use('hrsh7th/cmp-cmdline')
	use('hrsh7th/nvim-cmp')
	use('saadparwaiz1/cmp_luasnip')
	if packer_bootstrap then
		require("packer").sync()
	end
end)









-- call plug#begin()
-- " Vim-airline and vim-airline-themes
-- Plug 'nvim-lualine/lualine.nvim'
-- " VScode theme
-- Plug 'Mofiqul/vscode.nvim'
-- Plug 'savq/melange'
-- " LuaSnip
-- Plug 'L3MON4D3/LuaSnip'
-- " friendly-snippets
-- Plug 'rafamadriz/friendly-snippets'
-- " nvim-cmp
-- Plug 'neovim/nvim-lspconfig'
-- Plug 'hrsh7th/cmp-nvim-lsp'
-- Plug 'hrsh7th/cmp-buffer'
-- Plug 'hrsh7th/cmp-path'
-- Plug 'hrsh7th/cmp-cmdline'
-- Plug 'hrsh7th/nvim-cmp'
-- Plug 'saadparwaiz1/cmp_luasnip'
-- " devicons
-- Plug 'kyazdani42/nvim-web-devicons'
-- " jdtls
-- Plug 'mfussenegger/nvim-jdtls'
-- " telescope
-- Plug 'nvim-lua/plenary.nvim'
-- Plug 'nvim-telescope/telescope.nvim'
-- " nvim-treesitter
-- Plug 'nvim-treesitter/nvim-treesitter'
