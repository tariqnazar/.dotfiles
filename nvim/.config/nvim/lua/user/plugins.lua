local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "justinmk/vim-sneak"
  use "kyazdani42/nvim-tree.lua"
  use "preservim/nerdcommenter"
  use "mhinz/vim-startify"
  use "jiangmiao/auto-pairs"
  use "nvim-lua/plenary.nvim"
  use "nvim-lualine/lualine.nvim"
  use "romgrk/barbar.nvim"
  use "norcalli/nvim-colorizer.lua"

  -- Appearance
  -- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
  use "onsails/lspkind-nvim"
  use "christianchiarulli/nvcode-color-schemes.vim"
  use "ryanoasis/vim-devicons"
  use "kyazdani42/nvim-web-devicons"

  -- cmp pluggins
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"

  -- snippets
  --use "L3MON4D3/LuaSnip" --snippet engine
  --use "rafamadriz/friendly-snippets" -- a bunch of snippets to use
  use "sirver/ultisnips"
  use 'quangnguyen30192/cmp-nvim-ultisnips'
  -- LSP
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"

  -- Telescope
  use {"nvim-telescope/telescope.nvim",
        requires = { {'nvim-lua/plenary.nvim'} }
    }
  -- Treesitter
 use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
  -- Git
  use "tpope/vim-fugitive"
  use "tpope/vim-rhubarb"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
