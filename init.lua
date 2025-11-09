
-- ==============================
-- Neovim IDE Setup (Stable & Modern)
-- ==============================

-- Install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ==============================
-- Plugins
-- ==============================
require("lazy").setup({
  -- Core IDE plugins
  "neovim/nvim-lspconfig",           -- LSP support
  "williamboman/mason.nvim",         -- LSP/DAP installer
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/nvim-cmp",                -- Autocompletion
  "hrsh7th/cmp-nvim-lsp",
  "L3MON4D3/LuaSnip",                -- Snippets
  "nvim-treesitter/nvim-treesitter", -- Syntax highlighting
  "nvim-lualine/lualine.nvim",       -- Status line
  "nvim-tree/nvim-tree.lua",         -- File explorer
  "nvim-tree/nvim-web-devicons",     -- Icons
  "folke/tokyonight.nvim",           -- Theme
})

-- ==============================
-- UI Settings
-- ==============================
vim.o.termguicolors = true
vim.cmd([[colorscheme tokyonight-storm]])
vim.o.number = true
vim.o.relativenumber = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.mouse = "a"

-- Statusline
require("lualine").setup {
  options = { theme = "tokyonight" },
}

-- File explorer
require("nvim-tree").setup {}

-- ==============================
-- Mason & LSP Setup
-- ==============================
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls" },
  automatic_installation = true,
}

-- Capabilities for autocomplete
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Attach function (for keymaps, etc.)
local on_attach = function(_, bufnr)
  local bufmap = function(mode, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, { noremap = true, silent = true })
  end
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
  bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

-- Safe LSP setup (avoids deprecated calls)
-- LSP setup using the new vim.lsp.config API
local servers = { "lua_ls", "pyright", "ts_ls", "bashls" }

for _, server in ipairs(servers) do
  vim.lsp.config[server] = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- ==============================
-- Treesitter Setup (Safe Mode)
-- ==============================
require("nvim-treesitter.configs").setup {
  ensure_installed = { "lua", "python", "javascript", "bash", "html", "css" },
  highlight = { enable = true },
  indent = { enable = true },
  auto_install = true,
}

-- ==============================
-- Autocompletion Setup
-- ==============================
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }),
}

-- ==============================
-- Done
-- ==============================
print("✅ Neovim IDE setup loaded successfully!")

