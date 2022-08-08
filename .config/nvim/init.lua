local vimFolder
if vim.fn.has('nvim') == 1 then
  vimFolder = vim.fn.stdpath('config')
elseif vim.fn.has('unix') == 1 then
  vimFolder = vim.fn.expand('~/.vim')
else
  vimFolder = vim.fn.expand('~/vimfiles')
end

require('plugin-settings/packer')

-- {{{ VIM OPTIONS

-- " When in doubt call :help.
-- " Vim doesn't like keyboard layouts other than US-International, e.g. jumping
-- " through help tags is mapped with [c-ç] on a ABNT layout.
vim.cmd('colorscheme nord')
vim.cmd('filetype plugin indent on')
vim.g.mapleader = ' '
vim.opt.expandtab   = true -- Tabs are spaces
vim.opt.tabstop     = 2 -- 2 spaces
vim.opt.softtabstop = 2 -- A <BS> is 2 spaces
vim.opt.shiftwidth  = 2 -- >> and << is 2 spaces
vim.opt.shiftround  = true -- Identing is rounded to divisibles by 2
vim.opt.termguicolors = true
vim.opt.colorcolumn = '81'
vim.opt.textwidth = 80
vim.opt.showcmd = true
vim.opt.ruler = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.path:append('**')
vim.opt.wildmenu = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.smartindent = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 8
vim.opt.modeline = true

if vim.fn.has('vms') == 1 then
  vim.opt.backup = false -- VMs have their own backup settings.
else
  if vim.fn.isdirectory(vimFolder..'/backupdir') == 0 then
    vim.fn['mkdir'](vimFolder..'/backupdir')
  end

  if vim.fn.isdirectory(vimFolder..'/swpdir') == 0 then
    vim.fn['mkdir'](vimFolder..'/swpdir')
  end

  vim.opt.backup = true
  vim.opt.backupdir = vimFolder..'/backupdir'
  vim.opt.directory = vimFolder..'/swpdir'

  if vim.fn.has('persistent_undo') == 1 then
    if vim.fn.isdirectory(vimFolder..'/undodir') == 0 then
      vim.fn.mkdir(vimFolder..'/undodir')
    end

    vim.opt.undofile = true
    vim.opt.undodir = vimFolder..'/undodir'
  end
end

-- You can't highlight something with only two terminal colors.
local terminalColor = tonumber(vim.api.nvim_get_option('t_Co'))
if terminalColor > 2 or vim.fn.has('gui_running') then
  vim.opt.hlsearch = true
end

if vim.fn.has('folding') == 1 then
  vim.opt.foldenable = true
  vim.opt.foldmethod = "indent"
  vim.opt.foldlevelstart = 10
  vim.opt.foldnestmax = 10
end

-- }}}

-- MAPPINGS {{{

vim.api.nvim_set_keymap("i", "<c-c>", "<esc>", { noremap = true})

vim.api.nvim_set_keymap("n", "<up>", "<nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<down>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<left>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<right>", "<nop>", { noremap = true})
vim.api.nvim_set_keymap("n", "<leader><space>", "za", { noremap = true })
vim.api.nvim_set_keymap("n",
  "<leader>ev",
  ":sp $MYVIMRC<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>h",
  ":nohls<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>pv",
  ":wincmd v <bar> :Ex <bar> :vertical resize 30<CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n",
  "<leader>sv",
  ":source $MYVIMRC <bar> :doautocmd BufRead<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap("v", "J", ":m '>+1<CR>gv=gv", { noremap = true })
vim.api.nvim_set_keymap("v", "K", ":m '<-2<CR>gv=gv", { noremap = true })

if vim.fn.has('clipboard') == 1 then
  vim.api.nvim_set_keymap("v", "<c-c>", '"+y<esc>', { noremap = true })
  vim.api.nvim_set_keymap("v", "<c-v>", 'v"+p<esc>', { noremap = true })
end

-- }}}

-- vim: foldmethod=marker: foldlevel=0