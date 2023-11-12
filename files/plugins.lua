return require('packer').startup(function()

    -- Packages manager
    use 'wbthomason/packer.nvim'

    -- Appearance
    use 'projekt0n/github-nvim-theme'

    -- Navigation
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }

    -- Highlighting
    use 'nvim-treesitter/nvim-treesitter'
end)
