vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Appearance
require('github-theme').setup({
    specs = {
        github_dark = {
            bg0 = '#0e141b',
            bg1 = '#0d1117',
        }
    }
})

vim.cmd('colorscheme github_dark')

-- Navigation
require('nvim-tree').setup({})

-- Highlighting
require('nvim-treesitter.configs').setup{

    ensure_installed = {'c', 'lua', 'hcl', 'terraform'},

    sync_install = false,
    auto_install = true,

    highlight = {
        enable = true,
    },
}
