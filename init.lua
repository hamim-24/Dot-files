
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
  { "Mofiqul/vscode.nvim", lazy = false }, -- VSCode color theme (dark)
  { "p00f/nvim-ts-rainbow", event = "BufRead" }, -- rainbow parentheses
  { "nvim-treesitter/nvim-treesitter-context", event = "BufRead" } -- show context
})

-- ==============================
-- UI Settings
-- ==============================
vim.o.termguicolors = true
-- Setup VSCode dark theme with semantic highlighting
pcall(function()
  require('vscode').setup({ 
    style = 'dark',
    transparent = false,
    italic_comments = true,
    disable_nvimtree_bg = true,
  })
  vim.cmd([[colorscheme vscode]])

  -- VSCode Dark+ inspired colors
  local colors = {
    vscBlue = '#9CDCFE',       -- variables
    vscYellow = '#DCDCAA',     -- functions
    vscGreen = '#4EC9B0',      -- types/classes
    vscRed = '#F44747',        -- errors
    vscOrange = '#CE9178',     -- strings
    vscMagenta = '#C586C0',    -- control flow
    vscGrey = '#808080',       -- comments
    vscViolet = '#646695',     -- constants
  }

  -- Set up semantic token highlights
  local function hi(name, opts)
    vim.api.nvim_set_hl(0, name, opts)
  end

  -- Variables and properties
  hi('Identifier', { fg = colors.vscBlue })
  hi('@variable', { fg = colors.vscBlue })
  hi('@property', { fg = colors.vscBlue })
  hi('@parameter', { fg = colors.vscBlue })

  -- Functions and methods
  hi('Function', { fg = colors.vscYellow })
  hi('@function', { fg = colors.vscYellow })
  hi('@method', { fg = colors.vscYellow })

  -- Types and classes
  hi('@type', { fg = colors.vscGreen })
  hi('@constructor', { fg = colors.vscGreen })

  -- Control flow
  hi('@keyword', { fg = colors.vscMagenta })
  hi('@conditional', { fg = colors.vscMagenta })
  hi('@repeat', { fg = colors.vscMagenta })

  -- Constants and strings
  hi('@string', { fg = colors.vscOrange })
  hi('@constant', { fg = colors.vscViolet })

  -- Comments
  hi('@comment', { fg = colors.vscGrey, italic = true })
end)

-- VSCode-like highlight tweaks: make variables, functions and delimiters stand out
pcall(function()
  -- Colors approximating VSCode Dark palette
  local pal = {
    variable = "#9CDCFE",   -- light blue
    func = "#DCDCAA",       -- light yellow
    delimiter1 = "#E06C75", -- red
    delimiter2 = "#E5C07B", -- yellow
    delimiter3 = "#98C379", -- green
    delimiter4 = "#61AFEF", -- blue
    delimiter5 = "#C678DD", -- purple
    delimiter6 = "#56B6C2", -- cyan
  }

  -- Treesitter groups
  vim.api.nvim_set_hl(0, "TSVariable", { fg = pal.variable })
  vim.api.nvim_set_hl(0, "TSProperty", { fg = pal.variable })
  vim.api.nvim_set_hl(0, "Identifier", { fg = pal.variable })
  vim.api.nvim_set_hl(0, "TSFunction", { fg = pal.func })
  vim.api.nvim_set_hl(0, "Function", { fg = pal.func })
  vim.api.nvim_set_hl(0, "TSParameter", { fg = pal.variable })

  -- Rainbow delimiter groups (nvim-ts-rainbow uses RainbowDelimiterX)
  vim.api.nvim_set_hl(0, "RainbowDelimiterRed", { fg = pal.delimiter1 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterGreen", { fg = pal.delimiter3 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterYellow", { fg = pal.delimiter2 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterBlue", { fg = pal.delimiter4 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterViolet", { fg = pal.delimiter5 })
  vim.api.nvim_set_hl(0, "RainbowDelimiterCyan", { fg = pal.delimiter6 })

  -- Some rainbow plugins use numbered groups, set a few common ones too
  vim.api.nvim_set_hl(0, "RainbowDelimiter1", { fg = pal.delimiter1 })
  vim.api.nvim_set_hl(0, "RainbowDelimiter2", { fg = pal.delimiter2 })
  vim.api.nvim_set_hl(0, "RainbowDelimiter3", { fg = pal.delimiter3 })
  vim.api.nvim_set_hl(0, "RainbowDelimiter4", { fg = pal.delimiter4 })
  vim.api.nvim_set_hl(0, "RainbowDelimiter5", { fg = pal.delimiter5 })
  vim.api.nvim_set_hl(0, "RainbowDelimiter6", { fg = pal.delimiter6 })
end)
vim.o.number = true
vim.o.relativenumber = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.mouse = "a"

-- Statusline
require("lualine").setup {
  options = { theme = "auto" }, -- let lualine adapt to the active colorscheme
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
  highlight = { 
    enable = true,
    additional_vim_regex_highlighting = false, -- disable vim regex highlighting for better performance
  },
  indent = { enable = true },
  auto_install = true,
  -- Rainbow parentheses configuration
  rainbow = {
    enable = true,
    extended_mode = true,    -- Also highlight non-bracket delimiters
    max_file_lines = 1000,   -- Performance optimization
    colors = {               -- VSCode-like colors
      "#E06C75", -- red
      "#E5C07B", -- yellow
      "#98C379", -- green
      "#61AFEF", -- blue
      "#C678DD", -- purple
      "#56B6C2", -- cyan
    },
  },
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
