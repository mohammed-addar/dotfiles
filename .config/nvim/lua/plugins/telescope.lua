return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  cmd = 'Telescope',
  keys = {
    { '<leader>pf', desc = 'Find Project Files' },
    { '<C-p>', desc = 'Find Git Files' },
    { '<leader>ps', desc = 'Grep String Search' },
    { '<leader>sg', desc = 'Search by Live Grep' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  },
  config = function()
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = 'Find Project Files' })
    vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>ps', function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end, { desc = 'Grep String Search' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = 'Search by Live Grep' })
  end,
}
