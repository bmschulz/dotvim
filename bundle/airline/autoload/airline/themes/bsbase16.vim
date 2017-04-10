" I've modified bsbase16.vim with colors that match my colorscheme

" Each theme is contained in its own file and declares variables scoped to the
" file.  These variables represent the possible "modes" that airline can
" detect.  The mode is the return value of mode(), which gets converted to a
" readable string.  The following is a list currently supported modes: normal,
" insert, replace, visual, and inactive.
"
" Each mode can also have overrides.  These are small changes to the mode that
" don't require a completely different look.  "modified" and "paste" are two
" such supported overrides.  These are simply suffixed to the major mode,
" separated by an underscore.  For example, "normal_modified" would be normal
" mode where the current buffer is modified.
"
" The theming algorithm is a 2-pass system where the mode will draw over all
" parts of the statusline, and then the override is applied after.  This means
" it is possible to specify a subset of the theme in overrides, as it will
" simply overwrite the previous colors.  If you want simultaneous overrides,
" then they will need to change different parts of the statusline so they do
" not conflict with each other.

" First let's define some arrays.  The s: is just a VimL thing for scoping the
" variables to the current script.  Without this, these variables would be
" declared globally.
"
" The array is in the format [ guifg, guibg, ctermfg, ctermbg, opts ].
" The opts takes in values from ":help attr-list".
let s:N1   = [ '#202020' , '#90a959' , 235  , 77 ]
let s:N2   = [ '#ffffff' , '#444444' , 255 , 8 ]
let s:N3   = [ '#ffffff' , '#202020' , 255  , 235 ]

" The file array is a special case, where only the foreground colors are
" specified.  The background colors are automatically filled.
let s:file = [ '#ff0000' , ''        , 160 , ''  ]

" vim-airline is made up of multiple sections, but for theming purposes there
" is only 3 sections: the mode, the branch indicator, and the gutter (which
" then get mirrored on the right side).  generate_color_map is a helper
" function which generates a dictionary which declares the full colorscheme
" for the statusline.  See the source code of "autoload/airline/themes.vim"
" for the full set of keys available for theming.

" First, let's define a palette.  Airline will search for this variable.
" The # is a separator that maps with the directory structure. If you get
" this wrong, Vim will complain loudly.
let g:airline#themes#bsbase16#palette = {}

" Now let's declare some colors for normal mode and add it to the dictionary.
let g:airline#themes#bsbase16#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3, s:file)

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#bsbase16#palette.normal, hence why only certain keys are
" declared.
let g:airline#themes#bsbase16#palette.normal_modified = {
      \ 'airline_c': [ '#d28445', s:N3[1] , s:N3[2], s:N3[3], ''     ] ,
      \ }


let s:I1 = [ '#202020' , '#f4bf75' , 235  , 228  ]
let s:I2 = [ '#ffffff' , '#444444' , 255 , 8  ]
let s:I3 = [ '#ffffff' , '#202020' , 255  , 235  ]
let g:airline#themes#bsbase16#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3, s:file)
let g:airline#themes#bsbase16#palette.insert_modified = {
      \ 'airline_c': [ '#d28445', s:I3[1] , s:I3[2], s:I3[3], ''     ] ,
      \ }
let g:airline#themes#bsbase16#palette.insert_paste = {
      \ 'airline_a': [ s:I1[0]   , '#d78700' , s:I1[2] , 172     , ''     ] ,
      \ }


let s:R1 = [ '#202020' , '#ac4142' , 235  , 160  ]
let s:R2 = [ '#ffffff' , '#444444' , 255 , 8  ]
let s:R3 = [ '#ffffff' , '#202020' , 255  , 235  ]
let g:airline#themes#bsbase16#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3, s:file)
let g:airline#themes#bsbase16#palette.replace_modified = {
      \ 'airline_c': [ '#d28445', s:R3[1] , s:R3[2], s:R3[3], ''     ] ,
      \ }


let s:V1 = [ '#202020' , '#aa759f' , 235 , 134 ]
let s:V2 = [ '#ffffff' , '#444444' , 255 , 8 ]
let s:V3 = [ '#ffffff' , '#202020' , 255  , 235  ]
let g:airline#themes#bsbase16#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3, s:file)
let g:airline#themes#bsbase16#palette.visual_modified = {
      \ 'airline_c': [ '#d28445', s:V3[1] , s:V3[2], s:V3[3], ''     ] ,
      \ }


let s:IA1 = [ '#4e4e4e' , '#1c1c1c' , 239 , 234 , '' ]
let s:IA2 = [ '#4e4e4e' , '#262626' , 239 , 235 , '' ]
let s:IA3 = [ '#4e4e4e' , '#303030' , 239 , 236 , '' ]
let g:airline#themes#bsbase16#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3, s:file)
let g:airline#themes#bsbase16#palette.inactive_modified = {
      \ 'airline_c': [ '#875faf' , '' , 97 , '' , '' ] ,
      \ }


" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
if !get(g:, 'loaded_ctrlp', 0)
  finish
endif
let g:airline#themes#bsbase16#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
      \ [ '#ffffff' , '#444444' , 255 , 8  , ''     ],
      \ [ '#6a9fb5' , '#202020' , 45  , 235 , ''     ],
	\ [ '#202020' , '#6a9fb5' , 235 , 45  , 'bold' ])

"      \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
"      \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
"      \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])
