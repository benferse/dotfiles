--
-- Plugins installation via packer, including bootstrapping
-- packer itself as needed
--
-- Cobbled together from the bits and pieces at https://github.com/wbthomason/packer.nvim
--
local cmd = vim.cmd
local fn = vim.fn

local packer_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(packer_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        packer_path,
    }

    print 'Installing packer, please restart nvim...'
    cmd [[packadd packer.nvim]]
end

--
-- Reload nvim whenever the plugins settings file changes
--
cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
]]

--
-- Load packer, and let it do its thing <3
--
local is_ok, packer = pcall(require, 'packer')
if not is_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            return require('packer.util').float { border = 'rounded' }
        end,
    },
}

return packer.startup(function(use)
    --
    -- Let packer manage itself #packception
    --
    use { 'wbthomason/packer.nvim' }

    --
    -- The moral equivalent of an nvim lua standard library
    --
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }

    --
    -- Eye candy
    --
    use { 'arcticicestudio/nord-vim' }
    use { 'kyazdani42/nvim-web-devicons' }

    --
    -- Terminal helpers, embedded or external navigation
    --
    use { 'akinsho/toggleterm.nvim' }

    --
    -- Keymappings and keyboard navigation goodies
    --
    use { 'folke/which-key.nvim' }
    use { 'b0o/mapx.nvim' }

    --
    -- Telescope and its fuzzy friends
    --
    use { 'nvim-telescope/telescope.nvim' }

    --
    -- Git, source control, diff/merge
    --
    use { 'lewis6991/gitsigns.nvim' }

    --
    -- Treesitter and company
    --
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    --
    -- Automatic configuration after bootstrapping
    --
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
