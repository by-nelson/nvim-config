vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

require('github-theme').setup({
    specs = {
        github_dark = {
            bg0 = '#0e141b',
            bg1 = '#0d1117',
        }
    }
})

vim.cmd('colorscheme github_dark')
