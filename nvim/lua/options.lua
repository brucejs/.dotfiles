vim.opt.colorcolumn = '+1'
vim.opt.compatible = false
vim.opt.expandtab = true
vim.opt.list = true
vim.opt.listchars = { tab = '»-', trail = '·', eol = '¬' }
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = 'yes'
vim.opt.shiftwidth = 2
vim.opt.smartindent = false
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 79
vim.opt.wrap = false

vim.cmd([[
  syntax off

  augroup filetypes
    autocmd!
    au FileType gitcommit set colorcolumn+=51 textwidth=72
    " https://csswizardry.com/2017/03/configuring-git-and-vim/#update-2017-04-09
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
