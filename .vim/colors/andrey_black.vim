" Vim color file
" Maintainer:   Andrey Epifanov
" Last Change:  2010 Oct 4

" First remove all existing highlighting.

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "andrey_black"

hi Normal       ctermbg=Black       ctermfg=White
hi NonText                          ctermfg=Yellow
hi ErrorMsg     ctermbg=Red         ctermfg=White
hi Visual       ctermbg=Black       
hi Cursor       ctermbg=Black       ctermfg=Black
hi Directory                        ctermfg=Blue     
hi LineNr       ctermbg=Blue        ctermfg=White
hi MoreMsg                          ctermfg=Red
hi Question                         ctermfg=Green    
hi Search       ctermbg=White       ctermfg=Black
hi SpecialKey                       ctermfg=Green     
hi Title                            ctermfg=Magenta  
hi WarningMsg                       ctermfg=Red      
hi WildMenu     ctermbg=White       ctermfg=Black         
hi Folded       ctermbg=Grey        ctermfg=Blue      
hi FoldColumn   ctermbg=Grey        ctermfg=DarkBlue      
hi DiffAdd      ctermbg=Green                                         
hi DiffChange   ctermbg=Yellow                                        
hi DiffDelete   ctermbg=Red         ctermfg=White 
hi DiffText     ctermbg=Red         
hi MatchParen   ctermbg=Red         ctermfg=White
hi CLibFunc                         ctermfg=Blue
hi CLibFuncFail                     ctermfg=Red
hi Constant                         ctermfg=Green       
hi Special                          ctermfg=Yellow
hi Statement                        ctermfg=Green
hi String                           ctermfg=Magenta
hi Comment                          ctermfg=DarkGrey
hi Identifier                       ctermfg=Green
hi Include                          ctermfg=DarkGreen
hi PreProc                          ctermfg=DarkGreen
hi Operator                         ctermfg=Blue
hi Define                           ctermfg=DarkGreen
hi Type                             ctermfg=DarkCyan
hi Structure                        ctermfg=Green
hi Todo         ctermbg=Red         ctermfg=Yellow
hi Label                            ctermfg=DarkMagenta
