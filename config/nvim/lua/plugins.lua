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
        'git', 'clone',
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
    use {
        'arcticicestudio/nord-vim',
        branch = 'main',
    }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'goolord/alpha-nvim' }
    use { 'sunjon/shade.nvim' }
    use {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup()
        end
    }

    --
    -- UI chrome, window dressing, and the stuff that makes our
    -- experiences more IDE-y
    --
    use {
        'akinsho/bufferline.nvim',
        branch = 'main',
        requires = 'kyazdani42/nvim-web-devicons',
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }

    use { 'hrsh7th/nvim-cmp' }
    use {
        'hrsh7th/cmp-nvim-lsp',
        requires = {
            'hrsh7th/nvim-cmp',
            'neovim/nvim-lspconfig',
        },
    }
    use {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        requires = {
            'hrsh7th/nvim-cmp',
        },
    }

    use { 'hrsh7th/vim-vsnip' }
    use {
        'hrsh7th/cmp-vsnip',
        requires = {
            'hrsh7th/vim-vsnip',
            'hrsh7th/nvim-cmp',
        },
    }

    use { 'onsails/lspkind-nvim' }

    use {
        'folke/trouble.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
        }
    }

    use {
        'folke/todo-comments.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'nvim-lua/plenary.nvim',
            'folke/trouble.nvim',
        }
    }

    use { 'windwp/nvim-autopairs' }
    use { 'numToStr/Comment.nvim' }
    use { 'ur4ltz/surround.nvim' }

    --
    -- Terminal helpers, embedded or external navigation
    --
    use {
        'akinsho/toggleterm.nvim',
        branch = 'main',
    }

    --
    -- Keymappings and keyboard navigation goodies
    --
    use { 'benferse/which-key.nvim' }
    use { 'b0o/mapx.nvim' }
    use { 'famiu/bufdelete.nvim' }

    --
    -- Telescope and its fuzzy friends
    --
    use { 'nvim-telescope/telescope.nvim' }
    use { 'nvim-telescope/telescope-ui-select.nvim' }
    use { 'ahmedkhalf/project.nvim' }

    --
    -- Git, source control, diff/merge
    --
    use { 'lewis6991/gitsigns.nvim' }

    --
    -- Treesitter and company
    --
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use { 'nvim-treesitter/nvim-treesitter-textobjects' }
    use { 'rrethy/nvim-treesitter-textsubjects' }

    --
    -- Language Server Protocol support, as well as support for
    -- various programming environments and debuggers
    --
    use { 'neovim/nvim-lspconfig' }
    use { 'williamboman/nvim-lsp-installer' }
    use {
        'j-hui/fidget.nvim',
        config = function()
            require('fidget').setup()
        end
    }
    use {
        'smiteshp/nvim-navic',
        requires = 'neovim/nvim-lspconfig',
    }

    use {
        'simrat39/rust-tools.nvim',
        requires = 'neovim/nvim-lspconfig',
    }

    use { 'rust-lang/rust.vim' }

    use {
        'mfussenegger/nvim-dap',
        requires = 'nvim-lua/plenary.nvim',
    }

    use {
        'rcarriga/nvim-dap-ui',
        requires = 'mfussenegger/nvim-dap',
    }

    --
    -- Markdown support
    --
    use {
        'preservim/vim-markdown',
        ft = { 'markdown' },
        config = function()
            vim.g.vim_markdown_follow_anchor = 1
            vim.g.vim_markdown_math = 1
        end
    }

    use {
        'preservim/vim-pencil',
        ft = { 'markdown' },
        config = function()
            vim.cmd([[
                augroup Pencil
                    autocmd!
                    autocmd FileType markdown,mkd call pencil#init({"wrap": "soft"})
                    autocmd BufEnter *.md,*.mkd   SoftPencil
                    autocmd BufEnter text         call pencil#init()
                augroup END
            ]])
        end
    }

    use {
        'dhruvasagar/vim-table-mode',
        ft = { 'markdown' },
        config = function()
            vim.g.table_mode_corner = '|'
        end
    }

    --
    -- Playing with NeoTree
    --
    use {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            'muniftanjim/nui.nvim',
        },
        config = function()
            vim.g.neo_tree_remove_legacy_commands = 1

            require('neo-tree').setup {
                close_if_last_window = false,
                popup_border_style = 'rounded',
                enable_git_status = true,
                enable_diagnostics = true,
                default_component_configs = {
                    indent = {
                        indent_size = 2,
                        padding = 1,
                    },
                    name = {
                        use_git_status_colors = true,
                    },
                },
                window = {
                    position = 'left',
                },
                filesystem = {
                    follow_current_file = true,
                }
            }
        end
    }

    use {
        'stevearc/aerial.nvim',
        config = function()
            require('aerial').setup {
                default_direction = 'prefer_right',
                min_width = 0.2
            }
        end
    }

    --
    -- Automatic configuration after bootstrapping
    --
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)
