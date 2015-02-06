" Vim color file

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let colors_name = "monokai_terminal"

hi Normal       guifg=#F8F8F2 guibg=#272822 ctermfg=none ctermbg=none

hi Visual       guibg=#49483E gui=none ctermbg=59 cterm=none

" Main highlight groups
hi Cursor       guibg=fg
hi CursorLine   guibg=#3E3D32 gui=none ctermbg=237  cterm=none
hi ColorColumn  guibg=#3E3D32 gui=none ctermbg=none cterm=none
"hi CursorIM
"hi CursorColumn
"hi CursorLine

hi Directory    guifg=#66D9EF gui=none ctermfg=6 cterm=none
hi DiffAdd      guifg=bg guibg=#A6E22E ctermfg=2 cterm=none
hi DiffChange   guifg=bg guibg=#E6DB74 ctermfg=3 cterm=none
hi DiffDelete   guifg=bg guibg=#F92672 ctermfg=1 cterm=none
hi DiffText     guifg=bg guibg=#E6DB74 ctermfg=3 cterm=none
hi ErrorMsg     guifg=#F92672 guibg=bg gui=none ctermfg=1 ctermbg=none cterm=none
hi VertSplit    guifg=#3B3A32 guibg=bg gui=none ctermfg=9 ctermbg=none cterm=none
hi Folded       guifg=#75715E guibg=bg gui=none ctermfg=8 ctermbg=none cterm=none
hi FoldColumn   guifg=#75715E guibg=#3E3D32 gui=none ctermfg=8 ctermbg=9 cterm=none
hi SignColum    guifg=#75715E guibg=#3E3D32 gui=none ctermfg=8 ctermbg=none cterm=none
hi IncSearch    guifg=bg guibg=#E6DB74 gui=none ctermfg=237 ctermbg=136 cterm=none
hi LineNr       guifg=#75715E guibg=#3E3D32 gui=none ctermfg=102 ctermbg=none cterm=none
hi MatchParen   guifg=fg guibg=bg gui=bold ctermfg=none ctermbg=yellow cterm=bold
hi ModeMsg      gui=none cterm=none
hi MoreMsg      guifg=#66D9EF gui=none ctermfg=4 cterm=none
hi NonText      guifg=#3B3A32 gui=none ctermfg=9 cterm=none
hi Pmenu        guifg=fg guibg=#3E3D32 ctermfg=none ctermbg=9
hi PmenuSel     guifg=fg guibg=bg ctermfg=none ctermbg=none
hi PmenuSbar    guibg=bg ctermbg=none
hi PmenuThumb   guifg=fg ctermfg=none
hi Question     guifg=#A6E22E gui=none ctermfg=2
hi Search       guifg=bg guibg=#E6DB74 gui=none ctermfg=237 ctermbg=136 cterm=none
hi SpecialKey   guifg=#3B3A32 gui=none ctermfg=9 cterm=none
hi SpellBad     guisp=#F92672
hi SpellCap     guisp=#65D9EF
"hi SpellLocal
hi SpellRare    guisp=#AE81FF
hi StatusLine   guifg=fg guibg=#3E3D32 gui=none ctermfg=none ctermbg=9 cterm=none
hi StatusLineNC guifg=#75715E guibg=#3E3D32 gui=none ctermfg=8 ctermbg=9 cterm=none
hi TabLine      guifg=#75715E guibg=#3E3D32 gui=none ctermfg=8 ctermbg=9 cterm=none
hi TabLineFill  guifg=fg guibg=#3E3D32 gui=none ctermfg=none ctermbg=9 cterm=none
hi TabLineSel   guifg=fg guibg=#3E3D32 gui=none ctermfg=none ctermbg=9 cterm=none
hi Title        guifg=#F92672 gui=none ctermfg=12 cterm=none

"hi VisualNOS
hi WarningMsg   guifg=#F92672 gui=none ctermfg=1 cterm=none
"hi WildMenu

"hi Menu
"hi ScrollBar
"hi Tooltip


" Plugin specific highlight groups
hi MyTagListFileName guifg=#FD971F guibg=bg gui=none ctermfg=11 ctermbg=none cterm=none


" Color groups
hi Blue    guifg=#66D9EF gui=none ctermfg=6  cterm=none
hi Green   guifg=#A6E22E gui=none ctermfg=2  cterm=none
hi Grey    guifg=#75715E gui=none ctermfg=8  cterm=none
hi Orange  guifg=#FD971F gui=none ctermfg=11 cterm=none
hi Purple  guifg=#AE81FF gui=none ctermfg=5  cterm=none
hi Red     guifg=#F92672 gui=none ctermfg=197  cterm=none
hi White   guifg=#F8F8F2 gui=none ctermfg=7  cterm=none
hi Yellow  guifg=#E6DB74 gui=none ctermfg=3  cterm=none

hi BlueU   guifg=#66D9EF gui=underline ctermfg=6 cterm=underline

hi RedR    guifg=fg guibg=#F92672 gui=none ctermfg=197 ctermbg=none cterm=none
hi YellowR guifg=bg guibg=#FD971F gui=none ctermfg=white ctermbg=3 cterm=none

hi GreyCom    guifg=#75715E gui=none ctermfg=102  cterm=none


" Syntax highligh groups
hi! link Comment      GreyCom
"
hi! link Constant     Purple
hi! link String       Yellow
hi! link Character    Yellow
"hi Number
"hi Boolean
"hi Float
"
hi! link Identifier   Green
"hi Function
"
hi! link Statement    RedR
"hi Conditional
"hi Repeat
"hi Label
hi! link Operator     Green
"hi Keyword
"hi Exception
"
hi! link PreProc      Orange
hi! link Include      RedR
hi! link Define		  RedR
hi! link Macro		  RedR
"hi PreCondit
"
hi! link Type         Blue
hi! link StorageClass Red
"hi Structure
"hi Typedef
"
hi! link Special      White
"hi SpecialChar
hi! link Tag          Green
hi! link Delimiter    Red
"hi SpecialComment
"hi Debug
"
hi! link Underlined   BlueU
"hi Ignore
hi! link Error        RedR
hi! link Todo         YellowR

" Language specific highligh groups
" C
hi link cStatement              Green
" C++
hi link cppStatement            Green

" CSS
hi link cssBraces               White
hi link cssFontProp             White
hi link cssColorProp            White
hi link cssTextProp             White
hi link cssBoxProp              White
hi link cssRenderProp           White
hi link cssAuralProp            White
hi link cssRenderProp           White
hi link cssGeneratedContentProp White
hi link cssPagingProp           White
hi link cssTableProp            White
hi link cssUIProp               White
hi link cssFontDescriptorProp   White
" Java
hi link javaStatement           Green
" Ruby
hi link rubyClassVariable       White
hi link rubyControl             Green
hi link rubyGlobalVariable      White
hi link rubyInstanceVariable    White
hi link rubyDefine              Red
hi link rubyRailsFilterMethod   Blue
hi link rubyRailsRenderMethod   Blue
" HTML
hi link htmlTag         Comment
hi link htmlTagName     Conditional
hi link htmlEndTag      Comment
hi link htmlLink        Normal
hi link htmlArg         Green
" CSS/SASS
hi link cssTagName                  Yellow
hi link sassVariable                Green
hi link sassFunction                Red
hi link sassMixing                  Red
hi link sassMixin                   Red
hi link sassExtend                  Red
hi link sassFor                     Red
hi link sassInterpolationDelimiter  Magenta
hi link sassAmpersand               Character
hi link sassId                      Identifier
hi link sassClass                   Type
hi link sassIdChar                  sassId
hi link sassClassChar               sassClass
