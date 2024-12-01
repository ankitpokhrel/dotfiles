local g = vim.g
local opt = vim.opt

g.netrw_liststyle = 3

-- Line numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 5

-- Editor look and feel
opt.mouse = a
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.cursorline = false
opt.guifont = "Fira Code:h13"
opt.linespace = 8
opt.statuscolumn = "%C%s%{v:relnum?printf('%4s',v:relnum):v:lnum}       "

-- Swap and undo files
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = false

-- Tabs and Indentation
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.wrap = false

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true
