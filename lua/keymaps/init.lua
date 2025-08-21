local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('n', ';', ':', { desc = 'CMD enter command mode' })

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- map("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- map("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- =============================== Telescope =======================================
-- See `:help telescope.builtin`
local builtin = require 'telescope.builtin'
map('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
map('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
map('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
map('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
map('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
map('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>fo', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
map('n', '<leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })
map('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
map('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })

-- Slightly advanced example of overriding default behavior and theme
map('n', '<leader>f/', function()
  -- You can pass additional configuration to Telescope to change the theme, layout, etc.
  builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
map('n', '<leader>s/', function()
  builtin.live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

-- Shortcut for searching your Neovim configuration files
map('n', '<leader>sn', function()
  builtin.find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- =============================== Code related =======================================
map('n', '<leader>/', 'gcc', { desc = 'toggle comment', remap = true })
map('v', '<leader>/', 'gc', { desc = 'toggle comment', remap = true })
map('n', '<leader>fm', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = 'Format buffer' })
