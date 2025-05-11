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
        after = 'mason.nvim',
        config = function()
            require('mason-lspconfig').setup {
                ensure_installed = {
                    "bashls",
                    "clangd",
                    "gopls",
                    "pyright",
                    "terraformls",
                    "ts_ls",
                    "helm_ls",
                    "yamlls",
                },
                automatic_installation = true
            }
        end
    }

    use {
        'towolf/vim-helm',
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
            local has_words_before = function()
              local line, col = unpack(vim.api.nvim_win_get_cursor(0))
              return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

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
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
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
        after = 'mason-lspconfig.nvim',
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            require('mason-lspconfig').setup_handlers {
                function(server_name)
                    require('lspconfig')[server_name].setup {
                        capabilities = capabilities
                    }
                end,
            }
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
