local palette_file = vim.fn.expand("~/.config/theme/palette.json")

local file = io.open(palette_file, "r")
if not file then
    return
end

local content = file:read("*a")
file:close()

local palette = vim.json.decode(content)

local function hex(key)
    return "#" .. palette[key]:sub(1, 6)
end

local bg = hex("bg")
local fg = hex("fg")
local accent = hex("accent")
local border_inactive = hex("border_inactive")
local border_active = hex("border_active")

local black = hex("regular0")
local red = hex("regular1")
local green = hex("regular2")
local yellow = hex("regular3")
local blue = hex("regular4")
local magenta = hex("regular5")
local cyan = hex("regular6")
local white = hex("regular7")

local bright_black = hex("bright0")
local bright_red = hex("bright1")
local bright_green = hex("bright2")
local bright_yellow = hex("bright3")
local bright_blue = hex("bright4")
local bright_magenta = hex("bright5")
local bright_cyan = hex("bright6")
local bright_white = hex("bright7")

vim.api.nvim_set_hl(0, "Normal", { bg = bg, fg = fg })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = bg, fg = fg })
vim.api.nvim_set_hl(0, "NormalNC", { bg = bg, fg = fg })

vim.api.nvim_set_hl(0, "CursorLine", { bg = bright_black })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = bright_black })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = bright_black })

vim.api.nvim_set_hl(0, "LineNr", { fg = bright_black })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = accent, bold = true })

vim.api.nvim_set_hl(0, "Visual", { bg = bright_black })
vim.api.nvim_set_hl(0, "Search", { bg = yellow, fg = bg })
vim.api.nvim_set_hl(0, "IncSearch", { bg = accent, fg = bg })

vim.api.nvim_set_hl(0, "StatusLine", { bg = bright_black, fg = fg })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = bg, fg = bright_black })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_inactive })

vim.api.nvim_set_hl(0, "VertSplit", { fg = border_inactive })
vim.api.nvim_set_hl(0, "Folded", { bg = bright_black, fg = bright_black })
vim.api.nvim_set_hl(0, "FoldColumn", { bg = bg, fg = bright_black })

vim.api.nvim_set_hl(0, "Pmenu", { bg = bright_black, fg = fg })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = accent, fg = bg })
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = bright_black })
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = bright_white })

vim.api.nvim_set_hl(0, "TabLine", { bg = bg, fg = bright_black })
vim.api.nvim_set_hl(0, "TabLineSel", { bg = bright_black, fg = accent, bold = true })
vim.api.nvim_set_hl(0, "TabLineFill", { bg = bg })

vim.api.nvim_set_hl(0, "Comment", { fg = bright_black, italic = true })

vim.api.nvim_set_hl(0, "Constant", { fg = yellow })
vim.api.nvim_set_hl(0, "String", { fg = green })
vim.api.nvim_set_hl(0, "Character", { fg = green })
vim.api.nvim_set_hl(0, "Number", { fg = yellow })
vim.api.nvim_set_hl(0, "Boolean", { fg = yellow })
vim.api.nvim_set_hl(0, "Float", { fg = yellow })

vim.api.nvim_set_hl(0, "Identifier", { fg = cyan })
vim.api.nvim_set_hl(0, "Function", { fg = blue })
vim.api.nvim_set_hl(0, "Method", { fg = blue })

vim.api.nvim_set_hl(0, "Statement", { fg = magenta })
vim.api.nvim_set_hl(0, "Conditional", { fg = magenta })
vim.api.nvim_set_hl(0, "Repeat", { fg = magenta })
vim.api.nvim_set_hl(0, "Label", { fg = magenta })
vim.api.nvim_set_hl(0, "Operator", { fg = cyan })
vim.api.nvim_set_hl(0, "Keyword", { fg = magenta })
vim.api.nvim_set_hl(0, "Exception", { fg = red })

vim.api.nvim_set_hl(0, "PreProc", { fg = cyan })
vim.api.nvim_set_hl(0, "Include", { fg = cyan })
vim.api.nvim_set_hl(0, "Define", { fg = magenta })
vim.api.nvim_set_hl(0, "Macro", { fg = magenta })
vim.api.nvim_set_hl(0, "PreCondit", { fg = magenta })

vim.api.nvim_set_hl(0, "Type", { fg = yellow })
vim.api.nvim_set_hl(0, "StorageClass", { fg = yellow })
vim.api.nvim_set_hl(0, "Structure", { fg = yellow })
vim.api.nvim_set_hl(0, "Typedef", { fg = yellow })

vim.api.nvim_set_hl(0, "Special", { fg = cyan })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = cyan })
vim.api.nvim_set_hl(0, "Tag", { fg = magenta })
vim.api.nvim_set_hl(0, "Delimiter", { fg = fg })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = bright_black })
vim.api.nvim_set_hl(0, "Debug", { fg = red })

vim.api.nvim_set_hl(0, "Underlined", { underline = true, fg = cyan })
vim.api.nvim_set_hl(0, "Ignore", { fg = bright_black })
vim.api.nvim_set_hl(0, "Error", { fg = red, bold = true })
vim.api.nvim_set_hl(0, "Todo", { fg = accent, bold = true })

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = red })
vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = yellow })
vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = blue })
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = cyan })

vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = red })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = yellow })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = blue })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = cyan })

vim.api.nvim_set_hl(0, "LspReferenceText", { bg = bright_black })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bg = bright_black })
vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = bright_black })

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = green })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = yellow })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = red })

vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = bg, fg = fg })
vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_inactive })
vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = accent })
vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = bright_black })
vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = accent, bold = true })

vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = bg, fg = fg })
vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = blue })
vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = blue, bold = true })
vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = accent, bold = true })
vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = yellow })
vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = green })
vim.api.nvim_set_hl(0, "NvimTreeGitDeleted", { fg = red })

vim.api.nvim_set_hl(0, "WhichKey", { fg = cyan })
vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = magenta })
vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = fg })
vim.api.nvim_set_hl(0, "WhichKeySeperator", { fg = bright_black })

vim.api.nvim_set_hl(0, "@variable", { fg = fg })
vim.api.nvim_set_hl(0, "@variable.builtin", { fg = red })
vim.api.nvim_set_hl(0, "@variable.parameter", { fg = cyan })
vim.api.nvim_set_hl(0, "@function", { fg = blue })
vim.api.nvim_set_hl(0, "@function.builtin", { fg = blue })
vim.api.nvim_set_hl(0, "@function.method", { fg = blue })
vim.api.nvim_set_hl(0, "@function.call", { fg = blue })
vim.api.nvim_set_hl(0, "@keyword", { fg = magenta })
vim.api.nvim_set_hl(0, "@keyword.function", { fg = magenta })
vim.api.nvim_set_hl(0, "@keyword.operator", { fg = cyan })
vim.api.nvim_set_hl(0, "@keyword.return", { fg = magenta })
vim.api.nvim_set_hl(0, "@conditional", { fg = magenta })
vim.api.nvim_set_hl(0, "@repeat", { fg = magenta })
vim.api.nvim_set_hl(0, "@constant", { fg = yellow })
vim.api.nvim_set_hl(0, "@constant.builtin", { fg = yellow })
vim.api.nvim_set_hl(0, "@string", { fg = green })
vim.api.nvim_set_hl(0, "@string.escape", { fg = bright_cyan })
vim.api.nvim_set_hl(0, "@character", { fg = green })
vim.api.nvim_set_hl(0, "@number", { fg = yellow })
vim.api.nvim_set_hl(0, "@boolean", { fg = yellow })
vim.api.nvim_set_hl(0, "@type", { fg = yellow })
vim.api.nvim_set_hl(0, "@type.builtin", { fg = yellow })
vim.api.nvim_set_hl(0, "@attribute", { fg = cyan })
vim.api.nvim_set_hl(0, "@property", { fg = cyan })
vim.api.nvim_set_hl(0, "@field", { fg = cyan })
vim.api.nvim_set_hl(0, "@parameter", { fg = cyan })
vim.api.nvim_set_hl(0, "@comment", { fg = bright_black, italic = true })
vim.api.nvim_set_hl(0, "@comment.documentation", { fg = bright_black, italic = true })
vim.api.nvim_set_hl(0, "@operator", { fg = cyan })
vim.api.nvim_set_hl(0, "@punctuation", { fg = fg })
vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = fg })
vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = fg })
vim.api.nvim_set_hl(0, "@tag", { fg = magenta })
vim.api.nvim_set_hl(0, "@tag.attribute", { fg = cyan })
vim.api.nvim_set_hl(0, "@tag.delimiter", { fg = fg })

vim.g.terminal_color_0 = black
vim.g.terminal_color_1 = red
vim.g.terminal_color_2 = green
vim.g.terminal_color_3 = yellow
vim.g.terminal_color_4 = blue
vim.g.terminal_color_5 = magenta
vim.g.terminal_color_6 = cyan
vim.g.terminal_color_7 = white
vim.g.terminal_color_8 = bright_black
vim.g.terminal_color_9 = bright_red
vim.g.terminal_color_10 = bright_green
vim.g.terminal_color_11 = bright_yellow
vim.g.terminal_color_12 = bright_blue
vim.g.terminal_color_13 = bright_magenta
vim.g.terminal_color_14 = bright_cyan
vim.g.terminal_color_15 = bright_white