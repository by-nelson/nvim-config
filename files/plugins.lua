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

    -- Mason for easy LSP installation
    use { 
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end
    }

    use { 
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup {
                automatic_installation = true
            }
        end
    }

    -- Snippets engine
    -- Snippets source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'
    -- Snippets plugin
    use 'L3MON4D3/LuaSnip'

    -- Neovim autocompletion
    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            local luasnip = require 'luasnip'
            local cmp = require 'cmp'

            require('cmp').setup {
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_next_item()
                      elseif luasnip.expand_or_jumpable() then
                        luasnip.expand_or_jump()
                      else
                        fallback()
                      end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                      if cmp.visible() then
                        cmp.select_prev_item()
                      elseif luasnip.jumplable(-1) then
                        luasnip.jump(-1)
                      else
                        fallback()
                      end
                    end, { 'i', 's' }),
                }),
                sources = {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                },
            }
        end
    }

    -- Language Server Providers
    use {
        'neovim/nvim-lspconfig',

        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require 'lspconfig'
            local servers = {
                "bashls",
                "clangd",
                "gopls",
                "pyright",
                "terraformls",
                "tsserver"
            }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup {
                    capabilities = capabilities
                }
            end
        end
    }

    -- Git signs
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }

end)
