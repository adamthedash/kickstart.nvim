-- Custom colorscheme converted from base46
-- Save this as ~/.config/nvim/colors/custom.lua

local M = {}

-- Color palette
local colors = {
  white = '#e8e8d3',
  darker_black = '#101010',
  black = '#151515', --  nvim bg
  black2 = '#1c1c1c',
  one_bg = '#252525',
  one_bg2 = '#2e2e2e',
  one_bg3 = '#3a3a3a',
  grey = '#424242',
  grey_fg = '#474747',
  grey_fg2 = '#4c4c4c',
  light_grey = '#525252',
  red = '#F38BA8',
  baby_pink = '#ffa5c3',
  pink = '#F5C2E7',
  line = '#383747', -- for lines like vertsplit
  green = '#ABE9B3',
  vibrant_green = '#b6f4be',
  nord_blue = '#8bc2f0',
  blue = '#89B4FA',
  yellow = '#FAE3B0',
  sun = '#ffe9b6',
  purple = '#d0a9e5',
  dark_purple = '#c7a0dc',
  teal = '#B5E8E0',
  orange = '#F8BD96',
  cyan = '#89DCEB',
  statusline_bg = '#232232',
  lightbg = '#2f2e3e',
  pmenu_bg = '#ABE9B3',
  folder_bg = '#89B4FA',
  lavender = '#c7d1ff',

  -- Base16 colors
  base00 = '#151515',
  base01 = '#282737',
  base02 = '#2f2e3e',
  base03 = '#383747',
  base04 = '#414050',
  base05 = '#bfc6d4',
  base06 = '#ccd3e1',
  base07 = '#D9E0EE',
  base08 = '#F38BA8',
  base09 = '#F8BD96',
  base0A = '#FAE3B0',
  base0B = '#ABE9B3',
  base0C = '#89DCEB',
  base0D = '#56a8f5',
  base0E = '#cf8e6d',
  base0F = '#F38BA8',
}

local function setup()
  -- Clear existing highlights
  vim.cmd 'highlight clear'
  if vim.fn.exists 'syntax_on' then
    vim.cmd 'syntax reset'
  end

  vim.o.background = 'dark'
  vim.g.colors_name = 'custom'

  local highlights = {
    -- Editor highlights
    Normal = { fg = colors.base05, bg = colors.black },
    NormalFloat = { fg = colors.base05, bg = colors.one_bg },
    FloatBorder = { fg = colors.line, bg = colors.one_bg },
    ColorColumn = { bg = colors.black2 },
    Cursor = { fg = colors.black, bg = colors.base05 },
    CursorLine = { bg = colors.one_bg },
    CursorColumn = { bg = colors.one_bg },
    LineNr = { fg = colors.grey },
    CursorLineNr = { fg = colors.white, bold = true },
    SignColumn = { fg = colors.grey, bg = colors.black },
    Folded = { fg = colors.light_grey, bg = colors.one_bg },
    FoldColumn = { fg = colors.grey, bg = colors.black },
    VertSplit = { fg = colors.line },
    WinSeparator = { fg = colors.line },
    StatusLine = { fg = colors.base05, bg = colors.statusline_bg },
    StatusLineNC = { fg = colors.grey, bg = colors.one_bg },
    TabLine = { fg = colors.grey, bg = colors.one_bg },
    TabLineFill = { bg = colors.black },
    TabLineSel = { fg = colors.white, bg = colors.black },

    -- Pmenu
    Pmenu = { fg = colors.base05, bg = colors.one_bg },
    PmenuSel = { fg = colors.black, bg = colors.pmenu_bg },
    PmenuSbar = { bg = colors.one_bg2 },
    PmenuThumb = { bg = colors.grey },

    -- Search
    Search = { fg = colors.black, bg = colors.yellow },
    IncSearch = { fg = colors.black, bg = colors.orange },
    CurSearch = { fg = colors.black, bg = colors.orange },

    -- Visual
    Visual = { bg = colors.one_bg2 },
    VisualNOS = { bg = colors.one_bg2 },

    -- Messages
    ErrorMsg = { fg = colors.red },
    WarningMsg = { fg = colors.yellow },
    ModeMsg = { fg = colors.green },
    MoreMsg = { fg = colors.blue },
    Question = { fg = colors.blue },

    -- Diff
    DiffAdd = { fg = colors.green },
    DiffChange = { fg = colors.yellow },
    DiffDelete = { fg = colors.red },
    DiffText = { fg = colors.blue, bold = true },

    -- Syntax highlighting
    Comment = { fg = colors.grey_fg, italic = true },
    Constant = { fg = colors.base09 },
    String = { fg = colors.base0B },
    Character = { fg = colors.base0B },
    Number = { fg = colors.base09 },
    Boolean = { fg = colors.base09 },
    Float = { fg = colors.base09 },

    Identifier = { fg = colors.base08 },
    Function = { fg = colors.base0D },

    Statement = { fg = colors.base0E },
    Conditional = { fg = colors.base0E },
    Repeat = { fg = colors.base0E },
    Label = { fg = colors.base0E },
    Operator = { fg = colors.base05 },
    Keyword = { fg = colors.base0E },
    Exception = { fg = colors.base0E },

    PreProc = { fg = colors.base0A },
    Include = { fg = colors.base0D },
    Define = { fg = colors.base0E },
    Macro = { fg = colors.base08 },
    PreCondit = { fg = colors.base0A },

    Type = { fg = colors.base0E },
    StorageClass = { fg = colors.base0A },
    Structure = { fg = colors.base0E },
    Typedef = { fg = colors.base0A },

    Special = { fg = colors.base0C },
    SpecialChar = { fg = colors.base0F },
    Tag = { fg = colors.base0A },
    Delimiter = { fg = colors.base0F },
    SpecialComment = { fg = colors.base0C },
    Debug = { fg = colors.base08 },

    Underlined = { underline = true },
    Ignore = { fg = colors.grey },
    Error = { fg = colors.red, bold = true },
    Todo = { fg = colors.yellow, bold = true },

    -- Treesitter highlights (your custom polish_hl)
    ['@variable'] = { fg = colors.lavender },
    ['@variable.parameter'] = { fg = colors.lavender },
    ['@variable.builtin'] = { fg = colors.red },
    ['@property'] = { fg = colors.teal },
    ['@constant.macro'] = { fg = colors.pink },

    -- LSP semantic tokens for Rust
    ['@lsp.type.struct.rust'] = { fg = colors.lavender },
    ['@lsp.type.interface.rust'] = { fg = colors.lavender },
    ['@lsp.type.enum.rust'] = { fg = colors.lavender },

    -- Additional treesitter highlights
    ['@keyword'] = { fg = colors.base0E },
    ['@keyword.function'] = { fg = colors.base0E },
    ['@keyword.operator'] = { fg = colors.base0E },
    ['@keyword.return'] = { fg = colors.base0E },
    ['@function'] = { fg = colors.base0D },
    ['@function.builtin'] = { fg = colors.base0D },
    ['@function.macro'] = { fg = colors.base08 },
    ['@method'] = { fg = colors.base0D },
    ['@type'] = { fg = colors.base0A },
    ['@type.builtin'] = { fg = colors.base0A },
    ['@constructor'] = { fg = colors.base0C },
    ['@string'] = { fg = colors.base0B },
    ['@string.escape'] = { fg = colors.base0C },
    ['@number'] = { fg = colors.base09 },
    ['@boolean'] = { fg = colors.base09 },
    ['@constant'] = { fg = colors.base09 },
    ['@constant.builtin'] = { fg = colors.base09 },
    ['@comment'] = { fg = colors.grey_fg, italic = true },

    -- Git signs
    GitSignsAdd = { fg = colors.green },
    GitSignsChange = { fg = colors.yellow },
    GitSignsDelete = { fg = colors.red },

    -- Diagnostic
    DiagnosticError = { fg = colors.red },
    DiagnosticWarn = { fg = colors.yellow },
    DiagnosticInfo = { fg = colors.blue },
    DiagnosticHint = { fg = colors.teal },
    DiagnosticVirtualTextError = { fg = colors.red, bg = colors.black },
    DiagnosticVirtualTextWarn = { fg = colors.yellow, bg = colors.black },
    DiagnosticVirtualTextInfo = { fg = colors.blue, bg = colors.black },
    DiagnosticVirtualTextHint = { fg = colors.teal, bg = colors.black },

    -- LSP
    LspReferenceText = { bg = colors.one_bg2 },
    LspReferenceRead = { bg = colors.one_bg2 },
    LspReferenceWrite = { bg = colors.one_bg2 },
  }

  -- Apply highlights
  for group, colors in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, colors)
  end
end

-- Setup function to be called
M.setup = setup

-- Auto-setup when required
setup()

return M
