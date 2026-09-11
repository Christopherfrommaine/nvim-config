local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- Appearance
opt.termguicolors = true
opt.signcolumn = "yes"   -- prevents layout shift from diagnostics
opt.cursorline = true
opt.scrolloff = 8        -- keep 8 lines above/below cursor

-- Behaviour
opt.wrap = true
opt.splitright = true
opt.splitbelow = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"  -- sync with system clipboard
opt.undofile = true            -- persistent undo history
opt.updatetime = 250           -- faster completion/diagnostics
