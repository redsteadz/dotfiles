local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  if lsp == "html" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  elseif lsp == "cssls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  elseif lsp == "tsserver" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = { "typescript-language-server", "--stdio" },
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--offset-encoding=utf-16",
      },
    }
  end
end
lspconfig.emmet_ls.setup {
  -- on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
  },
}
lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern "Cargo.toml",
  settings = {
    ["rust_analyzer"] = {
      cargo = {
        allfeatures = true,
      },
    },
  },
}

lspconfig.pyright.setup {}
