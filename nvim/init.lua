-- Initialize Package Manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  "altercation/vim-colors-solarized",
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    dependencies = {
      {"nvim-lua/plenary.nvim"}
    }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
        sync_install = false,
        highlight = { enable = true },
      })
    end
  },
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      {"neovim/nvim-lspconfig"},             -- Required
      {"williamboman/mason.nvim"},           -- Optional
      {"williamboman/mason-lspconfig.nvim"}, -- Optional

      -- Autocompletion
      {"hrsh7th/nvim-cmp"},     -- Required
      {"hrsh7th/cmp-nvim-lsp"}, -- Required
      {"L3MON4D3/LuaSnip"},     -- Required
    }
  }
})

-- Initialize LSP
local lsp = require("lsp-zero").preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

-- nvim Options
vim.opt.autoindent = true
vim.opt.background = 'dark'
vim.opt.colorcolumn = '+1'
vim.opt.compatible = false
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '»-', trail = '·', eol = '¬' }
-- https://csswizardry.com/2017/05/writing-tidy-code/#invisibles
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 4
vim.opt.smartindent = false
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.textwidth = 79
vim.opt.wrap = false

-- Keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- Setup Commands
vim.cmd([[
    syntax off
    colorscheme solarized

    highlight Normal ctermbg=none guibg=none
    highlight SignColumn ctermbg=none guibg=none

    augroup configgroup
      autocmd!
      silent! autocmd! filetypedetect BufRead,BufNewFile *.tf
      autocmd BufRead,BufNewFile *.hcl set filetype=hcl
      autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
      autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json
      autocmd BufRead,BufNewFile .terraformrc,.terraform.rc set filetype=hcl
      autocmd FileType gitcommit set colorcolumn+=51 textwidth=72
      " https://csswizardry.com/2017/03/configuring-git-and-vim/#update-2017-04-09
      autocmd FileType html set tabstop=2 shiftwidth=2
    augroup END

    " Sort the selected list of HTML anchor tags by their rendered text, not their href attribute
    function! SortSelectedAnchorTags()
      '<,'>sort i /">\zs.\+\ze<\/a>/ r
    endfunction
    :vnoremap <Leader>a :call SortSelectedAnchorTags()<CR>

    function! TrimWhitespace()
      let l:save = winsaveview()
      %s/\s\+$//e
      call winrestview(l:save)
    endfunction
    :noremap <Leader>w :call TrimWhitespace()<CR>
    " https://vi.stackexchange.com/a/456
]])
