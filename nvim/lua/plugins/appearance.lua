-- lua/plugins/appearance.lua
return {
  {
    "projekt0n/github-nvim-theme",
    priority = 1000,
    config = function()
      require("github-theme").setup({
        specs = {
          github_dark = {
            bg0 = "#0e141b",
            bg1 = "#0d1117",
          },
        },
      })
      vim.cmd.colorscheme("github_dark")
    end,
  },
}
