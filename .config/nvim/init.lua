require "config.lazy"
require "clojure"


-- options and globals
vim.g.mapleader = ','
vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.termguicolors = true
-- vim.opt.winbar = "__________"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.undodir = '/tmp/.vimundo'
vim.opt.ttyfast = true
vim.opt.backspace = 'indent,eol,start'

function GetGitBranch()
  -- local branch = ''
  -- for line in io.popen('git rev-parse --abbrev-ref HEAD'):lines() do
  --   branch = line:match('(.*)$')
  -- end
  -- return branch
  return 'foooo'
end

-- print(GetGitBranch())

-- vim.opt.statusline = 'file: %f - %pp -  :%{GetGitBranch()} '
-- vim.opt.statusline = 'file: %f - %pp -  :%{GetGitBranch()} '
vim.opt.statusline = ':%{GetGitBranch()} %='


-- general key mappings
vim.api.nvim_set_keymap("n", "<leader>r", ":source ~/.config/nvim/init.lua<CR>", {noremap = true})
vim.api.nvim_set_keymap("v", "jk", "<esc>", {noremap = true})
vim.api.nvim_set_keymap("i", "jk", "<esc>", {noremap = true})
vim.api.nvim_set_keymap("", "-", ":Explore<CR>", {noremap = true})

vim.keymap.set("n", "<C-p>", require('fzf-lua').files, { desc = "Fzf Files" })
vim.keymap.set("n", "<C-g>", require('fzf-lua').grep, { })

local map = function(type, key, value)
	vim.api.nvim_buf_set_keymap(0,type,key,value,{noremap = true, silent = true});
end

local custom_attach = function(client)
	print("LSP started.");
	require'completion'.on_attach(client)
	require'diagnostic'.on_attach(client)

end

local custom_error = function(e)
	print("ERRR");
	print("error", e)
end


-- status not working for some reason
local lsp_status = require('lsp-status')
lsp_status.register_progress()

local lspconfig = require 'lspconfig'

lspconfig.clojure_lsp.setup{}
lspconfig.tsserver.setup{}

map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
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

