-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
  { "Mofiqul/vscode.nvim" },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "nvim-lualine/lualine.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "L3MON4D3/LuaSnip" },
})

-- Options
vim.o.termguicolors = true
vim.o.number        = true
vim.o.tabstop       = 4
vim.o.shiftwidth    = 4
vim.o.expandtab     = true
vim.o.mouse         = "a"
vim.opt.clipboard   = "unnamedplus"
vim.g.mapleader     = ","

-- Theme
require("vscode").setup({ style = "dark" })
vim.cmd("colorscheme vscode")

-- VSCode Dark+ colors
local hi = vim.api.nvim_set_hl
local c = {
  blue    = "#4ebffc",   -- variables
  yellow  = "#fdfd32",   -- functions
  teal    = "#4EC9B0",   -- types
  orange  = "#CE9178",   -- strings
  purple  = "#C586C0",   -- keywords
  green   = "#6A9955",   -- comments
  lime    = "#dff4c1",   -- constants
  white   = "#D4D4D4",   -- text
  red     = "#F44747",   -- errors/delimiter1
  dyellow = "#E5C07B",   -- delimiter2
  dgreen  = "#98C379",   -- delimiter3
  dblue   = "#61AFEF",   -- delimiter4
  dpurple = "#C678DD",   -- delimiter5
  cyan    = "#56B6C2",   -- delimiter6
}

-- Base groups
hi(0, "Normal",     { fg = c.white, bold = true })
hi(0, "Identifier", { fg = c.blue, bold = true })
hi(0, "Function",   { fg = c.yellow, bold = true })
hi(0, "Statement",  { fg = c.purple, bold = true })
hi(0, "Keyword",    { fg = c.purple, bold = true })
hi(0, "Type",       { fg = c.teal, bold = true })
hi(0, "PreProc",    { fg = c.purple, bold = true })
hi(0, "String",     { fg = c.orange, bold = true })
hi(0, "Number",     { fg = c.lime, bold = true })
hi(0, "Constant",   { fg = c.lime, bold = true })
hi(0, "Comment",    { fg = c.green, italic = true, bold = true })
hi(0, "Operator",   { fg = c.white, bold = true })
hi(0, "Special",    { fg = c.orange, bold = true })

-- Treesitter groups
hi(0, "@variable",              { fg = c.blue, bold = true })
hi(0, "@variable.builtin",      { fg = c.blue, bold = true })
hi(0, "@variable.parameter",    { fg = c.blue, bold = true })
hi(0, "@property",              { fg = c.blue, bold = true })
hi(0, "@function",              { fg = c.yellow, bold = true })
hi(0, "@function.builtin",      { fg = c.yellow, bold = true })
hi(0, "@function.call",         { fg = c.yellow, bold = true })
hi(0, "@method",                { fg = c.yellow, bold = true })
hi(0, "@method.call",           { fg = c.yellow, bold = true })
hi(0, "@type",                  { fg = c.teal, bold = true })
hi(0, "@type.builtin",          { fg = c.teal, bold = true })
hi(0, "@constructor",           { fg = c.teal, bold = true })
hi(0, "@keyword",               { fg = c.purple, bold = true })
hi(0, "@keyword.function",      { fg = c.purple, bold = true })
hi(0, "@keyword.return",        { fg = c.purple, bold = true })
hi(0, "@keyword.operator",      { fg = c.purple, bold = true })
hi(0, "@conditional",           { fg = c.purple, bold = true })
hi(0, "@repeat",                { fg = c.purple, bold = true })
hi(0, "@include",               { fg = c.purple, bold = true })
hi(0, "@exception",             { fg = c.purple, bold = true })
hi(0, "@string",                { fg = c.orange, bold = true })
hi(0, "@string.escape",         { fg = c.yellow, bold = true })
hi(0, "@number",                { fg = c.lime, bold = true })
hi(0, "@float",                 { fg = c.lime, bold = true })
hi(0, "@boolean",               { fg = c.lime, bold = true })
hi(0, "@constant",              { fg = c.blue, bold = true })
hi(0, "@constant.builtin",      { fg = c.blue, bold = true })
hi(0, "@comment",               { fg = c.green, italic = true, bold = true })
hi(0, "@operator",              { fg = c.white, bold = true })
hi(0, "@punctuation.bracket",   { fg = c.red, bold = true })
hi(0, "@punctuation.delimiter", { fg = c.dgreen, bold = true })
hi(0, "RainbowDelimiterRed",    { fg = c.red, bold = true })
hi(0, "RainbowDelimiterYellow", { fg = c.dyellow, bold = true })
hi(0, "RainbowDelimiterGreen",  { fg = c.dgreen, bold = true })
hi(0, "RainbowDelimiterBlue",   { fg = c.dblue, bold = true })
hi(0, "RainbowDelimiterViolet", { fg = c.dpurple, bold = true })
hi(0, "RainbowDelimiterCyan",   { fg = c.cyan, bold = true })
hi(0, "@tag",                   { fg = c.blue, bold = true })
hi(0, "@tag.attribute",         { fg = c.teal, bold = true })
hi(0, "@tag.delimiter",         { fg = c.white, bold = true })

-- Treesitter
require("nvim-treesitter").setup({
  ensure_installed = { "c", "cpp", "lua", "python", "javascript", "typescript",
                       "bash", "html", "css", "json", "yaml", "markdown", "java" },
  auto_install = true,
  highlight = { enable = true },
  indent    = { enable = true },
})

-- Status line
require("lualine").setup({ options = { theme = "vscode" } })

-- File explorer
require("nvim-tree").setup()
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- Mason + LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "pyright", "ts_ls", "bashls", "clangd", "jdtls" },
  automatic_installation = true,
})

local caps = require("cmp_nvim_lsp").default_capabilities()
local on_attach = function(_, bufnr)
  local map = function(lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, { noremap = true, silent = true })
  end
  map("gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("K",  "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  map("<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
end

for _, server in ipairs({ "lua_ls", "pyright", "ts_ls", "bashls", "clangd", "jdtls" }) do
  vim.lsp.config[server] = { on_attach = on_attach, capabilities = caps }
  vim.lsp.enable(server)
end

-- Autocompletion
local cmp = require("cmp")
cmp.setup({
  snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
  mapping = cmp.mapping.preset.insert({
    ["<CR>"]      = cmp.mapping.confirm({ select = true }),
    ["<Tab>"]     = cmp.mapping.select_next_item(),
    ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"]     = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})
