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


" Terminal color definitions 
let s:cterm00 = "00" 
let s:cterm03 = "08" 
let s:cterm05 = "248" 
let s:cterm07 = "15" 
let s:cterm08 = "45" 
let s:cterm0A = "215" 
let s:cterm0B = "228" 
let s:cterm0C = "160" 
let s:cterm0D = "134" 
let s:cterm0E = "06" 
" if exists('base16colorspace') && base16colorspace == "256" 
  let s:cterm01 = "235" 
  let s:cterm02 = "237" 
  let s:cterm04 = "242" 
  let s:cterm06 = "253" 
  let s:cterm09 = "77" 
  let s:cterm0F = "94" 
" else 
"  let s:cterm01 = "10" 
"  let s:cterm02 = "11" 
"  let s:cterm04 = "12" 
"  let s:cterm06 = "13" 
"  let s:cterm09 = "09" 
"  let s:cterm0F = "14" 
"endif 

set t_Co=256

" Theme setup 
hi clear 
syntax reset 
let g:colors_name = "bsbase16" 


" Highlighting function 
fun <sid>hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp) 
  if a:guifg != "" 
    exec "hi " . a:group . " guifg=#" . a:guifg 
  endif 
  if a:guibg != "" 
    exec "hi " . a:group . " guibg=#" . a:guibg 
  endif 
  if a:ctermfg != "" 
    exec "hi " . a:group . " ctermfg=" . a:ctermfg 
  endif 
  if a:ctermbg != "" 
    exec "hi " . a:group . " ctermbg=" . a:ctermbg 
  endif 
  if a:attr != "" 
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr 
  endif 
  if a:guisp != "" 
    exec "hi " . a:group . " guisp=#" . a:guisp 
  endif 
endfun 


" Vim editor colors 
call <sid>hi("Bold",          "", "", "", "", "bold", "") 
call <sid>hi("Debug",         s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("Directory",     s:gui0D, "", s:cterm0D, "", "", "") 
call <sid>hi("Error",         s:gui00, s:gui08, s:cterm00, s:cterm08, "", "") 
call <sid>hi("ErrorMsg",      s:gui08, s:gui00, s:cterm08, s:cterm00, "", "") 
call <sid>hi("Exception",     s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("FoldColumn",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "", "") 
call <sid>hi("Folded",        s:gui0B, s:gui02, s:cterm0B, s:cterm02, "", "") 
call <sid>hi("IncSearch",     s:gui01, s:gui09, s:cterm01, s:cterm09, "none", "") 
call <sid>hi("Italic",        "", "", "", "", "none", "") 
call <sid>hi("Macro",         s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("MatchParen",    "", s:gui03, "", s:cterm03,  "", "") 
call <sid>hi("ModeMsg",       s:gui0B, "", s:cterm0B, "", "", "") 
call <sid>hi("MoreMsg",       s:gui0B, "", s:cterm0B, "", "", "") 
call <sid>hi("Question",      s:gui0A, "", s:cterm0A, "", "", "") 
call <sid>hi("Search",        s:gui0A, s:gui01, s:cterm0A, s:cterm01,  "reverse", "") 
call <sid>hi("SpecialKey",    s:gui03, "", s:cterm03, "", "", "") 
call <sid>hi("TooLong",       s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("Underlined",    s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("Visual",        "", s:gui02, "", s:cterm02, "", "") 
call <sid>hi("VisualNOS",     s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("WarningMsg",    s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("WildMenu",      s:gui08, s:gui0A, s:cterm08, "", "", "") 
call <sid>hi("Title",         s:gui0D, "", s:cterm0D, "", "none", "") 
call <sid>hi("Conceal",       s:gui0D, s:gui00, s:cterm0D, s:cterm00, "", "") 
call <sid>hi("Cursor",        s:gui00, s:gui05, s:cterm00, s:cterm05, "", "") 
call <sid>hi("NonText",       s:gui03, "", s:cterm03, "", "", "") 
call <sid>hi("Normal",        s:gui05, s:gui00, s:cterm05, s:cterm00, "", "") 
call <sid>hi("LineNr",        s:gui03, s:gui01, s:cterm03, s:cterm01, "", "") 
call <sid>hi("SignColumn",    s:gui03, s:gui01, s:cterm03, s:cterm01, "", "") 
call <sid>hi("StatusLine",    s:gui04, s:gui02, s:cterm04, s:cterm02, "none", "") 
call <sid>hi("StatusLineNC",  s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "") 
call <sid>hi("VertSplit",     s:gui02, s:gui02, s:cterm02, s:cterm02, "none", "") 
call <sid>hi("ColorColumn",   "", s:gui01, "", s:cterm01, "none", "") 
call <sid>hi("CursorColumn",  "", s:gui01, "", s:cterm01, "none", "") 
call <sid>hi("CursorLine",    "", s:gui01, "", s:cterm01, "none", "") 
call <sid>hi("CursorLineNr",  s:gui03, s:gui01, s:cterm03, s:cterm01, "", "") 
call <sid>hi("PMenu",         s:gui04, s:gui01, s:cterm04, s:cterm01, "none", "") 
call <sid>hi("PMenuSel",      s:gui04, s:gui01, s:cterm01, s:cterm04, "", "") 
call <sid>hi("TabLine",       s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "") 
call <sid>hi("TabLineFill",   s:gui03, s:gui01, s:cterm03, s:cterm01, "none", "") 
call <sid>hi("TabLineSel",    s:gui0B, s:gui01, s:cterm0B, s:cterm01, "none", "") 


" Standard syntax highlighting 
call <sid>hi("Boolean",      s:gui09, "", s:cterm09, "", "", "") 
call <sid>hi("Character",    s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("Comment",      s:gui03, "", s:cterm03, "", "", "") 
call <sid>hi("Conditional",  s:gui0E, "", s:cterm0E, "", "", "") 
call <sid>hi("Constant",     s:gui09, "", s:cterm09, "", "", "") 
call <sid>hi("Define",       s:gui0E, "", s:cterm0E, "", "none", "") 
call <sid>hi("Delimiter",    s:gui0F, "", s:cterm0F, "", "", "") 
call <sid>hi("Float",        s:gui09, "", s:cterm09, "", "", "") 
call <sid>hi("Function",     s:gui0D, "", s:cterm0D, "", "", "") 
call <sid>hi("Identifier",   s:gui08, "", s:cterm08, "", "none", "") 
call <sid>hi("Include",      s:gui0D, "", s:cterm0D, "", "", "") 
call <sid>hi("Keyword",      s:gui0E, "", s:cterm0E, "", "", "") 
call <sid>hi("Label",        s:gui0A, "", s:cterm0A, "", "", "") 
call <sid>hi("Number",       s:gui09, "", s:cterm09, "", "", "") 
call <sid>hi("Operator",     s:gui05, "", s:cterm05, "", "none", "") 
call <sid>hi("PreProc",      s:gui0A, "", s:cterm0A, "", "", "") 
call <sid>hi("Repeat",       s:gui0A, "", s:cterm0A, "", "", "") 
call <sid>hi("Special",      s:gui0C, "", s:cterm0C, "", "", "") 
call <sid>hi("SpecialChar",  s:gui0F, "", s:cterm0F, "", "", "") 
call <sid>hi("Statement",    s:gui08, "", s:cterm08, "", "", "") 
call <sid>hi("StorageClass", s:gui0A, "", s:cterm0A, "", "", "") 
call <sid>hi("String",       s:gui0B, "", s:cterm0B, "", "", "") 
call <sid>hi("Structure",    s:gui0E, "", s:cterm0E, "", "", "") 
call <sid>hi("Tag",          s:gui0D, "", s:cterm0D, "", "bold,italic", "") 
call <sid>hi("Todo",         s:gui0A, s:gui01, s:cterm0A, s:cterm01, "", "") 
call <sid>hi("Type",         s:gui09, "", s:cterm09, "", "none", "") 
call <sid>hi("Typedef",      s:gui0A, "", s:cterm0A, "", "", "") 








  


" Fold highlighting
"call <sid>hi("Folded", s:gui0B, s:gui02, "")
"call <sid>hi("FoldColumn", s:gui0B, s:gui01, "")

highlight Folded guibg=#404040 guifg=#f4bf75
" Remove functions
delf <sid>hi
" delf <sid>gui

" Remove color variables 
unlet s:gui00 s:gui01 s:gui02 s:gui03  s:gui04  s:gui05  s:gui06  s:gui07  s:gui08  s:gui09 s:gui0A  s:gui0B  s:gui0C  s:gui0D  s:gui0E  s:gui0F 
unlet s:cterm00 s:cterm01 s:cterm02 s:cterm03 s:cterm04 s:cterm05 s:cterm06 s:cterm07 s:cterm08 s:cterm09 s:cterm0A s:cterm0B s:cterm0C s:cterm0D s:cterm0E s:cterm0F 
