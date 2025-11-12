--[[
return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
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
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason_lspconfig.setup({
        handlers = nil, -- just to be explicit
      })

      for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
        })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keybindings",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
          end
          bufmap("n", "K", vim.lsp.buf.hover)
          bufmap("n", "gd", vim.lsp.buf.definition)
          bufmap("n", "gD", vim.lsp.buf.declaration)
          bufmap("n", "gi", vim.lsp.buf.implementation)
          bufmap("n", "go", vim.lsp.buf.type_definition)
          bufmap("n", "gr", vim.lsp.buf.references)
          bufmap("n", "gs", vim.lsp.buf.signature_help)
          bufmap("n", "<F2>", vim.lsp.buf.rename)
          bufmap("n", "<F4>", vim.lsp.buf.code_action)
          bufmap("n", "gl", vim.diagnostic.open_float)
          bufmap("n", "[d", vim.diagnostic.goto_prev)
          bufmap("n", "]d", vim.diagnostic.goto_next)
        end,
      })
    end,
  },
}
]]

return {
  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
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
      automatic_installation = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Determine if setup_handlers exists
      if mason_lspconfig.setup_handlers then
        mason_lspconfig.setup_handlers({
          function(server_name)
            vim.lsp.config(server_name, {
              capabilities = capabilities,
            })
          end,
        })
      else
        -- fallback for older mason-lspconfig versions
        mason_lspconfig.setup({})
        for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
          vim.lsp.config(server_name, {
            capabilities = capabilities,
          })
        end
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        desc = "LSP keybindings",
        callback = function()
          local bufmap = function(mode, lhs, rhs)
            vim.keymap.set(mode, lhs, rhs, { buffer = true })
          end
          bufmap("n", "K", vim.lsp.buf.hover)
          bufmap("n", "gd", vim.lsp.buf.definition)
          bufmap("n", "gD", vim.lsp.buf.declaration)
          bufmap("n", "gi", vim.lsp.buf.implementation)
          bufmap("n", "go", vim.lsp.buf.type_definition)
          bufmap("n", "gr", vim.lsp.buf.references)
          bufmap("n", "gs", vim.lsp.buf.signature_help)
          bufmap("n", "<F2>", vim.lsp.buf.rename)
          bufmap("n", "<F4>", vim.lsp.buf.code_action)
          bufmap("n", "gl", vim.diagnostic.open_float)
          bufmap("n", "[d", vim.diagnostic.goto_prev)
          bufmap("n", "]d", vim.diagnostic.goto_next)
        end,
      })
    end,
  },
}
