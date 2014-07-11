" Base16 Default (https://github.com/chriskempson/base16)
" Scheme: Chris Kempson (http://chriskempson.com)

" GUI color definitions - original
let s:gui00 = "151515"	
let s:gui01 = "202020"	
let s:gui02 = "303030"	
let s:gui03 = "505050"
let s:gui04 = "b0b0b0"
let s:gui05 = "d0d0d0"
let s:gui06 = "e0e0e0"
let s:gui07 = "f5f5f5"
let s:gui08 = "6a9fb5" "blue
let s:gui09 = "90a959" "green
let s:gui0A = "d28445" "orange
let s:gui0B = "f4bf75" "yellow
let s:gui0C = "ac4142" "red
let s:gui0D = "aa759f" "purple
let s:gui0E = "75b5aa" "teal
let s:gui0F = "8f5536" "brown

" Theme setup
hi clear
syntax reset
let g:colors_name = "bsbase16"

" Highlighting function
fun <sid>hi(group, guifg, guibg, attr)
  if a:guifg != ""
    exec "hi " . a:group . " guifg=#" . s:gui(a:guifg)
  endif
  if a:guibg != ""
    exec "hi " . a:group . " guibg=#" . s:gui(a:guibg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr
  endif
endfun

" Return GUI color for light/dark variants
fun s:gui(color)
  if &background == "dark"
    return a:color
  endif

  if a:color == s:gui00
    return s:gui07
  elseif a:color == s:gui01
    return s:gui06
  elseif a:color == s:gui02
    return s:gui05
  elseif a:color == s:gui03
    return s:gui04
  elseif a:color == s:gui04
    return s:gui03
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui05
    return s:gui02
  elseif a:color == s:gui06
    return s:gui01
  elseif a:color == s:gui07
    return s:gui00
  endif

  return a:color
endfun

" Vim editor colors
call <sid>hi("Bold",          "", "", "bold")
call <sid>hi("Debug",         s:gui08, "", "")
call <sid>hi("Directory",     s:gui0D, "", "")
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, "")
call <sid>hi("Exception",     s:gui08, "", "")
call <sid>hi("FoldColumn",    "", s:gui01, "")
call <sid>hi("Folded",        s:gui03, s:gui01, "")
call <sid>hi("IncSearch",     s:gui0A, "", "")
call <sid>hi("Italic",        "", "", "none")
call <sid>hi("Macro",         s:gui08, "", "")
call <sid>hi("MatchParen",    s:gui03, s:gui00, "reverse")
call <sid>hi("ModeMsg",       s:gui0B, "", "")
call <sid>hi("MoreMsg",       s:gui0B, "", "")
call <sid>hi("Question",      s:gui0A, "", "")
call <sid>hi("Search",        s:gui0A, s:gui01, "reverse")
call <sid>hi("SpecialKey",    s:gui03, "", "")
call <sid>hi("TooLong",       s:gui08, "", "")
call <sid>hi("Underlined",    s:gui08, "", "")
call <sid>hi("Visual",        "", s:gui02, "")
call <sid>hi("VisualNOS",     s:gui08, "", "")
call <sid>hi("WarningMsg",    s:gui08, "", "")
call <sid>hi("WildMenu",      s:gui08, "", "")
call <sid>hi("Title",         s:gui0D, "", "none")
call <sid>hi("Conceal",       s:gui0D, s:gui00, "")
call <sid>hi("Cursor",        s:gui00, s:gui05, "")
call <sid>hi("NonText",       s:gui03, "", "")
call <sid>hi("Normal",        s:gui05, s:gui00, "")
call <sid>hi("LineNr",        s:gui03, s:gui01, "")
call <sid>hi("SignColumn",    s:gui03, s:gui01, "")
call <sid>hi("SpecialKey",    s:gui03, "", "")
call <sid>hi("StatusLine",    s:gui04, s:gui02, "none")
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, "none")
call <sid>hi("VertSplit",     s:gui02, s:gui02, "none")
call <sid>hi("ColorColumn",   "", s:gui01, "none")
call <sid>hi("CursorColumn",  "", s:gui01, "none")
call <sid>hi("CursorLine",    "", s:gui01, "none")
call <sid>hi("CursorLineNr",  s:gui03, s:gui01, "")
call <sid>hi("PMenu",         s:gui04, s:gui01, "none")
call <sid>hi("PMenuSel",      s:gui04, s:gui01, "reverse")
call <sid>hi("TabLine",       s:gui03, s:gui01, "none")
call <sid>hi("TabLineFill",   s:gui03, s:gui01, "none")
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, "none")

" Standard syntax highlighting
call <sid>hi("Boolean",      s:gui09, "", "")
call <sid>hi("Character",    s:gui08, "", "")
call <sid>hi("Comment",      s:gui03, "", "")
call <sid>hi("Conditional",  s:gui0E, "", "")
call <sid>hi("Constant",     s:gui09, "", "")
call <sid>hi("Define",       s:gui0E, "", "none")
call <sid>hi("Delimiter",    s:gui0F, "", "")
call <sid>hi("Float",        s:gui09, "", "")
call <sid>hi("Function",     s:gui0D, "", "")
call <sid>hi("Identifier",   s:gui08, "", "none")
call <sid>hi("Include",      s:gui0D, "", "")
call <sid>hi("Keyword",      s:gui0E, "", "")
call <sid>hi("Label",        s:gui0A, "", "")
call <sid>hi("Number",       s:gui09, "", "")
call <sid>hi("Operator",     s:gui05, "", "none")
call <sid>hi("PreProc",      s:gui0A, "", "")
call <sid>hi("Repeat",       s:gui0A, "", "")
call <sid>hi("Special",      s:gui0C, "", "")
call <sid>hi("SpecialChar",  s:gui0F, "", "")
call <sid>hi("Statement",    s:gui08, "", "")
call <sid>hi("StorageClass", s:gui0A, "", "")
call <sid>hi("String",       s:gui0B, "", "")
call <sid>hi("Structure",    s:gui0E, "", "")
call <sid>hi("Tag",          s:gui0C, "", "bold,italic")
call <sid>hi("Todo",         s:gui0A, s:gui01, "")
call <sid>hi("Type",         s:gui09, "", "none")
call <sid>hi("Typedef",      s:gui0A, "", "")

" Spelling highlighting
call <sid>hi("SpellBad",     "", s:gui00, "undercurl")
call <sid>hi("SpellLocal",   "", s:gui00, "undercurl")
call <sid>hi("SpellCap",     "", s:gui00, "undercurl")
call <sid>hi("SpellRare",    "", s:gui00, "undercurl")

" Additional diff highlighting
call <sid>hi("DiffAdd",      s:gui0B, s:gui00, "")
call <sid>hi("DiffChange",   s:gui0D, s:gui00, "")
call <sid>hi("DiffDelete",   s:gui08, s:gui00, "")
call <sid>hi("DiffText",     s:gui0D, s:gui00, "")
call <sid>hi("DiffAdded",    s:gui0B, s:gui00, "")
call <sid>hi("DiffFile",     s:gui08, s:gui00, "")
call <sid>hi("DiffNewFile",  s:gui0B, s:gui00, "")
call <sid>hi("DiffLine",     s:gui0D, s:gui00, "")
call <sid>hi("DiffRemoved",  s:gui08, s:gui00, "")

" Git highlighting
call <sid>hi("gitCommitOverflow",  s:gui08, "", "")
call <sid>hi("gitCommitSummary",   s:gui0B, "", "")
  
" GitGutter highlighting
call <sid>hi("GitGutterAdd",     s:gui0B, s:gui01, "")
call <sid>hi("GitGutterChange",  s:gui0D, s:gui01, "")
call <sid>hi("GitGutterDelete",  s:gui08, s:gui01, "")

" Fold highlighting
call <sid>hi("Folded", s:gui0B, s:gui02, "")
call <sid>hi("FoldColumn", s:gui0B, s:gui01, "")

highlight Folded guibg=#404040 guifg=#f4bf75
" Remove functions
delf <sid>hi
delf <sid>gui

" Remove color variables
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F
