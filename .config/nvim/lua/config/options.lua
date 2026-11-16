vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50

-- Sync Neovim clipboard with X11 system clipboard
vim.opt.clipboard = "unnamedplus"

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Minimal suckless statusline with LSP diagnostics
local function diagnostics()
  local count_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local count_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })

  local res = ""
  if count_errors > 0 then
    res = res .. string.format(" E:%d", count_errors)
  end
  if count_warnings > 0 then
    res = res .. string.format(" W:%d", count_warnings)
  end
  return res ~= "" and (res .. " ") or ""
end

function StatusLine()
  return table.concat({
    " %f %m%r",          -- File path and modified/readonly flags
    "%=",                -- Alignment separator (left/right split)
    diagnostics(),       -- Dynamic LSP Error & Warning counts
    "%y",                -- Filetype
    " [%l/%L:%c] ",      -- Line/Total Lines : Column
  })
end

vim.opt.statusline = "%!v:lua.StatusLine()"
