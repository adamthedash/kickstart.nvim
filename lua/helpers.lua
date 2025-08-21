local M = {}

--- Pretty print a table
function M.dump_table(o, max_depth, indent_size)
  max_depth = max_depth or 3
  indent_size = indent_size or 2

  local function _dump(obj, depth, current_indent)
    if depth > max_depth then
      return '...'
    end

    if type(obj) == 'table' then
      -- Check if table is empty
      local count = 0
      for _ in pairs(obj) do
        count = count + 1
      end
      if count == 0 then
        return '{}'
      end

      -- Check if it's a simple array-like table
      local is_array = true
      local array_count = 0
      for k, _ in pairs(obj) do
        if type(k) ~= 'number' or k ~= array_count + 1 then
          is_array = false
          break
        end
        array_count = array_count + 1
      end

      local next_indent = current_indent .. string.rep(' ', indent_size)
      local s = '{\n'

      -- Sort keys for consistent output
      local keys = {}
      for k in pairs(obj) do
        table.insert(keys, k)
      end
      table.sort(keys, function(a, b)
        if type(a) == type(b) then
          return tostring(a) < tostring(b)
        else
          return type(a) < type(b)
        end
      end)

      for i, k in ipairs(keys) do
        local v = obj[k]
        local key_str
        if type(k) == 'number' and is_array then
          key_str = '' -- Don't show numeric keys for arrays
        elseif type(k) == 'number' then
          key_str = '[' .. k .. '] = '
        elseif type(k) == 'string' and k:match '^[%a_][%w_]*$' then
          key_str = k .. ' = ' -- Valid identifier, no quotes needed
        else
          key_str = '["' .. tostring(k) .. '"] = '
        end

        s = s .. next_indent .. key_str .. _dump(v, depth + 1, next_indent)
        if i < #keys then
          s = s .. ','
        end
        s = s .. '\n'
      end

      return s .. current_indent .. '}'
    else
      if type(obj) == 'string' then
        return '"' .. obj .. '"'
      else
        return tostring(obj)
      end
    end
  end

  return _dump(o, 0, '')
end

--- Display the given ANSI-escaped message on a floating window
---@param rendered_diagnostic string
local function render_ansi_code_diagnostic(rendered_diagnostic)
  -- Remove ANSI escape codes from the diagnostic message
  local lines = vim.split(rendered_diagnostic:gsub('[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]', ''), '\n', { trimempty = true })
  local float_preview_lines = vim.deepcopy(lines)

  vim.schedule(function()
    -- Use vim.lsp.util.open_floating_preview with default config
    local bufnr, winnr = vim.lsp.util.open_floating_preview(float_preview_lines, 'plaintext', {
      -- Basic floating window configuration
      border = 'rounded',
      max_width = 80,
      max_height = 20,
      wrap = true,
      focusable = true,
    })

    -- Set up autocmd to handle window focus
    vim.api.nvim_create_autocmd('WinEnter', {
      callback = function()
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes([[<c-\><c-n>]] .. '<cmd>lua vim.api.nvim_win_set_cursor(' .. winnr .. ',{1,0})<CR>', true, false, true),
          'n',
          true
        )
      end,
      buffer = bufnr,
      once = true, -- Only trigger once
    })

    -- Open terminal in the buffer and send the diagnostic content
    local chanid = vim.api.nvim_open_term(bufnr, {})
    vim.api.nvim_chan_send(chanid, vim.trim(rendered_diagnostic))
  end)
end

--- Cycle through the diagnostics on the current line, displaying them as a verbose pop-up window
function M.cycle_diagnostics_on_current_line()
  local current_line = vim.fn.line '.' - 1
  local diagnostics = vim.diagnostic.get(0, {
    lnum = current_line,
    severity = { min = vim.diagnostic.severity.WARN },
  })

  if #diagnostics == 0 then
    vim.notify('No diagnostics on this line', vim.log.levels.INFO)
    return
  end

  -- If the current line is different from the previously checked line, reset our indexes
  local last_line = vim.b['diagnostics_last_line_checked']
  if current_line ~= last_line then
    vim.b['diagnostics_index'] = 1
    vim.b['diagnostics_last_line_checked'] = current_line
  end

  -- If our current index is longer than the number of diagnostics, reset back to the start
  local current_index = vim.b['diagnostics_index']
  if current_index > #diagnostics then
    current_index = 1
    vim.b['diagnostics_index'] = current_index
  end

  -- Grab the current diagnostic item
  local diagnostic = diagnostics[current_index]

  -- Check for rust-analyzer's rich diagnostic information
  -- rust-analyzer provides rendered diagnostics in diagnostic.user_data.lsp.data.rendered
  local rich_diag_message = vim.tbl_get(diagnostic, 'user_data', 'lsp', 'data', 'rendered')

  if rich_diag_message then
    render_ansi_code_diagnostic(rich_diag_message)
  else
    -- Fallback to regular diagnostic message in a floating window
    vim.lsp.util.open_floating_preview(vim.split(diagnostic.message, '\n'), 'plaintext', {
      border = 'rounded',
      max_width = 80,
      max_height = 20,
      wrap = true,
      focusable = true,
    })
  end

  -- Move the cursor to where the issue is
  vim.cmd "normal! m'" -- for jump list
  local win_id = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_cursor(win_id, { diagnostic.lnum + 1, diagnostic.col })

  -- Move to the next diagnostic in the list (loop around)
  vim.b['diagnostics_index'] = (current_index % #diagnostics) + 1
end

return M
