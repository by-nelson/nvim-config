-- lua/plugins/init.lua
return {
  { import = "plugins.appearance" },
  { import = "plugins.navigation" },
  { import = "plugins.highlighting" },
  { import = "plugins.lsp" },
  { import = "plugins.completion" },
  { import = "plugins.git" },
  { "folke/trouble.nvim", config = true },
  { "towolf/vim-helm" },
}
