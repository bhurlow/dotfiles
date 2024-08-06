
vim.g.mapleader = ','

require "config.lazy"
require "clojure"

-- options and globals
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.termguicolors = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.undodir = '/tmp/.vimundo'
vim.opt.ttyfast = true
vim.opt.backspace = 'indent,eol,start'

-- general key mappings
vim.api.nvim_set_keymap("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "jk", "<esc>", {noremap = true})
vim.api.nvim_set_keymap("i", "jk", "<esc>", {noremap = true})
vim.api.nvim_set_keymap("", "-", ":Explore<CR>", {noremap = true})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

vim.cmd 'colorscheme xcarbon'

-- Searching
vim.api.nvim_set_keymap("n", "<leader>f", ":FzfLua files<CR>", {noremap = true})
vim.keymap.set("n", "<C-p>", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set("n", "<C-g>", require('fzf-lua').grep, { })

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local lspconfig = require 'lspconfig'

lspconfig.clojure_lsp.setup{}
lspconfig.tsserver.setup{}
-- lspconfig.denols.setup{}

vim.api.nvim_set_keymap('i', '<C-o>', '<C-x><C-o>', { noremap = true, silent = true })

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      -- elseif luasnip.expand_or_jumpable() then
      --   luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
        -- luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
  },
}


map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')

map('n','gp','<cmd>%!pnpm exec prettier --stdin-filepath %<CR>')

map('n','rg','<cmd>%!cat % | gap<CR>')
 
vim.keymap.set("n", "gd", '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = "Fzf Files" })

vim.diagnostic.config({
  virtual_text = false
})

